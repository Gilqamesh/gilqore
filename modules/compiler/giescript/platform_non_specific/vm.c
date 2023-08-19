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

typedef enum vm_interpret_result {
    VM_OK,
    VM_COMPILE_ERROR,
    VM_RUNTIME_ERROR
} vm_interpret_result_t;

static void vm__define_ins_infos(vm_t* self);
static void vm__free_objs(vm_t* self);
// executes the chunk and returns the result
static vm_interpret_result_t vm__interpret(vm_t* self, chunk_t* chunk);
// compiles, interprets and returns the result
static vm_interpret_result_t vm__run_source(vm_t* self, const char* source);
static void    vm__error(vm_t* self, chunk_t* chunk, const char* err_msg, ...);
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
static u32     vm__pop_index(vm_t* self);

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
    ASSERT(chunk->instructions <= self->ip);
    chunk__disasm_ins(chunk, (u32) (self->ip - chunk->instructions));
    libc__printf("\n");
#else
    (void) self;
    (void) chunk;
#endif
}

static u8 vm__eat(vm_t* self) {
    return *self->ip++;
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

static u32 vm__pop_index(vm_t* self) {
    value_t index_value = vm__pop(self);
    ASSERT(value__is_num(index_value));

    r64 value_as_num = value__as_num(index_value);
    r64 value_as_num_integral_part;
    r64 value_as_num_fractional_part = r64__modular_fraction(value_as_num, &value_as_num_integral_part);
    ASSERT(value_as_num_integral_part >= 0 && value_as_num_fractional_part == 0.0);
    u32 index = (u32) value_as_num;

    return index;
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
    vm__define_ins_infos(self);

    self->ip = 0;
    self->values_stack_data = 0;
    self->values_stack_top = 0;
    self->values_stack_size = 0;

    self->objs = 0;

    table__create(&self->obj_str_table, allocator);

    table__create(&self->global_names_to_var_infos, allocator);
    value_arr__create(&self->global_values, allocator);

    self->allocator = allocator;

    return true;
}

void vm__destroy(vm_t* self) {
    if (self->values_stack_data) {
        allocator__free(self->allocator, self->values_stack_data);
    }
    vm__free_objs(self);
    
    table__destroy(&self->obj_str_table);

    table__destroy(&self->global_names_to_var_infos);
    value_arr__destroy(&self->global_values, self->allocator);

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
    chunk_t chunk;
    chunk__create(&chunk, self);

    compiler_t compiler;
    if (!compiler__create(&compiler, self, &chunk, script)) {
        chunk__destroy(&chunk);
        return false;
    }

    if (!compiler__compile(&compiler)) {
        compiler__destroy(&compiler);
        chunk__destroy(&chunk);
        return false;
    }

    for (u32 ins_index = 0; ins_index < chunk.instructions_fill; ++ins_index) {
        ins_mnemonic_t expected_ins = va_arg(ap, ins_mnemonic_t);
        ins_mnemonic_t ins = chunk.instructions[ins_index];
        if (ins == INS_IMM) {
            ++ins_index;
        } else if (ins == INS_IMM_LONG) {
            ins_index += 3;
        }
        if (expected_ins != ins) {
            return false;
        }
    }

    compiler__destroy(&compiler);

    chunk__destroy(&chunk);

    return true;
}

static vm_interpret_result_t vm__run_source(vm_t* self, const char* source) {
    chunk_t chunk;
    chunk__create(&chunk, self);

    compiler_t compiler;
    if (!compiler__create(&compiler, self, &chunk, source)) {
        chunk__destroy(&chunk);
        return VM_COMPILE_ERROR;
    }

    if (!compiler__compile(&compiler)) {
        compiler__destroy(&compiler);
        chunk__destroy(&chunk);
        return VM_COMPILE_ERROR;
    }

    compiler__destroy(&compiler);

    vm_interpret_result_t result = vm__interpret(self, &chunk);

    chunk__destroy(&chunk);

    return result;
}

static void vm__error(vm_t* self, chunk_t* chunk, const char* err_msg, ...) {
    va_list ap;

    va_start(ap, err_msg);
    libc__vprintf(err_msg, ap);
    va_end(ap);
    libc__printf("\n");

    ASSERT(chunk->instructions < self->ip);
    token_info_t* token_info = chunk__get_token_info(chunk, self->ip - chunk->instructions - 1);
    libc__printf("%u:%u %u:%u in script.\n", token_info->line_s, token_info->col_s, token_info->line_e, token_info->col_e);

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

static void vm__define_ins_infos(vm_t* self) {
    self->ins_infos[INS_RETURN].stack_delta = 0;
    self->ins_infos[INS_IMM].stack_delta = 1;
    self->ins_infos[INS_IMM_LONG].stack_delta = 1;
    self->ins_infos[INS_NIL].stack_delta = 1;
    self->ins_infos[INS_TRUE].stack_delta = 1;
    self->ins_infos[INS_FALSE].stack_delta = 1;
    self->ins_infos[INS_NEG].stack_delta = 0;
    self->ins_infos[INS_ADD].stack_delta = -1;
    self->ins_infos[INS_SUB].stack_delta = -1;
    self->ins_infos[INS_MUL].stack_delta = -1;
    self->ins_infos[INS_DIV].stack_delta = -1;
    self->ins_infos[INS_NOT].stack_delta = 0;
    self->ins_infos[INS_EQ].stack_delta = -1;
    self->ins_infos[INS_GT].stack_delta = -1;
    self->ins_infos[INS_LT].stack_delta = -1;
    self->ins_infos[INS_PRINT].stack_delta = -1;
    self->ins_infos[INS_POP].stack_delta = -1;
    self->ins_infos[INS_POPN].stack_delta = 0; // hardcoded to check previous imm when pushing this instruction
    self->ins_infos[INS_DEFINE_GLOBAL].stack_delta = -2;
    self->ins_infos[INS_GET_GLOBAL].stack_delta = 0;
    self->ins_infos[INS_SET_GLOBAL].stack_delta = -1;
    self->ins_infos[INS_GET_LOCAL].stack_delta = 0;
    self->ins_infos[INS_SET_LOCAL].stack_delta = -1;
    self->ins_infos[INS_JUMP_ON_FALSE].stack_delta = -1;
    self->ins_infos[INS_JUMP_ON_TRUE].stack_delta = -1;
}

vm_interpret_result_t vm__interpret(vm_t* self, chunk_t* chunk) {
    self->ip = chunk->instructions;

    ASSERT(chunk->values_stack_size_watermark > 0);
    if (self->values_stack_size < chunk->values_stack_size_watermark) {
        size_t new_values_stack_size = chunk->values_stack_size_watermark << 1;
        self->values_stack_data = allocator__realloc(
            self->allocator, self->values_stack_data,
            self->values_stack_size * sizeof(*self->values_stack_data),
            new_values_stack_size   * sizeof(*self->values_stack_data)
        );
        self->values_stack_size = new_values_stack_size;
    }
    self->values_stack_top = self->values_stack_data;

    while (42) {
        vm__interpret_trace(self, chunk);
        
        ins_mnemonic_t ins = vm__eat(self);

        switch (ins) {
            case INS_RETURN: {
                return VM_OK;
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
                    vm__error(self, chunk, "Operand must be a number.");
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
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
            } break ;
            case INS_SUB: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(value__as_num(left) - value__as_num(right)));
            } break ;
            case INS_MUL: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(value__as_num(left) * value__as_num(right)));
            } break ;
            case INS_DIV: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__num(value__as_num(left) / value__as_num(right)));
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
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__bool(value__as_num(left) > value__as_num(right)));
            } break ;
            case INS_LT: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, chunk, "Operands must be numbers.");
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
                u32 index = vm__pop_index(self);
                DISCARD_RETURN vm__popn(self, index);
            } break ;
            case INS_DEFINE_GLOBAL: {
                u32 index = vm__pop_index(self);

                ASSERT(index < self->global_values.values_fill);
                self->global_values.values[index] = vm__pop(self);
            } break ;
            case INS_GET_GLOBAL: {
                u32 index = vm__pop_index(self);

                ASSERT(index < self->global_values.values_fill);
                value_t value = self->global_values.values[index];

                if (value__is_undefined(value)) {
                    vm__error(self, chunk, "Undefined variable.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value);
            } break ;
            case INS_SET_GLOBAL: {
                u32 index = vm__pop_index(self);

                ASSERT(index < self->global_values.values_fill);
                value_t identifier = self->global_values.values[index];

                if (value__is_undefined(identifier)) {
                    vm__error(self, chunk, "Undefined variable.");
                    return VM_RUNTIME_ERROR;
                }
                value_t value = vm__peek(self);
                self->global_values.values[index] = value;
            } break ;
            case INS_GET_LOCAL: {
                u32 index = vm__pop_index(self);

                ASSERT(self->values_stack_top - index >= self->values_stack_data);
                value_t value = self->values_stack_data[index];
                vm__push(self, value);
            } break ;
            case INS_SET_LOCAL: {
                u32 index = vm__pop_index(self);

                ASSERT(index < self->values_stack_top - self->values_stack_data);
                value_t value = vm__peek(self);
                self->values_stack_data[index] = value;
            } break ;
            case INS_JUMP: {
                u32 ip = vm__pop_index(self);
                ASSERT(ip < chunk->instructions_fill);
                self->ip = chunk->instructions + ip;
            } break ;
            case INS_JUMP_ON_FALSE: {
                u32 ip = vm__pop_index(self);

                if (value__is_falsey(vm__peek(self))) {
                    ASSERT(ip < chunk->instructions_fill);
                    self->ip = chunk->instructions + ip;
                }
            } break ;
            case INS_JUMP_ON_TRUE: {
                u32 ip = vm__pop_index(self);

                if (!value__is_falsey(vm__peek(self))) {
                    ASSERT(ip < chunk->instructions_fill);
                    self->ip = chunk->instructions + ip;
                }
            } break ;
            default: ASSERT(false);
        }
    }
}
