#include "debug.h"
#include "chunk.h"
#include "value.h"

#include "libc/libc.h"

static u32 ins__simple(const char* name, u32 ip) {
    libc__printf("%s\n", name);
    return ip + 1;
}

static u32 ins__constant(const char* name, chunk_t* self, u32 ip) {
    u8 constant_index = self->code[ip + 1];
    libc__printf("%-16s %4d '", name, constant_index);
    value__print(self->values.values[constant_index]);
    libc__printf("'\n");

    return ip + 2;
}

static u32 ins__get_line(chunk_t* self, u32 ip) {
    // 12 0   6 1   1 2  12  3
    u32 lines_index = 0;
    while (lines_index < self->lines_fill) {
        u32 n = self->lines[lines_index];
        u32 line = self->lines[lines_index + 1];
        if (ip < n) {
            return line;
        }
        ip -= n;

        lines_index += 2;
    }

    ASSERT(false);
    return -1;
}

void chunk__disassemble(chunk_t* self, const char* name) {
    libc__printf("--== %s ==--\n", name);

    for (u32 ip = 0; ip < self->code_fill;) {
        ip = chunk__disassemble_ins(self, ip);
    }
}

u32 chunk__disassemble_ins(chunk_t* self, u32 ip) {
    libc__printf("%04d ", ip);
    u32 line = ins__get_line(self, ip);
    if (ip > 0 && line == ins__get_line(self, ip - 1)) {
        libc__printf("   | ");
    } else {
        libc__printf("%4d ", line);
    }

    u8 ins = self->code[ip];
    switch (ins) {
        case OP_CONSTANT: {
            return ins__constant("OP_CONSTANT", self, ip);
        } break ;
        case OP_RETURN: {
            return ins__simple("OP_RETURN", ip);
        } break ;
        default: {
            libc__printf("Unknown opcode %d\n", ins);
            return ip + 1;
        }
    }
}
