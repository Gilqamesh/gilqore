#include "debug.h"
#include "chunk.h"
#include "value.h"

#include "libc/libc.h"

#define IP_FORMAT "%04d "
#define LINE_FORMAT "%04d "
#define INS_FORMAT "%-16s "

static u32  disasm__simple(const char* instruction, u32 ip);
static void disasm__imm_interal(const char* instruction, chunk_t* self, u32 imm_ip);
static u32  disasm__imm(const char* instruction, chunk_t* self, u32 ip);
static u32  disasm__imm_long(const char* instruction, chunk_t* self, u32 ip);

static u32 disasm__simple(const char* instruction, u32 ip) {
    libc__printf("%s\n", instruction);
    return ip + 1;
}

static void disasm__imm_interal(const char* instruction, chunk_t* self, u32 imm_ip) {
    libc__printf(INS_FORMAT, instruction);
    libc__printf(IP_FORMAT, imm_ip);
    libc__printf("'");

    value__print(self->immediates.values[imm_ip]);

    libc__printf("'\n");
}

static u32 disasm__imm(const char* instruction, chunk_t* self, u32 ip) {
    u8 imm_ip = self->instructions[ip + 1];
    disasm__imm_interal(instruction, self, imm_ip);

    return ip + 2;
}

static u32 disasm__imm_long(const char* instruction, chunk_t* self, u32 ip) {
    u32 imm_ip_high = self->instructions[ip + 1];
    u32 imm_ip_mid  = self->instructions[ip + 2];
    u32 imm_ip_low  = self->instructions[ip + 3];
    disasm__imm_interal(instruction, self, (imm_ip_high << 16) | (imm_ip_mid << 8) | imm_ip_low);

    return ip + 4;
}

void chunk__disasm(chunk_t* self, const char* name) {
    libc__printf("--== %s ==--\n", name);

    for (u32 ip = 0; ip < self->instructions_fill;) {
        ip = chunk__disasm_ins(self, ip);
    }
}

u32 chunk__disasm_ins(chunk_t* self, u32 ip) {
    libc__printf(IP_FORMAT, ip);
    u32 line = chunk__ins_get_line(self, ip);
    if (ip > 0 && line == chunk__ins_get_line(self, ip - 1)) {
        libc__printf("   | ");
    } else {
        libc__printf(LINE_FORMAT, line);
    }

    u8 ins = self->instructions[ip];
    switch (ins) {
        case INS_RETURN: {
            return disasm__simple("INS_RETURN", ip);
        } break ;
        case INS_IMM: {
            return disasm__imm("INS_IMM", self, ip);
        } break ;
        case INS_IMM_LONG: {
            return disasm__imm_long("INS_IMM_LONG", self, ip);
        } break ;
        case INS_NIL: {
            return disasm__simple("INS_NIL", ip);
        } break ;
        case INS_TRUE: {
            return disasm__simple("INS_TRUE", ip);
        } break ;
        case INS_FALSE: {
            return disasm__simple("INS_FALSE", ip);
        } break ;
        case INS_NEG: {
            return disasm__simple("INS_NEG", ip);
        } break ;
        case INS_ADD: {
            return disasm__simple("INS_ADD", ip);
        } break ;
        case INS_SUB: {
            return disasm__simple("INS_SUB", ip);
        } break ;
        case INS_MUL: {
            return disasm__simple("INS_MUL", ip);
        } break ;
        case INS_DIV: {
            return disasm__simple("INS_DIV", ip);
        } break ;
        case INS_NOT: {
            return disasm__simple("INS_NOT", ip);
        } break ;
        case INS_EQ: {
            return disasm__simple("INS_EQ", ip);
        } break ;
        case INS_GT: {
            return disasm__simple("INS_GT", ip);
        } break ;
        case INS_LT: {
            return disasm__simple("INS_LT", ip);
        } break ;
        case INS_PRINT: {
            return disasm__simple("INS_PRINT", ip);
        } break ;
        case INS_POP: {
            return disasm__simple("INS_POP", ip);
        } break ;
        case INS_DEFINE_GLOBAL: {
            return disasm__simple("INS_DEFINE_GLOBAL", ip);
        } break ;
        case INS_GET_GLOBAL: {
            return disasm__simple("INS_GET_GLOBAL", ip);
        } break ;
        case INS_SET_GLOBAL: {
            return disasm__simple("INS_SET_GLOBAL", ip);
        } break ;
        default: {
            libc__printf("Unknown instruction %d\n", ins);
            return ip + 1;
        }
    }
}
