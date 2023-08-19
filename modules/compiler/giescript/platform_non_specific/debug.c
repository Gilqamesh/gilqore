#include "debug.h"
#include "chunk.h"
#include "value.h"

#include "libc/libc.h"

#define IP_FORMAT "%04d "
#define INS_FORMAT "%-16s "

static u32  disasm__simple(const char* instruction, u32 ip);
static void disasm__imm_interal(const char* instruction, chunk_t* chunk, u32 imm_ip);
static u32  disasm__imm(const char* instruction, chunk_t* chunk, u32 ip);
static u32  disasm__imm_long(const char* instruction, chunk_t* chunk, u32 ip);
// static u32  disasm__local(const char* instruction, chunk_t* chunk, u32 ip);

// static u32  disasm__get_index(chunk_t* chunk, u32 ip, u32* index);

static u32 disasm__simple(const char* instruction, u32 ip) {
    libc__printf("%s\n", instruction);
    return ip + 1;
}

static void disasm__imm_interal(const char* instruction, chunk_t* chunk, u32 imm_ip) {
    libc__printf(INS_FORMAT, instruction);
    libc__printf(IP_FORMAT, imm_ip);
    libc__printf("'");

    value__print(chunk->immediates.values[imm_ip]);

    libc__printf("'\n");
}

static u32 disasm__imm(const char* instruction, chunk_t* chunk, u32 ip) {
    u8 imm_ip = chunk->instructions[ip + 1];
    disasm__imm_interal(instruction, chunk, imm_ip);

    return ip + 2;
}

static u32 disasm__imm_long(const char* instruction, chunk_t* chunk, u32 ip) {
    u32 imm_ip_high = chunk->instructions[ip + 1];
    u32 imm_ip_mid  = chunk->instructions[ip + 2];
    u32 imm_ip_low  = chunk->instructions[ip + 3];
    disasm__imm_interal(instruction, chunk, (imm_ip_high << 16) | (imm_ip_mid << 8) | imm_ip_low);

    return ip + 4;
}

// static u32 disasm__local(const char* instruction, chunk_t* chunk, u32 ip) {
//     u32 local_index;
//     ++ip; // skip INS_GET_LOCAL/INS_SET_LOCAL
//     u32 index_len = disasm__get_index(chunk, ip, &local_index);
//     libc__printf(INS_FORMAT, instruction);
//     libc__printf(IP_FORMAT, local_index);
//     libc__printf("\n");

//     return ip + index_len + 1;
// }

// static u32 disasm__get_index(chunk_t* chunk, u32 ip, u32* index) {
//     u8 ins = chunk->instructions[ip];
//     u32 index_len;
//     switch (ins) {
//         case INS_IMM: {
//             *index = chunk->instructions[ip + 1];
//             index_len = 1;
//         } break ;
//         case INS_IMM_LONG: {
//             u32 imm_ip_high = chunk->instructions[ip + 1];
//             u32 imm_ip_mid  = chunk->instructions[ip + 2];
//             u32 imm_ip_low  = chunk->instructions[ip + 3];
//             *index = (imm_ip_high << 16) | (imm_ip_mid << 8) | imm_ip_low;
//             index_len = 3;
//         } break ;
//         default: {
//             ASSERTFV(false, "\n!! 'ins: %u' !!\n", ins);
//         }
//     }

//     return index_len;
// }

void chunk__disasm(chunk_t* self, const char* name) {
    libc__printf("--== %s ==--\n", name);

    for (u32 ip = 0; ip < self->instructions_fill;) {
        ip = chunk__disasm_ins(self, ip);
    }
}

u32 chunk__disasm_ins(chunk_t* self, u32 ip) {
    libc__printf(IP_FORMAT, ip);
    token_info_t* token_info = chunk__get_token_info(self, ip);
    libc__printf("%u:%u %u:%u ", token_info->line_s, token_info->col_s, token_info->line_e, token_info->col_e);

    u8 ins = self->instructions[ip];
    switch (ins) {
        case INS_RETURN: {
            return disasm__simple("RET", ip);
        } break ;
        case INS_IMM: {
            return disasm__imm("IMM", self, ip);
        } break ;
        case INS_IMM_LONG: {
            return disasm__imm_long("IMML", self, ip);
        } break ;
        case INS_NIL: {
            return disasm__simple("NIL", ip);
        } break ;
        case INS_TRUE: {
            return disasm__simple("TRUE", ip);
        } break ;
        case INS_FALSE: {
            return disasm__simple("FALSE", ip);
        } break ;
        case INS_NEG: {
            return disasm__simple("NEG", ip);
        } break ;
        case INS_ADD: {
            return disasm__simple("ADD", ip);
        } break ;
        case INS_SUB: {
            return disasm__simple("SUB", ip);
        } break ;
        case INS_MUL: {
            return disasm__simple("MUL", ip);
        } break ;
        case INS_DIV: {
            return disasm__simple("DIV", ip);
        } break ;
        case INS_NOT: {
            return disasm__simple("NOT", ip);
        } break ;
        case INS_EQ: {
            return disasm__simple("EQ", ip);
        } break ;
        case INS_GT: {
            return disasm__simple("GT", ip);
        } break ;
        case INS_LT: {
            return disasm__simple("LT", ip);
        } break ;
        case INS_PRINT: {
            return disasm__simple("PRINT", ip);
        } break ;
        case INS_POP: {
            return disasm__simple("POP", ip);
        } break ;
        case INS_POPN: {
            return disasm__simple("POPN", ip);
        } break ;
        case INS_DEFINE_GLOBAL: {
            return disasm__simple("DEFG", ip);
        } break ;
        case INS_GET_GLOBAL: {
            return disasm__simple("GETG", ip);
        } break ;
        case INS_SET_GLOBAL: {
            return disasm__simple("SETG", ip);
        } break ;
        case INS_GET_LOCAL: {
            return disasm__simple("GETL", ip);
        } break ;
        case INS_SET_LOCAL: {
            return disasm__simple("SETL", ip);
        } break ;
        case INS_JUMP: {
            return disasm__simple("JMP", ip);
        } break ;
        case INS_JUMP_ON_FALSE: {
            return disasm__simple("JMPF", ip);
        } break ;
        case INS_JUMP_ON_TRUE: {
            return disasm__simple("JMPT", ip);
        } break ;
        default: {
            libc__printf("Unknown instruction %d\n", ins);
            return ip + 1;
        }
    }
}
