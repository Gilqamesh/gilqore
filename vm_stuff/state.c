#include "state.h"

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

bool state__create(state_t* self) {
    memset(self, 0, sizeof(*self));

    buffer__create(&self->stack, 4096);

    if (!shared_lib__create(&self->shared_libs)) {
        return false;
    }

    const uint32_t number_of_stack_frames = 8;
    self->stack_frame_start = malloc(number_of_stack_frames * sizeof(*self->stack_frame_start));
    self->stack_frame_cur = self->stack_frame_start;
    self->stack_frame_end = self->stack_frame_start + number_of_stack_frames;


    return true;
}

void state__destroy(state_t* self) {
    (void) self;
}

#define BINARY_REG(state_p, op) do { \
    reg_t a; \
    reg_t b; \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, b); \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, a); \
    reg_t result = a op b; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, reg_t, result); \
    debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a); \
    debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b); \
    debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result); \
} while (false)

#define BINARY_REG_B(state_p, op) do { \
    reg_t a; \
    reg_t b; \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, b); \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, a); \
    reg_t result = a op b; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, reg_t, result); \
    debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a); \
    debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b); \
    debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result); \
} while (false)

#define BINARY_REGF(state_p, op) do { \
    regf_t a; \
    regf_t b; \
    BUFFER_POP_WRAPPER((state_p)->stack, regf_t, b); \
    BUFFER_POP_WRAPPER((state_p)->stack, regf_t, a); \
    regf_t result = a op b; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, regf_t, result); \
    debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a); \
    debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b); \
    debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result); \
} while (false)

#define UNARY_REG(state_p, op) do { \
    reg_t a; \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, a); \
    reg_t result = op a; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, reg_t, result); \
    debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a); \
    debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result); \
} while (false)

#define UNARY_REG_B(state_p, op) do { \
    reg_t a; \
    BUFFER_POP_WRAPPER((state_p)->stack, reg_t, a); \
    reg_t result = op a; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, reg_t, result); \
    debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a); \
    debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result); \
} while (false)

#define UNARY_REGF(state_p, op) do { \
    regf_t a; \
    BUFFER_POP_WRAPPER((state_p)->stack, regf_t, a); \
    regf_t result = op a; \
    BUFFER_PUSH_WRAPPER((state_p)->stack, regf_t, result); \
    debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (regf_t) a); \
    debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (regf_t) result); \
} while (false)

void state__run(state_t* self, type_internal_function_t* entry_fn) {
    self->alive = true;
    self->stack_frame_cur->ip = type_internal_function__start_ip(entry_fn);
    self->stack_frame_cur->reg_aligned_bp = self->stack.cur;
    ASSERT((size_t) self->stack_frame_cur->reg_aligned_bp % sizeof(reg_t) == 0);

    while (self->alive) {
        debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_IP, self->stack_frame_cur->ip);
        ins_t ins;
        IP_POP(self->stack_frame_cur->ip, uint8_t, ins);
        debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_MNEMONIC, ins__to_str(ins));
        switch (ins) {
            case INS_PRINT: {
                reg_t a;
                BUFFER_POP_WRAPPER(self->stack, reg_t, a);
                printf("%ld\n", (int64_t) a);
            } break ;
            case INS_PRINTF: {
                regf_t a;
                BUFFER_POP_WRAPPER(self->stack, regf_t, a);
                printf("%lf\n", (double) a);
            } break ;
            case INS_MOV_IMM: {
                reg_t imm;
                IP_POP(self->stack_frame_cur->ip, reg_t, imm);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) imm);
            } break ;
            case INS_GROW: {
                int32_t n;
                IP_POP(self->stack_frame_cur->ip, int32_t, n);
                BUFFER_GROW_WRAPPER(self->stack, n);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
            } break ;
            // case INS_PUSH: {
            //     reg_t n;
            //     IP_POP(self->stack_frame_cur->ip, reg_t, n);
            //     ALIGNED_BUFFER_PUSH_WRAPPER(self, type__size(t_reg), type__alignment(t_reg));
            //     reg_t* a;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, 0, reg_t*, a);
            //     *a = n;
            //     debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
            // } break ;
            // case INS_PUSHF: {
            //     regf_t n;
            //     IP_POP(self->stack_frame_cur->ip, regf_t, n);
            //     ALIGNED_BUFFER_PUSH_WRAPPER(self, type__size(t_regf), type__alignment(t_regf));
            //     regf_t* a;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, 0, regf_t*, a);
            //     *a = n;
            //     debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) n);
            // } break ;
            // case INS_PUSH_TYPE: {
            //     uint64_t alignment;
            //     uint64_t size;
            //     IP_POP(self->stack_frame_cur->ip, uint64_t, alignment);
            //     IP_POP(self->stack_frame_cur->ip, uint64_t, size);
            //     ALIGNED_BUFFER_PUSH_WRAPPER(self, size, alignment);

            //     uint8_t* addr_of_type;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, 0, uint8_t*, addr_of_type);
            //     debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr_of_type);
            // } break ;
            // case INS_POP: {
            //     ALIGNED_BUFFER_POP_WRAPPER(self, 1);
            // } break ;
            // case INS_POPN: {
            //     uint8_t n;
            //     IP_POP(self->stack_frame_cur->ip, uint8_t, n);
            //     ALIGNED_BUFFER_POP_WRAPPER(self, n);
            // } break ;
            case INS_ADD: {
                BINARY_REG(self, +);
            } break ;
            case INS_ADDF: {
                BINARY_REGF(self, +);
            } break ;
            case INS_SUB: {
                BINARY_REG(self, -);
            } break ;
            case INS_SUBF: {
                BINARY_REGF(self, -);
            } break ;
            case INS_MUL: {
                BINARY_REG(self, *);
            } break ;
            case INS_MULF: {
                BINARY_REGF(self, *);
            } break ;
            case INS_DIV: {
                BINARY_REG(self, /);
            } break ;
            case INS_DIVF: {
                BINARY_REGF(self, /);
            } break ;
            case INS_MOD: {
                BINARY_REG(self, %);
            } break ;
            case INS_MODF: {
            } break ;
            case INS_NEG: {
                UNARY_REG(self, -);
            } break ;
            case INS_NEGF: {
                UNARY_REGF(self, -);
            } break ;
            case INS_INC: {
                UNARY_REG(self, ++);
            } break ;
            case INS_DEC: {
                UNARY_REG(self, --);
            } break ;
            case INS_CVTF2U: { // note: undefined when float is < 0
                ASSERT(sizeof(reg_t) == sizeof(regf_t) && "if not, then do a pop (to get rid of regf_t type) followed by a push (for reg_t)");
                regf_t a;
                BUFFER_POP_WRAPPER(self->stack, regf_t, a);
                reg_t result = (reg_t) a;
                BUFFER_PUSH_WRAPPER(self->stack, reg_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INT_CVTU2F: {
                ASSERT(sizeof(reg_t) == sizeof(regf_t) && "if not, then do a pop (to get rid of reg_t type) followed by a push (for regf_t)");
                reg_t a;
                BUFFER_POP_WRAPPER(self->stack, reg_t, a);
                regf_t result = (regf_t) a;
                BUFFER_PUSH_WRAPPER(self->stack, regf_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INT_CVTS2F: {
                ASSERT(sizeof(reg_t) == sizeof(regf_t) && "if not, then do a pop (to get rid of reg_t type) followed by a push (for regf_t)");
                reg_t a;
                BUFFER_POP_WRAPPER(self->stack, reg_t, a);
                regf_t result = (regf_t) (int64_t) a;
                BUFFER_PUSH_WRAPPER(self->stack, regf_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_LNOT: {
                UNARY_REG(self, !);
            } break ;
            case INS_LAND: {
                BINARY_REG(self, &&);
            } break ;
            case INS_LOR: {
                BINARY_REG(self, ||);
            } break ;
            case INS_LT: {
                BINARY_REG(self, <);
            } break ;
            case INS_GT: {
                BINARY_REG(self, >);
            } break ;
            case INS_EQ: {
                BINARY_REG(self, ==);
            } break ;
            case INS_LTF: {
                BINARY_REGF(self, <);
            } break ;
            case INS_GTF: {
                BINARY_REGF(self, >);
            } break ;
            case INT_EQF: {
                BINARY_REG(self, ==);
            } break ;

            case INS_BNOT: {
                UNARY_REG_B(self, ~);
            } break ;
            case INS_BXOR: {
                BINARY_REG_B(self, ^);
            } break ;
            case INS_BAND: {
                BINARY_REG_B(self, &);
            } break ;
            case INS_BOR: {
                BINARY_REG_B(self, |);
            } break ;

            case INS_JMP: {
                uint8_t* addr;

                IP_POP(self->stack_frame_cur->ip, uint8_t*, addr);
                self->stack_frame_cur->ip = addr;

                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
            } break ;
            case INS_JT: {
                uint8_t*  addr;
                reg_t     a;

                IP_POP(self->stack_frame_cur->ip, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self->stack, reg_t, a);

                if (a) {
                    self->stack_frame_cur->ip = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
            } break ;
            case INS_JF: {
                uint8_t*  addr;
                reg_t     a;

                IP_POP(self->stack_frame_cur->ip, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self->stack, reg_t, a);

                if (!a) {
                    self->stack_frame_cur->ip = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
            } break ;

            case INS_MOV: {
                uint32_t dst_offset_from_bp;
                uint32_t src_offset_from_bp;
                uint32_t src_size;

                IP_POP(self->stack_frame_cur->ip, uint32_t, dst_offset_from_bp);
                IP_POP(self->stack_frame_cur->ip, uint32_t, src_offset_from_bp);
                IP_POP(self->stack_frame_cur->ip, uint32_t, src_size);

                uint8_t* dst = self->stack_frame_cur->reg_aligned_bp + dst_offset_from_bp;
                uint8_t* src = self->stack_frame_cur->reg_aligned_bp + src_offset_from_bp;

                ASSERT(src >= self->stack.start && src < self->stack.cur);
                ASSERT(src + src_size < self->stack.cur);
                ASSERT(dst >= self->stack.start && dst < self->stack.cur);
                ASSERT(dst + src_size < self->stack.cur);

                memmove(dst, src, src_size);

                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, dst);
                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, src);
            } break ;
            // case INS_LOAD: {
            //     uint8_t index_of_type;
            //     uint32_t offset_of_member;
            //     uint32_t size_of_member;
            //     uint32_t alignment_of_member;
            //     IP_POP(self->stack_frame_cur->ip, uint8_t, index_of_type);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, offset_of_member);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, size_of_member);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, alignment_of_member);

            //     uint8_t* type_addr;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, index_of_type, uint8_t*, type_addr);
            //     uint8_t* src_member_addr = type_addr + offset_of_member;
            //     ALIGNED_BUFFER_PUSH_WRAPPER(self, size_of_member, alignment_of_member);
            //     uint8_t* dst_member_addr;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, 0, uint8_t*, dst_member_addr);
            //     memmove(dst_member_addr, src_member_addr, size_of_member);

            //     debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, dst_member_addr);
            //     debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, src_member_addr);
            // } break ;
            // case INS_STORE: {
            //     uint8_t index_of_type;
            //     uint32_t offset_of_member;
            //     uint32_t size_of_member;
            //     uint32_t alignment_of_member;
            //     IP_POP(self->stack_frame_cur->ip, uint8_t, index_of_type);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, offset_of_member);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, size_of_member);
            //     IP_POP(self->stack_frame_cur->ip, uint32_t, alignment_of_member);

            //     uint8_t* type_addr;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, index_of_type, uint8_t*, type_addr);
            //     uint8_t* dst_member_addr = type_addr + offset_of_member;
            //     uint8_t* src_member_addr;
            //     ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, 0, uint8_t*, src_member_addr);
            //     memmove(dst_member_addr, src_member_addr, size_of_member);
            //     ALIGNED_BUFFER_POP_WRAPPER(self, 1);

            //     debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, src_member_addr);
            //     debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, dst_member_addr);
            // } break ;
            case INS_LEA: {
                uint32_t offset_from_bp;

                IP_POP(self->stack_frame_cur->ip, uint32_t, offset_from_bp);
                reg_t addr = (reg_t) (self->stack_frame_cur->reg_aligned_bp + offset_from_bp);

                memmove(self->stack.cur - sizeof(reg_t), &addr, sizeof(addr));

                debug__push_hex(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint8_t*) &addr, sizeof(addr));
            } break ;

            case INS_CALL_INTERNAL: {
                type_internal_function_t* internal_function;
                IP_POP(self->stack_frame_cur->ip, type_internal_function_t*, internal_function);
                
                ASSERT(self->stack_frame_cur < self->stack_frame_end && "Stack overflow");
                ++self->stack_frame_cur;
                self->stack_frame_cur->ip = type_internal_function__start_ip(internal_function);
                self->stack_frame_cur->fn = internal_function;
                self->stack_frame_cur->reg_aligned_bp = self->stack.cur;
                uint32_t remainder = (size_t) self->stack_frame_cur->reg_aligned_bp % sizeof(reg_t);
                self->stack_frame_cur->offset_for_alignment = 0;
                if (remainder) {
                    self->stack_frame_cur->offset_for_alignment = sizeof(reg_t) - remainder;
                }
                self->stack_frame_cur->reg_aligned_bp += self->stack_frame_cur->offset_for_alignment;

                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, self->stack_frame_cur->ip);
                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, self->stack_frame_cur->reg_aligned_bp);
                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, self->stack_frame_cur->fn->function_base.name);
            } break ;
            case INS_CALL_EXTERNAL: {
                type_external_function_t* external_function;
                IP_POP(self->stack_frame_cur->ip, type_external_function_t*, external_function);
                type_external_function__call(external_function, self);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, external_function->function_base.name);
            } break ;
            case INS_CALL_BUILTIN: {
                type_builtin_function_t* builtin_function;
                IP_POP(self->stack_frame_cur->ip, type_builtin_function_t*, builtin_function);
                type_builtin_function__call(builtin_function, self);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, builtin_function->function_base.name);
            } break ;

            case INS_RET: {
                if (self->stack_frame_cur == self->stack_frame_start) {
                    self->alive = false;
                } else {
                    self->stack.cur = self->stack_frame_cur->reg_aligned_bp - self->stack_frame_cur->offset_for_alignment;
                    --self->stack_frame_cur;

                    debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, self->stack_frame_cur->ip);
                }
            } break ;
            default: ASSERT(false);
        }

        debug__dump_line(&debug, DEBUG_OUT_MODE_RUNTIME_CODE);
        debug__dump_line(&debug, DEBUG_OUT_MODE_RUNTIME_STACK);
        debug__clear_line(&debug);
    }
}
