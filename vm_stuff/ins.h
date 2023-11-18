#ifndef INS_H
# define INS_H

# include <stdint.h>
# include <stdarg.h>
# include <stdbool.h>

#define CODE_PUSH(ip, type, a) do { \
    *(type*) ip = a; \
    debug__push_code(&debug, (uint8_t*)&a, sizeof(type)); \
    ip += sizeof(type); \
} while (false)
#define CODE_POP(ip, type, result) do { \
    (result) = *(type*) (ip); \
    (ip) += sizeof(type); \
    debug__push_code(&debug, (uint8_t*)&result, sizeof(type)); \
} while (false)

// todo: change these into types?
typedef struct reg {
    uint64_t _;
    uint64_t __;
} reg_t;
typedef struct regf {
    double _;
    double __;
} regf_t;
// static_ASSERT(sizeof(reg_t) <= (uint8_t)-1, "instructions such as INS_STACK_LOAD takes in the number of bytes to load, which couldn't be more than size of reg_t");


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
    INS_PUSH,           // push reg_t sized integer argument onto the stack
    INS_PUSH_TYPE,      // push sp until 64-bit alignment argument is met followed by 64-bit size argument
    INS_PUSHF,          // push regf_t sized floating point argument onto the stack
    INS_PUSH_SP,        // push stack pointer onto the stack
    INS_PUSH_BP,        // push base pointer onto the stack
    INS_POP,
    INS_POP_TYPE,       // pop sp until 64-bit alignment argument is met followed by 64-bit size argument
    INS_POPF,
    INS_POP_SP,
    INS_POP_BP,
    INS_POP_REG,
    INS_MOV_REG,
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
    INS_NOT,
    INS_XOR,
    INS_AND,
    INS_OR,
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
    INS_STACK_LOAD,
    INS_STACK_STORE,
    INS_CALL_INTERNAL,
    INS_CALL_EXTERNAL,
    INS_CALL_BUILTIN,
    INS_RET,
    INS_EXIT,
    INS_NOP
} ins_t;

const char* enum_ins__to_str(ins_t ins);
uint8_t* ins__vadd(ins_t ins, uint8_t* ip, va_list ap);
uint8_t* ins__add(ins_t ins, uint8_t* ip, ...);

#endif // INS_H
