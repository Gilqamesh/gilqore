#include "ins.h"

#include <assert.h>

#include "types.h"
#include "debug.h"
#include "state.h"

uint8_t* ins__vadd(ins_t ins, uint8_t* ip, va_list ap) {
    debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_IP, ip);
    debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_MNEMONIC, ins__to_str(ins));

    *ip++ = (uint8_t) ins;
    switch (ins) {
    case INS_PRINT:
    case INS_PRINTF: {
    } break ;

    case INS_MOV_IMM: {
        reg_t imm = va_arg(ap, reg_t);
        IP_PUSH(ip, reg_t, imm);

        debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) imm);
    } break ;
    case INS_GROW: {
        int32_t n = va_arg(ap, int32_t);
        IP_PUSH(ip, int32_t, n);

        debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
    } break ;
    
    // case INS_PUSH_TYPE: {
    //     type_t* type = va_arg(ap, type_t*);
    //     uint64_t alignment = type__alignment(type);
    //     uint64_t size = type__size(type);
    //     IP_PUSH(ip, uint64_t, alignment);
    //     IP_PUSH(ip, uint64_t, size);
    // } break ;
    // case INS_PUSH: {
    //     reg_t n = va_arg(ap, reg_t);
    //     IP_PUSH(ip, reg_t, n);

    //     debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
    // } break ;
    // case INS_PUSHF: {
    //     regf_t n = va_arg(ap, regf_t);
    //     IP_PUSH(ip, regf_t, n);

    //     debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) n);
    // } break ;
    // case INS_POP: {
    // } break ;
    // case INS_POPN: {
    //     uint8_t n = va_arg(ap, uint32_t); // int is minimum va_arg can work with
    //     IP_PUSH(ip, uint8_t, n);
    // } break ;
    
    case INS_ADD:
    case INS_ADDF:
    case INS_SUB:
    case INS_SUBF:
    case INS_MUL:
    case INS_MULF:
    case INS_DIV:
    case INS_DIVF:
    case INS_MOD:
    case INS_MODF:
    case INS_NEG:
    case INS_NEGF:
    case INS_INC:
    case INS_DEC:
    
    case INS_CVTF2U:
    case INT_CVTU2F:
    case INT_CVTS2F:
    
    case INS_LNOT:
    case INS_LAND:
    case INS_LOR:
    case INS_LT:
    case INS_GT:
    case INS_EQ:
    case INS_LTF:
    case INS_GTF:
    case INT_EQF:
    
    case INS_BNOT:
    case INS_BXOR:
    case INS_BAND:
    case INS_BOR: {
    } break ;
    
    case INS_JMP:
    case INS_JT:
    case INS_JF: {
        uint8_t* addr = va_arg(ap, uint8_t*);
        IP_PUSH(ip, uint8_t*, addr);

        debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
    } break ;
    
    case INS_MOV: {
        uint32_t dst_offset_from_bp = va_arg(ap, uint32_t);
        uint32_t src_offset_from_bp = va_arg(ap, uint32_t);
        uint32_t src_size = va_arg(ap, uint32_t);
        IP_PUSH(ip, uint32_t, dst_offset_from_bp);
        IP_PUSH(ip, uint32_t, src_offset_from_bp);
        IP_PUSH(ip, uint32_t, src_size);
    } break ;
    // case INS_LOAD:
    // case INS_STORE: {
    //     uint8_t index_of_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
    //     uint32_t offset_of_member = va_arg(ap, uint32_t);
    //     uint32_t size_of_member = va_arg(ap, uint32_t);
    //     uint32_t alignment_of_member = va_arg(ap, uint32_t);
    //     IP_PUSH(ip, uint8_t, index_of_type);
    //     IP_PUSH(ip, uint32_t, offset_of_member);
    //     IP_PUSH(ip, uint32_t, size_of_member);
    //     IP_PUSH(ip, uint32_t, alignment_of_member);
    // } break ;
    case INS_LEA: {
        uint8_t index_of_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
        uint32_t offset_of_member = va_arg(ap, uint32_t);
        IP_PUSH(ip, uint8_t, index_of_type);
        IP_PUSH(ip, uint32_t, offset_of_member);
    } break ;
    
    case INS_CALL_INTERNAL:
    case INS_CALL_EXTERNAL:
    case INS_CALL_BUILTIN: {
        type_function_t* function = va_arg(ap, type_function_t*);
        IP_PUSH(ip, type_function_t*, function);

        debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, function->name);
    } break ;
    
    case INS_RET: {
    } break ;
    
    default: ASSERT(false);
    }

    debug__dump_line(&debug, DEBUG_OUT_MODE_COMPILE);
    debug__clear_line(&debug);

    return ip;
}

uint8_t* ins__add(ins_t ins, uint8_t* ip, ...) {
    va_list ap;
    va_start(ap, ip);

    ip = ins__vadd(ins, ip, ap);

    va_end(ap);

    return ip;
}

const char* ins__to_str(ins_t ins) {
    switch (ins) {
    case INS_PRINT: return "PRINT";
    case INS_PRINTF: return "PRINTF";
    case INS_MOV_IMM: return "MOV_IMM";
    case INS_GROW: return "GROW";
    // case INS_PUSH_TYPE: return "PUSH_TYPE";
    // case INS_PUSH: return "PUSH";
    // case INS_PUSHF: return "PUSHF";
    // case INS_POP: return "POP";
    // case INS_POPN: return "POPN";

    case INS_ADD: return "ADD";
    case INS_ADDF: return "ADDF";
    case INS_SUB: return "SUB";
    case INS_SUBF: return "SUBF";
    case INS_MUL: return "MUL";
    case INS_MULF: return "MULF";
    case INS_DIV: return "DIV";
    case INS_DIVF: return "DIVF";
    case INS_MOD: return "MOD";
    case INS_MODF: return "MODF";
    case INS_NEG: return "NEG";
    case INS_NEGF: return "NEGF";
    case INS_INC: return "INC";
    case INS_DEC: return "DEC";

    case INS_CVTF2U: return "CVTF2U";
    case INT_CVTU2F: return "CVTU2F";
    case INT_CVTS2F: return "CVTS2F";

    case INS_LNOT: return "LNOT";
    case INS_LAND: return "LAND";
    case INS_LOR: return "LOR";
    case INS_LT: return "LT";
    case INS_GT: return "GT";
    case INS_EQ: return "EQ";
    case INS_LTF: return "LTF";
    case INS_GTF: return "GTF";
    case INT_EQF: return "EQF";

    case INS_BNOT: return "BNOT";
    case INS_BXOR: return "BXOR";
    case INS_BAND: return "BAND";
    case INS_BOR: return "BOR";

    case INS_JMP: return "JMP";
    case INS_JT: return "JT";
    case INS_JF: return "JF";

    case INS_MOV: return "MOV";
    // case INS_LOAD: return "LOAD";
    // case INS_STORE: return "STORE";
    case INS_LEA: return "LEA";

    case INS_CALL_INTERNAL: return "CALL_INTERNAL";
    case INS_CALL_EXTERNAL: return "CALL_EXTERNAL";
    case INS_CALL_BUILTIN: return "CALL_BUILTIN";

    case INS_RET: return "RET";

    default: ASSERT(false);
    }
}
