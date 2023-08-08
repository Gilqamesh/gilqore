#include "vm.h"

#include "chunk.h"
#include "debug.h"
#include "value.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"

#define DEBUG_VM_TRACE

// trace the current state of the vm
static void    vm__interpret_trace(vm_t* self, chunk_t* chunk);
// push value on the value stack
static void    vm__push           (vm_t* self, value_t value);
// pop value from the value stack
static value_t vm__pop            (vm_t* self);

static void vm__interpret_trace(vm_t* self, chunk_t* chunk) {
#if defined(DEBUG_VM_TRACE)
    libc__printf("--== vm trace ==--\n"); 
    libc__printf("     values stack\n");
    values_stack_t* stack = &self->values;
    value_t* value = stack->data;
    while (value != stack->top) {
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

static void vm__push(vm_t* self, value_t value) {
    ASSERT(self->values.top < self->values.data + self->values.data_size && "overflow");

    *self->values.top++ = value;
}

static value_t vm__pop(vm_t* self) {
    ASSERT(self->values.top > self->values.data && "underflow");

    return *--self->values.top;
}

bool vm__create(vm_t* self, allocator_t* allocator) {
    (void) allocator;

    self->ip = 0;
    self->values.data = 0;
    self->values.top = 0;
    self->values.data_size = 0;

    return true;
}

void vm__destroy(vm_t* self, allocator_t* allocator) {
    allocator__free(allocator, self->values.data);
    libc__memset(self, 0, sizeof(*self));
}

bool vm__run_file(vm_t* self, const char* path, allocator_t* allocator) {
    (void) path;
    (void) allocator;

    return true;
}

bool vm__run_repl(vm_t* self, allocator_t* allocator) {
    console_t console = console__init_module(KILOBYTES(1), false);
    bool prompt_is_running = true;
    char line_buffer[KILOBYTES(1)];
    while (prompt_is_running) {
        console__write(console, "> ");
        // libc__printf("> ");
        u32 read_line_length = console__read_line(console, line_buffer, ARRAY_SIZE(line_buffer) - 2);
        line_buffer[read_line_length] = '\n';
        line_buffer[read_line_length + 1] = '\0';
        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            vm__interpret(self, allocator);
            prompt_is_running |= run_source(self, line_buffer, read_line_length);
        }
    }

    console__deinit_module(console);

    return true;
}

vm_code_t vm__interpret(vm_t* self, allocator_t* allocator, chunk_t* chunk) {
#define READ_BYTE() (*self->ip++)
#define READ_IMM() (chunk->immediates.values[READ_BYTE()])
#define READ_IMM_LONG(value) { \
    u32 imm_index = READ_BYTE()  << 16; \
    imm_index     += READ_BYTE() << 8; \
    imm_index     += READ_BYTE(); \
    value = chunk->immediates.values[imm_index]; \
} while (false)
#define INS_BINARY(op) { \
    value_t right = vm__pop(self); \
    value_t left  = vm__pop(self); \
    vm__push(self, left op right); \
} while (false)

    self->ip = chunk->instructions;

    if (self->values.data_size < chunk->values_stack_size_watermark) {
        size_t new_values_data_size = chunk->values_stack_size_watermark << 1;
        self->values.data = allocator__realloc(allocator, self->values.data, self->values.data_size, new_values_data_size);
        self->values.data_size = new_values_data_size;
    }
    self->values.top = self->values.data;

    while (42) {
        vm__interpret_trace(self, chunk);
        
        u8 ins = READ_BYTE();

        switch (ins) {
            case INS_RETURN: {
                value_t value = vm__pop(self);
                value__print(value);
                libc__printf("\n");
                return VM_OK;
            } break ;
            case INS_IMM: {
                value_t imm = READ_IMM();
                vm__push(self, imm);
            } break ;
            case INS_IMM_LONG: {
                value_t imm_long;
                READ_IMM_LONG(imm_long);
                vm__push(self, imm_long);
            } break ;
            case INS_NEG: {
                ASSERT(self->values.top != self->values.data);
                value_t* value = self->values.top - 1;
                *value = -*value;
            } break ;
            case INS_ADD: {
                INS_BINARY(+);
            } break ;
            case INS_SUB: {
                INS_BINARY(-);
            } break ;
            case INS_MUL: {
                INS_BINARY(*);
            } break ;
            case INS_DIV: {
                INS_BINARY(/);
            } break ;
            default: ASSERT(false);
        }
    }

#undef READ_BYTE
#undef READ_IMM
#undef READ_IMM_LONG
#undef INS_BINARY
}
