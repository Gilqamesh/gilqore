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
        case INS_PUSH: {
            reg_t n = va_arg(ap, reg_t);
            IP_PUSH(ip, reg_t, n);

            debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
        } break ;
        case INS_PUSHF: {
            regf_t n = va_arg(ap, regf_t);
            IP_PUSH(ip, regf_t, n);

            debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) n);
        } break ;
        case INS_PUSH_TYPE: {
            type_t* type = va_arg(ap, type_t*);
            uint8_t buffer_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint64_t alignment = type__alignment(type);
            uint64_t size = type__size(type);
            IP_PUSH(ip, uint8_t, buffer_type);
            IP_PUSH(ip, uint64_t, alignment);
            IP_PUSH(ip, uint64_t, size);

            aligned_buffer_type_t aligned_buffer_type = (aligned_buffer_type_t) buffer_type;
            ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
            
            debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
        } break ;
        case INS_POP_TYPE: {
            uint8_t buffer_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            IP_PUSH(ip, uint8_t, buffer_type);

            aligned_buffer_type_t aligned_buffer_type = (aligned_buffer_type_t) buffer_type;
            ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);

            debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
        } break ;
        case INS_POPN_TYPE: {
            uint8_t buffer_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint8_t n = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            IP_PUSH(ip, uint8_t, buffer_type);
            IP_PUSH(ip, uint8_t, n);

            aligned_buffer_type_t aligned_buffer_type = (aligned_buffer_type_t) buffer_type;
            ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);

            debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
        } break ;
        case INS_POP:
        case INS_POPF:
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
        case INS_DUP:
        case INS_DUPF:
        case INS_NEG:
        case INS_NEGF:
        case INS_INC:
        case INS_DEC:
        case INS_CVTF2I:
        case INT_CVTI2F:
        case INS_LNOT:
        case INS_LAND:
        case INS_LOR:
        case INS_BNOT:
        case INS_BXOR:
        case INS_BAND:
        case INS_BOR: {
        } break ;
        case INS_JMP: {
            uint8_t* addr = va_arg(ap, uint8_t*);
            IP_PUSH(ip, uint8_t*, addr);

            debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
        } break ;
        case INS_JZ:
        case INS_JZF:
        case INS_JL:
        case INS_JLF:
        case INS_JG:
        case INS_JGF:
        case INS_JE:
        case INS_JEF:
        case INS_JLE:
        case INS_JLEF:
        case INS_JGE:
        case INS_JGEF: {
            uint8_t* addr = va_arg(ap, uint8_t*);
            IP_PUSH(ip, uint8_t*, addr);

            debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
        } break ;
        case INS_LRA:
        case INS_LRAF:
        case INS_SAR:
        case INS_SARF: {
            uint8_t buffer_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint8_t offset_index_of_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint32_t offset_of_atom = va_arg(ap, uint32_t);
            uint8_t size_of_atom = va_arg(ap, uint32_t);
            IP_PUSH(ip, uint8_t, buffer_type);
            IP_PUSH(ip, uint8_t, offset_index_of_type);
            IP_PUSH(ip, uint32_t, offset_of_atom);
            IP_PUSH(ip, uint8_t, size_of_atom);

            aligned_buffer_type_t aligned_buffer_type = (aligned_buffer_type_t) buffer_type;
            ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);

            debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
        } break ;
        case INS_LREA: {
            uint8_t buffer_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint8_t offset_index_of_type = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            uint32_t offset_of_member = va_arg(ap, uint32_t);
            IP_PUSH(ip, uint8_t, buffer_type);
            IP_PUSH(ip, uint8_t, offset_index_of_type);
            IP_PUSH(ip, uint32_t, offset_of_member);

            aligned_buffer_type_t aligned_buffer_type = (aligned_buffer_type_t) buffer_type;
            ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);

            debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
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
        case INS_EXIT: {
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
    case INS_PUSH: return "PUSH";
    case INS_POP: return "POP";
    case INS_POPF: return "POPF";
    case INS_PUSHF: return "PUSHF";
    case INS_PUSH_TYPE: return "PUSH_TYPE";
    case INS_POP_TYPE: return "POP_TYPE";

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
    case INS_DUP: return "DUP";
    case INS_DUPF: return "DUPF";
    case INS_NEG: return "NEG";
    case INS_NEGF: return "NEGF";
    case INS_INC: return "INC";
    case INS_DEC: return "DEC";
    case INS_CVTF2I: return "CVTF2I";
    case INT_CVTI2F: return "CVTI2F";
    case INS_LNOT: return "LNOT";
    case INS_LAND: return "LAND";
    case INS_LOR: return "LOR";
    case INS_BNOT: return "BNOT";
    case INS_BXOR: return "BXOR";
    case INS_BAND: return "BAND";
    case INS_BOR: return "BOR";
    case INS_JMP: return "JMP";
    case INS_JZ: return "JZ";
    case INS_JZF: return "JZF";
    case INS_JL: return "JL";
    case INS_JLF: return "JLF";
    case INS_JG: return "JG";
    case INS_JGF: return "JGF";
    case INS_JE: return "JE";
    case INS_JEF: return "JEF";
    case INS_JLE: return "JLE";
    case INS_JLEF: return "JLEF";
    case INS_JGE: return "JGE";
    case INS_JGEF: return "JGEF";

    case INS_LRA: return "LRA";
    case INS_LRAF: return "LRAF";
    case INS_SAR: return "SAR";
    case INS_SARF: return "SARF";
    case INS_LREA: return "LREA";

    case INS_CALL_INTERNAL: return "CALL_INTERNAL";
    case INS_CALL_EXTERNAL: return "CALL_EXTERNAL";
    case INS_CALL_BUILTIN: return "CALL_BUILTIN";

    case INS_RET: return "RET";
    case INS_EXIT: return "EXIT";

    default: ASSERT(false);
    }
}
