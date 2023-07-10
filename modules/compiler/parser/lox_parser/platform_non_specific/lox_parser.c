#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/parser/parser.h"
#include "compiler/tokenizer/tokenizer.h"
#include "libc/libc.h"
#include "types/basic_types/basic_types.h"
#include "algorithms/hash/hash.h"

#include "lox_parse_state.h"

static struct memory_slice lox_parser_expr_evalute__op_unary(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__op_binary(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__grouping(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__literal(struct parser_expression* expr, struct memory_slice buffer);

bool lox_parser__clear(struct parser* self) {
    self->had_syntax_error = false;
    self->had_runtime_error = false;
    self->token_index = 0;
    if (lox_parser_clear_tables(self) == false) {
        return false;
    }

    return true;
}

const char* lox_parser__expression_type_to_str(enum lox_parser_expression_type expr_type) {
    switch (expr_type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return "unary";
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return "binary";
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return "grouping";
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return "literal";
        case LOX_PARSER_EXPRESSION_TYPE_VAR: return "variable";
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

const char* lox_parser__statement_type_to_str(enum lox_parser_statement_type type) {
    switch (type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: return "print";
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: return "expression";
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: return "variable declaration";
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

#include "lox_parse_state.inl"

struct parser_statement* lox_parser__parse_statement(struct parser* self) {
    struct parser_statement* statement = lox_parser__declaration(self);
    if (statement == NULL) {
        lox_parser__advance_till_next_statement(self);
    }

    return statement;
}

void lox_parser__delete_from_expressions_table(
    struct parser* self,
    struct lox_var_environment* env,
    struct parser_expression* expression
) {
        switch (expression->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
            struct lox_parser_expr_op_unary* unary_expression = (struct lox_parser_expr_op_unary*) expression;
            lox_parser__delete_from_expressions_table(self, env, unary_expression->expr);
            // todo: delete unary_expression->evaluated_literal;
            lox_parser__delete_expr__op_unary(self, unary_expression);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
            struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expression;
            lox_parser__delete_from_expressions_table(self, env, binary_expr->left);
            lox_parser__delete_from_expressions_table(self, env, binary_expr->right);
            // todo: delete binary_expr->evaluated_literal
            lox_parser__delete_expr__op_binary(self, binary_expr);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
            struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expression;
            lox_parser__delete_from_expressions_table(self, env, grouping_expr->expr);
            // todo: delete grouping_expr->evaluated_literal
            lox_parser__delete_expr__grouping(self, grouping_expr);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
            struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expression;
            // todo: delete literal_expr->literal
            lox_parser__delete_expr__literal(self, literal_expr);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_VAR: {
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) expression;
            if (var_expr->value != NULL) {
                lox_parser__delete_from_expressions_table(self, env, var_expr->value);
            }
            // todo: delete var_expr->evaluated_literal;
            lox_parser__delete_expr__var(env, var_expr);
        } break ;
        default: ASSERT(false);
    }
}

void lox_parser__print_expressions_table_stats(struct parser* self) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    libc__printf(
        "  --=== Expressions table ===--\n"
        "  unary expressions allocated: %u, total: %u\n"
        "  binary expressions allocated: %u, total: %u\n"
        "  grouping expressions allocated: %u, total: %u\n"
        "  literal expressions allocated: %u, total: %u\n"
        "  global environment variable expressions allocated: %u, total: %u\n"
        "  -----------------------------\n",
        table->op_unary_arr_fill, table->op_unary_arr_size,
        table->op_binary_arr_fill, table->op_binary_arr_size,
        table->grouping_arr_fill, table->grouping_arr_size,
        table->literal_arr_fill, table->literal_arr_size,
        table->var_environment_stack->var_expressions_arr_fill, table->var_environment_stack->var_expressions_arr_size
    );
}

struct lox_parser_expr_op_unary* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct tokenizer_token* op,
    struct parser_expression* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->op_unary_arr_fill == table->op_unary_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) op % table->op_unary_arr_size;
    for (u32 unary_index = hash_value; unary_index < table->op_unary_arr_size; ++unary_index) {
        struct lox_parser_expr_op_unary* result = &table->op_unary_arr[unary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
            result->expr = expr;
            result->op = op;
            result->evaluated_literal = NULL;

            ++table->op_unary_arr_fill;

            return result;
        }
    }

    for (u32 unary_index = 0; unary_index < hash_value; ++unary_index) {
        struct lox_parser_expr_op_unary* result = &table->op_unary_arr[unary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
            result->expr = expr;
            result->op = op;
            result->evaluated_literal = NULL;

            ++table->op_unary_arr_fill;

            return result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__op_unary(struct parser* self, struct lox_parser_expr_op_unary* op_unary_expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    u32 hash_value = (u64) op_unary_expr->op % table->op_unary_arr_size;
    for (u32 unary_index = hash_value; unary_index < table->op_unary_arr_size; ++unary_index) {
        struct lox_parser_expr_op_unary* unary_expr_to_delete = &table->op_unary_arr[unary_index];
        if (unary_expr_to_delete->op == op_unary_expr->op) {
            op_unary_expr->op = NULL;

            --table->op_unary_arr_fill;

            return ;
        }
    }

    for (u32 unary_index = 0; unary_index < hash_value; ++unary_index) {
        struct lox_parser_expr_op_unary* unary_expr_to_delete = &table->op_unary_arr[unary_index];
        if (unary_expr_to_delete->op == op_unary_expr->op) {
            op_unary_expr->op = NULL;

            --table->op_unary_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct lox_parser_expr_op_binary* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct parser_expression* left,
    struct tokenizer_token* op,
    struct parser_expression* right
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->op_binary_arr_fill == table->op_binary_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) op % table->op_binary_arr_size;
    for (u32 binary_index = hash_value; binary_index < table->op_binary_arr_size; ++binary_index) {
        struct lox_parser_expr_op_binary* result = &table->op_binary_arr[binary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
            result->left = left;
            result->op = op;
            result->right = right;
            result->evaluated_literal = NULL;

            ++table->op_binary_arr_fill;

            return result;
        }
    }

    for (u32 binary_index = 0; binary_index < hash_value; ++binary_index) {
        struct lox_parser_expr_op_binary* result = &table->op_binary_arr[binary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
            result->left = left;
            result->op = op;
            result->right = right;
            result->evaluated_literal = NULL;

            ++table->op_binary_arr_fill;

            return result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__op_binary(struct parser* self, struct lox_parser_expr_op_binary* op_binary_expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    u32 hash_value = (u64) op_binary_expr->op % table->op_binary_arr_size;
    for (u32 binary_index = hash_value; binary_index < table->op_binary_arr_size; ++binary_index) {
        struct lox_parser_expr_op_binary* binary_expr_to_delete = &table->op_binary_arr[binary_index];
        if (binary_expr_to_delete->op == op_binary_expr->op) {
            op_binary_expr->op = NULL;

            --table->op_binary_arr_fill;

            return ;
        }
    }

    for (u32 binary_index = 0; binary_index < hash_value; ++binary_index) {
        struct lox_parser_expr_op_binary* binary_expr_to_delete = &table->op_binary_arr[binary_index];
        if (binary_expr_to_delete->op == op_binary_expr->op) {
            op_binary_expr->op = NULL;

            --table->op_binary_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct lox_parser_expr_grouping* lox_parser__get_expr__grouping(
    struct parser* self,
    struct parser_expression* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->grouping_arr_fill == table->grouping_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) expr % table->grouping_arr_size;
    for (u32 grouping_index = hash_value; grouping_index < table->grouping_arr_size; ++grouping_index) {
        struct lox_parser_expr_grouping* result = &table->grouping_arr[grouping_index];
        if (result->expr == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
            result->expr = expr;
            result->evaluated_literal = NULL;

            ++table->grouping_arr_fill;

            return result;
        }
    }

    for (u32 grouping_index = 0; grouping_index < hash_value; ++grouping_index) {
        struct lox_parser_expr_grouping* result = &table->grouping_arr[grouping_index];
        if (result->expr == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
            result->expr = expr;
            result->evaluated_literal = NULL;

            ++table->grouping_arr_fill;

            return result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__grouping(struct parser* self, struct lox_parser_expr_grouping* grouping_expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    u32 hash_value = (u64) grouping_expr->expr % table->grouping_arr_size;
    for (u32 grouping_index = hash_value; grouping_index < table->grouping_arr_size; ++grouping_index) {
        struct lox_parser_expr_grouping* grouping_expr_to_delete = &table->grouping_arr[grouping_index];
        if (grouping_expr_to_delete->expr == grouping_expr->expr) {
            grouping_expr_to_delete->expr = NULL;
            --table->grouping_arr_fill;

            return ;
        }
    }

    for (u32 grouping_index = 0; grouping_index < hash_value; ++grouping_index) {
        struct lox_parser_expr_grouping* grouping_expr_to_delete = &table->grouping_arr[grouping_index];
        if (grouping_expr_to_delete->expr == grouping_expr->expr) {
            grouping_expr_to_delete->expr = NULL;
            --table->grouping_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct lox_parser_expr_literal* lox_parser__get_expr__literal(
    struct parser* self,
    struct tokenizer_token* value
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->literal_arr_fill == table->literal_arr_size) {
        error_code__exit(21437);
    }
    
    u32 hash_value = (u64) value % table->literal_arr_size;
    for (u32 literal_index = hash_value; literal_index < table->literal_arr_size; ++literal_index) {
        struct lox_parser_expr_literal* literal_expr = &table->literal_arr[literal_index];
        if (literal_expr->value == NULL) {
            literal_expr->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
            literal_expr->value = value;
            literal_expr->literal = NULL;

            ++table->literal_arr_fill;

            return literal_expr;
        }
    }

    for (u32 literal_index = 0; literal_index < hash_value; ++literal_index) {
        struct lox_parser_expr_literal* literal_expr = &table->literal_arr[literal_index];
        if (literal_expr->value == NULL) {
            literal_expr->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
            literal_expr->value = value;
            literal_expr->literal = NULL;

            ++table->literal_arr_fill;

            return literal_expr;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__literal(struct parser* self, struct lox_parser_expr_literal* literal_expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    u32 hash_value = (u64) literal_expr->value % table->literal_arr_size;
    for (u32 literal_index = hash_value; literal_index < table->literal_arr_size; ++literal_index) {
        struct lox_parser_expr_literal* literal_expr_to_delete = &table->literal_arr[literal_index];
        if (literal_expr_to_delete->value == literal_expr->value) {
            literal_expr_to_delete->value = NULL;
            --table->literal_arr_fill;

            return ;
        }
    }

    for (u32 literal_index = 0; literal_index < hash_value; ++literal_index) {
        struct lox_parser_expr_literal* literal_expr_to_delete = &table->literal_arr[literal_index];
        if (literal_expr_to_delete->value == literal_expr->value) {
            literal_expr_to_delete->value = NULL;
            --table->literal_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct lox_literal_object* lox_parser__get_literal__object(
    struct parser* self,
    struct memory_slice value
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    if (table->object_arr_fill == table->object_arr_size) {
        error_code__exit(234782);
    }

    struct lox_literal_object* result = &table->object_arr[table->object_arr_fill++];
    result->base.type = LOX_LITERAL_TYPE_OBJECT;
    result->data = value;

    return result;
}

struct lox_literal_nil* lox_parser__get_literal__nil(
    struct parser* self
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    if (table->nil_arr_fill == table->nil_arr_size) {
        error_code__exit(234782);
    }

    struct lox_literal_nil* result = &table->nil_arr[table->nil_arr_fill++];
    result->base.type = LOX_LITERAL_TYPE_NIL;

    return result;
}

struct lox_literal_boolean* lox_parser__get_literal__boolean(
    struct parser* self,
    bool value
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    if (table->boolean_arr_fill == table->boolean_arr_size) {
        error_code__exit(234782);
    }

    struct lox_literal_boolean* result = &table->boolean_arr[table->boolean_arr_fill++];
    result->base.type = LOX_LITERAL_TYPE_BOOLEAN;
    result->data = value;

    return result;
}

struct lox_literal_number* lox_parser__get_literal__number(
    struct parser* self,
    r64 value
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    if (table->number_arr_fill == table->number_arr_size) {
        error_code__exit(234782);
    }

    struct lox_literal_number* result = &table->number_arr[table->number_arr_fill++];
    result->base.type = LOX_LITERAL_TYPE_NUMBER;
    result->data = value;

    return result;
}

struct lox_literal_string* lox_parser__get_literal__string(
    struct parser* self,
    char* format, ...
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    ASSERT(table->string_arr_size >= table->string_arr_fill);
    u32 string_arr_bytes_left = table->string_arr_size - table->string_arr_fill;
    if (string_arr_bytes_left == 0) {
        error_code__exit(234782);
    }

    struct lox_literal_string* result = (struct lox_literal_string*) ((char*) table->string_arr + table->string_arr_fill);
    result->base.type = LOX_LITERAL_TYPE_STRING;
    result->data = (char*) result + sizeof(*result);

    va_list ap;

    va_start(ap, format);
    u32 bytes_written = libc__vsnprintf(
        result->data,
        string_arr_bytes_left,
        format, ap
    );
    if (bytes_written >= string_arr_bytes_left) {
        self->had_runtime_error = true;
        // ran out of string memory
        return NULL;
    }

    table->string_arr_fill += sizeof(*result) + bytes_written + 1;

    va_end(ap);

    return result;
}

struct memory_slice lox_parser__convert_expr_to_string(struct parser_expression* expr, struct memory_slice buffer) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_parser_expr_evalute__op_unary(expr, buffer);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_parser_expr_evalute__op_binary(expr, buffer);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_parser_expr_evalute__grouping(expr, buffer);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_parser_expr_evalute__literal(expr, buffer);
        default: {
            ASSERT(false);
            return buffer;
        }
    }
}

struct memory_slice lox_parser__vwrite_to_memory(
    struct memory_slice remaining,
    char* format, va_list ap
) {
    u64 result_size = memory_slice__size(&remaining);
    char* result = (char*) memory_slice__memory(&remaining);

    u32 bytes_written = libc__vsnprintf(
        result,
        result_size,
        format, ap
    );
    if (bytes_written > result_size) {
        bytes_written = result_size;
    }

    return memory_slice__create(result + bytes_written, result_size - bytes_written);
}

struct memory_slice lox_parser__write_to_memory(
    struct memory_slice remaining,
    char* format, ...
) {
    va_list ap;

    va_start(ap, format);
    remaining = lox_parser__vwrite_to_memory(remaining, format, ap);
    va_end(ap);

    return remaining;
}

static struct memory_slice lox_parser__write_to_memory_expressions(
    struct tokenizer_token* token,
    struct memory_slice buffer,
    u32 expressions_count, ...
) {
    if (expressions_count) {
        va_list ap;

        va_start(ap, expressions_count);
        while (expressions_count > 0) {
            struct parser_expression* expr = (struct parser_expression*) va_arg(ap, void*);
            parser__convert_expr_to_string lox_parser_expr_evalute_fn = NULL;
            switch (expr->type) {
                case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
                    lox_parser_expr_evalute_fn = lox_parser_expr_evalute__op_unary;
                } break ;
                case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
                    lox_parser_expr_evalute_fn = lox_parser_expr_evalute__op_binary;
                } break ;
                case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
                    lox_parser_expr_evalute_fn = lox_parser_expr_evalute__grouping;
                } break ;
                case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
                    lox_parser_expr_evalute_fn = lox_parser_expr_evalute__literal;
                } break ;
                default: ASSERT(false);
            }
            buffer = lox_parser_expr_evalute_fn(expr, buffer);
            --expressions_count;
        }
        va_end(ap);
    }

    if (token) {
        buffer = lox_parser__write_to_memory(buffer, "%.*s ", token->lexeme_len, token->lexeme);
    }

    return buffer;
}

struct memory_slice lox_parser_expr_evalute__op_unary(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    return
    lox_parser__write_to_memory_expressions(
        unary_expr->op,
        buffer,
        1,
        unary_expr->expr
    );
}

struct memory_slice lox_parser_expr_evalute__op_binary(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    return
    lox_parser__write_to_memory_expressions(
        binary_expr->op,
        buffer,
        2,
        binary_expr->left,
        binary_expr->right
    );
}

struct memory_slice lox_parser_expr_evalute__grouping(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;

    buffer = lox_parser__write_to_memory(buffer, "( ");

    buffer = lox_parser__write_to_memory_expressions(NULL, buffer, 1, grouping_expr->expr);

    buffer = lox_parser__write_to_memory(buffer, ") ");

    return buffer;
}

struct memory_slice lox_parser_expr_evalute__literal(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;

    // if (literal_expr->value->type == LOX_TOKEN_STRING) {
    //     buffer = lox_parser__write_to_memory(buffer, "\"");
    // }

    buffer = lox_parser__write_to_memory_expressions(literal_expr->value, buffer, 0);

    // if (literal_expr->value->type == LOX_TOKEN_STRING) {
    //     buffer = lox_parser__write_to_memory(buffer, "\"");
    // }

    return buffer;
}

static bool lox_parser__literal_is_truthy(struct parser_literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            return true;
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            return false;
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* boolean_literal = (struct lox_literal_boolean*) literal;
            return boolean_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal;
            return number_literal->data != 0.0;
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            return true;
        } break ;
        default: {
            ASSERT(false);
            return false;
        }
    }
}

static bool lox_parser__literal_is_equal(struct parser_literal* left, struct parser_literal* right) {
    if (left->type != right->type) {
        return false;
    }

    switch (left->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            // todo: when are two objects equal to each other?
            return false;
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            return right->type == LOX_LITERAL_TYPE_NIL;
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* left_boolean_literal = (struct lox_literal_boolean*) left;
            struct lox_literal_boolean* right_boolean_literal = (struct lox_literal_boolean*) right;
            return left_boolean_literal->data == right_boolean_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* left_number_literal = (struct lox_literal_number*) left;
            struct lox_literal_number* right_number_literal = (struct lox_literal_number*) right;
            return left_number_literal->data == right_number_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            struct lox_literal_string* left_string_literal = (struct lox_literal_string*) left;
            struct lox_literal_string* right_string_literal = (struct lox_literal_string*) right;
            return libc__strcmp(left_string_literal->data, right_string_literal->data) == 0;
        } break ;
        default: {
            ASSERT(false);
            return false;
        }
    }
}

static struct parser_literal* lox_parser__evaluate_unary(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    if (unary_expr->evaluated_literal != NULL) {
        return unary_expr->evaluated_literal;
    }

    struct parser_literal* literal_base = lox_parser__evaluate_expression(self, unary_expr->expr);

    switch (unary_expr->op->type) {
        case LOX_TOKEN_MINUS: {
            if (literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                parser__runtime_error(
                    self,
                    "Expect operand to be '%s' for operator: '%s', but it was of type '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(unary_expr->op->type),
                    lox_parser__literal_type_to_str(literal_base->type)
                );
                return NULL;
            }
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal_base;
            unary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(self, -number_literal->data);
            return unary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EXCLAM: {
            unary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(self, !lox_parser__literal_is_truthy(literal_base));
            return unary_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static void lox_parser__literal_base_print(struct parser_literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            libc__printf("(object)\n");
            ASSERT(false && "todo: implement");
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            libc__printf("nil\n");
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* boolean_literal = (struct lox_literal_boolean*) literal;
            libc__printf("%s\n", boolean_literal->data ? "true" : "false");
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal;
            libc__printf("%lf\n", number_literal->data);
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            struct lox_literal_string* string_literal = (struct lox_literal_string*) literal;
            libc__printf("%s\n", string_literal->data);
        } break ;
        default: ASSERT(false);
    }
}

void lox_parser__interpret_expr(struct parser* self, struct parser_expression* expr) {
    struct parser_literal* literal = lox_parser__evaluate_expression(self, expr);
    if (literal == NULL) {
        return ;
    }

    lox_parser__literal_base_print(literal);
}

void lox_parser__evaluate_statement(struct parser* self, struct parser_statement* statement) {
    switch (statement->type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: {
            struct lox_parser_statement_print* print_statement = (struct lox_parser_statement_print*) statement;
            struct parser_literal* literal_base = lox_parser__evaluate_expression(self, print_statement->expr);
            if (literal_base != NULL) {
                lox_parser__literal_base_print(literal_base);
            }
            // lox_parser__evaluate_expr(self, print_statement->expr);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: {
            struct lox_parser_statement_expression* expression_statement = (struct lox_parser_statement_expression*) statement;
            struct parser_literal* expr_literal_base = lox_parser__evaluate_expression(self, expression_statement->expr);
            (void) expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: {
            struct lox_parser_statement_var_decl* variable_statement = (struct lox_parser_statement_var_decl*) statement;
            struct parser_literal* var_expr_literal_base = lox_parser__evaluate_expression(self, variable_statement->var_expr);
            (void) var_expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BLOCK: {
            struct lox_parser_statement_block* block_statement = (struct lox_parser_statement_block*) statement;
            struct lox_var_environment* new_env = lox_var_environment__push(self);
            (void) new_env;

            struct lox_parser_statement_node* cur_node = block_statement->statement_list;
            while (cur_node != NULL) {
                lox_parser__evaluate_statement(self, cur_node->statement);
                cur_node = cur_node->next;
            }
            lox_var_environment__pop(self);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_NODE: {
            struct lox_parser_statement_node* node_statement = (struct lox_parser_statement_node*) statement;
            (void) node_statement;
            ASSERT(false);
        }
        default: ASSERT(false);
    }
}

bool lox_parser__is_finished_parsing(struct parser* self) {
    return self->tokenizer->tokens[self->token_index].type == LOX_TOKEN_EOF;
}

void lox_parser__print_statements_table_stats(struct parser* self) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    libc__printf(
        "  --=== Statements table ===--\n"
        "  print statements allocated: %u, total: %u\n"
        "  expression statements allocated: %u, total: %u\n"
        "  variable statements allocated: %u, total: %u\n"
        "  node statements allocated: %u, total: %u\n"
        "  block statements allocated: %u, total: %u\n"
        "  ----------------------------\n",
        table->print_statements_arr_fill, table->print_statements_arr_size,
        table->expression_statements_arr_fill, table->expression_statements_arr_size,
        table->var_decl_statements_arr_fill, table->var_decl_statements_arr_size,
        table->lox_parser_statement_node_arr_fill, table->lox_parser_statement_node_arr_size,
        table->block_statements_arr_fill, table->block_statements_arr_size
    );
}

struct lox_parser_statement_print* lox_parser__get_statement_print(
    struct parser* self,
    struct parser_expression* expr
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->print_statements_arr_fill == table->print_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_statement_print* result = &table->print_statements_arr[table->print_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_PRINT;
    result->expr = expr;

    return result;
}

struct lox_parser_statement_expression* lox_parser__get_statement_expression(
    struct parser* self,
    struct parser_expression* expr
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->expression_statements_arr_fill == table->expression_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_statement_expression* result = &table->expression_statements_arr[table->expression_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_EXPRESSION;
    result->expr = expr;

    return result;
}

struct lox_parser_statement_var_decl* lox_parser__get_statement_var_decl(
    struct parser* self,
    struct parser_expression* var_expr
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->var_decl_statements_arr_fill == table->var_decl_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_statement_var_decl* result = &table->var_decl_statements_arr[table->var_decl_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_VAR_DECL;
    result->var_expr = var_expr;

    return result;
}

struct lox_parser_statement_node* lox_parser__get_statement_node(
    struct parser* self,
    struct parser_statement* statement
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->lox_parser_statement_node_arr_fill == table->lox_parser_statement_node_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_statement_node* result = &table->lox_parser_statement_node_arr[table->lox_parser_statement_node_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_NODE;
    result->statement = statement;
    result->next = NULL;

    return result;
}

struct lox_parser_statement_block* lox_parser__get_statement_block(
    struct parser* self,
    struct lox_parser_statement_node* statement_node
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->block_statements_arr_fill == table->block_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_statement_block* result = &table->block_statements_arr[table->block_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_BLOCK;
    result->statement_list = statement_node;

    return result;
}

struct lox_parser_expr_var* lox_parser__get_expr__var(
    struct lox_var_environment* env,
    struct tokenizer_token* var_name
) {
    u32 var_hash = hash__sum_n(var_name->lexeme, var_name->lexeme_len) % env->var_expressions_arr_size;
    for (u32 var_index = var_hash; var_index < env->var_expressions_arr_size; ++var_index) {
        struct lox_parser_expr_var* cur_var = &env->var_expressions_arr[var_index];
        if (
            cur_var->name != NULL &&
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            return cur_var;
        }
    }

    for (u32 var_index = 0; var_index < var_hash; ++var_index) {
        struct lox_parser_expr_var* cur_var = &env->var_expressions_arr[var_index];
        if (
            cur_var->name != NULL &&
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            return cur_var;
        }
    }

    return NULL;
}

struct lox_parser_expr_var* lox_parser__set_expr__var(
    struct parser* self,
    struct lox_var_environment* env,
    struct tokenizer_token* var_name,
    struct parser_expression* var_value
) {
    u32 var_hash = hash__sum_n(var_name->lexeme, var_name->lexeme_len) % env->var_expressions_arr_size;
    for (u32 var_index = var_hash; var_index < env->var_expressions_arr_size; ++var_index) {
        struct lox_parser_expr_var* cur_var = &env->var_expressions_arr[var_index];
        if (cur_var->name == NULL) {
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_expressions_arr_fill;
            
            return cur_var;
        } else if (
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            // delete previous declaration
            lox_parser__delete_from_expressions_table(self, env, (struct parser_expression*) cur_var);
            // note: allow redeclaring/redefining variables
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_expressions_arr_fill;

            return cur_var;
        }
    }

    for (u32 var_index = 0; var_index < var_hash; ++var_index) {
        struct lox_parser_expr_var* cur_var = &env->var_expressions_arr[var_index];
        if (cur_var->name == NULL) {
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_expressions_arr_fill;

            return cur_var;
        } else if (
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            // delete previous declaration
            lox_parser__delete_from_expressions_table(
                self,
                env,
                (struct parser_expression*) cur_var
            );
            // note: allow redeclaring/redefining variables
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_expressions_arr_fill;

            return cur_var;
        }
    }

    // var declaration arr is full
    error_code__exit(12434);
    return NULL;
}

void lox_parser__delete_expr__var(
    struct lox_var_environment* env,
    struct lox_parser_expr_var* var_expr
) {
    ASSERT(env->var_expressions_arr_fill != 0);
    --env->var_expressions_arr_fill;

    struct lox_parser_expr_var* env_var = lox_parser__get_expr__var(env, var_expr->name);
    env_var->name = NULL;
}

static struct parser_literal* lox_parser__evaluate_binary(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    if (binary_expr->evaluated_literal != NULL) {
        return binary_expr->evaluated_literal;
    }

    // note: evaluate both before type checking with left to right associativity
    struct parser_literal* left_literal_base = lox_parser__evaluate_expression(self, binary_expr->left);
    if (left_literal_base == NULL) {
        return NULL;
    }

    struct parser_literal* right_literal_base = lox_parser__evaluate_expression(self, binary_expr->right);
    if (right_literal_base == NULL) {
        return NULL;
    }

    switch (binary_expr->op->type) {
        case LOX_TOKEN_MINUS: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                parser__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                self,
                ((struct lox_literal_number*)left_literal_base)->data - ((struct lox_literal_number*)right_literal_base)->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_SLASH: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                parser__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
            struct lox_literal_number* right_literal = (struct lox_literal_number*) right_literal_base;
            if (right_literal->data == 0.0) {
                parser__runtime_error(
                    self,
                    "Cannot divide by 0."
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                self,
                left_literal->data / right_literal->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_STAR: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                parser__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                self,
                ((struct lox_literal_number*)left_literal_base)->data * ((struct lox_literal_number*)right_literal_base)->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_PLUS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data + ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                    self,
                    "%s%s", ((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
                struct lox_literal_string* right_literal = (struct lox_literal_string*) right_literal_base;
                if (r64__fractional_part(left_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                        self,
                        "%.0lf%s", left_literal->data, right_literal->data
                    );
                    return binary_expr->evaluated_literal;
                } else {
                    parser__runtime_error(
                        self,
                        "Cannot add fractional number '%lf' to string '%s'.",
                        left_literal->data,
                        right_literal->data
                    );
                    return NULL;
                }
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                struct lox_literal_string* left_literal = (struct lox_literal_string*) left_literal_base;
                struct lox_literal_number* right_literal = (struct lox_literal_number*) right_literal_base;
                if (r64__fractional_part(right_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                        self,
                        "%s%.0lf", left_literal->data, right_literal->data
                    );
                    return binary_expr->evaluated_literal;
                } else {
                    parser__runtime_error(
                        self,
                        "Cannot add string '%s' to fractional number '%lf'.",
                        left_literal->data,
                        right_literal->data
                    );
                    return NULL;
                }
            } else {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__nil(self);
                parser__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_GREATER: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data > ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) > 0
                );
                return binary_expr->evaluated_literal;
            } else {
                parser__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_GREATER_EQUAL: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data >= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) >= 0
                );
                return binary_expr->evaluated_literal;
            } else {
                parser__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_LESS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data < ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) < 0
                );
                return binary_expr->evaluated_literal;
            } else {
                parser__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_LESS_EQUAL: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data <= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    self,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) <= 0
                );
                return binary_expr->evaluated_literal;
            } else {
                parser__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_EXCLAM_EQUAL: {
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                self,
                !lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                self,
                lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            ASSERT(binary_expr->right->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
            struct parser_literal* predicate_literal_base = lox_parser__evaluate_expression(self, binary_expr->left);
            if (lox_parser__literal_is_truthy(predicate_literal_base)) {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_parser__evaluate_expression(self, conditional_expr->left);
            } else {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_parser__evaluate_expression(self, conditional_expr->right);
            }
            // evaluate condition
            // return either left expr or right expr
        } break ;
        case LOX_TOKEN_COLON: {
            // note: ternary will select and evaluate either left or right of this binary expr
            return NULL;
        }
        case LOX_TOKEN_EQUAL: {
            ASSERT(binary_expr->left->type == LOX_PARSER_EXPRESSION_TYPE_VAR);
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) binary_expr->left;
            var_expr->evaluated_literal = lox_parser__evaluate_expression(self, binary_expr->right);
            return var_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return NULL;
}

static struct parser_literal* lox_parser__evaluate_grouping(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;
    if (grouping_expr->evaluated_literal != NULL) {
        return grouping_expr->evaluated_literal;
    }

    return lox_parser__evaluate_expression(self, grouping_expr->expr);
}

static struct parser_literal* lox_parser__evaluate_literal(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;
    if (literal_expr->literal != NULL) {
        return literal_expr->literal;
    }

    // convert token to literal
    switch (literal_expr->value->type) {
        case LOX_TOKEN_NIL: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__nil(self);
        } break ;
        case LOX_TOKEN_FALSE: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__boolean(self, false);
        } break ;
        case LOX_TOKEN_TRUE: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__boolean(self, true);
        } break ;
        case LOX_TOKEN_NUMBER: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__number(self, libc__strntod(literal_expr->value->lexeme, literal_expr->value->lexeme_len));
        } break ;
        case LOX_TOKEN_STRING: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__string(self, "%.*s", literal_expr->value->lexeme_len, literal_expr->value->lexeme);
        } break ;
        case LOX_TOKEN_IDENTIFIER: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__nil(self);
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return literal_expr->literal;
}

struct parser_literal* lox_parser__evaluate_variable(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) expr;
    if (var_expr->evaluated_literal != NULL) {
        return var_expr->evaluated_literal;
    }

    struct lox_var_environment* cur_env = lox_parser__get_current_env(self);
    struct lox_parser_expr_var* env_var = lox_parser__get_expr__var(cur_env, var_expr->name);
    if (env_var == NULL) {
        cur_env = cur_env->enclosing_env;
        while (cur_env != NULL) {
            env_var = lox_parser__get_expr__var(cur_env, var_expr->name);
            if (env_var != NULL) {
                break ;
            }

            cur_env = cur_env->enclosing_env;
        }
    }

    if (env_var == NULL) {
        // note: if it was syntax error, we wouldn't be able to reference variables without forward declaration,
        // for example when referencing to functions in a function body
        // making it a runtime error, we can refer to variables that aren't declared yet, so this'd be a runtime error
        //   print a;
        //   var a = 3;
        parser__runtime_error(self, "Undefined variable");
        return NULL;
    }

    if (env_var->value == NULL) {
        struct lox_parser_expr_literal* env_var_literal = lox_parser__get_expr__literal(self, env_var->name);
        lox_parser__set_expr__var(
            self,
            cur_env,
            env_var_literal->value,
            (struct parser_expression*) env_var_literal
        );
    }

    struct parser_literal* evaluated_literal = lox_parser__evaluate_expression(self, env_var->value);
    if (evaluated_literal == NULL) {
        // evaluate previous environment?
        return NULL;
    }

    env_var->evaluated_literal = evaluated_literal;

    return evaluated_literal;
}

struct parser_literal* lox_parser__evaluate_expression(struct parser* self, struct parser_expression* expr) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_parser__evaluate_unary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_parser__evaluate_binary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_parser__evaluate_grouping(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_parser__evaluate_literal(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_VAR: return lox_parser__evaluate_variable(self, expr);
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

const char* lox_parser__literal_type_to_str(enum lox_literal_type literal_type) {
    switch (literal_type) {
        case LOX_LITERAL_TYPE_OBJECT: return "object";
        case LOX_LITERAL_TYPE_NIL: return "nil";
        case LOX_LITERAL_TYPE_BOOLEAN: return "boolean";
        case LOX_LITERAL_TYPE_NUMBER: return "number";
        case LOX_LITERAL_TYPE_STRING: return "string";
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

void lox_parser__print_literal_table_stats(struct parser* self) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    libc__printf(
        "  --=== Literals table ===--\n"
        "  object literals allocated: %u, total: %u\n"
        "  nil literals allocated: %u, total: %u\n"
        "  boolean literals allocated: %u, total: %u\n"
        "  number literals allocated: %u, total: %u\n"
        "  string literals allocated: %u, total: %u\n"
        "  --------------------------\n",
        table->object_arr_fill, table->object_arr_size,
        table->nil_arr_fill, table->nil_arr_size,
        table->boolean_arr_fill, table->boolean_arr_size,
        table->number_arr_fill, table->number_arr_size,
        table->string_arr_fill, table->string_arr_size
    );
}
