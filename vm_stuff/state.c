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

uint32_t string_hash_fn(const hash_map_key_t* string_key) {
    const char* _string_ky = *(const char**) string_key;
    uint32_t result = 0;
    
    while (*_string_ky != '\0') {
        result += *_string_ky++;
    }

    return result;
}

bool string_eq_fn(const hash_map_key_t* string_key_a, const hash_map_key_t* string_key_b) {
    const char* _string_key_a = *(const char**) string_key_a;
    const char* _string_key_b = *(const char**) string_key_b;

    return strcmp(_string_key_a, _string_key_b) == 0;
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
    self->stack_top = self->stack;
    self->stack_end = self->stack + stack_size;
    self->base_pointer = self->stack_top;

    self->stack_aligned_size = 1024;
    self->stack_aligned = malloc(self->stack_aligned_size * sizeof(*self->stack_aligned));

    uint32_t types_size_of_key = sizeof(const char*);
    uint32_t types_size_of_value = sizeof(type_t*);
    uint64_t types_memory_size = 1024 * hash_map__entry_size(types_size_of_key, types_size_of_value);
    void* types_memory = malloc(types_memory_size);
    if (!hash_map__create(&self->types, types_memory, types_memory_size, types_size_of_key, types_size_of_value, string_hash_fn, string_eq_fn)) {
        return false;
    }

    return true;
}

void state__destroy(state_t* self) {
}

static void type__add(hash_map_t* types, type_t* type) {
    uint64_t abbr_name_addr = (uint64_t) type->abbreviated_name;
    uint64_t type_addr = (uint64_t) type;
    if (!hash_map__insert(types, &abbr_name_addr, &type_addr)) {
        ASSERT(false);
    }
}

static type_t* type__find(hash_map_t* types, const char* abbreviated_name) {
    uint64_t abbr_name_addr = (uint64_t) abbreviated_name;
    type_t** type_addr = hash_map__find(types, &abbr_name_addr);
    ASSERT(type_addr);

    return *type_addr;
}

static inline void compile__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr) {
    *(uint64_t*)(jmp_ip + 1) = (uint64_t) new_addr;
}

static inline void state__patch_call(uint8_t* call_ip, uint8_t* new_addr) {
    *(uint64_t*)(call_ip + 1) = (uint64_t) new_addr;
}

static void compile__function(hash_map_t* types, type_internal_function_t* function, uint8_t* ip) {
    debug__set_fn(&debug, function->name);
    type_internal_function__set_ip(function, ip);
    type_internal_function__add_ins(function, INS_PUSH_BP);
    type_internal_function__add_ins(function, INS_MOV_REG, 0, 1);

    // push for locals
    for (uint32_t local_index = 0; local_index < function->locals_top; ++local_index) {
        type_internal_function__add_ins(function, INS_PUSH_TYPE, function->locals[local_index].type);
    }

    function->compile_fn(types, function);

    type_internal_function__add_ins(function, INS_POP_BP);
    type_internal_function__add_ins(function, INS_RET, function->arguments_top);
}

#define STACK_CHECK(state_p, addr) do { \
    ASSERT((uint8_t*) addr >= (state_p)->stack && "Stack underflow."); \
    ASSERT((uint8_t*) addr < (state_p)->stack_end && "Stack overflow."); \
} while (false)
#define BP_SET(state_p, n) do { \
    STACK_CHECK(state_p, n); \
    (state_p)->base_pointer = (uint8_t*) n; \
} while (false)
#define SP_SET(state_p, n) do { \
    STACK_CHECK(state_p, n); \
    (state_p)->stack_top = (uint8_t*) n; \
} while (false)
#define STACK_GROW(state_p, n) do { \
    SP_SET(state_p, (state_p)->stack_top + n); \
} while (false)
#define STACK_PUSH(state_p, type, a) do { \
    debug__push_ins_arg_bytes(&debug, (uint8_t*)&a, sizeof(type)); \
    *(type*) ((state_p)->stack_top) = a; \
    STACK_GROW(state_p, sizeof(type)); \
} while (false)
#define STACK_TOP(state_p, type, minus) (*(type*) ((state_p)->stack_top - sizeof(type) - minus))
#define STACK_POP(state_p, type, result) do { \
    result = *(type*) ((state_p)->stack_top - sizeof(type)); \
    debug__push_ins_arg_bytes(&debug, (uint8_t*)&result, sizeof(type)); \
    (state_p)->stack_top -= sizeof(type); \
} while (false)

void state__compile_fact(hash_map_t* types, type_internal_function_t* type_function) {
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

void state__compile_ret_struct_fn(hash_map_t* types, type_internal_function_t* type_function) {
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

void compile__emit_type(type_internal_function_t* type_function, type_t* type, ...) {
    va_list ap;
    va_start(ap, type);

    type_internal_function__add_ins(type_function, INS_PUSH_TYPE, type);

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

    type_internal_function__add_ins(type_function, INS_PUSH, value);
    type_internal_function__add_ins(type_function, INS_PUSH_SP);
    type_internal_function__add_ins(type_function, INS_PUSH, sp_offset - 8 /* "INS_PUSH, value" 2 lines ago*/);
    type_internal_function__add_ins(type_function, INS_ADD);
    type_internal_function__add_ins(type_function, INS_STACK_STORE, type__size(type));

    va_end(ap);
}

void compile__emit_call(type_internal_function_t* type_function, type_t* fn_to_call) {
    switch (fn_to_call->type_specifier) {
        case TYPE_FUNCTION_INTERNAL: {
            type_internal_function__add_ins(type_function, INS_CALL_INTERNAL, fn_to_call);
        } break ;
        case TYPE_FUNCTION_EXTERNAL: {
            type_internal_function__add_ins(type_function, INS_CALL_EXTERNAL, fn_to_call);
        } break ;
        case TYPE_FUNCTION_BUILTIN: {
            type_internal_function__add_ins(type_function, INS_CALL_BUILTIN, fn_to_call);
        } break ;
        default: ASSERT(false);
    }
}

void state__compile_start(hash_map_t* types, type_internal_function_t* type_function) {
    type_t* t_reg = type__find(types, "reg");
    ASSERT(t_reg);

    type_internal_function_t* main_fn = (type_internal_function_t*) type__find(types, "main");
    ASSERT(main_fn);

    type_internal_function__add_ins(type_function, INS_PUSH_TYPE, t_reg);
    compile__emit_call(type_function, (type_t*) main_fn);
    type_internal_function__add_ins(type_function, INS_EXIT);
}

void state__compile_main(hash_map_t* types, type_internal_function_t* type_function) {
    type_t* t_s32 = type__find(types, "s32");
    ASSERT(t_s32);

    type_t* fact_fn_decl = type__find(types, "fact");
    ASSERT(fact_fn_decl);

    type_t* print_fn = type__find(types, "print");
    ASSERT(print_fn);

    compile__emit_type(type_function, t_s32, NULL, 10);
    compile__emit_call(type_function, fact_fn_decl);

    // type_internal_function__load_local(type_function, "fact_result", NULL);
    type_internal_function__add_ins(type_function, INS_PUSH, *(uint64_t*) type_function->locals[0].type);
    type_internal_function__add_ins(type_function, INS_PUSH_BP);

    compile__emit_call(type_function, print_fn);
    type_internal_function__add_ins(type_function, INS_POP_TYPE);
    type_internal_function__add_ins(type_function, INS_PUSH, 42);
    type_internal_function__store_return(type_function, NULL);
}

void state__compile(state_t* self) {
    // _start_fn
    type_internal_function_t* main_fn = (type_internal_function_t*) type__find(&self->types, "main");
    ASSERT(main_fn);
    compile__function(&self->types, main_fn, self->code);

    type_internal_function_t* _start_fn = (type_internal_function_t*) type__find(&self->types, "_start");
    ASSERT(_start_fn);
    compile__function(&self->types, _start_fn, type_internal_function__end_ip(main_fn));

    type_internal_function_t* fact_fn = (type_internal_function_t*) type__find(&self->types, "fact");
    ASSERT(fact_fn);
    compile__function(&self->types, fact_fn, type_internal_function__end_ip(_start_fn));

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

    // call ret struct
    // type_t* ta = type__find(self, "a");
    // ASSERT(ta);
    // fn_decl_t* fn_decl = fn_decl__create("ret_struct", &state__compile_ret_struct_fn, ta);

    // uint8_t* ret_struct_fn_ip = ip;
    // ip = state__add_fn(self, fn_decl, ret_struct_fn_ip);
    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_PUSH_ALIGNED, type__alignment(ta), type__size(ta));
    // ip = state__add_ins(self, ip, INS_CALL, ret_struct_fn_ip);
    // ip = state__add_ins(self, ip, INS_POP_ALIGNED);
    // ip = state__add_ins(self, ip, INS_EXIT);

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

    // entry_ip = ip;
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 0);
}

void state__define_internal_functions(hash_map_t* types) {
    type_t* t_reg = type__find(types, "reg");
    type_t* t_s64 = type__find(types, "s64");
    type_t* t_s32 = type__find(types, "s32");
    type_t* t_a = type__find(types, "a");
    ASSERT(t_reg);
    ASSERT(t_s64);
    ASSERT(t_s64);

    type_internal_function_t* ret_struct_fn = type_internal_function__create("fact", &state__compile_ret_struct_fn);
    type_internal_function__set_return(ret_struct_fn, t_a);

    type_internal_function_t* fact_fn = type_internal_function__create("fact", &state__compile_fact);
    type_internal_function__set_return(fact_fn, t_s64);
    type_internal_function__add_argument(fact_fn, "arg1", t_s32);

    type_internal_function_t* main_fn = type_internal_function__create("main", &state__compile_main);
    type_internal_function__add_local(main_fn, "fact_result", t_s64);
    type_internal_function__set_return(main_fn, t_reg);

    type_internal_function_t* _start_fn = type_internal_function__create("_start", &state__compile_start);

    type__add(types, (type_t*) ret_struct_fn);
    type__add(types, (type_t*) fact_fn);
    type__add(types, (type_t*) main_fn);
    type__add(types, (type_t*) _start_fn);
}

void state__execute_malloc(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    uint8_t* malloc_arg_sp = state->base_pointer - type_builtin__argument_offset_from_bp(self, 0);
    uint64_t malloc_arg = *(uint64_t*) malloc_arg_sp;
    void* malloc_result = malloc(malloc_arg);
    uint8_t* malloc_return_sp = state->base_pointer - type_builtin__return_offset_from_bp(self);
    *(uint64_t*) malloc_return_sp = *(uint64_t*) malloc_result;
}

void state__execute_free(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    uint8_t* free_arg_sp = state->base_pointer - type_builtin__argument_offset_from_bp(self, 0);
    uint64_t* free_arg = (uint64_t*) *(uint64_t*) free_arg_sp;
    free(free_arg);
}

void state__execute_print(type_builtin_function_t* self, void* processor) {
    state_t* state = (state_t*) processor;

    type_t* type = (type_t*) (state->base_pointer + type_builtin__argument_offset_from_bp(self, 0));
    uint8_t* addr = state->base_pointer + type_builtin__argument_offset_from_bp(self, 1);
    type__print(type, stdout, 3, -1, addr);
}

void state__define_builtin_functions(hash_map_t* types) {
    type_t* t_u64 = type__find(types, "u64");
    ASSERT(t_u64);
    type_t* t_void_p = type__find(types, "void_p");
    ASSERT(t_void_p);

    type_builtin_function_t* builtin_malloc = type_builtin_function__create("malloc", &state__execute_malloc);
    type_builtin_function__add_argument(builtin_malloc, "size", t_u64);
    type_builtin_function__set_return(builtin_malloc, t_void_p);

    type_builtin_function_t* builtin_free = type_builtin_function__create("free", &state__execute_free);
    type_builtin_function__add_argument(builtin_free, "addr", t_void_p);

    type_builtin_function_t* builtin_print = type_builtin_function__create("print", &state__execute_print);
    type_builtin_function__add_argument(builtin_print, "type", t_void_p);
    type_builtin_function__add_argument(builtin_print, "addr", t_void_p);

    type__add(types, (type_t*) builtin_malloc);
    type__add(types, (type_t*) builtin_free);
    type__add(types, (type_t*) builtin_print);
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
    fprintf(fp, "%ld", *(int64_t*) address);
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
    fprintf(fp, "%lu", *(uint64_t*) address);
}

static void _type__print_value_r32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%f", *(float*) address);
}

static void _type__print_value_r64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%lf", *(double*) address);
}

static void _type__print_value_reg(FILE* fp, uint8_t* address) {
    reg_t* reg = (reg_t*) address;
    fprintf(fp, "%lu", *reg);
}

void state__create_atom_types(hash_map_t* types) {
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
    type_atom_t* treg = type_atom__create("reg", "reg", sizeof(reg_t), &_type__print_value_reg);
    static_assert(sizeof(float) == 4, "");
    static_assert(sizeof(double) == 8, "");

    type__add(types, (type_t*) ts8 );
    type__add(types, (type_t*) ts16);
    type__add(types, (type_t*) ts32);
    type__add(types, (type_t*) ts64);
    type__add(types, (type_t*) tu8 );
    type__add(types, (type_t*) tu16);
    type__add(types, (type_t*) tu32);
    type__add(types, (type_t*) tu64);
    type__add(types, (type_t*) tr32);
    type__add(types, (type_t*) tr64);
    type__add(types, (type_t*) treg);
}

void state__create_user_types(hash_map_t* types) {
    type_t* t_void_p = (type_t*) type_pointer__create("void_p", NULL);
    type__add(types, t_void_p);
    
    typedef struct saa {
        int8_t   _;
        uint16_t __;
        uint64_t ___;
        uint16_t ____[7];
    } saa_t;

    type_struct_t* ta = type_struct__create("a");
    type__add(types, (type_t*) ta);
    type_t* ts8 = type__find(types, "s8");
    type_atom_t* ts16_aligned_4 = type_atom__create("s16_aligned_4", "s16_aligned_4", sizeof(int16_t), &_type__print_value_s16);
    type__set_alignment((type_t*) ts16_aligned_4, 4);

    type_t* tu64 = type__find(types, "u64");
    ASSERT(ts8);
    ASSERT(tu64);
    type_struct__add(ta, ts8,  "member_1");
    type_struct__add(ta, (type_t*) ts16_aligned_4, "member_2");
    type_struct__add(ta, tu64, "member_3");
    type__set_alignment((type_t*) ta, 1024);

    type_array_t* tb = type_array__create("b", ts8, 7);
    type_struct__add(ta, (type_t*) tb, "member_array");
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

    state__create_atom_types(&state.types);
    state__create_user_types(&state.types);
    state__define_internal_functions(&state.types);
    state__define_builtin_functions(&state.types);

    state__compile(&state);
    type_internal_function_t* _start = (type_internal_function_t*) type__find(&state.types, "_start");
    ASSERT(_start);

    uint64_t time_total_virt = 0;
    uint64_t time_total_real = 0;
    uint32_t number_of_iters = 1;
    for (uint32_t current_iter = 0; current_iter < number_of_iters; ++current_iter) {
        state.alive = true;
        state.ip = type_internal_function__ip(_start);
        state.stack_top = state.stack;
        state.base_pointer = state.stack;
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
                    state.stack_aligned[state.stack_aligned_top++] = state.stack_top;
                    uint64_t remainder = ((uint64_t) state.stack_top) % alignment;
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
                case INS_PUSH_SP: {
                    reg_t result = (uint64_t) state.stack_top;
                    STACK_PUSH(&state, reg_t, result);
                } break ;
                case INS_PUSH_BP: {
                    reg_t result = (uint64_t) state.base_pointer;
                    STACK_PUSH(&state, reg_t, result);
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
                case INS_POP_SP: {
                    reg_t result;
                    STACK_POP(&state, reg_t, result);
                    SP_SET(&state, (uint8_t*) result);
                } break ;
                case INS_POP_BP: {
                    reg_t result;
                    STACK_POP(&state, reg_t, result);
                    BP_SET(&state, (uint8_t*) result);
                } break ;
                case INS_MOV_REG: {
                    uint8_t dst_reg;
                    uint8_t src_reg;
                    CODE_POP(state.ip, uint8_t, dst_reg);
                    CODE_POP(state.ip, uint8_t, src_reg);
                    BP_SET(&state, state.stack_top);
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
                case INS_STACK_LOAD: {
                    reg_t addr;
                    uint8_t bytes;
                    STACK_POP(&state, reg_t, addr);
                    CODE_POP(state.ip, uint8_t, bytes);
                    ASSERT(bytes <= sizeof(reg_t));
                    memmove(state.stack_top, (void*) addr, bytes);
                    debug__push_ins_arg_bytes(&debug, (uint8_t*) addr, bytes);
                    if (bytes < sizeof(reg_t)) {
                        // fill remaining bytes with 0s
                        memset(state.stack_top + bytes, 0, sizeof(reg_t) - bytes);
                    }
                    STACK_GROW(&state, sizeof(reg_t));
                } break ;
                case INS_STACK_STORE: {
                    reg_t addr;
                    uint8_t bytes;
                    STACK_POP(&state, reg_t, addr);
                    CODE_POP(state.ip, uint8_t, bytes);
                    ASSERT(bytes <= sizeof(reg_t));
                    STACK_GROW(&state, -(int64_t) sizeof(reg_t));
                    memmove((void*) addr, state.stack_top, bytes);
                    debug__push_ins_arg_bytes(&debug, (uint8_t*) state.stack_top, bytes);
                } break ;
                case INS_CALL_INTERNAL: {
                    type_internal_function_t* internal_function;
                    CODE_POP(state.ip, type_internal_function_t*, internal_function);
                    STACK_PUSH(&state, uint8_t*, state.ip);
                    state.ip = type_internal_function__ip(internal_function);
 
                    debug__push_ins_arg_str(&debug, internal_function->name);
                } break ;
                case INS_CALL_EXTERNAL: {
                    ASSERT(false && "todo: implement");
                    type_external_function_t* external_function;
                    CODE_POP(state.ip, type_external_function_t*, external_function);
                    type_external_function__call(external_function);
 
                    debug__push_ins_arg_str(&debug, external_function->name);
                } break ;
                case INS_CALL_BUILTIN: {
                    type_builtin_function_t* builtin_function;
                    CODE_POP(state.ip, type_builtin_function_t*, builtin_function);
                    type_builtin_function__call(builtin_function, &state);
 
                    debug__push_ins_arg_str(&debug, builtin_function->name);
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
