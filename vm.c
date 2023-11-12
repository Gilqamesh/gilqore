#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <windows.h>
#include <stdarg.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include "types.h"
#if defined (__GNUC__)
# include <x86intrin.h>
#endif

#include "types.h"

// #define PROFILING

enum reg_type {
    REG_BP,

    _REG_TYPE_SIZE
};

typedef struct reg {
    uint64_t _;
    uint64_t __;
} reg_t;
typedef struct regf {
    double _;
    double __;
} regf_t;
static_assert(sizeof(reg_t) <= (uint8_t)-1, "instructions such as INS_STACK_LOAD takes in the number of bytes to load, which couldn't be more than size of reg_t");

enum ins {
    INS_PUSH8,      // push 8-bit argument onto the stack
    INS_PUSH16,     // push 16-bit argument onto the stack
    INS_PUSH32,     // push 32-bit argument onto the stack
    INS_PUSH,       // push reg_t sized integer argument onto the stack
    INS_PUSHF,      // push regf_t sized floating point argument onto the stack
    INS_PUSH_SP,    // grow stack by argument bytes
    INS_PUSH_REG,   // push argument register onto the stack
    INS_POP8,
    INS_POP16,
    INS_POP32,
    INS_POP,
    INS_POPF,
    INS_POP_SP,
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
    INS_CALL,
    INS_CALL_BUILTIN,
    INS_RET,
    INS_EXIT,

    _INS_SIZE
};

typedef struct state {
    uint8_t* ip;
    uint8_t* code;
    uint32_t code_size;

    uint8_t* stack_top;
    uint8_t* stack;
    uint32_t stack_size;
    uint8_t* base_pointer;

    reg_t exit_status_code;

    reg_t registers[_REG_TYPE_SIZE];

    type_t** types;
    uint32_t types_size;
    uint32_t types_top;

    bool     alive;
} state_t;

static void state__type_add(state_t* self, type_t* type) {
    if (self->types_top == self->types_size) {
        if (self->types_top == 0) {
            self->types_size = 8;
            self->types = malloc(self->types_size * sizeof(*self->types));
        } else {
            self->types_size <<= 1;
            self->types = realloc(self->types, self->types_size * sizeof(*self->types));
        }
    }

    assert(self->types_top < self->types_size);
    self->types[self->types_top++] = type;
}

static type_t* state__type_find(state_t* self, const char* abbreviated_name) {
    type_t* result = NULL;

    for (uint32_t type_index = 0; self->types_top; ++type_index) {
        type_t* type = self->types[type_index];
        if (strcmp(type->abbreviated_name, abbreviated_name) == 0) {
            result = type;
            break ;
        }
    }

    return result;
}

static inline void state__patch_jmp(state_t* self, uint8_t* jmp_ip, uint8_t* addr) {
    *(uint64_t*)(jmp_ip + 1) = (uint64_t) addr;
}

#define CODE_PUSH(state_p, type, ip, a) do { \
    *(type*) ip = a; \
    ip += sizeof(type); \
} while (false)
#define CODE_POP(state_p, type, result) do { \
    result = *(type*) (state_p)->ip; \
    (state_p)->ip += sizeof(type); \
} while (false)
#define STACK_PUSH(state_p, type, a) do { \
    *(type*) ((state_p)->stack_top) = a; \
    (state_p)->stack_top += sizeof(type); \
} while (false)
#define STACK_TOP(state_p, type, minus) (*(type*) ((state_p)->stack_top - sizeof(type) - minus))
#define STACK_POP(state_p, type, result) do { \
    result = *(type*) ((state_p)->stack_top - sizeof(type)); \
    (state_p)->stack_top -= sizeof(type); \
} while (false)

/*
<u8>                        push8
<u16>                       push16
<u32>                       push32
<reg_t>                     push
<reg_t>                     pushf
<u32>                       push_sp
<u8>                        push_reg
                            pop8
                            pop16
                            pop32
                            pop
                            popf
<u32>                       pop_sp
<u8>                        pop_reg
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
<u8*>                       call
<u16 id>                    call_builtin
<u32 arg_size>              ret
<reg_t>                     exit
*/
uint8_t* state__add_ins(state_t* self, uint8_t* ip, enum ins ins, ...) {
    va_list ap;
    va_start(ap, ins);

    *ip++ = (uint8_t) ins;
    switch (ins) {
        case INS_PUSH8: {
            uint8_t n = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(self, uint8_t, ip, n);
        } break ;
        case INS_PUSH16: {
            uint16_t n = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(self, uint16_t, ip, n);
        } break ;
        case INS_PUSH32: {
            uint32_t n = va_arg(ap, uint32_t);
            CODE_PUSH(self, uint32_t, ip, n);
        } break ;
        case INS_PUSH: {
            reg_t n = va_arg(ap, reg_t);
            CODE_PUSH(self, reg_t, ip, n);
        } break ;
        case INS_PUSHF: {
            regf_t n = va_arg(ap, regf_t);
            CODE_PUSH(self, regf_t, ip, n);
        } break ;
        case INS_PUSH_SP: {
            uint32_t n = va_arg(ap, uint32_t);
            CODE_PUSH(self, uint32_t, ip, n);
        } break ;
        case INS_POP_SP: {
            uint32_t n = va_arg(ap, uint32_t);
            CODE_PUSH(self, uint32_t, ip, n);
        } break ;
        case INS_PUSH_REG: {
            uint8_t reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(self, uint8_t, ip, reg);
        } break ;
        case INS_POP_REG: {
            uint8_t reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(self, uint8_t, ip, reg);
        } break ;
        case INS_MOV_REG: {
            uint8_t dst_reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            uint8_t src_reg = va_arg(ap, uint32_t); // 4 bytes is minimum va_arg can work with
            CODE_PUSH(self, uint8_t, ip, dst_reg);
            CODE_PUSH(self, uint8_t, ip, src_reg);
        } break ;
        case INS_POP8:
        case INS_POP16:
        case INS_POP32:
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
            CODE_PUSH(self, uint8_t*, ip, addr);
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
            CODE_PUSH(self, uint8_t*, ip, addr);
        } break ;
        case INS_STACK_LOAD:
        case INS_STACK_STORE: {
            uint8_t bytes = va_arg(ap, uint32_t);
            CODE_PUSH(self, uint8_t, ip, bytes);
        } break ;
        case INS_CALL: {
            uint8_t* a = va_arg(ap, uint8_t*);
            CODE_PUSH(self, uint8_t*, ip, a);
        } break ;
        case INS_CALL_BUILTIN: {
            uint16_t builtin_id = va_arg(ap, uint32_t); // int is minimum va_arg can work with
            CODE_PUSH(self, uint16_t, ip, builtin_id);
        } break ;
        case INS_RET: {
            uint32_t arg_size = va_arg(ap, uint32_t);
            CODE_PUSH(self, uint32_t, ip, arg_size);
        } break ;
        case INS_EXIT: {
            reg_t exit_code = va_arg(ap, reg_t);
            CODE_PUSH(self, reg_t, ip, exit_code);
        } break ;
        default: assert(false);
    }

    va_end(ap);

    return ip;
}

/*
fact:
    mov_imm     reg_ret, 1

    mov_arg     reg_acc_1, 0
    jz          fact_end, reg_acc_1
    inc         reg_acc_1
    mov_imm     reg_acc_0, 1

loop_start:
    mul         reg_ret, reg_ret, reg_acc_0
    inc         reg_acc_0
    je          fact_end, reg_acc_0, reg_acc_1
    jmp         loop_start

fact_end:
    ret

main:
    push        5
    call        fact
    pop         8
    print       reg_ret
    exit
*/

typedef struct instance {
    const char* name;
    type_t*     type;
} instance_t;

typedef struct fn_decl {
    const char* name;

    uint8_t* (*fn_def)(state_t* self, struct fn_decl* fn_decl, uint8_t* ip);

    uint8_t*    ip;
    type_t*     return_type;

    type_t**    arguments;
    uint32_t    arguments_top;
    uint32_t    arguments_size;

    uint32_t    code_size;
    uint32_t    frame_size;

    instance_t** locals;
    uint32_t     locals_top;
    uint32_t     locals_size;
} fn_decl_t;

fn_decl_t* fn_decl__create(
    const char* name,
    uint8_t* (*fn_def)(state_t* self, fn_decl_t* fn_decl, uint8_t* ip),
    type_t* return_type
) {
    fn_decl_t* result = calloc(1, sizeof(*result));

    result->return_type = return_type;
    result->fn_def = fn_def;

    return result;
}

uint8_t* state__compile_fn(state_t* self, fn_decl_t* fn_decl, uint8_t* ip) {
    fn_decl->ip = ip;
    return fn_decl->fn_def(self, fn_decl, ip);
}

int64_t fn_decl__get_fn_return_offset_from_bp(fn_decl_t* self, va_list ap) {
    assert(self->return_type);

    int64_t result = 0;
    result -= sizeof(reg_t); // BP register on stack
    result -= sizeof(uint8_t*); // return address
    for (uint32_t arg_index = 0; arg_index < self->arguments_top; ++arg_index) {
        result -= type__size(self->arguments[arg_index]);
    }
    result -= type__size(self->return_type);

    type_t* parent = self->return_type;
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(parent, member_name);
        if (member) {
            result += (int64_t) member->offset;
            if (member->type->type_specifier == TYPE_ARRAY) {
                type_array_t* type_array = (type_array_t*) member->type;
                uint64_t element_index = va_arg(ap, uint64_t);
                result += (int64_t) element_index * type__size(type_array->element_type);
            }
            parent = member->type;
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return result;
}

int64_t fn_decl__get_fn_arg_offset_from_bp(fn_decl_t* self, uint32_t index, va_list ap) {
    int64_t result = 0;
    result -= sizeof(reg_t); // BP register on stack
    result -= sizeof(uint8_t*); // return address
    for (uint32_t arg_index = 0; arg_index < self->arguments_top; ++arg_index) {
        type_t* argument = self->arguments[arg_index];
        if (arg_index < index) {
            assert(false);
        }
        result -= type__size(argument);
        if (arg_index == index) {
            type_t* parent = argument;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(parent, member_name);
                if (member) {
                    result += (int64_t) member->offset;
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        type_array_t* type_array = (type_array_t*) member->type;
                        uint64_t element_index = va_arg(ap, uint64_t);
                        result += (int64_t) element_index * type__size(type_array->element_type);
                    }
                    parent = member->type;
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            break ;
        }
    }

    return result;
}

int64_t fn_decl__get_fn_local_offset_from_bp(fn_decl_t* self, const char* local_name, va_list ap) {
    int64_t result = 0;
    for (uint32_t local_index = 0; local_index < self->locals_top; ++local_index) {
        instance_t* local = self->locals[local_index];
        if (strcmp(local_name, local->name) == 0) {
            type_t* parent = local->type;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(parent, member_name);
                if (member) {
                    result += (int64_t) member->offset;
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        type_array_t* type_array = (type_array_t*) member->type;
                        uint64_t element_index = va_arg(ap, uint64_t);
                        result += (int64_t) element_index * type__size(type_array->element_type);
                    }
                    parent = member->type;
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            break ;
        }
        result += type__size(local->type);
    }

    return result;
}

typedef struct stack_frame {
    struct local {
        instance_t*     instance;
        struct local*   next;
    };
    uint8_t* bp;
} stack_frame_t;

void fn_decl__add_argument(fn_decl_t* self, type_t* argument) {
    if (self->arguments_size == 0) {
        self->arguments_size = 8;
        self->arguments = malloc(self->arguments_size * sizeof(*self->arguments));
    } else if (self->arguments_top == self->arguments_size) {
        self->arguments_size <<= 1;
        self->arguments = realloc(self->arguments, self->arguments_size * sizeof(*self->arguments));
    }

    assert(self->arguments_top != self->arguments_size);
    self->arguments[self->arguments_top++] = argument;
}

void fn_decl__add_local(fn_decl_t* self, instance_t* local) {
    if (self->locals_size == 0) {
        self->locals_size = 8;
        self->locals = malloc(self->locals_size * sizeof(*self->locals));
    } else if (self->locals_top == self->locals_size) {
        self->locals_size <<= 1;
        self->locals = realloc(self->locals, self->locals_size * sizeof(*self->locals));
    }

    assert(self->locals_top != self->locals_size);
    self->locals[self->locals_top++] = local;
}

uint64_t fn_decl__size_of_arg(fn_decl_t* self, uint32_t arg_index, va_list ap) {
    assert(arg_index < self->arguments_top);

    type_t* member_type = self->arguments[arg_index];
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(member_type, member_name);
        if (member) {
            if (member->type->type_specifier == TYPE_ARRAY) {
                uint64_t element_index = va_arg(ap, uint64_t);
                (void) element_index; // all elements are of the same type
                type_array_t* type_array = (type_array_t*) member->type;
                member_type = type_array->element_type;
            } else {
                member_type = member->type;
            }
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return type__size(member_type);
}

uint64_t fn_decl__size_of_ret(fn_decl_t* self, va_list ap) {
    assert(self->return_type);

    type_t* member_type = self->return_type;
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(member_type, member_name);
        if (member) {
            if (member->type->type_specifier == TYPE_ARRAY) {
                uint64_t element_index = va_arg(ap, uint64_t);
                (void) element_index; // all elements are of the same type
                type_array_t* type_array = (type_array_t*) member->type;
                member_type = type_array->element_type;
            } else {
                member_type = member->type;
            }
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return type__size(member_type);
}

uint64_t fn_decl__size_of_local(fn_decl_t* self, const char* local_name, va_list ap) {
    for (uint32_t local_index = 0; local_index < self->locals_top; ++local_index) {
        instance_t* local = self->locals[local_index];
        if (strcmp(local_name, local->name) == 0) {
            type_t* member_type = local->type;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(member_type, member_name);
                if (member) {
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        uint64_t element_index = va_arg(ap, uint64_t);
                        (void) element_index; // all elements are of the same type
                        type_array_t* type_array = (type_array_t*) member->type;
                        member_type = type_array->element_type;
                    } else {
                        member_type = member->type;
                    }
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            return type__size(member_type);
        }
    }

    assert(false);
    return 0;
}

uint8_t* compile__store_argument(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, uint32_t arg_index, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, arg_index);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_arg_offset_from_bp(fn_decl, arg_index, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, arg_index);
    ip = state__add_ins(self, ip, INS_STACK_STORE, fn_decl__size_of_arg(fn_decl, arg_index, ap));
    va_end(ap);

}

uint8_t* compile__load_argument(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, uint32_t arg_index, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, arg_index);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_arg_offset_from_bp(fn_decl, arg_index, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, arg_index);
    ip = state__add_ins(self, ip, INS_STACK_LOAD, fn_decl__size_of_arg(fn_decl, arg_index, ap));
    va_end(ap);
}

uint8_t* compile__store_return(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, ip);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_return_offset_from_bp(fn_decl, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, ip);
    ip = state__add_ins(self, ip, INS_STACK_STORE, fn_decl__size_of_ret(fn_decl, ap));
    va_end(ap);

}

uint8_t* compile__load_return(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, ip);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_return_offset_from_bp(fn_decl, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, ip);
    ip = state__add_ins(self, ip, INS_STACK_LOAD, fn_decl__size_of_ret(fn_decl, ap));
    va_end(ap);

}

uint8_t* compile__load_local(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, const char* local_name, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, local_name);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_local_offset_from_bp(fn_decl, local_name, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, local_name);
    ip = state__add_ins(self, ip, INS_STACK_LOAD, fn_decl__size_of_local(fn_decl, local_name, ap));
    va_end(ap);

}

uint8_t* compile__store_local(state_t* self, fn_decl_t* fn_decl, uint8_t* ip, const char* local_name, ...) {
    va_list ap;

    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);

    va_start(ap, local_name);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){fn_decl__get_fn_local_offset_from_bp(fn_decl, local_name, ap), 0});
    va_end(ap);

    ip = state__add_ins(self, ip, INS_ADD);

    va_start(ap, local_name);
    ip = state__add_ins(self, ip, INS_STACK_STORE, fn_decl__size_of_local(fn_decl, local_name, ap));
    va_end(ap);
}

uint8_t* state__compile_fact_fn(state_t* self, fn_decl_t* fn_decl, uint8_t* ip) {
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ 1, 0 });
    ip = compile__store_return(self, fn_decl, ip, NULL);

    ip = compile__load_argument(self, fn_decl, ip, 0, NULL);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ 1, 0 });
    uint8_t* fact_end = ip;
    ip = state__add_ins(self, ip, INS_JLE, NULL);
    uint8_t* loop_start = ip;
    ip = compile__load_return(self, fn_decl, ip, NULL);
    ip = compile__load_argument(self, fn_decl, ip, 0, NULL);
    ip = state__add_ins(self, ip, INS_MUL);
    ip = compile__store_return(self, fn_decl, ip, NULL);
    ip = compile__load_argument(self, fn_decl, ip, 0, NULL);
    ip = state__add_ins(self, ip, INS_DEC);
    ip = compile__store_argument(self, fn_decl, ip, 0, NULL);
    ip = compile__load_argument(self, fn_decl, ip, 0, NULL);
    uint8_t* fact_end2 = ip;
    ip = state__add_ins(self, ip, INS_JZ, fact_end);
    ip = state__add_ins(self, ip, INS_JMP, loop_start);

// fact end:
    state__patch_jmp(self, fact_end, ip);
    state__patch_jmp(self, fact_end2, ip);

    return ip;
}

uint8_t* state__compile_ret_struct_fn(state_t* self, fn_decl_t* fn_decl, uint8_t* ip) {
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ -120, 0});
    ip = compile__store_return(self, fn_decl, ip, "member_1", NULL);

    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ 65000, 0});
    ip = compile__store_return(self, fn_decl, ip, "member_2", NULL);

    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ 123456789101112, 0});
    ip = compile__store_return(self, fn_decl, ip, "member_3", NULL);

    type_struct_t* ret_type = (type_struct_t*) state__type_find(self, "a");
    assert(ret_type);
    member_t* member_array = type_struct__member(ret_type, "member_array");
    assert(member_array);
    type_array_t* arr_type = (type_array_t*) member_array->type;
    assert(member_array->type->type_specifier == TYPE_ARRAY);
    for (uint32_t arr_index = 0; arr_index < arr_type->element_size; ++arr_index) {
        ip = state__add_ins(self, ip, INS_PUSH, (reg_t){ arr_index * 13, 0 });
        ip = compile__store_return(self, fn_decl, ip, "member_array", arr_index, NULL);
    }

    return ip;
}

uint64_t fact(uint64_t a) {
    uint64_t result = 1;
    if (a == 0) {
        return result;
    }

    while (a) {
        result *= a--;
    }

    return result;
}

uint8_t* state__add_fn(state_t* self, fn_decl_t* fn_decl, uint8_t* ip) {
    ip = state__add_ins(self, ip, INS_PUSH_REG, REG_BP);
    ip = state__add_ins(self, ip, INS_MOV_REG, REG_BP, 1);
    ip = state__compile_fn(self, fn_decl, ip);
    ip = state__add_ins(self, ip, INS_POP_REG, REG_BP);

    uint32_t argument_size = 0;
    for (uint32_t arg_index = 0; arg_index < fn_decl->arguments_top; ++arg_index) {
        argument_size += type__size(fn_decl->arguments[arg_index]);
    }

    ip = state__add_ins(self, ip, INS_RET, argument_size);

    return ip;
}

uint8_t* state__compile(state_t* self) {
    uint8_t* ip = self->code;
    uint8_t* entry_ip = 0;

    // 42
    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_PUSH, 2);
    // ip = state__add_ins(self, ip, INS_PUSH, 40);
    // ip = state__add_ins(self, ip, INS_ADD);
    // ip = state__add_ins(self, ip, INS_CALL_BUILTIN, 2);
    // ip = state__add_ins(self, ip, INS_EXIT, 0);

    // counter
    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_PUSH, 1);
    // uint8_t* loop_start = ip;
    // ip = state__add_ins(self, ip, INS_PUSH, 1);
    // ip = state__add_ins(self, ip, INS_ADD);
    // ip = state__add_ins(self, ip, INS_CALL_BUILTIN, 2);
    // ip = state__add_ins(self, ip, INS_JMP, loop_start);
    // ip = state__add_ins(self, ip, INS_EXIT, 0);

    // call factorial
    // type_t* t_s64 = state__type_find(self, "s64");
    // type_t* t_s32 = state__type_find(self, "s32");
    // assert(t_s32);
    // assert(t_s64);
    // fn_decl_t* fn_decl = fn_decl__create("fact", &state__compile_fact_fn, t_s64);
    // fn_decl__add_argument(fn_decl, t_s32);

    // uint8_t* fact_call_site_ip = ip;
    // ip = state__add_fn(self, fn_decl, fact_call_site_ip);
    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_PUSH_SP, type__size(t_s64)); // push stack frame for return type
    // ip = state__add_ins(self, ip, INS_PUSH32, 10);
    // ip = state__add_ins(self, ip, INS_CALL, fact_call_site_ip);
    // ip = state__add_ins(self, ip, INS_PUSH, (reg_t){type__hash(t_s64), 0});
    // ip = state__add_ins(self, ip, INS_CALL_BUILTIN, 2);
    // ip = state__add_ins(self, ip, INS_POP_SP, type__size(t_s64)); // pop stack frame
    // ip = state__add_ins(self, ip, INS_EXIT, (reg_t){0, 0});

    // call ret struct
    type_t* ta = state__type_find(self, "a");
    assert(ta);
    fn_decl_t* fn_decl = fn_decl__create("ret_struct", &state__compile_ret_struct_fn, ta);

    uint8_t* fn_ret_ip = ip;
    ip = state__add_fn(self, fn_decl, fn_ret_ip);
    entry_ip = ip;
    ip = state__add_ins(self, ip, INS_PUSH_SP, type__size(ta)); // push stack frame for return type
    ip = state__add_ins(self, ip, INS_CALL, fn_ret_ip);
    ip = state__add_ins(self, ip, INS_PUSH, (reg_t){type__hash(ta), 0});
    ip = state__add_ins(self, ip, INS_CALL_BUILTIN, 2);
    ip = state__add_ins(self, ip, INS_POP_SP, type__size(ta)); // pop stack frame
    ip = state__add_ins(self, ip, INS_EXIT, (reg_t){0, 0});

    // call builtin, load/store
    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_REG_MOV_IMM, REG_ACC_0, (uint64_t) (3 * sizeof(int32_t)));
    // ip = state__add_ins(self, ip, INS_PUSH, REG_ACC_0);
    // ip = state__add_ins(self, ip, INS_CALL_BUILTIN, (uint16_t) 0);
    // ip = state__add_ins(self, ip, INS_POP);
    // uint8_t* exit_one_ip = ip;
    // ip = state__add_ins(self, ip, INS_JZ, NULL, REG_RET);
    // ip = state__add_ins(self, ip, INS_REG_MOV_IMM, REG_ACC_0, (uint64_t) 1);
    // ip = state__add_ins(self, ip, INS_REG_MOV, REG_ACC_2, REG_RET);
    // ip = state__add_ins(self, ip, INS_REG_STORE, REG_ACC_2, REG_ACC_0, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_REG_LOAD, REG_ACC_1, REG_ACC_2, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_PRINT, REG_ACC_1);
    // ip = state__add_ins(self, ip, INS_REG_MOV_IMM, REG_ACC_3, (uint64_t) sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_ADD, REG_ACC_2, REG_ACC_2, REG_ACC_3);
    // ip = state__add_ins(self, ip, INS_REG_MOV_IMM, REG_ACC_0, (uint64_t) 2);
    // ip = state__add_ins(self, ip, INS_REG_STORE, REG_ACC_2, REG_ACC_0, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_REG_LOAD, REG_ACC_1, REG_ACC_2, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_PRINT, REG_ACC_1);
    // ip = state__add_ins(self, ip, INS_REG_MOV_IMM, REG_ACC_0, (uint64_t) 3);
    // ip = state__add_ins(self, ip, INS_ADD, REG_ACC_2, REG_ACC_2, REG_ACC_3);
    // ip = state__add_ins(self, ip, INS_REG_STORE, REG_ACC_2, REG_ACC_0, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_REG_LOAD, REG_ACC_1, REG_ACC_2, sizeof(int32_t));
    // ip = state__add_ins(self, ip, INS_PRINT, REG_ACC_1);
    // ip = state__add_ins(self, ip, INS_PUSH, REG_RET);
    // ip = state__add_ins(self, ip, INS_CALL_BUILTIN, (int16_t) 1);
    // ip = state__add_ins(self, ip, INS_POP);
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 0);
    // state__patch_jmp(self, exit_one_ip, ip);
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 1);

    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 0);

    uint32_t len = ip - self->code;
    (void) len;

    FILE* fp = fopen("vmout", "w");
    for (uint32_t i = 0; i < len; ++i) {
        fprintf(fp, "%d ", self->code[i]);
    }
    fprintf(fp, "\n");
    fclose(fp);

    return entry_ip;
}

typedef struct cache {
    char*    memory;
    uint32_t memory_size;
} cache_t;

void clear_cache(cache_t* cache) {
    for (uint32_t j = 0; j < cache->memory_size; j++) {
        cache->memory[j] = j * j;
    }
}

void state__builtin_execute(state_t* self, uint16_t builtin_id) {
    switch (builtin_id) {
        case 0: {
            reg_t arg = STACK_TOP(self, reg_t, 0);
            void* result = malloc(arg._);
            STACK_PUSH(self, uint8_t*, result);
        } break ;
        case 1: {
            reg_t arg = STACK_TOP(self, reg_t, 0);
            free((void*) arg._);
        } break ;
        case 2: {
            reg_t type_hash;
            STACK_POP(self, reg_t, type_hash);
            bool found_type = false;
            for (uint32_t type_index = 0; type_index < self->types_top; ++type_index) {
                type_t* type = self->types[type_index];
                if (type__hash(type) == type_hash._) {
                    type__print(type, stdout, 3, -1, self->stack_top - type__size(type));
                    found_type = true;
                    break ;
                }
            }
            assert(found_type);
        } break ;
        default: assert(false);
    }
}

static void _type__print_value_s8(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(int8_t*) address);
}

static void _type__print_value_s16(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(int16_t*) address);
}

static void _type__print_value_s32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(int32_t*) address);
}

static void _type__print_value_s64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%lld", *(int64_t*) address);
}

static void _type__print_value_u8(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(uint8_t*) address);
}

static void _type__print_value_u16(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(uint16_t*) address);
}

static void _type__print_value_u32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(uint32_t*) address);
}

static void _type__print_value_u64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%llu", *(uint64_t*) address);
}

static void _type__print_value_r32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%f", *(float*) address);
}

static void _type__print_value_r64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%lf", *(double*) address);
}

void state__create_atom_types(state_t* self) {
    type_atom_t* ts8 =  type_atom__create("s8",  "s8",  sizeof(int8_t), &_type__print_value_s8);
    type_atom_t* ts16 = type_atom__create("s16", "s16", sizeof(int16_t), &_type__print_value_s16);
    type_atom_t* ts32 = type_atom__create("s32", "s32", sizeof(int32_t), &_type__print_value_s32);
    type_atom_t* ts64 = type_atom__create("s64", "s64", sizeof(int64_t), &_type__print_value_s64);
    type_atom_t* tu8 =  type_atom__create("u8",  "u8",  sizeof(uint8_t), &_type__print_value_u8);
    type_atom_t* tu16 = type_atom__create("u16", "u16", sizeof(uint16_t), &_type__print_value_u16);
    type_atom_t* tu32 = type_atom__create("u32", "u32", sizeof(uint32_t), &_type__print_value_u32);
    type_atom_t* tu64 = type_atom__create("u64", "u64", sizeof(uint64_t), &_type__print_value_u64);
    type_atom_t* tr32 = type_atom__create("r32", "r32", sizeof(float), &_type__print_value_r32);
    type_atom_t* tr64 = type_atom__create("r64", "r64", sizeof(double), &_type__print_value_r64);
    static_assert(sizeof(float) == 4, "");
    static_assert(sizeof(double) == 8, "");

    state__type_add(self, (type_t*) ts8 );
    state__type_add(self, (type_t*) ts16);
    state__type_add(self, (type_t*) ts32);
    state__type_add(self, (type_t*) ts64);
    state__type_add(self, (type_t*) tu8 );
    state__type_add(self, (type_t*) tu16);
    state__type_add(self, (type_t*) tu32);
    state__type_add(self, (type_t*) tu64);
    state__type_add(self, (type_t*) tr32);
    state__type_add(self, (type_t*) tr64);
}

void state__create_user_types(state_t* self) {
    typedef struct saa {
        int8_t   _;
        uint16_t __;
        uint64_t ___;
        uint16_t ____[7];
    } saa_t;

    type_struct_t* ta = type_struct__create("a");
    state__type_add(self, (type_t*) ta);
    type_t* ts8  = state__type_find(self, "s8");
    type_t* tu16 = state__type_find(self, "u16");
    type_t* tu64 = state__type_find(self, "u64");
    assert(ts8);
    assert(tu16);
    assert(tu64);
    type_struct__add(ta, ts8,  "member_1");
    type_struct__add(ta, tu16, "member_2");
    type_struct__add(ta, tu64, "member_3");

    type_array_t* tb = type_array__create("b", tu16, 7);
    type_struct__add(ta, (type_t*) tb, "member_array");
}

int main() {
    cache_t cache;
    cache.memory_size = 20 * 1024 * 1024;
    cache.memory = malloc(cache.memory_size);

    state_t state = { 0 };

    state__create_atom_types(&state);
    state__create_user_types(&state);

    state.code_size = 4096;
    state.code = malloc(state.code_size * sizeof(*state.code));
    state.stack_size = 4096;
    state.stack = malloc(state.stack_size * sizeof(*state.stack));
    state.ip = state.code;
    state.stack_top = state.stack;
    state.base_pointer = state.stack_top;

    uint8_t* entry_ip = state__compile(&state);

    uint64_t time_total_virt = 0;
    uint64_t time_total_real = 0;
    uint32_t number_of_iters = 1;
    for (uint32_t current_iter = 0; current_iter < number_of_iters; ++current_iter) {
        state.alive = true;
        state.ip = entry_ip;
        state.stack_top = state.stack;
        state.base_pointer = state.stack;
        // clear_cache(&cache);

        while (state.alive) {
            uint8_t ins = *state.ip++;
            switch (ins) {
                case INS_PUSH8: {
                    uint8_t n;
                    CODE_POP(&state, uint8_t, n);
                    STACK_PUSH(&state, uint8_t, n);
                } break ;
                case INS_PUSH16: {
                    uint16_t n;
                    CODE_POP(&state, uint16_t, n);
                    STACK_PUSH(&state, uint16_t, n);
                } break ;
                case INS_PUSH32: {
                    uint32_t n;
                    CODE_POP(&state, uint32_t, n);
                    STACK_PUSH(&state, uint32_t, n);
                } break ;
                case INS_PUSH: {
                    reg_t n;
                    CODE_POP(&state, reg_t, n);
                    STACK_PUSH(&state, reg_t, n);
                } break ;
                case INS_PUSHF: {
                    regf_t n;
                    CODE_POP(&state, regf_t, n);
                    STACK_PUSH(&state, regf_t, n);
                } break ;
                case INS_PUSH_SP: {
                    uint32_t n; 
                    CODE_POP(&state, uint32_t, n);
                    state.stack_top += n;
                } break ;
                case INS_PUSH_REG: {
                    uint8_t reg;
                    CODE_POP(&state, uint8_t, reg);
                    reg_t result = {
                        ._ = (uint64_t) state.base_pointer,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_POP8: {
                    state.stack_top -= sizeof(uint8_t);
                } break ;
                case INS_POP16: {
                    state.stack_top -= sizeof(uint16_t);
                } break ;
                case INS_POP32: {
                    state.stack_top -= sizeof(uint32_t);
                } break ;
                case INS_POP: {
                    state.stack_top -= sizeof(reg_t);
                } break ;
                case INS_POPF: {
                    state.stack_top -= sizeof(regf_t);
                } break ;
                case INS_POP_SP: {
                    uint32_t n;
                    CODE_POP(&state, uint32_t, n);
                    state.stack_top -= n;
                } break ;
                case INS_POP_REG: {
                    uint8_t reg;
                    CODE_POP(&state, uint8_t, reg);
                    reg_t n;
                    STACK_POP(&state, reg_t, n);
                    state.base_pointer = (uint8_t*) n._;
                } break ;
                case INS_MOV_REG: {
                    uint8_t dst_reg;
                    uint8_t src_reg;
                    CODE_POP(&state, uint8_t, dst_reg);
                    CODE_POP(&state, uint8_t, src_reg);
                    state.base_pointer = state.stack_top;
                } break ;
                case INS_ADD: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ + b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_ADDF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = {
                        ._ = a._ + b._,
                        .__ = 0.0
                    };
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_SUB: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ - b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_SUBF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = {
                        ._ = a._ - b._,
                        .__ = 0.0
                    };
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_MUL: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ * b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_MULF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = {
                        ._ = a._ * b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_DIV: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ / b._,
                        .__ = 0.0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_DIVF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = {
                        ._ = a._ / b._,
                        .__ = 0.0
                    };
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_MOD: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ % b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_MODF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = {
                        ._ = fmod(a._, b._),
                        .__ = 0.0
                    };
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_DUP: {
                    reg_t result = STACK_TOP(&state, reg_t, 0);
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_DUPF: {
                    regf_t result = STACK_TOP(&state, regf_t, 0);
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_NEG: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    a._ = -a._;
                    STACK_PUSH(&state, reg_t, a);
                } break ;
                case INS_NEGF: {
                    regf_t a;
                    STACK_POP(&state, regf_t, a);
                    a._ = -a._;
                    a.__ = -a.__;
                    STACK_PUSH(&state, regf_t, a);
                } break ;
                case INS_INC: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ + 1,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_DEC: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ - 1,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_NOT: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    a._ = ~a._;
                    STACK_PUSH(&state, reg_t, a);
                } break ;
                case INS_XOR: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ ^ b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_AND: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ & b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_OR: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = {
                        ._ = a._ | b._,
                        .__ = 0
                    };
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_JMP: {
                    uint8_t* addr;
                    CODE_POP(&state, uint8_t*, addr);
                    state.ip = addr;
                } break ;
                case INS_JZ: {
                    uint8_t* addr;
                    reg_t a;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, a);
                    if (a._ == 0) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JZF: {
                    uint8_t* addr;
                    regf_t a;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, a);
                    if (a._ == 0.0 && a.__ == 0.0) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JL: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a._ < b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a._ < b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JG: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a._ > b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a._ > b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a._ == b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a._ == b._ && a.__ == b.__) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a._ <= b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a._ <= b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a._ >= b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a._ >= b._) {
                        state.ip = addr;
                    }
                } break ;
                case INS_STACK_LOAD: {
                    reg_t addr;
                    uint8_t bytes;
                    STACK_POP(&state, reg_t, addr);
                    CODE_POP(&state, uint8_t, bytes);
                    assert(bytes <= sizeof(reg_t));
                    memmove(state.stack_top, (void*) addr._, bytes);
                    if (bytes < sizeof(reg_t)) {
                        // fill remaining bytes with 0s
                        memset(state.stack_top + bytes, 0, sizeof(reg_t) - bytes);
                    }
                    state.stack_top += sizeof(reg_t);
                } break ;
                case INS_STACK_STORE: {
                    reg_t addr;
                    uint8_t bytes;
                    STACK_POP(&state, reg_t, addr);
                    CODE_POP(&state, uint8_t, bytes);
                    assert(bytes <= sizeof(reg_t));
                    state.stack_top -= sizeof(reg_t);
                    memmove((void*) addr._, state.stack_top, bytes);
                } break ;
                case INS_CALL: {
                    uint8_t* addr;
                    CODE_POP(&state, uint8_t*, addr);
                    STACK_PUSH(&state, uint8_t*, state.ip);
                    state.ip = addr;
                } break ;
                case INS_CALL_BUILTIN: {
                    uint16_t builtin_id;
                    CODE_POP(&state, uint16_t, builtin_id);
                    state__builtin_execute(&state, builtin_id);
                } break ;
                case INS_RET: {
                    uint32_t arg_size;
                    uint8_t* addr;
                    CODE_POP(&state, uint32_t, arg_size);
                    STACK_POP(&state, uint8_t*, addr);
                    state.stack_top -= arg_size;
                    state.ip = addr;
                } break ;
                case INS_EXIT: {
                    state.alive = false;
                    CODE_POP(&state, reg_t, state.exit_status_code);
                } break ;
                default: assert(false);
            }
        }
        printf("\nExit status code: %llu\n", state.exit_status_code._);
    }

    free(cache.memory);
    free(state.code);
    free(state.stack);

    return 0;
}

// todo: alignment when pushing types to the stack
// todo: 
