#include "vm.h"

#include "chunk.h"
#include "debug.h"
#include "value.h"
#include "compiler.h"
#include "obj.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"

#define DEBUG_VM_TRACE

typedef enum vm_interpret_result {
    VM_OK,
    VM_COMPILE_ERROR,
    VM_RUNTIME_ERROR
} vm_interpret_result_t;

static void vm__free_objs(vm_t* self, allocator_t* allocator);
// executes the chunk and returns the result
static vm_interpret_result_t vm__interpret(vm_t* self, allocator_t* allocator, chunk_t* chunk);
// compiles, interprets and returns the result
static vm_interpret_result_t vm__run_source(vm_t* self, allocator_t* allocator, const char* source);
static void    vm__error(vm_t* self, chunk_t* chunk, const char* err_msg, ...);
// trace the current state of the vm
static void    vm__interpret_trace(vm_t* self, chunk_t* chunk);
// eats next instruction ip
static u8      vm__eat(vm_t* self);
static value_t vm__eat_imm(vm_t* self, chunk_t* chunk);
static value_t vm__eat_imm_long(vm_t* self, chunk_t* chunk);
// push value on the value stack
static void    vm__push           (vm_t* self, value_t value);
// pop value from the value stack
static value_t vm__pop            (vm_t* self);

static void vm__interpret_trace(vm_t* self, chunk_t* chunk) {
#if defined(DEBUG_VM_TRACE)
    libc__printf("--== vm trace ==--\n"); 
    libc__printf("     values stack\n");
    value_t* value = self->values_data;
    while (value != self->values_top) {
        libc__printf("[ ");
        value__print(*value++);
        libc__printf(" ]");
    }
    libc__printf("\n");
    
    libc__printf("     instructions disasm\n");
    ASSERT(chunk->instructions <= self->ip);
    chunk__disasm_ins(chunk, (u32) (self->ip - chunk->instructions));
    libc__printf("\n");
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

static void vm__push(vm_t* self, value_t value) {
    ASSERT(self->values_top < self->values_data + self->values_size && "overflow");

    *self->values_top++ = value;
}

static value_t vm__pop(vm_t* self) {
    ASSERT(self->values_top > self->values_data && "underflow");

    return *--self->values_top;
}

bool vm__create(vm_t* self, allocator_t* allocator) {
    self->ip = 0;
    self->values_data = 0;
    self->values_top = 0;
    self->values_size = 0;

    self->objs = 0;

    table__create(&self->obj_str_table, allocator);

    return true;
}

void vm__destroy(vm_t* self, allocator_t* allocator) {
    allocator__free(allocator, self->values_data);
    vm__free_objs(self, allocator);
    table__destroy(&self->obj_str_table);

    libc__memset(self, 0, sizeof(*self));
}

bool vm__run_file(vm_t* self, allocator_t* allocator, const char* path) {
    size_t script_file_size;
    if (file__size(path, &script_file_size) == false) {
        return false;
    }
    char* script_file_contents = allocator__alloc(allocator, script_file_size + 1);

    file_t script_file;
    if (file__open(&script_file, path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false) {
        return false;
    }
    u32 script_file_contents_len = file__read(&script_file, script_file_contents, script_file_size);
    script_file_contents[script_file_contents_len] = '\0';
    file__close(&script_file);

    vm_interpret_result_t result = vm__run_source(self, allocator, script_file_contents);
    switch (result) {
        case VM_OK: {
            libc__printf("VM: No errors compiling and running file '%s'\n", path);
        } break ;
        case VM_COMPILE_ERROR: {
            libc__printf("VM: Compilation error in file '%s'\n", path);
        } break ;
        case VM_RUNTIME_ERROR: {
            libc__printf("VM: Runtime error in file '%s'\n", path);
        } break ;
    }

    libc__free(script_file_contents);

    return true;
}

bool vm__run_repl(vm_t* self, allocator_t* allocator) {
    console_t console = console__init_module(KILOBYTES(1), false);
    size_t line_buffer_size = KILOBYTES(1);
    char*  line_buffer = allocator__alloc(allocator, line_buffer_size);

    bool prompt_is_running = true;
    while (prompt_is_running) {
        console__write(console, "> ");
        u32 read_line_length = console__read_line(console, line_buffer, line_buffer_size - 2);
        line_buffer[read_line_length] = '\n';
        line_buffer[read_line_length + 1] = '\0';

        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            vm__run_source(self, allocator, line_buffer);
        }
    }

    allocator__free(allocator, line_buffer);
    console__deinit_module(console);

    return true;
}

static vm_interpret_result_t vm__run_source(vm_t* self, allocator_t* allocator, const char* source) {
    chunk_t chunk;
    chunk__create(&chunk, allocator);

    compiler_t compiler;
    compiler__init(&compiler, self, source);
    if (!compiler__compile(&compiler, allocator, &chunk)) {
        chunk__destroy(&chunk, allocator);
        return VM_COMPILE_ERROR;
    }

    vm_interpret_result_t result = vm__interpret(self, allocator, &chunk);

    chunk__destroy(&chunk, allocator);

    return result;
}

static void vm__error(vm_t* self, chunk_t* chunk, const char* err_msg, ...) {
    va_list ap;

    va_start(ap, err_msg);
    libc__vprintf(err_msg, ap);
    va_end(ap);
    libc__printf("\n");

    ASSERT(chunk->instructions < self->ip);
    u32 line = chunk__ins_get_line(chunk, self->ip - chunk->instructions - 1);
    libc__printf("[line %u] in script.\n", line);

    self->values_top = self->values_data;
}

static void vm__free_objs(vm_t* self, allocator_t* allocator) {
    obj_t* obj = self->objs;
    while (obj) {
        obj_t* next = obj->next_free;
        obj__free(allocator, obj);
        obj = next;
    }
}

vm_interpret_result_t vm__interpret(vm_t* self, allocator_t* allocator, chunk_t* chunk) {
    self->ip = chunk->instructions;

    if (self->values_size < chunk->values_stack_size_watermark) {
        size_t new_values_data_size = chunk->values_stack_size_watermark << 1;
        self->values_data = allocator__realloc(allocator, self->values_data, self->values_size, new_values_data_size * sizeof(*self->values_data));
        self->values_size = new_values_data_size;
    }
    self->values_top = self->values_data;

    while (42) {
        vm__interpret_trace(self, chunk);
        
        u8 ins = vm__eat(self);

        switch (ins) {
            case INS_RETURN: {
                value_t value = vm__pop(self);
                value__print(value);
                libc__printf("\n");
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
                ASSERT(self->values_top != self->values_data);
                value_t* value = self->values_top - 1;
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
                    vm__push(self, value__obj((obj_t*) obj__cat_str(self, allocator, left, right)));
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
                ASSERT(self->values_top != self->values_data);
                value_t* value = self->values_top - 1;
                vm__push(self, value__bool(value__is_falsey(*value)));
            } break ;
            case INS_EQ: {
                value_t right = vm__pop(self);
                value_t left = vm__pop(self);
                vm__push(self, value__bool(value__is_eq(left, right)));
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
            case INS_GT: {
                value_t right = vm__pop(self);
                value_t left  = vm__pop(self);
                if (!value__is_num(left) || !value__is_num(right)) {
                    vm__error(self, chunk, "Operands must be numbers.");
                    return VM_RUNTIME_ERROR;
                }
                vm__push(self, value__bool(value__as_num(left) > value__as_num(right)));
            } break ;
            default: ASSERT(false);
        }
    }
}
