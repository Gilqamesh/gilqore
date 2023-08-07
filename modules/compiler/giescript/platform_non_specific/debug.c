#include "debug.h"
#include "chunk.h"
#include "value.h"

#include "libc/libc.h"

#define IP_FORMAT "%04d "
#define LINE_FORMAT "%04d "
#define OP_FORMAT "%-16s "

static u32 disasm__simple(const char* op, u32 ip) {
    libc__printf("%s\n", op);
    return ip + 1;
}

static void disasm__imm_interal(const char* op, chunk_t* self, u32 imm_ip) {
    libc__printf(OP_FORMAT, op);
    libc__printf(IP_FORMAT, imm_ip);
    libc__printf("'");

    value__print(self->immediates.values[imm_ip]);

    libc__printf("'\n");
}

static u32 disasm__imm(const char* op, chunk_t* self, u32 ip) {
    u8 imm_ip = self->code[ip + 1];
    disasm__imm_interal(op, self, imm_ip);

    return ip + 2;
}

static u32 disasm__imm_long(const char* op, chunk_t* self, u32 ip) {
    u32 imm_ip_high = self->code[ip + 1];
    u32 imm_ip_mid  = self->code[ip + 2];
    u32 imm_ip_low  = self->code[ip + 3];
    disasm__imm_interal(op, self, (imm_ip_high << 16) | (imm_ip_mid << 8) | imm_ip_low);

    return ip + 4;
}

static u32 op__get_line(chunk_t* self, u32 ip) {
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

void chunk__disasm(chunk_t* self, const char* name) {
    libc__printf("--== %s ==--\n", name);

    for (u32 ip = 0; ip < self->code_fill;) {
        ip = chunk__disasm_op(self, ip);
    }
}

u32 chunk__disasm_op(chunk_t* self, u32 ip) {
    libc__printf(IP_FORMAT, ip);
    u32 line = op__get_line(self, ip);
    if (ip > 0 && line == op__get_line(self, ip - 1)) {
        libc__printf("   | ");
    } else {
        libc__printf(LINE_FORMAT, line);
    }

    u8 op = self->code[ip];
    switch (op) {
        case OP_IMM: {
            return disasm__imm("OP_IMM", self, ip);
        } break ;
        case OP_IMM_LONG: {
            return disasm__imm_long("OP_IMM_LONG", self, ip);
        } break ;
        case OP_RETURN: {
            return disasm__simple("OP_RETURN", ip);
        } break ;
        default: {
            libc__printf("Unknown opcode %d\n", op);
            return ip + 1;
        }
    }
}
