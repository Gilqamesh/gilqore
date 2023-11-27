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

    INS_PUSH,
    INS_POP,             // pop reg_t sized value from stack

    INS_PUSHF,           // push regf_t sized floating point argument onto the stack
    INS_POPF,            // pop regf_t sized floating point from the stack

    INS_PUSH_TYPE,
    INS_POP_TYPE,
    INS_POPN_TYPE,

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
    INS_DUP,
    INS_DUPF,
    INS_NEG,
    INS_NEGF,
    INS_INC,
    INS_DEC,

    INS_CVTF2I,
    INT_CVTI2F,

    // logical
    INS_LNOT,
    INS_LAND,
    INS_LOR,

    // bitwise
    INS_BNOT,
    INS_BXOR,
    INS_BAND,
    INS_BOR,

    INS_JMP,
    INS_JZ,
    INS_JZF,
    INS_JL,
    INS_JLF,
    INS_JG,
    INS_JGF,
    INS_JE,
    INS_JEF,
    INS_JLE,
    INS_JLEF,
    INS_JGE,
    INS_JGEF,

    /*
        memory access (between memory and registers)
        LRA, LRAF: load atom into register(f)-buffer from aligned-buffer
        SAR, SARF: store atom into aligned-buffer from register(f)-buffer
        arguments:
            - aligned buffer type
            - offset index of type (from top of the buffer, must be positive)
            - offset of atom (from addr of type)
            - size of atom (max reg_size)
        LREA: load address into register-buffer from aligned-buffer
        arguments:
            - aligned buffer type
            - offset index of type (from top of the buffer, must be positive)
            - offset of member (does not have to be an atom)
    */
    INS_LRA,
    INS_LRAF,
    INS_SAR,
    INS_SARF,
    INS_LREA,

    INS_CALL_INTERNAL,
    INS_CALL_EXTERNAL,
    INS_CALL_BUILTIN,

    INS_RET,
    INS_EXIT
} ins_t;

const char* ins__to_str(ins_t ins);
uint8_t* ins__vadd(ins_t ins, uint8_t* ip, va_list ap);
uint8_t* ins__add(ins_t ins, uint8_t* ip, ...);

#endif // INS_H
