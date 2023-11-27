#include "debug.h"
#include "compiler.h"

static void internal__compile_fact(compiler_t* self);
static void internal__compile_ret_struct_fn(compiler_t* self);
static void internal__compile_start(compiler_t* self);
static void internal__compile_main(compiler_t* self);
static void internal__compile_store_load(compiler_t* self);

static void internal__compile_fact(compiler_t* self) {
    type_internal_function__add_ins(self, INS_PUSH, 1);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, NULL);

    uint32_t arg1_index;
    ASSERT(type_function__get_argument(&self->compiled_fn->function_base, "arg1", &arg1_index));
    compiler__emit_internal_function_arg(self, &self->compiled_fn->function_base, FUNCTION_INS_LOAD_INTEGRAL, arg1_index, NULL);
    type_internal_function__add_ins(self, INS_PUSH, 1);
    uint8_t* fact_end = type_internal_function__end_ip(self);
    type_internal_function__add_ins(self, INS_JLE, NULL);
    uint8_t* loop_start = type_internal_function__end_ip(self);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_LOAD_INTEGRAL, NULL);
    compiler__emit_internal_function_arg(self, &self->compiled_fn->function_base, FUNCTION_INS_LOAD_INTEGRAL, arg1_index, NULL);
    type_internal_function__add_ins(self, INS_MUL);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, NULL);
    compiler__emit_internal_function_arg(self, &self->compiled_fn->function_base, FUNCTION_INS_LOAD_INTEGRAL, arg1_index, NULL);
    type_internal_function__add_ins(self, INS_DEC);
    compiler__emit_internal_function_arg(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, arg1_index, NULL);
    compiler__emit_internal_function_arg(self, &self->compiled_fn->function_base, FUNCTION_INS_LOAD_INTEGRAL, arg1_index, NULL);
    uint8_t* fact_end2 = type_internal_function__end_ip(self);
    type_internal_function__add_ins(self, INS_JZ, fact_end);
    type_internal_function__add_ins(self, INS_JMP, loop_start);

    compiler__patch_jmp(fact_end, type_internal_function__end_ip(self));
    compiler__patch_jmp(fact_end2, type_internal_function__end_ip(self));
}

static void internal__compile_ret_struct_fn(compiler_t* self) {
    type_internal_function__add_ins(self, INS_PUSH, -120);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, "member_1", NULL);

    type_internal_function__add_ins(self, INS_PUSH, -12345);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, "member_2", NULL);

    type_internal_function__add_ins(self, INS_PUSH, 123456789101112);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, "member_3", NULL);

    ASSERT(self->compiled_fn->function_base.return_type->type_specifier == TYPE_STRUCT);
    type_struct_t* type_struct = (type_struct_t*) self->compiled_fn->function_base.return_type;
    member_t* member_array = type_struct__member(type_struct, "member_array");
    ASSERT(member_array);

    type_array_t* arr_type = (type_array_t*) member_array->type;
    ASSERT(member_array->type->type_specifier == TYPE_ARRAY);
    for (uint32_t arr_index = 0; arr_index < arr_type->element_size; ++arr_index) {
        type_internal_function__add_ins(self, INS_PUSH, arr_index * 13);
        compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, "member_array", arr_index, NULL);
    }
}

static void internal__compile_start(compiler_t* self) {
    type_function_t* main_fn = (type_function_t*) types__type_find(&self->types, "main");
    ASSERT(main_fn);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_s64, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    compiler__emit_internal_function_call(self, main_fn);
    type_internal_function__add_ins(self, INS_EXIT);
}

static void internal__compile_main(compiler_t* self) {
    type_function_t* fact_fn_decl_internal = (type_function_t*) types__type_find(&self->types, "fact_internal");
    ASSERT(fact_fn_decl_internal);
    ASSERT(type__is_function((type_t*) fact_fn_decl_internal));

    type_function_t* fact_fn_decl_external = (type_function_t*) types__type_find(&self->types, "fact");
    ASSERT(fact_fn_decl_external);
    ASSERT(type__is_function((type_t*) fact_fn_decl_external));

    type_function_t* print_fn = (type_function_t*) types__type_find(&self->types, "print");
    ASSERT(print_fn);
    ASSERT(type__is_function((type_t*) print_fn));

    type_t* t_a = types__type_find(&self->types, "a");
    ASSERT(t_a);

    type_function_t* ret_struct = (type_function_t*) types__type_find(&self->types, "ret_struct");
    ASSERT(ret_struct);
    ASSERT(type__is_function((type_t*) ret_struct));

    type_t* fact_result = type_internal_function__get_local(self, "fact_result");
    ASSERT(fact_result);
    type_t* t_void_p = types__type_find(&self->types, "void_p");
    ASSERT(t_void_p);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, fact_result, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_u64, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH, 10);
    compiler__emit_internal_function_arg(self, fact_fn_decl_external, FUNCTION_INS_STORE_INTEGRAL, 0, NULL);
    compiler__emit_internal_function_call(self, fact_fn_decl_internal);
    // compiler__emit_internal_function_call(self, fact_fn_decl_external);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_void_p, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_void_p, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH, (uint64_t) fact_result);
    uint32_t print_type_index;
    ASSERT(type_function__get_argument(print_fn, "type", &print_type_index));
    uint32_t print_addr_index;
    ASSERT(type_function__get_argument(print_fn, "addr", &print_addr_index));
    compiler__emit_internal_function_arg(self, print_fn, FUNCTION_INS_STORE_INTEGRAL, print_type_index, NULL);
    compiler__emit_internal_function_ret(self, fact_fn_decl_external, FUNCTION_INS_LOAD_ADDRESS, NULL);
    compiler__emit_internal_function_arg(self, print_fn, FUNCTION_INS_STORE_INTEGRAL, print_addr_index, NULL);
    compiler__emit_internal_function_call(self, print_fn);

    type_internal_function__add_ins(self, INS_PUSH, 7280);
    type_internal_function__add_ins(self, INS_PUSH, 133);
    type_internal_function__add_ins(self, INS_OR);
    type_internal_function__add_ins(self, INS_POP);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_a, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK);
    compiler__emit_internal_function_call(self, ret_struct);

    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_void_p, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH_TYPE, t_void_p, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    type_internal_function__add_ins(self, INS_PUSH, (uint64_t) t_a);
    compiler__emit_internal_function_arg(self, print_fn, FUNCTION_INS_STORE_INTEGRAL, print_type_index, NULL);
    compiler__emit_internal_function_ret(self, ret_struct, FUNCTION_INS_LOAD_ADDRESS, NULL);
    compiler__emit_internal_function_arg(self, print_fn, FUNCTION_INS_STORE_INTEGRAL, print_addr_index, NULL);
    compiler__emit_internal_function_call(self, print_fn);

    // ret_struct's ret value, temporary type pushes must be bookkeeped for every function
    type_internal_function__add_ins(self, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK);
    // fact's ret value, temporary type pushes must be bookkeeped for every function
    type_internal_function__add_ins(self, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK);

    type_internal_function__add_ins(self, INS_PUSH, 42);
    compiler__emit_internal_function_ret(self, &self->compiled_fn->function_base, FUNCTION_INS_STORE_INTEGRAL, NULL);
}

static void internal__compile_store_load(compiler_t* self) {
    (void) self;
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
    // compiler__patch_jmp(exit_one_ip, ip);
    // ip = state__add_ins(self, ip, INS_EXIT, (uint64_t) 1);
}
