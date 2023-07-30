#ifndef LOX_INTERPRETER_H
# define LOX_INTERPRETER_H

# include "lox_interpreter_defs.h"

# include "compiler/interpreter/interpreter.h"

PUBLIC_API void lox_interpreter__interpret_ast(struct interpreter* self, struct parser_ast ast);

PUBLIC_API bool lox_interpreter__initialize(struct interpreter* self, struct memory_slice internal_buffer);
PUBLIC_API bool lox_interpreter__clear(struct interpreter* self);

// ENVIRONMENT METHODS AND TABLE START

struct lox_env {
    struct lox_expr_var* var_arr;
    // todo: remove, we can infer this from the current env_id
    struct lox_env* parent;
    struct lox_env* next;

    u32 var_arr_fill;

    // todo: remove, we can infer this from table
    u32 var_arr_size;
};

struct lox_interpreter_env_table {
    u32 env_memory_size; // size of one env

    struct lox_env* env_pool_free_list;
    struct lox_env* env_pool_arr;
    u32 env_pool_arr_fill;
    u32 env_pool_arr_size;

    u64 table_memory_size;
};

struct lox_interpreter_env_table* lox_interpreter__get_env_table(struct interpreter* self);

struct lox_env* lox_interpreter__env_pool_get(struct interpreter* self);
void lox_interpreter__env_pool_put(struct interpreter* self, struct lox_env* env);
struct lox_env* lox_interpreter__global_env(struct interpreter* self);

struct lox_expr_var* lox_interpreter__get_var(struct interpreter* self, struct token* var_name);
struct lox_expr_var* lox_interpreter__define_var(
    struct interpreter* self,
    struct token* var_name, struct expr* var_value
);

// ENVIRONMENT METHODS AND TABLE END

#endif // LOX_INTERPRETER_H
