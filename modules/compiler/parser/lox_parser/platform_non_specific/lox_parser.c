#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/parser/parser.h"
#include "compiler/tokenizer/tokenizer.h"
#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

#include "lox_parse_state.h"

static struct memory_slice lox_parser_expr_evalute__op_unary(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__op_binary(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__grouping(struct parser_expression* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__literal(struct parser_expression* expr, struct memory_slice buffer);

const char* lox_parser__expression_type_to_str(enum lox_parser_expression_type expr_type) {
    switch (expr_type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return "unary";
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return "binary";
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return "grouping";
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return "literal";
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
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static struct lox_expressions_table* lox_parser__get_expressions_table(struct parser* self) {
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

static struct lox_literal_table* lox_parser__get_literal_table(struct parser* self) {
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

static struct lox_statements_table* lox_parser__get_statements_table(struct parser* self) {
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

static bool lox_parser_clear_tables(struct parser* self, struct tokenizer* tokenizer) {
    (void) tokenizer;
    // todo: need data from the tokenizer on how much tokens it has for each token type
    // todo: determine the kinds of expressions we have

    // expressions table
    {
        struct lox_expressions_table* expression_table = lox_parser__get_expressions_table(self);
        u64 expression_table_size = expression_table->table_memory_size;
        u64 memory_offset = sizeof(*expression_table);
        ASSERT(expression_table_size >= memory_offset);
        expression_table_size -= memory_offset;
        u64 expression_subtable_memory_size = expression_table_size / 4;

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
        u64 expression_table_size = statements_table->table_memory_size;
        u64 memory_offset = sizeof(*statements_table);
        ASSERT(expression_table_size >= memory_offset);
        expression_table_size -= memory_offset;
        u64 expression_subtable_memory_size = expression_table_size / 4;

        statements_table->print_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->print_statements_arr_fill = 0;
        statements_table->print_statements_arr_size = expression_subtable_memory_size / sizeof(*statements_table->print_statements_arr);
        memory_offset += expression_subtable_memory_size;

        statements_table->expression_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->expression_statements_arr_fill = 0;
        statements_table->expression_statements_arr_size = expression_subtable_memory_size / sizeof(*statements_table->expression_statements_arr);
        memory_offset += expression_subtable_memory_size;
    }

    return true;
}

#include "lox_parse_state.inl"

struct parser_statement* lox_parser__parse_tokens(struct parser* self, struct tokenizer* tokenizer) {
    if (lox_parser_clear_tables(self, tokenizer) == false) {
        return NULL;
    }
    struct lox_parse_state parse_state = {
        .parser = self,
        .tokenizer = tokenizer,
        .token_index = self->token_index
    };
    return lox_parse_state__statement(&parse_state);
}

void lox_parser__print_expressions_table_stats(struct parser* self) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    libc__printf(
        "  --=== Expressions table ===--\n"
        "  unary expressions allocated: %u, total: %u\n"
        "  binary expressions allocated: %u, total: %u\n"
        "  grouping expressions allocated: %u, total: %u\n"
        "  literal expressions allocated: %u, total: %u\n"
        "  -----------------------------\n",
        table->op_unary_arr_fill, table->op_unary_arr_size,
        table->op_binary_arr_fill, table->op_binary_arr_size,
        table->grouping_arr_fill, table->grouping_arr_size,
        table->literal_arr_fill, table->literal_arr_size
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

    struct lox_parser_expr_op_unary* result = &table->op_unary_arr[table->op_unary_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
    result->expr = expr;
    result->op = op;
    result->evaluated_literal = NULL;

    return result;
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

    struct lox_parser_expr_op_binary* result = &table->op_binary_arr[table->op_binary_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
    result->left = left;
    result->op = op;
    result->right = right;
    result->evaluated_literal = NULL;

    return result;
}

struct lox_parser_expr_grouping* lox_parser__get_expr__grouping(
    struct parser* self,
    struct parser_expression* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->grouping_arr_fill == table->grouping_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_expr_grouping* result = &table->grouping_arr[table->grouping_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
    result->expr = expr;
    result->evaluated_literal = NULL;

    return result;
}

struct lox_parser_expr_literal* lox_parser__get_expr__literal(
    struct parser* self,
    struct tokenizer_token* value
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->literal_arr_fill == table->literal_arr_size) {
        error_code__exit(21437);
    }
    
    struct lox_parser_expr_literal* result = &table->literal_arr[table->literal_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
    result->value = value;
    result->literal = NULL;

    return result;
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

struct memory_slice lox_parser__convert_to_string(struct parser_expression* expr, struct memory_slice buffer) {
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
            parser__convert_expr_to_string_fn lox_parser_expr_evalute_fn = NULL;
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

static bool lox_parser__literal_is_truthy(struct lox_literal_base* literal) {
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

static bool lox_parser__literal_is_equal(struct lox_literal_base* left, struct lox_literal_base* right) {
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

static struct lox_literal_base* lox_parser__interpret_unary(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    if (unary_expr->evaluated_literal != NULL) {
        return unary_expr->evaluated_literal;
    }

    struct lox_literal_base* literal_base = lox_parser__interpret_expression(self, unary_expr->expr);

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
            unary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__number(self, -number_literal->data);
            return unary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EXCLAM: {
            unary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(self, !lox_parser__literal_is_truthy(literal_base));
            return unary_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static void lox_parser__literal_base_print(struct lox_literal_base* literal) {
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

void lox_parser__evaluate_expr_fn(struct parser* self, struct parser_expression* expr) {
    struct lox_literal_base* literal = lox_parser__interpret_expression(self, expr);
    if (literal == NULL) {
        return ;
    }

    lox_parser__literal_base_print(literal);
}

void lox_parser__evaluate_statement_fn(struct parser* self, struct parser_statement* statement) {
    switch (statement->type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: {
            struct lox_parser_statement_print* print_statement = (struct lox_parser_statement_print*) statement;
            struct lox_literal_base* literal_base = lox_parser__interpret_expression(self, print_statement->expr);
            lox_parser__literal_base_print(literal_base);
            // lox_parser__evaluate_expr_fn(self, print_statement->expr);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: {
            struct lox_parser_statement_expression* expression_statement = (struct lox_parser_statement_expression*) statement;
            struct lox_literal_base* literal_base = lox_parser__interpret_expression(self, expression_statement->expr);
            (void) literal_base;
        } break ;
        default: ASSERT(false);
    }
}

void lox_parser__print_statements_table_stats(struct parser* self) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    libc__printf(
        "  --=== Statements table ===--\n"
        "  print statements allocated: %u, total: %u\n"
        "  expression statements allocated: %u, total: %u\n"
        "  ----------------------------\n",
        table->print_statements_arr_fill, table->print_statements_arr_size,
        table->expression_statements_arr_fill, table->expression_statements_arr_size
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

static struct lox_literal_base* lox_parser__interpret_binary(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    if (binary_expr->evaluated_literal != NULL) {
        return binary_expr->evaluated_literal;
    }

    // note: evaluate both before type checking with left to right associativity
    struct lox_literal_base* left_literal_base = lox_parser__interpret_expression(self, binary_expr->left);
    struct lox_literal_base* right_literal_base = lox_parser__interpret_expression(self, binary_expr->right);

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
            binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__number(
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
            binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__number(
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
            binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__number(
                self,
                ((struct lox_literal_number*)left_literal_base)->data * ((struct lox_literal_number*)right_literal_base)->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_PLUS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__number(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data + ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__string(
                    self,
                    "%s%s", ((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
                struct lox_literal_string* right_literal = (struct lox_literal_string*) right_literal_base;
                if (r64__fractional_part(left_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__string(
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
                    binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__string(
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
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data > ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data >= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data < ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                    self,
                    ((struct lox_literal_number*)left_literal_base)->data <= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
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
            binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                self,
                !lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            binary_expr->evaluated_literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(
                self,
                lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            ASSERT(binary_expr->right->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
            struct lox_literal_base* predicate_literal_base = lox_parser__interpret_expression(self, binary_expr->left);
            if (lox_parser__literal_is_truthy(predicate_literal_base)) {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_parser__interpret_expression(self, conditional_expr->left);
            } else {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_parser__interpret_expression(self, conditional_expr->right);
            }
            // evaluate condition
            // return either left expr or right expr
        } break ;
        case LOX_TOKEN_COLON: {
            // note: ternary will select and evaluate either left or right of this binary expr
            return NULL;
        }
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return NULL;
}

static struct lox_literal_base* lox_parser__interpret_grouping(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;
    if (grouping_expr->evaluated_literal != NULL) {
        return grouping_expr->evaluated_literal;
    }

    return lox_parser__interpret_expression(self, grouping_expr->expr);
}

static struct lox_literal_base* lox_parser__interpret_literal(struct parser* self, struct parser_expression* expr) {
    struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;
    if (literal_expr->literal != NULL) {
        return literal_expr->literal;
    }

    // convert token to literal
    switch (literal_expr->value->type) {
        case LOX_TOKEN_NIL: {
            literal_expr->literal = (struct lox_literal_base*) lox_parser__get_literal__nil(self);
        } break ;
        case LOX_TOKEN_FALSE: {
            literal_expr->literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(self, false);
        } break ;
        case LOX_TOKEN_TRUE: {
            literal_expr->literal = (struct lox_literal_base*) lox_parser__get_literal__boolean(self, true);
        } break ;
        case LOX_TOKEN_NUMBER: {
            literal_expr->literal = (struct lox_literal_base*) lox_parser__get_literal__number(self, libc__strntod(literal_expr->value->lexeme, literal_expr->value->lexeme_len));
        } break ;
        case LOX_TOKEN_STRING: {
            literal_expr->literal = (struct lox_literal_base*) lox_parser__get_literal__string(self, "%.*s", literal_expr->value->lexeme_len, literal_expr->value->lexeme);
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return literal_expr->literal;
}

struct lox_literal_base* lox_parser__interpret_expression(struct parser* self, struct parser_expression* expr) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_parser__interpret_unary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_parser__interpret_binary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_parser__interpret_grouping(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_parser__interpret_literal(self, expr);
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
