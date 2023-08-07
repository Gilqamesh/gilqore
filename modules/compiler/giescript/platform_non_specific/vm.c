#include "vm.h"

#include "chunk.h"
#include "debug.h"
#include "value.h"

#include "libc/libc.h"

#define DEBUG_TRACE_EXECUTION

void vm__create(vm_t* self) {
    (void) self;
}

void vm__destroy(vm_t* self) {
    (void) self;
}

vm_code_t vm__interpret(vm_t* self, chunk_t* chunk) {
#define READ_BYTE() (*self->ip++)
#define READ_IMM() (chunk->immediates.values[READ_BYTE()])
#define READ_IMM_LONG(value) { \
    u32 imm_index = READ_BYTE()  << 16; \
    imm_index     += READ_BYTE() << 8; \
    imm_index     += READ_BYTE(); \
    value = chunk->immediates.values[imm_index]; \
}

    self->ip = chunk->code;

    while (42) {
        u8 op = READ_BYTE();

#if defined(DEBUG_TRACE_EXECUTION)
        ASSERT(chunk->code <= self->ip);
        chunk__disasm_op(chunk, (u32) (self->ip - chunk->code));
#endif

        switch (op) {
            case OP_RETURN: {
                return VM_OK;
            } break ;
            case OP_IMM: {
                value_t imm = READ_IMM();
                value__print(imm);
                libc__printf("\n");
            } break ;
            case OP_IMM_LONG: {
                value_t imm_long;
                READ_IMM_LONG(imm_long);
                value__print(imm_long);
                libc__printf("\n");
            } break ;
            default: ASSERT(false);
        }
    }

#undef READ_BYTE
#undef READ_IMM
#undef READ_IMM_LONG
}
