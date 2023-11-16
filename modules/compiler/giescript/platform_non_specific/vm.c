#include "vm.h"

#include "chunk.h"
#include "debug.h"
#include "value.h"
#include "compiler.h"
#include "obj.h"

#include "types/basic_types/basic_types.h"
#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"
#include "gil_math/gil_math.h"

typedef enum vm_interpret_result {
    VM_OK,
    VM_COMPILE_ERROR,
    VM_RUNTIME_ERROR
} vm_interpret_result_t;

static void vm__define_abi(vm_t* self);
static void vm__free_objs(vm_t* self);
// executes the chunk and returns the result
static vm_interpret_result_t vm__interpret(vm_t* self);
// compiles, interprets and returns the result
static vm_interpret_result_t vm__run_source(vm_t* self, const char* source);
static void    vm__error(vm_t* self, const char* err_msg, ...);
// trace the current state of the vm
static void    vm__interpret_trace(vm_t* self, chunk_t* chunk);
// returns next instruction and advances ip
static u8      vm__eat(vm_t* self);
static value_t vm__eat_imm(vm_t* self, chunk_t* chunk);
static value_t vm__eat_imm_long(vm_t* self, chunk_t* chunk);
static value_t vm__peek(vm_t* self);
// push value on the value stack
static void    vm__push(vm_t* self, value_t value);
// pop value from the value stack
static value_t vm__pop(vm_t* self);
static value_t vm__popn(vm_t* self, u32 n);
static u32     vm__pop_integer(vm_t* self);
static bool    vm__call(vm_t* self, obj_fun_t* caller, u32 n_args);

static void vm__interpret_trace(vm_t* self, chunk_t* chunk) {
#if defined(DEBUG_VM_TRACE)
    libc__printf("--== vm trace ==--\n"); 
    libc__printf("     stack: ");
    value_t* value = self->values_stack_data;
    while (value != self->values_stack_top) {
        libc__printf("[ ");
        value__print(*value++);
        libc__printf(" ]");
    }
    libc__printf("\n");
    
    libc__printf("     ins:   ");
    ASSERT(self->stack_frames_fill > 0);
    stack_frame_t* stack_frame = &self->stack_frames[self->stack_frames_fill - 1];
    ASSERT(chunk->instructions <= stack_frame->ip);
    chunk__disasm_ins(chunk, (u32) (stack_frame->ip - chunk->instructions));
    libc__printf("\n");
#else
    (void) self;
    (void) chunk;
#endif
}

static u8 vm__eat(vm_t* self) {
    ASSERT(self->stack_frames_fill > 0);
    stack_frame_t* stack_frame = &self->stack_frames[self->stack_frames_fill - 1];
    return *stack_frame->ip++;
}

static value_t vm__eat_imm(vm_t* self, chunk_t* chunk) {
    return chunk->immediates.values[vm__eat(self)];
}

static value_t vm__eat_imm_long(vm_t* self, chunk_t* chunk) {
    u32 imm_index =  vm__eat(self) << 16;
    imm_index     += vm__eat(self) << 8;
    imm_index     += vm__eat(self);

    return chunk->immediates.values[imm_index];
}

static u32 vm__pop_integer(vm_t* self) {
    value_t index_value = vm__pop(self);
    ASSERT(value__is_num(index_value));

    r64 value_as_num = value__as_num(index_value);
    r64 value_as_num_integral_part;
    r64 value_as_num_fractional_part = r64__modular_fraction(value_as_num, &value_as_num_integral_part);
    ASSERT(value_as_num_integral_part >= 0 && value_as_num_fractional_part == 0.0);
    u32 index = (u32) value_as_num;

    return index;
}

static bool vm__call(vm_t* self, obj_fun_t* caller, u32 n_args) {
    if (caller->arity != n_args) {
        vm__error(self, "Expected %u number of arguments, but got %u.", caller->arity, n_args);

        return false;
    }

    if (self->stack_frames_fill == ARRAY_SIZE(self->stack_frames)) {
        vm__error(self, "Stack overflow.");

        return false;
    }

    stack_frame_t* frame = &self->stack_frames[self->stack_frames_fill++];
    frame->caller = caller;
    frame->ip = caller->chunk.instructions;

    // ASSERT(self->values_stack_top - n_args - 1 >= self->values_stack_data);
    // frame->slots = self->values_stack_top - n_args - 1;
    ASSERT(self->values_stack_top - n_args >= self->values_stack_data);
    frame->slots = self->values_stack_top - n_args;

    return true;
}

static value_t vm__peek(vm_t* self) {
    ASSERT(self->values_stack_top > self->values_stack_data && "underflow");

    return *(self->values_stack_top - 1);
}

static void vm__push(vm_t* self, value_t value) {
    ASSERT(self->values_stack_top < self->values_stack_data + self->values_stack_size && "overflow");

    *self->values_stack_top++ = value;
}

static value_t vm__pop(vm_t* self) {
    ASSERT(self->values_stack_top > self->values_stack_data && "underflow");

    return *--self->values_stack_top;
}

static value_t vm__popn(vm_t* self, u32 n) {
    ASSERT(self->values_stack_top - n >= self->values_stack_data && "underflow");
    
    return *(self->values_stack_top -= n);
}

bool vm__create(vm_t* self, allocator_t* allocator) {
    libc__memset(self, 0, sizeof(*self));

    vm__define_abi(self);

    table__create(&self->obj_str_table, allocator);

    self->allocator = allocator;

    self->values_stack_size = 256;
    self->values_stack_data = allocator__alloc(allocator, self->values_stack_size * sizeof(*self->values_stack_data));
    self->values_stack_top = self->values_stack_data;

    return true;
}

void vm__destroy(vm_t* self) {
    if (self->values_stack_data) {
        allocator__free(self->allocator, self->values_stack_data);
    }
    vm__free_objs(self);
    
    table__destroy(&self->obj_str_table);

    libc__memset(self, 0, sizeof(*self));
}

bool vm__run_file(vm_t* self, const char* path) {
    size_t script_file_size;
    if (file__size(path, &script_file_size) == false) {
        return false;
    }
    char* script_file_contents = allocator__alloc(self->allocator, script_file_size + 1);

    file_t script_file;
    if (file__open(&script_file, path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false) {
        return false;
    }
    u32 script_file_contents_len = file__read(&script_file, script_file_contents, script_file_size);
    script_file_contents[script_file_contents_len] = '\0';
    file__close(&script_file);

    vm_interpret_result_t result = vm__run_source(self, script_file_contents);
    switch (result) {
        case VM_OK: {
        } break ;
        case VM_COMPILE_ERROR: {
            libc__printf("VM: Compilation error in file '%s'\n", path);
        } break ;
        case VM_RUNTIME_ERROR: {
            libc__printf("VM: Runtime error in file '%s'\n", path);
        } break ;
    }

    allocator__free(self->allocator, script_file_contents);

    return true;
}

bool vm__run_repl(vm_t* self) {
    console_t console = console__init_module(KILOBYTES(1), false);
    size_t line_buffer_size = KILOBYTES(1);
    char*  line_buffer = allocator__alloc(self->allocator, line_buffer_size);

    bool prompt_is_running = true;
    while (prompt_is_running) {
        console__write(console, "> ");
        u32 read_line_length = console__read_line(console, line_buffer, line_buffer_size - 2);
        line_buffer[read_line_length] = '\n';
        line_buffer[read_line_length + 1] = '\0';

        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            vm__run_source(self, line_buffer);
        }
    }

    allocator__free(self->allocator, line_buffer);
    console__deinit_module(console);

    return true;
}

bool vm__test_source(vm_t* self, const char* script, ...) {
    bool result;

    va_list ap;
    va_start(ap, script);
    result = vm__vtest_source(self, script, ap);
    va_end(ap);

    return result;
}

bool vm__vtest_source(vm_t* self, const char* script, va_list ap) {
    compiler_t compiler;
    if (!compiler__create(&compiler, self, script)) {
        return false;
    }

    obj_fun_t* fn = compiler__compile(&compiler);
    if (!fn) {
        compiler__destroy(&compiler);
        return false;
    }

    chunk_t* chunk = &fn->chunk;
    bool result = true;
    for (u32 ins_index = 0; result && ins_index < chunk->instructions_fill; ++ins_index) {
        ins_mnemonic_t expected_ins = va_arg(ap, ins_mnemonic_t);
        ins_mnemonic_t ins = chunk->instructions[ins_index];
        if (ins == INS_IMM) {
            ++ins_index;
        } else if (ins == INS_IMM_LONG) {
            ins_index += 3;
        }
        if (expected_ins != ins) {
            result = false;
        }
    }

    compiler__destroy(&compiler);

    return result;
}

static vm_interpret_result_t vm__run_source(vm_t* self, const char* source) {
    compiler_t compiler;
    if (!compiler__create(&compiler, self, source)) {
        return VM_COMPILE_ERROR;
    }

    obj_fun_t* fn = compiler__compile(&compiler);
    if (!fn) {
        compiler__destroy(&compiler);
        return VM_COMPILE_ERROR;
    }

    compiler__destroy(&compiler);

    vm__call(self, fn, 0);

    return vm__interpret(self);
}

static void vm__error(vm_t* self, const char* err_msg, ...) {
    va_list ap;

    libc__printf("Runtime error: ");
    va_start(ap, err_msg);
    libc__vprintf(err_msg, ap);
    va_end(ap);
    libc__printf("\n");

    ASSERT(self->stack_frames_fill > 0);
    stack_frame_t* stack_frame = &self->stack_frames[self->stack_frames_fill - 1];
    ASSERT(stack_frame->caller);
    chunk_t* chunk = &stack_frame->caller->chunk;
    ASSERT(chunk->instructions < stack_frame->ip);
    token_info_t* token_info = chunk__get_token_info(chunk, stack_frame->ip - chunk->instructions - 1);
    libc__printf("%u:%u %u:%u in script.\n", token_info->line_s, token_info->col_s, token_info->line_e, token_info->col_e);

    libc__printf("--== stack trace ==--\n");
    for (s32 frame_index = (s32) self->stack_frames_fill - 1; frame_index >= 0; --frame_index) {
        stack_frame_t* frame = &self->stack_frames[frame_index];
        obj_fun_t* fn = frame->caller;
        ASSERT(fn);
        u32 ip = frame->ip - fn->chunk.instructions - 1;
        token_info = chunk__get_token_info(&fn->chunk, ip);
        libc__printf("%u:%u %u:%u | ", token_info->line_s, token_info->col_s, token_info->line_e, token_info->col_e);
        value__print(fn->name);
        libc__printf("\n");
    }

    self->values_stack_top = self->values_stack_data;
}

static void vm__free_objs(vm_t* self) {
    obj_t* obj = self->objs;
    while (obj) {
        obj_t* next = obj->next_free;
        obj__free(self, obj);
        obj = next;
    }
}

static void vm__define_abi(vm_t* self) {
    self->abi.stack_delta[INS_RETURN] = 0;
    self->abi.stack_delta[INS_IMM] = 1;
    self->abi.stack_delta[INS_IMM_LONG] = 1;
    self->abi.stack_delta[INS_NIL] = 1;
    self->abi.stack_delta[INS_TRUE] = 1;
    self->abi.stack_delta[INS_FALSE] = 1;
    self->abi.stack_delta[INS_NEG] = 0;
    self->abi.stack_delta[INS_ADD] = -1;
    self->abi.stack_delta[INS_SUB] = -1;
    self->abi.stack_delta[INS_MUL] = -1;
    self->abi.stack_delta[INS_DIV] = -1;
    self->abi.stack_delta[INS_MOD] = -1;
    self->abi.stack_delta[INS_NOT] = 0;
    self->abi.stack_delta[INS_EQ] = -1;
    self->abi.stack_delta[INS_GT] = -1;
    self->abi.stack_delta[INS_LT] = -1;
    self->abi.stack_delta[INS_PRINT] = -1;
    self->abi.stack_delta[INS_POP] = -1;
    self->abi.stack_delta[INS_POPN] = 0; // hardcoded to check previous imm when pushing this instruction
    self->abi.stack_delta[INS_LOAD] = 0;
    self->abi.stack_delta[INS_STORE] = -1;
    self->abi.stack_delta[INS_JUMP] = -1;
    self->abi.stack_delta[INS_JUMP_ON_FALSE] = -1;
    self->abi.stack_delta[INS_JUMP_ON_TRUE] = -1;
    self->abi.stack_delta[INS_CALL] = -1;
}

vm_interpret_result_t vm__interpret(vm_t* self) {
    ASSERT(self->stack_frames_fill > 0);
    stack_frame_t* stack_frame = &self->stack_frames[self->stack_frames_fill - 1];

    // ASSERT(chunk->values_stack_size_watermark > 0);
    // if (self->values_stack_size < chunk->values_stack_size_watermark) {
    //     size_t new_values_stack_size = chunk->values_stack_size_watermark << 1;
    //     self->values_stack_data = allocator__realloc(
    //         self->allocator, self->values_stack_data,
    //         self->values_stack_size * sizeof(*self->values_stack_data),
    //         new_values_stack_size   * sizeof(*self->values_stack_data)
    //     );
    //     self->values_stack_size = new_values_stack_size;
    // }
    self->values_stack_top = self->values_stack_data;

    while (42) {
        chunk_t* chunk = &stack_frame->caller->chunk;
        vm__interpret_trace(self, chunk);
        
        ins_mnemonic_t ins = vm__eat(self);

        switch (ins) {
            case INS_RETURN: {
                value_t return_value = vm__pop(self);
                ASSERT(self->stack_frames_fill > 0);
                if (--self->stack_frames_fill == 0) {
                    // vm__pop(self);
                    return VM_OK;
                }

                self->values_stack_top = stack_frame->slots;
                vm__push(self, return_value);

                stack_frame = &self->stack_frames[self->stack_frames_fill - 1];
            } break ;
            case INS_IMM: {
                value_t imm = vm__eat_imm(self, chunk);
                vm__push(self, imm);
            } break ;
            case INS_IMM_LONG: {
                value_t imm_long = vm__eat_imm_long(self, chunk);
                vm__push(self, imm_long);
            } break ;
            case INS_NIL: {
                vm__push(self, value__nil());
            } break ;
            case INS_TRUE: {
                vm__push(self, value__bool(true));
            } break ;
            case INS_FALSE: {
                vm__push(self, value__bool(false));
            } break ;
            case INS_NEG: {
                ASSERT(self->values_stack_top != self->values_stack_data);
                value_t* value = self->values_stack_top - 1;
                if (!value__is_num(*value)) {
                    vm__error(self, "Operand must be a number.");
                    return VM_RUNTIME_ERROR;
                }
                *value = value__num(-value__as_num(*value));
            } break ;
            case INS_ADD: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (obj__is_str(left) && obj__is_str(right)) {
                    vm__push(self, obj__cat_str(self, left, right));
                } else if (value__is_num(left) && value__is_num(right)) {
                    vm__push(self, value__num(value__as_num(left) + value__as_num(right)));
                } else {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
            } break ;
            case INS_SUB: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(value__as_num(left) - value__as_num(right)));
            } break ;
            case INS_MUL: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(value__as_num(left) * value__as_num(right)));
            } break ;
            case INS_DIV: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                r64 left_num = value__as_num(left);
                r64 right_num = value__as_num(right);
                if (right_num == 0.0) {
                    vm__error(self, "Cannot divide by 0.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(left_num / right_num));
            } break ;
            case INS_MOD: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                r64 left_num = value__as_num(left);
                r64 right_num = value__as_num(right);
                if (right_num == 0.0) {
                    vm__error(self, "Cannot divide by 0.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(r64__mod(left_num, right_num)));
            } break ;
            case INS_NOT: {
                value_t value = vm__pop(self);
                vm__push(self, value__bool(value__is_falsey(value)));
            } break ;
            case INS_EQ: {
                value_t right = vm__pop(self);
                value_t left = vm__pop(self);
                vm__push(self, value__bool(value__is_eq(left, right)));
            } break ;
            case INS_GT: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__bool(value__as_num(left) > value__as_num(right)));
            } break ;
            case INS_LT: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__bool(value__as_num(left) < value__as_num(right)));
            } break ;
            case INS_PRINT: {
                value_t value = vm__pop(self);
                value__print(value);
                libc__printf("\n");
            } break ;
            case INS_POP: {
                DISCARD_RETURN vm__pop(self);
            } break ;
            case INS_POPN: {
                u32 index = vm__pop_integer(self);
                DISCARD_RETURN vm__popn(self, index);
            } break ;
            case INS_LOAD: {
                u32 index = vm__pop_integer(self);

                ASSERT(self->values_stack_top - index >= self->values_stack_data);
                ASSERT(stack_frame->slots);
                value_t value = stack_frame->slots[index];
                vm__push(self, value);
            } break ;
            case INS_STORE: {
                u32 index = vm__pop_integer(self);

                ASSERT(index < self->values_stack_top - self->values_stack_data);
                value_t value = vm__peek(self);
                ASSERT(stack_frame->slots);
                stack_frame->slots[index] = value;
            } break ;
            case INS_JUMP: {
                u32 ip = vm__pop_integer(self);
                ASSERT(ip < chunk->instructions_fill);
                stack_frame->ip = chunk->instructions + ip;
            } break ;
            case INS_JUMP_ON_FALSE: {
                u32 ip = vm__pop_integer(self);

                if (value__is_falsey(vm__peek(self))) {
                    ASSERT(ip < chunk->instructions_fill);
                    stack_frame->ip = chunk->instructions + ip;
                }
            } break ;
            case INS_JUMP_ON_TRUE: {
                u32 ip = vm__pop_integer(self);

                if (!value__is_falsey(vm__peek(self))) {
                    ASSERT(ip < chunk->instructions_fill);
                    stack_frame->ip = chunk->instructions + ip;
                }
            } break ;
            case INS_DUP: {
                vm__push(self, vm__peek(self));
            } break ;
            case INS_CALL: {
                u32 n_args = vm__pop_integer(self);
                ASSERT(self->values_stack_top - n_args - 1 >= self->values_stack_data);
                value_t caller = *(self->values_stack_top - n_args - 1);
                if (obj__is_fun(caller)) {
                    obj_fun_t* caller_fn = obj__as_fun(caller);
                    if (!vm__call(self, caller_fn, n_args)) {
                        return VM_RUNTIME_ERROR;
                    }
                } else {
                    vm__error(self, "Can only call functions.");
                }

                ASSERT(self->stack_frames_fill > 0 && self->stack_frames_fill < ARRAY_SIZE(self->stack_frames));
                stack_frame = &self->stack_frames[self->stack_frames_fill - 1];
            } break ;
            default: ASSERT(false);
        }
    }
}
