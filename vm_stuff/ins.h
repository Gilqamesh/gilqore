#ifndef INS_H
# define INS_H

# include <stdint.h>
# include <stdarg.h>
# include <stdbool.h>

# include "buffer.h"

# define IP_PUSH(ip, type, a) do { \
    *(type*) (ip) = (a); \
    debug__push_hex(&debug, DEBUG_BUFFER_TYPE_INS_BYTECODE, (uint8_t*)(&(a)), sizeof(type)); \
    (ip) += sizeof(type); \
} while (false)
# define IP_POP(ip, type, result) do { \
    (result) = *(type*) (ip); \
    (ip) += sizeof(type); \
    debug__push_hex(&debug, DEBUG_BUFFER_TYPE_INS_BYTECODE, (uint8_t*)(&(result)), sizeof(type)); \
} while (false)

// todo: change these into types?
typedef uint64_t reg_t;
typedef double regf_t;

/* ABI
<reg_t>                     push
<u64 align> <u64 size>      push_type
<reg_t>                     pushf
                            push_sp
                            push_bp
                            pop
                            pop_aligned
                            popf
                            pop_sp
                            pop_bp
<u8 dst_reg> <u8 src_reg>   mov_reg
                            add
                            addf
                            sub
                            subf
                            mul
                            mulf
                            div
                            divf
                            mod
                            modf
                            dup
                            dupf
                            neg
                            negf
                            inc
                            dec
                            not
                            xor
                            and
                            or
<u8* ip>                    jmp
<u8* ip>                    jz
<u8* ip>                    jzf
<u8* ip>                    jl
<u8* ip>                    jlf
<u8* ip>                    jg
<u8* ip>                    jgf
<u8* ip>                    je
<u8* ip>                    jef
<u8* ip>                    jle
<u8* ip>                    jlef
<u8* ip>                    jge
<u8* ip>                    jgef
<u8 bytes>                  stack_load  // load from addr 1, 2, 4, or 8 bytes onto the stack
<u8 bytes>                  stack_store // store to addr 1, 2, 4, or 8 bytes from the stack
<type_internal_function_t*> call_internal
<type_external_function_t*> call_external // call c-compiled binary at loaded address (wip)
<type_builtin_function_t*>  call_builtin // temporary, until call_external is figured out
<u16>                       ret // pop argument amount of aligned arguments, and pop return address from the stack
                            exit
                            nop
*/

typedef enum ins {
    INS_PRINT,
    INS_PRINTF,

    // INS_PUSH_TYPE,

    // maybe have a data segment instead of these two
    // INS_PUSH,  // special push_type for reg_t  immediate
    // INS_PUSHF, // special push_type for regf_t immediate

    // todo: replace this with INS_LOAD from data segment
    INS_MOV_IMM, // copies reg_t size immediate on top of the stack, does not grow
    INS_GROW,    // grow stack by N bytes

    // INS_POP,
    // INS_POPN,

    /* ALU operations (between register(f) and register(f)) */
    INS_ADD,
    INS_ADDF,
    INS_SUB,
    INS_SUBF,
    INS_MUL,
    INS_MULF,
    INS_DIV,
    INS_DIVF,
    INS_MOD,
    INS_MODF,
    INS_NEG,
    INS_NEGF,
    INS_INC,
    INS_DEC,

    INS_CVTF2U,
    INT_CVTU2F,
    INT_CVTS2F,

    // logical
    INS_LNOT,
    INS_LAND,
    INS_LOR,
    INS_LT,
    INS_LTF,
    INS_GT,
    INS_GTF,
    INS_EQ,
    INT_EQF,

    // bitwise
    INS_BNOT,
    INS_BXOR,
    INS_BAND,
    INS_BOR,

    INS_JMP,
    INS_JT,
    INS_JF,

    /*
        MOV:
            - dst offset from BP
            - src offset from BP
            - src size

        LOAD: load type into stack from the stack
        STORE: store type from stack into stack
        arguments:
            - src offset from BP
            - src size to_load
            - alignment of member
        LEA: load address of type into stack from stack
        arguments:
            - offset from BP

            - index of type from BP
            - offset of member
    */
    INS_MOV,
    // INS_LOAD,
    // INS_STORE,
    INS_LEA,

    INS_CALL_INTERNAL,
    INS_CALL_EXTERNAL,
    INS_CALL_BUILTIN,

    INS_RET
} ins_t;

const char* ins__to_str(ins_t ins);
uint8_t* ins__add(ins_t ins, uint8_t* ip, ...);
uint8_t* ins__vadd(ins_t ins, uint8_t* ip, va_list ap);

#endif // INS_H
