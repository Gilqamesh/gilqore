#include "ins.h"

#include <assert.h>

#include "types.h"
#include "debug.h"

uint8_t* ins__vadd(ins_t ins, uint8_t* ip, va_list ap) {
    debug__set_ip(&debug, ip);

    *ip++ = (uint8_t) ins;
    switch (ins) {
        case INS_PUSH: {
            reg_t n = va_arg(ap, reg_t);
            CODE_PUSH(ip, reg_t, n);
        } break ;
        case INS_PUSH_TYPE: {
            type_t* type = va_arg(ap, type_t*);
            uint64_t alignment = type__alignment(type);
            uint64_t size = type__size(type);
            CODE_PUSH(ip, uint64_t, alignment);
            CODE_PUSH(ip, uint64_t, size);
        } break ;
        case INS_POP_TYPE: {
        } break ;
        case INS_PUSHF: {
            regf_t n = va_arg(ap, regf_t);
            CODE_PUSH(ip, regf_t, n);
        } break ;
        case INS_PUSH_SP: {
        } break ;
        case INS_PUSH_BP: {
        } break ;
        case INS_POP_SP: {
        } break ;
        case INS_POP_BP: {
        } break ;
        case INS_MOV_REG: {
            uint8_t dst_reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            uint8_t src_reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(ip, uint8_t, dst_reg);
            CODE_PUSH(ip, uint8_t, src_reg);
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
        case INS_NOT:
        case INS_XOR:
        case INS_AND:
        case INS_OR: {
        } break ;
        case INS_JMP: {
            uint8_t* addr = va_arg(ap, uint8_t*);
            CODE_PUSH(ip, uint8_t*, addr);
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
            CODE_PUSH(ip, uint8_t*, addr);
        } break ;
        case INS_STACK_LOAD:
        case INS_STACK_STORE: {
            uint8_t bytes = va_arg(ap, uint32_t);
            CODE_PUSH(ip, uint8_t, bytes);
        } break ;
        case INS_CALL_INTERNAL: {
            type_internal_function_t* internal_function = va_arg(ap, type_internal_function_t*);
            CODE_PUSH(ip, type_internal_function_t*, internal_function);

            debug__push_ins_arg_str(&debug, internal_function->name);
        } break ;
        case INS_CALL_EXTERNAL: {
            type_external_function_t* external_function = va_arg(ap, type_external_function_t*);
            CODE_PUSH(ip, type_external_function_t*, external_function);

            debug__push_ins_arg_str(&debug, external_function->name);
        } break ;
        case INS_CALL_BUILTIN: {
            type_builtin_function_t* builtin_function = va_arg(ap, type_builtin_function_t*);
            CODE_PUSH(ip, type_builtin_function_t*, builtin_function);

            debug__push_ins_arg_str(&debug, builtin_function->name);
        } break ;
        case INS_RET: {
            uint16_t number_of_arguments = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            CODE_PUSH(ip, uint16_t, number_of_arguments);
        } break ;
        case INS_EXIT: {
        } break ;
        default: ASSERT(false);
    }

    debug__dump_line(&debug, debug.compiled_code_file);

    return ip;
}

uint8_t* ins__add(ins_t ins, uint8_t* ip, ...) {
    va_list ap;
    va_start(ap, ip);

    ip = ins__vadd(ins, ip, ap);

    va_end(ap);

    return ip;
}

const char* enum_ins__to_str(ins_t ins) {
    switch (ins) {
    case INS_PUSH: return "PUSH";
    case INS_PUSH_TYPE: return "PUSH_TYPE";
    case INS_PUSHF: return "PUSHF";
    case INS_PUSH_SP: return "PUSH_SP";
    case INS_PUSH_BP: return "PUSH_BP";
    case INS_POP: return "POP";
    case INS_POP_TYPE: return "POP_TYPE";
    case INS_POPF: return "POPF";
    case INS_POP_SP: return "POP_SP";
    case INS_POP_BP: return "POP_BP";
    case INS_POP_REG: return "POP_REG";
    case INS_MOV_REG: return "MOV_REG";
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
    case INS_NOT: return "NOT";
    case INS_XOR: return "XOR";
    case INS_AND: return "AND";
    case INS_OR: return "OR";
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
    case INS_STACK_LOAD: return "STACK_LOAD";
    case INS_STACK_STORE: return "STACK_STORE";
    case INS_CALL_INTERNAL: return "CALL_INTERNAL";
    case INS_CALL_EXTERNAL: return "CALL_EXTERNAL";
    case INS_CALL_BUILTIN: return "CALL_BUILTIN";
    case INS_RET: return "RET";
    case INS_EXIT: return "EXIT";
    case INS_NOP: return "NOP";
    default: ASSERT(false);
    }
}
