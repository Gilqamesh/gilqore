#ifndef COMPILER_H
# define COMPILER_H

# include <stdint.h>
# include <stdarg.h>
# include <stdbool.h>

# include "types.h"
# include "scanner.h"
# include "hash_map.h"

typedef struct compiler_flags {
    uint32_t compiler_flag_limit_errors_n;
} compiler_flags_t;

typedef bool (*compiler_flag_fn_t)(const char* arg, compiler_flags_t*);
typedef struct compiler_flag {
    compiler_flag_fn_t  fn;
    const char*         help_message;
} compiler_flag_t;

compiler_flag_t* compiler__flag_find(const char* flag);
extern hash_map_t* compiler_flag_fns;

typedef struct compiler {
    scanner_t                 scanner;
    types_t                   types;

    // might not need these as the compiled_fn gets them upon creation
    uint8_t*                  ip_start;
    uint8_t*                  ip_cur;
    uint8_t*                  ip_end;

    token_t                   token_cur;
    token_t                   token_prev;

    hash_map_t*               scope_cur;
    hash_map_t*               scope_start;
    hash_map_t*               scope_end;

    type_internal_function_t* compiled_fn;

    bool                      panic_mode;
    bool                      had_error;

    compiler_flags_t*         flags;

    struct compiler*          parent;
} compiler_t;

bool compiler__module_init();

bool compiler__create(compiler_t* self, compiler_flags_t* compiler_flags, const char* source, uint64_t source_len);
void compiler__destroy(compiler_t* self);

bool compiler__compile(compiler_t* self, const char* fn_name, uint8_t* ip_start, uint8_t* ip_end);

void compiler__define_builtins(compiler_t* self);

void compiler__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr);

/* EMITTERS START */

typedef enum function_ins {
    FUNCTION_INS_LOAD_ADDRESS,
    FUNCTION_INS_STORE_INTEGRAL,
    FUNCTION_INS_STORE_FLOAT,
    FUNCTION_INS_LOAD_INTEGRAL,
    FUNCTION_INS_LOAD_FLOAT
} function_ins_t;
ins_t function_ins__to_ins(function_ins_t function_ins);

// @param internal_function the function to compile from
// @param target_function the function's argument to access, CAREFUL: context dependent, can't call this anywhere, as all functions share the same argument buffer
// @param arg_index index of argument
// @param ... MUST be null-terminated, subsequent members of the supplied argument, if 'lea' is false, this must end in an atom
void compiler__emit_internal_function_arg(compiler_t* self, type_function_t* target_function, function_ins_t function_ins, uint32_t arg_index, ...);

// @param internal_function the function to compile from
// @param target_function the function's return value to access, CAREFUL: context dependent, can't call this anywhere, as all functions share the same return buffer
// @param ... subsequent members of the supplied argument, if 'lea' is false, this must end in an atom
void compiler__emit_internal_function_ret(compiler_t* self, type_function_t* target_function, function_ins_t function_ins, ...);

// @param ... subsequent members of the supplied argument, if 'lea' is false, this must end in an atom
void compiler__emit_internal_function_local(compiler_t* self, function_ins_t function_ins, const char* local_name, ...);

void compiler__emit_internal_function_call(compiler_t* self, type_function_t* target_function);

void compiler__emit_decl_fn(compiler_t* self);
void compiler__emit_stmt(compiler_t* self, token_type_t token_type);
void compiler__emit_type_decl_stmt(compiler_t* self, token_type_t token_type);
void compiler__emit_expr_stmt(compiler_t* self);

/* EMITTERS END */

#endif // COMPILER_H
