#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdarg.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#if defined (__GNUC__)
# include <x86intrin.h>
#endif

#include "state.h"
#include "debug.h"

// #define PROFILING

const char* address_register_type__to_str(address_register_type_t reg) {
    switch (reg) {
    case REG_SP: return "REG_SP";
    case REG_BP: return "REG_BP";
    case REG_ADDR1: return "REG_ADDR1";
    default: ASSERT(false);
    }

    return 0;
}

bool state__create(state_t* self) {
    memset(self, 0, sizeof(*self));

    self->code_size = 4096;
    self->code = malloc(self->code_size * sizeof(*self->code));
    for (uint32_t code_index = 0; code_index < self->code_size; ++code_index) {
        self->code[code_index] = INS_NOP;
    }
    self->ip = self->code;

    const uint64_t stack_size = 4096;
    self->stack = malloc(stack_size * sizeof(*self->stack));
    self->address_registers[REG_SP] = self->stack;
    self->stack_end = self->stack + stack_size;
    self->address_registers[REG_BP] = self->address_registers[REG_SP];

    self->stack_aligned_size = 1024;
    self->stack_aligned = malloc(self->stack_aligned_size * sizeof(*self->stack_aligned));

    if (!types__create(&self->types)) {
        return false;
    }

    if (!shared_lib__create(&self->shared_libs)) {
        return false;
    }

    return true;
}

void state__destroy(state_t* self) {
}

static inline void compile__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr) {
    *(uint64_t*)(jmp_ip + 1) = (uint64_t) new_addr;
}

static inline void state__patch_call(uint8_t* call_ip, uint8_t* new_addr) {
    *(uint64_t*)(call_ip + 1) = (uint64_t) new_addr;
}

#define STACK_CHECK(state_p, addr) do { \
    ASSERT((uint8_t*) (addr) >= (state_p)->stack && "Stack underflow."); \
    ASSERT((uint8_t*) (addr) < (state_p)->stack_end && "Stack overflow."); \
} while (false)
#define BP_SET(state_p, n) do { \
    STACK_CHECK(state_p, n); \
    (state_p)->address_registers[REG_BP] = (uint8_t*) (n); \
} while (false)
#define SP_SET(state_p, n) do { \
    STACK_CHECK(state_p, n); \
    (state_p)->address_registers[REG_SP] = (uint8_t*) (n); \
} while (false)
#define STACK_GROW(state_p, n) do { \
    SP_SET(state_p, (state_p)->address_registers[REG_SP] + (n)); \
} while (false)
#define STACK_PUSH(state_p, type, a) do { \
    debug__push_stack_delta(&debug, (uint8_t*)(&(a)), sizeof(type)); \
    *(type*) ((state_p)->address_registers[REG_SP]) = (a); \
    STACK_GROW(state_p, sizeof(type)); \
} while (false)
#define STACK_TOP(state_p, type, minus) (*(type*) ((state_p)->address_registers[REG_SP] - sizeof(type) - minus))
#define STACK_POP(state_p, type, result) do { \
    result = *(type*) ((state_p)->address_registers[REG_SP] - sizeof(type)); \
    debug__push_stack_delta(&debug, (uint8_t*)(&(result)), sizeof(type)); \
    (state_p)->address_registers[REG_SP] -= sizeof(type); \
} while (false)

void state__compile_fact(type_internal_function_t* type_function, types_t* types) {
    type_internal_function__add_ins(type_function, INS_PUSH, 1);
    type_internal_function__store_return(type_function, NULL);

    type_internal_function__load_argument(type_function, "arg1", NULL);
    type_internal_function__add_ins(type_function, INS_PUSH, 1);
    uint8_t* fact_end = type_internal_function__end_ip(type_function);
    type_internal_function__add_ins(type_function, INS_JLE, NULL);
    uint8_t* loop_start = type_internal_function__end_ip(type_function);
    type_internal_function__load_return(type_function, NULL);
    type_internal_function__load_argument(type_function, "arg1", NULL);
    type_internal_function__add_ins(type_function, INS_MUL);
    type_internal_function__store_return(type_function, NULL);
    type_internal_function__load_argument(type_function, "arg1", NULL);
    type_internal_function__add_ins(type_function, INS_DEC);
    type_internal_function__store_argument(type_function, "arg1", NULL);
    type_internal_function__load_argument(type_function, "arg1", NULL);
    uint8_t* fact_end2 = type_internal_function__end_ip(type_function);
    type_internal_function__add_ins(type_function, INS_JZ, fact_end);
    type_internal_function__add_ins(type_function, INS_JMP, loop_start);

    compile__patch_jmp(fact_end, type_internal_function__end_ip(type_function));
    compile__patch_jmp(fact_end2, type_internal_function__end_ip(type_function));
}

void state__compile_ret_struct_fn(type_internal_function_t* type_function, types_t* types) {
    type_internal_function__add_ins(type_function, INS_PUSH, -120);
    type_internal_function__store_return(type_function, "member_1", NULL);

    type_internal_function__add_ins(type_function, INS_PUSH, -12345);
    type_internal_function__store_return(type_function, "member_2", NULL);

    type_internal_function__add_ins(type_function, INS_PUSH, 123456789101112);
    type_internal_function__store_return(type_function, "member_3", NULL);

    ASSERT(type_function->return_type->type_specifier == TYPE_STRUCT);
    type_struct_t* type_struct = (type_struct_t*) type_function->return_type;
    member_t* member_array = type_struct__member(type_struct, "member_array");
    ASSERT(member_array);

    type_array_t* arr_type = (type_array_t*) member_array->type;
    ASSERT(member_array->type->type_specifier == TYPE_ARRAY);
    for (uint32_t arr_index = 0; arr_index < arr_type->element_size; ++arr_index) {
        type_internal_function__add_ins(type_function, INS_PUSH, arr_index * 13);
        type_internal_function__store_return(type_function, "member_array", arr_index, NULL);
    }
}

void compile__emit_set_type(type_internal_function_t* self, type_t* type, ...) {
    va_list ap;
    va_start(ap, type);

    int64_t sp_offset = 0;
    sp_offset -= type__size(type);

    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(type, member_name);
        if (member) {
            sp_offset += (int64_t) member->offset;
            if (member->type->type_specifier == TYPE_ARRAY) {
                type_array_t* type_array = (type_array_t*) member->type;
                uint64_t element_index = va_arg(ap, uint64_t);
                sp_offset += (int64_t) element_index * type__size(type_array->element_type);
            }
            type = member->type;
        } else {
            ASSERT(false);
        }
        member_name = va_arg(ap, const char*);
    }

    ASSERT(type);

    uint64_t value = va_arg(ap, uint64_t);

    type_internal_function__add_ins(self, INS_PUSH, value);
    type_internal_function__add_ins(
        self,
        INS_STORE,
        REG_SP,
        sp_offset - sizeof(reg_t) /* INS_PUSH, value */,
        type__size(type)
    );

    va_end(ap);
}

void compile__emit_call(type_internal_function_t* self, type_t* fn_to_call) {
    switch (fn_to_call->type_specifier) {
        case TYPE_FUNCTION_INTERNAL: {
            type_internal_function__add_ins(self, INS_CALL_INTERNAL, fn_to_call);
        } break ;
        case TYPE_FUNCTION_EXTERNAL: {
            type_internal_function__add_ins(self, INS_CALL_EXTERNAL, fn_to_call);
        } break ;
        case TYPE_FUNCTION_BUILTIN: {
            type_internal_function__add_ins(self, INS_CALL_BUILTIN, fn_to_call);

            type_builtin_function_t* builtin_fn = (type_builtin_function_t*) fn_to_call;
            for (uint32_t arg_index = 0; arg_index < builtin_fn->arguments_offsets_top; ++arg_index) {
                type_internal_function__add_ins(self, INS_POP_TYPE);
            }
        } break ;
        default: ASSERT(false);
    }
}

void state__compile_start(type_internal_function_t* self, types_t* types) {
    type_t* t_s64 = types__type_find(types, "s64");
    ASSERT(t_s64);

    type_internal_function_t* main_fn = (type_internal_function_t*) types__type_find(types, "main");
    ASSERT(main_fn);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_s64);
    compile__emit_call(self, (type_t*) main_fn);
    type_internal_function__add_ins(self, INS_EXIT);
}

void state__compile_main(type_internal_function_t* self, types_t* types) {
    type_t* t_s32 = types__type_find(types, "s32");
    ASSERT(t_s32);
    type_t* t_u64 = types__type_find(types, "u64");
    ASSERT(t_u64);
    type_t* fact_fn_decl = types__type_find(types, "fact");
    ASSERT(fact_fn_decl);
    type_t* print_fn = types__type_find(types, "print");
    ASSERT(print_fn);
    type_t* t_a = types__type_find(types, "a");
    ASSERT(t_a);
    type_t* ret_struct = types__type_find(types, "ret_struct");
    ASSERT(ret_struct);
    type_t* fact_result = type_internal_function__get_local(self, "fact_result", NULL);
    ASSERT(fact_result);
    type_t* t_void_p = types__type_find(types, "void_p");
    ASSERT(t_void_p);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_s32);
    compile__emit_set_type(self, t_s32, NULL, 10);
    compile__emit_call(self, fact_fn_decl);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, fact_result);
    compile__emit_set_type(self, fact_result, NULL, (uint64_t) fact_result);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_void_p);
    type_internal_function__add_ins(self, INS_PUSH_REG, REG_BP);
    type_internal_function__add_ins(
        self,
        INS_STORE,
        REG_SP,
        - sizeof(reg_t) /* PUSH_REG, REG_BP */ -(int64_t) type__size(t_void_p),
        type__size(t_void_p)
    );
    compile__emit_call(self, print_fn);

    // save address for second argument of print
    type_internal_function__add_ins(self, INS_MOV_REG, REG_ADDR1, REG_SP);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_a);
    compile__emit_call(self, ret_struct);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_a);
    compile__emit_set_type(self, t_void_p, NULL, (uint64_t) t_a);
    type_internal_function__add_ins(self, INS_PUSH_REG, REG_ADDR1);

    compile__emit_call(self, print_fn);

    type_internal_function__add_ins(self, INS_PUSH, 42);
    type_internal_function__store_return(self, NULL);
}

void state__compile_store_load_fn(type_internal_function_t* self, types_t* types) {
}

void state__define_internal_functions(state_t* self) {
    type_t* t_s64 = types__type_find(&self->types, "s64");
    type_t* t_s32 = types__type_find(&self->types, "s32");
    type_t* t_a = types__type_find(&self->types, "a");
    ASSERT(t_s64);
    ASSERT(t_s64);

    type_internal_function_t* ret_struct_fn = type_internal_function__create("ret_struct", &state__compile_ret_struct_fn);
    type_internal_function__set_return(ret_struct_fn, t_a);

    type_internal_function_t* fact_fn = type_internal_function__create("fact", &state__compile_fact);
    type_internal_function__set_return(fact_fn, t_s64);
    type_internal_function__add_argument(fact_fn, "arg1", t_s32);

    type_internal_function_t* main_fn = type_internal_function__create("main", &state__compile_main);
    type_internal_function__add_local(main_fn, "fact_result", t_s64);
    type_internal_function__set_return(main_fn, t_s64);

    type_internal_function_t* _start_fn = type_internal_function__create("_start", &state__compile_start);

    type_internal_function_t* store_load_fn = type_internal_function__create("store_load_fn", &state__compile_store_load_fn);

    types__type_add(&self->types, (type_t*) ret_struct_fn);
    types__type_add(&self->types, (type_t*) fact_fn);
    types__type_add(&self->types, (type_t*) main_fn);
    types__type_add(&self->types, (type_t*) _start_fn);
    types__type_add(&self->types, (type_t*) store_load_fn);

    type_internal_function__compile(main_fn, &self->types, self->code);
    type_internal_function__compile(_start_fn, &self->types, type_internal_function__end_ip(main_fn));
    type_internal_function__compile(fact_fn, &self->types, type_internal_function__end_ip(_start_fn));
    type_internal_function__compile(ret_struct_fn, &self->types, type_internal_function__end_ip(fact_fn));
    type_internal_function__compile(store_load_fn, &self->types, type_internal_function__end_ip(ret_struct_fn));

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
    // compile__patch_jmp(exit_one_ip, ip);
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 1);
}

void state__execute_malloc(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    uint64_t malloc_arg = *(uint64_t*) (state->address_registers[REG_SP] + type_builtin_function__argument_offset_from_bp(self, 0));
    void* malloc_result = malloc(malloc_arg);
    uint8_t* malloc_return_sp = state->address_registers[REG_SP] + type_builtin_function__return_offset_from_bp(self);
    *(uint64_t*) malloc_return_sp = *(uint64_t*) malloc_result;
}

void state__execute_free(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    void* addr = (void*) *(uint64_t*) (state->address_registers[REG_SP] + type_builtin_function__argument_offset_from_bp(self, 0));
    free(addr);
}

void state__execute_print(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    type_t* type = (type_t*) *(uint64_t*) (state->address_registers[REG_SP] + type_builtin_function__argument_offset_from_bp(self, 0));
    uint8_t* addr = (uint8_t*) *(uint64_t*) (state->address_registers[REG_SP] + type_builtin_function__argument_offset_from_bp(self, 1));
    type__print(type, stdout, 3, -1, addr);
}

void state__define_builtin_functions(state_t* self) {
    type_t* t_u64 = types__type_find(&self->types, "u64");
    ASSERT(t_u64);
    type_t* t_void_p = types__type_find(&self->types, "void_p");
    ASSERT(t_void_p);

    type_builtin_function_t* builtin_malloc = type_builtin_function__create("malloc", &state__execute_malloc);
    type_builtin_function__add_argument(builtin_malloc, "size", t_u64);
    type_builtin_function__set_return(builtin_malloc, t_void_p);

    type_builtin_function_t* builtin_free = type_builtin_function__create("free", &state__execute_free);
    type_builtin_function__add_argument(builtin_free, "addr", t_void_p);

    type_builtin_function_t* builtin_print = type_builtin_function__create("print", &state__execute_print);
    type_builtin_function__add_argument(builtin_print, "type", t_void_p);
    type_builtin_function__add_argument(builtin_print, "addr", t_void_p);

    types__type_add(&self->types, (type_t*) builtin_malloc);
    types__type_add(&self->types, (type_t*) builtin_free);
    types__type_add(&self->types, (type_t*) builtin_print);
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

static void _type__print_value_s16_aligned_4(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(int16_t*) address);
}

void state__create_user_types(types_t* types) {
    type_struct_t* ta = type_struct__create("a");
    types__type_add(types, (type_t*) ta);
    type_t* ts8 = types__type_find(types, "s8");
    ASSERT(ts8);
    type_atom_t* ts16_aligned_4 = type_atom__create("s16_aligned_4", "s16_aligned_4", sizeof(int16_t), &_type__print_value_s16_aligned_4);
    type__set_alignment((type_t*) ts16_aligned_4, 4);

    type_t* tu64 = types__type_find(types, "u64");
    ASSERT(tu64);
    type_struct__add(ta, ts8,  "member_1");
    type_struct__add(ta, (type_t*) ts16_aligned_4, "member_2");
    type_struct__add(ta, tu64, "member_3");
    // type__set_alignment((type_t*) ta, 1024);

    type_array_t* tb = type_array__create("b", ts8, 7);
    type_struct__add(ta, (type_t*) tb, "member_array");
}

void state__load_shared_libs(state_t* self) {
    shared_lib__add(&self->shared_libs, "libtest.so");
}

void state__define_external_functions(state_t* self) {
    type_t* tu64 = types__type_find(&self->types, "u64");
    ASSERT(tu64);

    type_external_function_t* fact_fn = type_external_function__create("fact", "libtest.so", &self->shared_libs, false);
    type_external_function__add_argument(fact_fn, "arg", tu64, &self->types);
    type_external_function__set_return(fact_fn, tu64, &self->types);
    type_external_function__set_signature(fact_fn, &self->types);
}

int main() {
    cache_t cache;
    cache.memory_size = 20 * 1024 * 1024;
    cache.memory = malloc(cache.memory_size);

    state_t state;
    if (!state__create(&state)) {
        ASSERT(false);
    }

    debug__create(&debug, &state);

    state__load_shared_libs(&state);
    state__create_user_types(&state.types);
    state__define_builtin_functions(&state);
    state__define_external_functions(&state);
    state__define_internal_functions(&state);

    type_internal_function_t* _start = (type_internal_function_t*) types__type_find(&state.types, "_start");
    ASSERT(_start);

    uint64_t time_total_virt = 0;
    uint64_t time_total_real = 0;
    uint32_t number_of_iters = 1;
    for (uint32_t current_iter = 0; current_iter < number_of_iters; ++current_iter) {
        state.alive = true;
        state.ip = type_internal_function__start_ip(_start);
        state.address_registers[REG_SP] = state.stack;
        state.address_registers[REG_BP] = state.stack;
        // clear_cache(&cache);

        while (state.alive) {
            debug__set_ip(&debug, state.ip);
            ASSERT(state.ip >= state.code && state.ip < state.code + state.code_size);
            uint8_t ins = *state.ip++;
            switch (ins) {
                case INS_PUSH: {
                    reg_t n;
                    CODE_POP(state.ip, reg_t, n);
                    STACK_PUSH(&state, reg_t, n);
                } break ;
                case INS_PUSH_TYPE: {
                    uint64_t alignment;
                    uint64_t size;
                    CODE_POP(state.ip, uint64_t, alignment);
                    CODE_POP(state.ip, uint64_t, size);
                    ASSERT(state.stack_aligned_top < state.stack_aligned_size && "Stack aligned metadata overflow");
                    state.stack_aligned[state.stack_aligned_top++] = state.address_registers[REG_SP];
                    uint64_t remainder = ((uint64_t) state.address_registers[REG_SP]) % alignment;
                    if (remainder) {
                        STACK_GROW(&state, alignment - remainder);
                    }
                    STACK_GROW(&state, size);
                } break ;
                case INS_PUSHF: {
                    regf_t n;
                    CODE_POP(state.ip, regf_t, n);
                    STACK_PUSH(&state, regf_t, n);
                } break ;
                case INS_PUSH_REG: {
                    address_register_type_t reg;
                    CODE_POP(state.ip, uint8_t, reg);
                    ASSERT(reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    uint8_t* result = state.address_registers[reg];
                    ASSERT(reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    STACK_PUSH(&state, uint8_t*, result);

                    debug__push_ins_arg(&debug, address_register_type__to_str(reg));
                } break ;
                case INS_POP: {
                    STACK_GROW(&state, -(int64_t) sizeof(reg_t));
                } break ;
                case INS_POP_TYPE: {
                    ASSERT(state.stack_aligned_top > 0 && "Stack aligned metadata underflow");
                    uint8_t* new_sp = state.stack_aligned[--state.stack_aligned_top];
                    SP_SET(&state, new_sp);
                } break ;
                case INS_POPF: {
                    STACK_GROW(&state, -(int64_t) sizeof(regf_t));
                } break ;
                case INS_POP_REG: {
                    reg_t result;
                    address_register_type_t reg;
                    CODE_POP(state.ip, uint8_t, reg);
                    STACK_POP(&state, reg_t, result);
                    state.address_registers[reg] = (uint8_t*) result;

                    debug__push_ins_arg(&debug, address_register_type__to_str(reg));
                } break ;
                case INS_MOV_REG: {
                    address_register_type_t dst_reg;
                    address_register_type_t src_reg;
                    CODE_POP(state.ip, uint8_t, dst_reg);
                    CODE_POP(state.ip, uint8_t, src_reg);
                    ASSERT(dst_reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    ASSERT(src_reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    state.address_registers[dst_reg] = state.address_registers[src_reg];

                    debug__push_ins_arg(&debug, address_register_type__to_str(dst_reg));
                    debug__push_ins_arg(&debug, address_register_type__to_str(src_reg));
                } break ;
                case INS_ADD: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a + b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_ADDF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = a + b;
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_SUB: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a - b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_SUBF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = a - b;
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_MUL: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a * b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_MULF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = a * b;
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_DIV: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a / b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_DIVF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = a / b;
                    STACK_PUSH(&state, regf_t, result);
                } break ;
                case INS_MOD: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a % b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_MODF: {
                    regf_t a;
                    regf_t b;
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    regf_t result = fmod(a, b);
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
                    a = -a;
                    STACK_PUSH(&state, reg_t, a);
                } break ;
                case INS_NEGF: {
                    regf_t a;
                    STACK_POP(&state, regf_t, a);
                    a = -a;
                    STACK_PUSH(&state, regf_t, a);
                } break ;
                case INS_INC: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a + 1;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_DEC: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a - 1;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_NOT: {
                    reg_t a;
                    STACK_POP(&state, reg_t, a);
                    a = ~a;
                    STACK_PUSH(&state, reg_t, a);
                } break ;
                case INS_XOR: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a ^ b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_AND: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a & b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_OR: {
                    reg_t a;
                    reg_t b;
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    reg_t result = a | b;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_JMP: {
                    uint8_t* addr;
                    CODE_POP(state.ip, uint8_t*, addr);
                    state.ip = addr;
                } break ;
                case INS_JZ: {
                    uint8_t* addr;
                    reg_t a;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, a);
                    if (a == 0) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JZF: {
                    uint8_t* addr;
                    regf_t a;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, a);
                    if (a == 0.0) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JL: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a < b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a < b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JG: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a > b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a > b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a == b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a == b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a <= b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JLEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a <= b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGE: {
                    uint8_t* addr;
                    reg_t a;
                    reg_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, reg_t, b);
                    STACK_POP(&state, reg_t, a);
                    if (a >= b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_JGEF: {
                    uint8_t* addr;
                    regf_t a;
                    regf_t b;
                    uint8_t bytes;
                    CODE_POP(state.ip, uint8_t*, addr);
                    STACK_POP(&state, regf_t, b);
                    STACK_POP(&state, regf_t, a);
                    if (a >= b) {
                        state.ip = addr;
                    }
                } break ;
                case INS_LOAD: {
                    address_register_type_t reg;
                    int16_t offset;
                    uint8_t size;
                    CODE_POP(state.ip, uint8_t, reg);
                    CODE_POP(state.ip, int16_t, offset);
                    CODE_POP(state.ip, uint8_t, size);
                    ASSERT(reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    ASSERT(size <= 8);
                    STACK_CHECK(&state, state.address_registers[REG_SP] + size);
                    debug__push_stack_delta(&debug, state.address_registers[reg] + offset, size);
                    memmove(state.address_registers[REG_SP], state.address_registers[reg] + offset, size);
                    if (size < sizeof(reg_t)) {
                        // fill remaining bytes with 0s
                        memset(state.address_registers[REG_SP] + size, 0, sizeof(reg_t) - size);
                    }
                    STACK_GROW(&state, sizeof(reg_t));

                    debug__push_ins_arg(&debug, address_register_type__to_str(reg));
                } break ;
                case INS_STORE: {
                    address_register_type_t reg;
                    int16_t offset;
                    uint8_t size;
                    CODE_POP(state.ip, uint8_t, reg);
                    CODE_POP(state.ip, int16_t, offset);
                    CODE_POP(state.ip, uint8_t, size);
                    ASSERT(reg < _ADDRESS_REGISTER_TYPE_SIZE);
                    ASSERT(size <= 8);
                    debug__push_stack_delta(&debug, state.address_registers[REG_SP], size);
                    memmove(state.address_registers[reg] + offset, state.address_registers[REG_SP] -(int64_t) sizeof(reg_t), size);
                    STACK_GROW(&state, -(int64_t) sizeof(reg_t));

                    debug__push_ins_arg(&debug, address_register_type__to_str(reg));
                } break ;
                case INS_CALL_INTERNAL: {
                    type_internal_function_t* internal_function;
                    CODE_POP(state.ip, type_internal_function_t*, internal_function);

                    debug__push_ins_arg(&debug, internal_function->name);

                    STACK_PUSH(&state, uint8_t*, state.ip);
                    state.ip = type_internal_function__start_ip(internal_function);
                } break ;
                case INS_CALL_EXTERNAL: {
                    ASSERT(false && "todo: implement");
                    type_external_function_t* external_function;
                    CODE_POP(state.ip, type_external_function_t*, external_function);

                    debug__push_ins_arg(&debug, external_function->name);

                    type_external_function__call(external_function, &state);
                } break ;
                case INS_CALL_BUILTIN: {
                    /* stack layout (top-down) when called
                        arguments of builtin function
                        return value of builtin function
                    */
                    type_builtin_function_t* builtin_function;
                    CODE_POP(state.ip, type_builtin_function_t*, builtin_function);

                    debug__push_ins_arg(&debug, builtin_function->name);

                    type_builtin_function__call(builtin_function, &state);
                } break ;
                case INS_RET: {
                    uint8_t* addr;
                    uint16_t number_of_arguments;
                    STACK_POP(&state, uint8_t*, addr);
                    CODE_POP(state.ip, uint16_t, number_of_arguments);
                    ASSERT(state.stack_aligned_top >= number_of_arguments && "Stack aligned metadata underflow");
                    state.stack_aligned_top -= number_of_arguments;
                    if (number_of_arguments > 0) {
                        uint8_t* new_sp = state.stack_aligned[state.stack_aligned_top];
                        SP_SET(&state, new_sp);
                    }
                    state.ip = addr;
                } break ;
                case INS_EXIT: {
                    state.alive = false;
                    STACK_POP(&state, reg_t, state.exit_status_code);
                    printf("\nExit status code: %lu\n", state.exit_status_code);
                } break ;
                case INS_NOP: {
                } break ;
                default: ASSERT(false);
            }

            debug__dump_line(&debug, debug.runtime_code_file);
        }
    }

    state__destroy(&state);
    debug__destroy(&debug);

    return 0;
}

// todo: debug - dump compiled byte-code, runtime byte-code, stack into files
// todo: instruction to load in from dll
// todo: fn types for this? ^

// lower priority todos:
// todo: control flow graph
