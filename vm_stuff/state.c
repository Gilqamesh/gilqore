#include "state.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

const char* buffer_type__to_str(buffer_type_t type) {
    switch (type) {
    case BUFFER_TYPE_IP: return "IP";
    case BUFFER_TYPE_RETURN_IP_STACK: return "RETURN_IP_STACK";
    case BUFFER_TYPE_REGISTER_STACK: return "REGISTER_STACK";
    case BUFFER_TYPE_REGISTERF_STACK: return "REGISTERF_STACK";
    default: ASSERT(false);
    }

    return 0;
}

debug_buffer_type_t buffer_type__to_debug_buffer_type(buffer_type_t type) {
    switch (type) {
    case BUFFER_TYPE_IP: return DEBUG_BUFFER_TYPE_IP;
    case BUFFER_TYPE_RETURN_IP_STACK: return DEBUG_BUFFER_TYPE_RETURN_IP;
    case BUFFER_TYPE_REGISTER_STACK: return DEBUG_BUFFER_TYPE_REGISTER;
    case BUFFER_TYPE_REGISTERF_STACK: return DEBUG_BUFFER_TYPE_REGISTERF;
    default: ASSERT(false);
    }

    return 0;
}

const char* aligned_buffer_type__to_str(aligned_buffer_type_t type) {
    switch (type) {
    case ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK: return "ARGUMENT_TYPE_STACK";
    case ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK: return "RETURN_TYPE_STACK";
    case ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK: return "LOCAL_TYPE_STACK";
    default: ASSERT(false);
    }

    return 0;
}

debug_buffer_type_t aligned_buffer_type__to_debug_buffer_type(aligned_buffer_type_t type) {
    switch (type) {
    case ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK: return DEBUG_BUFFER_TYPE_ARG_TYPE;
    case ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK: return DEBUG_BUFFER_TYPE_RET_TYPE;
    case ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK: return DEBUG_BUFFER_TYPE_LOC_TYPE;
    default: ASSERT(false);
    }

    return 0;
}

bool state__create(state_t* self) {
    memset(self, 0, sizeof(*self));

    const uint32_t buffer_sizes[_BUFFER_TYPE_SIZE] = {
        [BUFFER_TYPE_IP]                = 4096,
        [BUFFER_TYPE_RETURN_IP_STACK]   = 256,
        [BUFFER_TYPE_REGISTER_STACK]    = 4096,
        [BUFFER_TYPE_REGISTERF_STACK]   = 4096
    };
    for (uint32_t buffer_index = 0; buffer_index < _BUFFER_TYPE_SIZE; ++buffer_index) {
        if (!buffer__create(&self->buffer[buffer_index], buffer_sizes[buffer_index])) {
            return false;
        }
    }

    const uint32_t aligned_buffer_sizes[_ALIGNED_BUFFER_TYPE_SIZE] = {
        [ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK]   = 4096,
        [ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK]     = 256,
        [ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK]      = 4096,
    };
    for (uint32_t aligned_buffer_index = 0; aligned_buffer_index < _ALIGNED_BUFFER_TYPE_SIZE; ++aligned_buffer_index) {
        if (!aligned_buffer__create(&self->aligned_buffer[aligned_buffer_index], aligned_buffer_sizes[aligned_buffer_index], aligned_buffer_sizes[aligned_buffer_index] << 2)) {
            return false;
        }
    }

    if (!shared_lib__create(&self->shared_libs)) {
        return false;
    }

    return true;
}

void state__destroy(state_t* self) {
    (void) self;
}

void state__init(state_t* self, uint8_t* ip) {
    self->buffer[BUFFER_TYPE_IP].cur = ip;
}

void state__run(state_t* self) {
    self->alive = true;
    while (self->alive) {
        debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_IP, self->buffer[BUFFER_TYPE_IP].cur);
        ASSERT(
            self->buffer[BUFFER_TYPE_IP].cur >= self->buffer[BUFFER_TYPE_IP].start &&
            self->buffer[BUFFER_TYPE_IP].cur < self->buffer[BUFFER_TYPE_IP].end
        );
        uint8_t ins = *self->buffer[BUFFER_TYPE_IP].cur++;
        debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_MNEMONIC, ins__to_str(ins));
        switch (ins) {
            case INS_PRINT: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                printf("%ld\n", (int64_t) a);
            } break ;
            case INS_PRINTF: {
                regf_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                printf("%lf\n", a);
            } break ;
            case INS_PUSH: {
                reg_t n;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, reg_t, n);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, n);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) n);
            } break ;
            case INS_PUSH_TYPE: {
                aligned_buffer_type_t aligned_buffer_type;
                uint64_t alignment;
                uint64_t size;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint64_t, alignment);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint64_t, size);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ALIGNED_BUFFER_PUSH_WRAPPER(self, aligned_buffer_type, size, alignment);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
            } break ;
            case INS_PUSHF: {
                regf_t n;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, regf_t, n);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, n);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) n);
            } break ;
            case INS_POP: {
                BUFFER_GROW(self->buffer[BUFFER_TYPE_REGISTER_STACK], -(int64_t) sizeof(reg_t));
            } break ;
            case INS_POP_TYPE: {
                aligned_buffer_type_t aligned_buffer_type;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ALIGNED_BUFFER_POP_WRAPPER(self, aligned_buffer_type, 1);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
            } break ;
            case INS_POPN_TYPE: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t n;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, n);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ALIGNED_BUFFER_POP_WRAPPER(self, aligned_buffer_type, n);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
            } break ;
            case INS_POPF: {
                BUFFER_GROW(self->buffer[BUFFER_TYPE_REGISTERF_STACK], -(int64_t) sizeof(regf_t));
            } break ;
            case INS_ADD: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a + b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INS_ADDF: {
                regf_t a;
                regf_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t result = a + b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_SUB: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a - b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INS_SUBF: {
                regf_t a;
                regf_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t result = a - b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_MUL: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a * b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INS_MULF: {
                regf_t a;
                regf_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t result = a * b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_DIV: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a / b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INS_DIVF: {
                regf_t a;
                regf_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t result = a / b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_MOD: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a % b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) result);
            } break ;
            case INS_MODF: {
                regf_t a;
                regf_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t result = fmod(a, b);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, result);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) result);
            } break ;
            case INS_DUP: {
                reg_t a;
                BUFFER_TOP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, 0, a);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
            } break ;
            case INS_DUPF: {
                regf_t a;
                BUFFER_TOP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, 0, a);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
            } break ;
            case INS_NEG: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t b = -a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_NEGF: {
                regf_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                regf_t b = -a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_INC: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t b = a + 1;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_DEC: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t b = a - 1;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_CVTF2I: {
                regf_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                reg_t b = a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, regf_t, b);

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INT_CVTI2F: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                regf_t b = a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_LNOT: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t b = !a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
            } break ;
            case INS_LAND: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a && b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result);
            } break ;
            case INS_LOR: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a || b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result);
            } break ;
            case INS_BNOT: {
                reg_t a;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t b = ~a;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
            } break ;
            case INS_BXOR: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a ^ b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result);
            } break ;
            case INS_BAND: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a & b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result);
            } break ;
            case INS_BOR: {
                reg_t a;
                reg_t b;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                reg_t result = a | b;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, result);

                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) a);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) b);
                debug__push_bin(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (uint64_t) result);
            } break ;
            case INS_JMP: {
                uint8_t* addr;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                self->buffer[BUFFER_TYPE_IP].cur = addr;

                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
            } break ;
            case INS_JZ: {
                uint8_t* addr;
                reg_t a;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a == 0) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
            } break ;
            case INS_JZF: {
                uint8_t* addr;
                regf_t a;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a == 0.0) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
            } break ;
            case INS_JL: {
                uint8_t* addr;
                reg_t a;
                reg_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a < b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_JLF: {
                uint8_t* addr;
                regf_t a;
                regf_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a < b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_JG: {
                uint8_t* addr;
                reg_t a;
                reg_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a > b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_JGF: {
                uint8_t* addr;
                regf_t a;
                regf_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a > b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_JE: {
                uint8_t* addr;
                reg_t a;
                reg_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a == b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_JEF: {
                uint8_t* addr;
                regf_t a;
                regf_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a == b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_JLE: {
                uint8_t* addr;
                reg_t a;
                reg_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a <= b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_JLEF: {
                uint8_t* addr;
                regf_t a;
                regf_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a <= b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_JGE: {
                uint8_t* addr;
                reg_t a;
                reg_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, a);
                if (a >= b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) a);
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) b);
            } break ;
            case INS_JGEF: {
                uint8_t* addr;
                regf_t a;
                regf_t b;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t*, addr);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, b);
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, a);
                if (a >= b) {
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                }

                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) a);
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) b);
            } break ;
            case INS_LRA: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t offset_index_of_type;
                uint32_t offset_of_atom;
                uint8_t size_of_atom;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, offset_index_of_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint32_t, offset_of_atom);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, size_of_atom);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ASSERT(size_of_atom <= sizeof(reg_t));
                uint8_t* type_addr;
                ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, aligned_buffer_type, offset_index_of_type, type_addr);
                uint8_t* atom_addr = type_addr + offset_of_atom;
                reg_t atom = 0;
                memmove(&atom, atom_addr, size_of_atom);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, atom);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) atom);
            } break ;
            case INS_LRAF: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t offset_index_of_type;
                uint32_t offset_of_atom;
                uint8_t size_of_atom;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, offset_index_of_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint32_t, offset_of_atom);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, size_of_atom);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ASSERT(size_of_atom <= sizeof(regf_t));
                uint8_t* type_addr;
                ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, aligned_buffer_type, offset_index_of_type, type_addr);
                uint8_t* atom_addr = type_addr + offset_of_atom;
                regf_t atom = 0;
                memmove(&atom, atom_addr, size_of_atom);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, atom);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) atom);
            } break ;
            case INS_SAR: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t offset_index_of_type;
                uint32_t offset_of_atom;
                uint8_t size_of_atom;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, offset_index_of_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint32_t, offset_of_atom);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, size_of_atom);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ASSERT(size_of_atom <= sizeof(reg_t));
                reg_t atom = 0;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, atom);
                uint8_t* type_addr;
                ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, aligned_buffer_type, offset_index_of_type, type_addr);
                uint8_t* atom_addr = type_addr + offset_of_atom;
                memmove(atom_addr, &atom, size_of_atom);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (int64_t) atom);
            } break ;
            case INS_SARF: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t offset_index_of_type;
                uint32_t offset_of_atom;
                uint8_t size_of_atom;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, offset_index_of_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint32_t, offset_of_atom);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, size_of_atom);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                ASSERT(size_of_atom <= sizeof(regf_t));
                regf_t atom = 0;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTERF_STACK, regf_t, atom);
                uint8_t* type_addr;
                ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, aligned_buffer_type, offset_index_of_type, type_addr);
                uint8_t* atom_addr = type_addr + offset_of_atom;
                memmove(atom_addr, &atom, size_of_atom);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
                debug__push_flt(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, (double) atom);
            } break ;
            case INS_LREA: {
                aligned_buffer_type_t aligned_buffer_type;
                uint8_t offset_index_of_type;
                uint32_t offset_of_member;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, aligned_buffer_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint8_t, offset_index_of_type);
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, uint32_t, offset_of_member);
                ASSERT(aligned_buffer_type < _ALIGNED_BUFFER_TYPE_SIZE);
                uint8_t* type_addr;
                ALIGNED_BUFFER_ADDR_AT_WRAPPER(self, aligned_buffer_type, offset_index_of_type, type_addr);
                uint8_t* member_addr = type_addr + offset_of_member;
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, uint8_t*, member_addr);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, aligned_buffer_type__to_str(aligned_buffer_type));
                debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, member_addr);
            } break ;
            case INS_CALL_INTERNAL: {
                type_internal_function_t* internal_function;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, type_internal_function_t*, internal_function);
                BUFFER_PUSH_WRAPPER(self, BUFFER_TYPE_RETURN_IP_STACK, uint8_t*, self->buffer[BUFFER_TYPE_IP].cur);
                self->buffer[BUFFER_TYPE_IP].cur = type_internal_function__start_ip(internal_function);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, internal_function->function_base.name);
            } break ;
            case INS_CALL_EXTERNAL: {
                type_external_function_t* external_function;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, type_external_function_t*, external_function);
                type_external_function__call(external_function, self);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, external_function->function_base.name);
            } break ;
            case INS_CALL_BUILTIN: {
                type_builtin_function_t* builtin_function;
                IP_POP(self->buffer[BUFFER_TYPE_IP].cur, type_builtin_function_t*, builtin_function);
                type_builtin_function__call(builtin_function, self);

                debug__push_str(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, builtin_function->function_base.name);
            } break ;
            case INS_RET: {
                uint8_t* addr;
                if (self->buffer[BUFFER_TYPE_RETURN_IP_STACK].cur == self->buffer[BUFFER_TYPE_RETURN_IP_STACK].start) {
                    self->alive = false;
                } else {
                    BUFFER_POP_WRAPPER(self, BUFFER_TYPE_RETURN_IP_STACK, uint8_t*, addr);
                    self->buffer[BUFFER_TYPE_IP].cur = addr;
                    debug__push_ptr(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, addr);
                }
            } break ;
            case INS_EXIT: {
                self->alive = false;
                BUFFER_POP_WRAPPER(self, BUFFER_TYPE_REGISTER_STACK, reg_t, self->exit_status_code);
                printf("\nExit status code: %lu\n", self->exit_status_code);

                debug__push_int(&debug, DEBUG_BUFFER_TYPE_INS_OPERAND, self->exit_status_code);
            } break ;
            default: ASSERT(false);
        }


        debug__dump_line(&debug, DEBUG_OUT_MODE_RUNTIME_CODE);
        debug__dump_line(&debug, DEBUG_OUT_MODE_RUNTIME_STACK);
        debug__clear_line(&debug);
    }
}
