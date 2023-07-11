#include "lox_parse_state.h"

#include "compiler/tokenizer/tokenizer.h"
#include "compiler/parser/parser.h"
#include "compiler/parser/lox_parser/lox_parser.h"

#include "libc/libc.h"

bool lox_parser__is_finished(struct parser* self) {
    return lox_parser__is_finished_parsing(self);
}

struct lox_expressions_table* lox_parser__get_expressions_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (memory_size < sizeof(struct lox_expressions_table)) {
        error_code__exit(12321);
    }

    struct lox_expressions_table* table = (struct lox_expressions_table*) memory;
    table->table_memory_size = table_size;

    return table;
}

struct lox_literal_table* lox_parser__get_literal_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (memory_size < sizeof(struct lox_literal_table)) {
        error_code__exit(12321);
    }

    struct lox_literal_table* table = (struct lox_literal_table*) (memory + table_size);
    table->table_memory_size = table_size;

    return table;
}

struct lox_statements_table* lox_parser__get_statements_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (memory_size < sizeof(struct lox_statements_table)) {
        error_code__exit(12321);
    }

    struct lox_statements_table* table = (struct lox_statements_table*) (memory + 2 * table_size);
    table->table_memory_size = table_size;

    return table;
}

static void lox_parser__clear_environment(struct parser* self, struct lox_var_environment* env) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    libc__memset(env, 0, table->var_environment_memory_size);
    env->var_expressions_arr = (void*) ((char*) env + sizeof(*env));
    env->var_expressions_arr_size = (table->var_environment_memory_size - sizeof(*env)) / sizeof(*env->var_expressions_arr);
}

static struct lox_var_environment* lox_parser__get_environment_internal(struct parser* self, u32 env_id) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    ASSERT(env_id < table->var_env_arr_size);
    struct lox_var_environment* result = (struct lox_var_environment*) ((char*) table->var_env_arr + env_id * table->var_environment_memory_size);
    ASSERT(result->var_expressions_arr != NULL);
    ASSERT(result->var_expressions_arr_size > 0);
    return result;
}

struct lox_var_environment* lox_parser__get_environment(struct parser* self) {
    ASSERT(self->env_id > 0);
    return lox_parser__get_environment_internal(self, self->env_id - 1);
}

struct lox_var_environment* lox_parser__push_environment(struct parser* self) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    ASSERT(self->env_id < table->var_env_arr_size);
    struct lox_var_environment* result = (struct lox_var_environment*) ((char*) table->var_env_arr + self->env_id * table->var_environment_memory_size);
    lox_parser__clear_environment(self, result);
    ++self->env_id;
    return result;
}

struct lox_var_environment* lox_var_environment__get_from_pool(struct parser* self) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    struct lox_var_environment* result = NULL;
    if (table->var_env_pool_free_list != NULL) {
        result = table->var_env_pool_free_list;
        lox_parser__clear_environment(self, result);
        table->var_env_pool_free_list = table->var_env_pool_free_list->next;
    } else {
        result = (struct lox_var_environment*) ((char*) table->var_env_pool_arr + table->var_env_pool_arr_fill * table->var_environment_memory_size);
        lox_parser__clear_environment(self, result);
        if (table->var_env_pool_arr_fill == table->var_env_pool_arr_size) {
            error_code__exit(324234);
        }
    }

    return result;
}

void lox_var_environment__put_to_pool(struct parser* self, struct lox_var_environment* env) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    struct lox_var_environment* cur = env->next;
    while (cur != NULL) {
        struct lox_var_environment* next = cur->next;
        cur->next = table->var_env_pool_free_list;
        table->var_env_pool_free_list = cur;
        cur = next;
    }
}

bool lox_parser_clear_tables(struct parser* self) {
    // todo: need data from the tokenizer on how much tokens it has for each token type
    // todo: determine the kinds of expressions we have

    // expressions table
    {
        struct lox_expressions_table* expression_table = lox_parser__get_expressions_table(self);
        u64 expression_table_size = expression_table->table_memory_size;
        u64 memory_offset = sizeof(*expression_table);
        ASSERT(expression_table_size >= memory_offset);
        expression_table_size -= memory_offset;
        u64 expression_subtable_memory_size = expression_table_size / 7;

        expression_table->op_unary_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->op_unary_arr_fill = 0;
        expression_table->op_unary_arr_size = expression_subtable_memory_size / sizeof(*expression_table->op_unary_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->op_binary_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->op_binary_arr_fill = 0;
        expression_table->op_binary_arr_size = expression_subtable_memory_size / sizeof(*expression_table->op_binary_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->grouping_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->grouping_arr_fill = 0;
        expression_table->grouping_arr_size = expression_subtable_memory_size / sizeof(*expression_table->grouping_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->literal_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->literal_arr_fill = 0;
        expression_table->literal_arr_size = expression_subtable_memory_size / sizeof(*expression_table->literal_arr);
        memory_offset += expression_subtable_memory_size;

        u32 number_of_environments = 64;
        expression_table->var_env_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->var_environment_memory_size = expression_subtable_memory_size / number_of_environments;
        expression_table->var_env_arr_size = number_of_environments;
        lox_parser__push_environment(self);
        memory_offset += expression_subtable_memory_size;

        u32 number_of_env_pools = 128;
        expression_table->var_env_pool_free_list = NULL;
        expression_table->var_env_pool_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->var_env_pool_arr_size = number_of_env_pools;
        libc__memset(expression_table->var_env_pool_arr, 0, expression_subtable_memory_size);
        memory_offset += expression_subtable_memory_size;
    }

    // literals table
    {
        struct lox_literal_table* literals_table = lox_parser__get_literal_table(self);
        u64 literals_table_size = literals_table->table_memory_size;
        u64 memory_offset = sizeof(*literals_table);
        ASSERT(literals_table_size >= memory_offset);
        literals_table_size -= memory_offset;
        u64 literals_subtable_memory_size = literals_table_size / 5;

        literals_table->object_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->object_arr_fill = 0;
        literals_table->object_arr_size = literals_subtable_memory_size;
        memory_offset += literals_subtable_memory_size;

        literals_table->nil_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->nil_arr_fill = 0;
        literals_table->nil_arr_size = literals_subtable_memory_size / sizeof(*literals_table->nil_arr);
        memory_offset += literals_subtable_memory_size;

        literals_table->boolean_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->boolean_arr_fill = 0;
        literals_table->boolean_arr_size = literals_subtable_memory_size / sizeof(*literals_table->boolean_arr);
        memory_offset += literals_subtable_memory_size;

        literals_table->number_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->number_arr_fill = 0;
        literals_table->number_arr_size = literals_subtable_memory_size / sizeof(*literals_table->number_arr);
        memory_offset += literals_subtable_memory_size;

        literals_table->string_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->string_arr_fill = 0;
        literals_table->string_arr_size = literals_subtable_memory_size;
        memory_offset += literals_subtable_memory_size;
    }

    // statements table
    {
        struct lox_statements_table* statements_table = lox_parser__get_statements_table(self);
        u64 statements_table_size = statements_table->table_memory_size;
        u64 memory_offset = sizeof(*statements_table);
        ASSERT(statements_table_size >= memory_offset);
        statements_table_size -= memory_offset;
        u64 statements_subtable_memory_size = statements_table_size / 5;

        statements_table->print_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->print_statements_arr_fill = 0;
        statements_table->print_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->print_statements_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->expression_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->expression_statements_arr_fill = 0;
        statements_table->expression_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->expression_statements_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->var_decl_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->var_decl_statements_arr_fill = 0;
        statements_table->var_decl_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->var_decl_statements_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->lox_parser_statement_node_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->lox_parser_statement_node_arr_fill = 0;
        statements_table->lox_parser_statement_node_arr_size = statements_subtable_memory_size / sizeof(*statements_table->lox_parser_statement_node_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->block_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->block_statements_arr_fill = 0;
        statements_table->block_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->block_statements_arr);
        memory_offset += statements_subtable_memory_size;
    }

    return true;
}

enum lox_token_type lox_parser__peek(struct parser* self) {
    return self->tokenizer->tokens[self->token_index].type;
}

struct tokenizer_token* lox_parser__advance(struct parser* self) {
    if (lox_parser__is_finished(self) == true) {
        return NULL;
    }

    return &self->tokenizer->tokens[self->token_index++];
}

struct tokenizer_token* lox_parser__advance_if(struct parser* self, enum lox_token_type token_type) {
    return lox_parser__peek(self) == token_type ? lox_parser__advance(self) : NULL;
}

struct tokenizer_token* lox_parser__advance_err(
    struct parser* self,
    enum lox_token_type token_type,
    const char* format, ...
) {
    struct tokenizer_token* token = lox_parser__advance(self);
    if (token == NULL || token->type != token_type) {
        va_list ap;

        va_start(ap, format);
        parser__syntax_verror(self, format, ap);
        va_end(ap);

        return NULL;
    }

    return token;
}

struct tokenizer_token* lox_parser__get_previous(struct parser* self) {
    if (self->token_index == 0) {
        return NULL;
    }

    return &self->tokenizer->tokens[self->token_index - 1];
}

void lox_parser__advance_till_next_statement(struct parser* self) {
    while (lox_parser__is_finished_parsing(self) == false ) {
        switch (lox_parser__peek(self)) {
            case LOX_TOKEN_CLASS:
            case LOX_TOKEN_FUN:
            case LOX_TOKEN_VAR:
            case LOX_TOKEN_FOR:
            case LOX_TOKEN_IF:
            case LOX_TOKEN_WHILE:
            case LOX_TOKEN_PRINT:
            case LOX_TOKEN_RETURN: {
                return ;
            } break ;
            default:
        }

        (void) lox_parser__advance(self);
    }
}
