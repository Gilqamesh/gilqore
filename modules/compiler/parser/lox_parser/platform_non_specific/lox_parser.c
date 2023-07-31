#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/parser/parser.h"
#include "compiler/tokenizer/tokenizer.h"
#include "libc/libc.h"
#include "types/basic_types/basic_types.h"
#include "algorithms/hash/hash.h"
#include "time/time.h"
#include "system/system.h"

#include "lox_parse_state.h"

static struct memory_slice lox_parser_expr_evalute__op_unary(struct expr* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__op_binary(struct expr* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__grouping(struct expr* expr, struct memory_slice buffer);
static struct memory_slice lox_parser_expr_evalute__literal(struct expr* expr, struct memory_slice buffer);

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
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: return "logical";
        case LOX_PARSER_EXPRESSION_TYPE_NODE: return "node";
        case LOX_PARSER_EXPRESSION_TYPE_CALL: return "call";
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

char* lox_parser__expression_to_str(struct expr* expr, char* buffer, u32 *buffer_size) {
    if (*buffer_size == 0) {
        return buffer;
    }

    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
            struct lox_expr_unary* expr_unary = (struct lox_expr_unary*) expr;

            u32 bytes_written = libc__snprintf(buffer, *buffer_size, "%.*s", expr_unary->op->lexeme_len, expr_unary->op->lexeme);
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;

            buffer = lox_parser__expression_to_str(expr_unary->expr, buffer, buffer_size);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
            struct lox_expr_binary* expr_binary = (struct lox_expr_binary*) expr;
            buffer = lox_parser__expression_to_str(expr_binary->left, buffer, buffer_size);

            u32 bytes_written = libc__snprintf(buffer, *buffer_size, " %.*s ", expr_binary->op->lexeme_len, expr_binary->op->lexeme);
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;

            buffer = lox_parser__expression_to_str(expr_binary->right, buffer, buffer_size);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
            struct lox_expr_group* expr_grouping = (struct lox_expr_group*) expr;

            u32 bytes_written = libc__snprintf(buffer, *buffer_size, "(");
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;

            buffer = lox_parser__expression_to_str(expr_grouping->expr, buffer, buffer_size);

            bytes_written = libc__snprintf(buffer, *buffer_size, ")");
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
            struct lox_expr_literal* expr_literal = (struct lox_expr_literal*) expr;
            u32 bytes_written = 0;
            if (expr_literal->value->type == LOX_TOKEN_STRING) {
                bytes_written = libc__snprintf(buffer, *buffer_size, "\"%.*s\"", expr_literal->value->lexeme_len, expr_literal->value->lexeme);
            } else {
                bytes_written = libc__snprintf(buffer, *buffer_size, "%.*s", expr_literal->value->lexeme_len, expr_literal->value->lexeme);
            }

            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_VAR: {
            struct lox_expr_var* expr_var = (struct lox_expr_var*) expr;
            u32 bytes_written = libc__snprintf(buffer, *buffer_size, "%.*s", expr_var->name->lexeme_len, expr_var->name->lexeme);
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: {
            struct lox_expr_logical* expr_logical = (struct lox_expr_logical*) expr;
            buffer = lox_parser__expression_to_str(expr_logical->left, buffer, buffer_size);

            u32 bytes_written = libc__snprintf(buffer, *buffer_size, " %.*s ", expr_logical->op->lexeme_len, expr_logical->op->lexeme);
            if (bytes_written >= *buffer_size) {
                *buffer_size = 0;
                return buffer + *buffer_size;
            }
            *buffer_size -= bytes_written;
            buffer += bytes_written;

            buffer = lox_parser__expression_to_str(expr_logical->right, buffer, buffer_size);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_NODE: {
            struct lox_expr_node* expr_node = (struct lox_expr_node*) expr;
            while (expr_node) {
                buffer = lox_parser__expression_to_str(expr_node->expression, buffer, buffer_size);
                if (*buffer_size == 0) {
                    break ;
                }

                struct lox_expr_node* next_node = expr_node->next;
                if (next_node != NULL) {
                    u32 bytes_written = libc__snprintf(buffer, *buffer_size, ", ");
                    if (bytes_written >= *buffer_size) {
                        *buffer_size = 0;
                        return buffer + *buffer_size;
                    }
                    *buffer_size -= bytes_written;
                    buffer += bytes_written;
                }

                expr_node = next_node;
            }
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_CALL: {
            struct lox_expr_call* expr_call = (struct lox_expr_call*) expr;
            buffer = lox_parser__expression_to_str(expr_call->callee, buffer, buffer_size);
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }

    return buffer;
}

const char* lox_parser__statement_type_to_str(enum lox_parser_statement_type type) {
    switch (type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: return "print";
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: return "expression";
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: return "variable declaration";
        case LOX_PARSER_STATEMENT_TYPE_NODE: return "node";
        case LOX_PARSER_STATEMENT_TYPE_BLOCK: return "block";
        case LOX_PARSER_STATEMENT_TYPE_IF: return "if";
        case LOX_PARSER_STATEMENT_TYPE_WHILE: return "while";
        case LOX_PARSER_STATEMENT_TYPE_BREAK: return "break";
        case LOX_PARSER_STATEMENT_TYPE_CONTINUE: return "continue";
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

#include "lox_parse_state.inl"

void lox_parser__delete_from_expressions_table(struct parser* self,struct expr* expression) {
        switch (expression->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
            struct lox_expr_unary* unary_expression = (struct lox_expr_unary*) expression;
            lox_parser__delete_from_expressions_table(self, unary_expression->expr);
            // todo: delete unary_expression->evaluated_literal;
            lox_parser__delete_expr__op_unary(self, expression);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
            struct lox_expr_binary* binary_expr = (struct lox_expr_binary*) expression;
            lox_parser__delete_from_expressions_table(self, binary_expr->left);
            lox_parser__delete_from_expressions_table(self, binary_expr->right);
            // todo: delete binary_expr->evaluated_literal
            lox_parser__delete_expr__op_binary(self, expression);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
            struct lox_expr_group* grouping_expr = (struct lox_expr_group*) expression;
            lox_parser__delete_from_expressions_table(self, grouping_expr->expr);
            // todo: delete grouping_expr->evaluated_literal
            lox_parser__delete_expr__grouping(self, expression);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
            struct lox_expr_literal* literal_expr = (struct lox_expr_literal*) expression;
            (void) literal_expr;
            // todo: delete literal_expr->literal
            lox_parser__delete_expr__literal(self, expression);
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_VAR: {
            struct lox_expr_var* var_expr = (struct lox_expr_var*) expression;
            if (var_expr->value != NULL) {
                lox_parser__delete_from_expressions_table(self, var_expr->value);
            }
            // todo: delete var_expr->evaluated_literal;
            // lox_parser__delete_expr__var(expression);
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
        "  -----------------------------\n",
        table->op_unary_arr_fill, table->op_unary_arr_size,
        table->op_binary_arr_fill, table->op_binary_arr_size,
        table->grouping_arr_fill, table->grouping_arr_size,
        table->literal_arr_fill, table->literal_arr_size
    );
}

struct expr* lox_parser__copy_expression(
    struct parser* self,
    struct expr* expr
) {
    if (expr == NULL) {
        return NULL;
    }
    
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
            struct lox_expr_unary* expr_op_unary = (struct lox_expr_unary*) expr;
            return (struct expr*) lox_parser__get_expr__op_unary(
                self,
                expr_op_unary->op,
                lox_parser__copy_expression(self, expr_op_unary->expr)
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
            struct lox_expr_binary* expr_op_binary = (struct lox_expr_binary*) expr;
            return (struct expr*) lox_parser__get_expr__op_binary(
                self,
                lox_parser__copy_expression(self, expr_op_binary->left),
                expr_op_binary->op,
                lox_parser__copy_expression(self, expr_op_binary->right)
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
            struct lox_expr_group* expr_grouping = (struct lox_expr_group*) expr;
            return (struct expr*) lox_parser__get_expr__grouping(
                self,
                lox_parser__copy_expression(self, expr_grouping->expr)
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
            struct lox_expr_literal* expr_literal = (struct lox_expr_literal*) expr;
            return (struct expr*) lox_parser__get_expr__literal(
                self,
                expr_literal->value
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_VAR: {
            struct lox_expr_var* expr_var = (struct lox_expr_var*) expr;
            return lox_parser__get_expr__var(
                self,
                expr_var->name, lox_parser__copy_expression(self, expr_var->value)
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: {
            struct lox_expr_logical* expr_logical = (struct lox_expr_logical*) expr;
            return (struct expr*) lox_parser__get_expr__logical(
                self,
                lox_parser__copy_expression(self, expr_logical->left),
                expr_logical->op,
                lox_parser__copy_expression(self, expr_logical->right)
            );
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_NODE: {
            struct lox_expr_node* result = NULL;
            struct lox_expr_node** presult = &result;
            struct lox_expr_node* expr_node = (struct lox_expr_node*) expr;
            while (expr_node) {
                *presult = lox_parser__get_expr__node(
                    self,
                    lox_parser__copy_expression(self, expr_node->expression)
                );
                presult = &(*presult)->next;
                expr_node = expr_node->next;
            }
            return (struct expr*) result;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_CALL: {
            struct lox_expr_call* expr_call = (struct lox_expr_call*) expr;
            return (struct expr*) lox_parser__get_expr__call(
                self,
                lox_parser__copy_expression(self, expr_call->callee),
                expr_call->closing_paren,
                (struct lox_expr_node*) lox_parser__copy_expression(self, (struct expr*) expr_call->parameters)
            );
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

struct expr* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct token* op,
    struct expr* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->op_unary_arr_fill == table->op_unary_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) op % table->op_unary_arr_size;
    for (u32 unary_index = hash_value; unary_index < table->op_unary_arr_size; ++unary_index) {
        struct lox_expr_unary* result = &table->op_unary_arr[unary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
            result->expr = expr;
            result->op = op;
            result->evaluated_literal = NULL;

            ++table->op_unary_arr_fill;

            return (struct expr*) result;
        }
    }

    for (u32 unary_index = 0; unary_index < hash_value; ++unary_index) {
        struct lox_expr_unary* result = &table->op_unary_arr[unary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
            result->expr = expr;
            result->op = op;
            result->evaluated_literal = NULL;

            ++table->op_unary_arr_fill;

            return (struct expr*) result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__op_unary(struct parser* self, struct expr* expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    ASSERT(expr->type == LOX_PARSER_EXPRESSION_TYPE_OP_UNARY);
    struct lox_expr_unary* op_unary_expr = (struct lox_expr_unary*) expr;

    u32 hash_value = (u64) op_unary_expr->op % table->op_unary_arr_size;
    for (u32 unary_index = hash_value; unary_index < table->op_unary_arr_size; ++unary_index) {
        struct lox_expr_unary* unary_expr_to_delete = &table->op_unary_arr[unary_index];
        if (unary_expr_to_delete->op == op_unary_expr->op) {
            op_unary_expr->op = NULL;

            --table->op_unary_arr_fill;

            return ;
        }
    }

    for (u32 unary_index = 0; unary_index < hash_value; ++unary_index) {
        struct lox_expr_unary* unary_expr_to_delete = &table->op_unary_arr[unary_index];
        if (unary_expr_to_delete->op == op_unary_expr->op) {
            op_unary_expr->op = NULL;

            --table->op_unary_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct expr* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct expr* left,
    struct token* op,
    struct expr* right
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->op_binary_arr_fill == table->op_binary_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) op % table->op_binary_arr_size;
    for (u32 binary_index = hash_value; binary_index < table->op_binary_arr_size; ++binary_index) {
        struct lox_expr_binary* result = &table->op_binary_arr[binary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
            result->left = left;
            result->op = op;
            result->right = right;
            result->evaluated_literal = NULL;

            ++table->op_binary_arr_fill;

            return (struct expr*) result;
        }
    }

    for (u32 binary_index = 0; binary_index < hash_value; ++binary_index) {
        struct lox_expr_binary* result = &table->op_binary_arr[binary_index];
        if (result->op == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
            result->left = left;
            result->op = op;
            result->right = right;
            result->evaluated_literal = NULL;

            ++table->op_binary_arr_fill;

            return (struct expr*) result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__op_binary(struct parser* self, struct expr* expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    ASSERT(expr->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
    struct lox_expr_binary* op_binary_expr = (struct lox_expr_binary*) expr;

    u32 hash_value = (u64) op_binary_expr->op % table->op_binary_arr_size;
    for (u32 binary_index = hash_value; binary_index < table->op_binary_arr_size; ++binary_index) {
        struct lox_expr_binary* binary_expr_to_delete = &table->op_binary_arr[binary_index];
        if (binary_expr_to_delete->op == op_binary_expr->op) {
            op_binary_expr->op = NULL;

            --table->op_binary_arr_fill;

            return ;
        }
    }

    for (u32 binary_index = 0; binary_index < hash_value; ++binary_index) {
        struct lox_expr_binary* binary_expr_to_delete = &table->op_binary_arr[binary_index];
        if (binary_expr_to_delete->op == op_binary_expr->op) {
            op_binary_expr->op = NULL;

            --table->op_binary_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct expr* lox_parser__get_expr__grouping(
    struct parser* self,
    struct expr* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->grouping_arr_fill == table->grouping_arr_size) {
        error_code__exit(21437);
    }

    u32 hash_value = (u64) expr % table->grouping_arr_size;
    for (u32 grouping_index = hash_value; grouping_index < table->grouping_arr_size; ++grouping_index) {
        struct lox_expr_group* result = &table->grouping_arr[grouping_index];
        if (result->expr == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
            result->expr = expr;
            result->evaluated_literal = NULL;

            ++table->grouping_arr_fill;

            return (struct expr*) result;
        }
    }

    for (u32 grouping_index = 0; grouping_index < hash_value; ++grouping_index) {
        struct lox_expr_group* result = &table->grouping_arr[grouping_index];
        if (result->expr == NULL) {
            result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
            result->expr = expr;
            result->evaluated_literal = NULL;

            ++table->grouping_arr_fill;

            return (struct expr*) result;
        }
    }

    error_code__exit(324342);
    return NULL;
}

void lox_parser__delete_expr__grouping(struct parser* self, struct expr* expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    ASSERT(expr->type == LOX_PARSER_EXPRESSION_TYPE_GROUPING);
    struct lox_expr_group* grouping_expr = (struct lox_expr_group*) expr;

    u32 hash_value = (u64) grouping_expr->expr % table->grouping_arr_size;
    for (u32 grouping_index = hash_value; grouping_index < table->grouping_arr_size; ++grouping_index) {
        struct lox_expr_group* grouping_expr_to_delete = &table->grouping_arr[grouping_index];
        if (grouping_expr_to_delete->expr == grouping_expr->expr) {
            grouping_expr_to_delete->expr = NULL;
            --table->grouping_arr_fill;

            return ;
        }
    }

    for (u32 grouping_index = 0; grouping_index < hash_value; ++grouping_index) {
        struct lox_expr_group* grouping_expr_to_delete = &table->grouping_arr[grouping_index];
        if (grouping_expr_to_delete->expr == grouping_expr->expr) {
            grouping_expr_to_delete->expr = NULL;
            --table->grouping_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct expr* lox_parser__get_expr__literal(struct parser* self, struct token* value) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->literal_arr_fill == table->literal_arr_size) {
        error_code__exit(21437);
    }
    
    u32 hash_value = (u64) value % table->literal_arr_size;
    for (u32 literal_index = hash_value; literal_index < table->literal_arr_size; ++literal_index) {
        struct lox_expr_literal* literal_expr = &table->literal_arr[literal_index];
        if (literal_expr->value == NULL) {
            literal_expr->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
            literal_expr->value = value;
            literal_expr->literal = NULL;

            ++table->literal_arr_fill;

            return (struct expr*) literal_expr;
        }
    }

    for (u32 literal_index = 0; literal_index < hash_value; ++literal_index) {
        struct lox_expr_literal* literal_expr = &table->literal_arr[literal_index];
        if (literal_expr->value == NULL) {
            literal_expr->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
            literal_expr->value = value;
            literal_expr->literal = NULL;

            ++table->literal_arr_fill;

            return (struct expr*) literal_expr;
        }
    }

    error_code__exit(324342);
    return NULL;
}

struct expr* lox_parser__get_expr__literal_true(struct parser* self) {
    static const char true_lexeme[] = "true";
    static struct token true_token = {
        .lexeme = true_lexeme,
        .lexeme_len = ARRAY_SIZE(true_lexeme) - 1,
        .type = LOX_TOKEN_TRUE,
        .line = -1
    };
    struct lox_expr_literal* result = (struct lox_expr_literal*) lox_parser__get_expr__literal(self, &true_token);
    result->literal = (struct literal*) lox_parser__get_literal__boolean(self, true);
    return (struct expr*) result;
}

struct expr* lox_parser__get_expr__literal_false(struct parser* self) {
    static const char false_lexeme[] = "false";
    static struct token false_token = {
        .lexeme = false_lexeme,
        .lexeme_len = ARRAY_SIZE(false_lexeme) - 1,
        .type = LOX_TOKEN_FALSE,
        .line = -1
    };
    struct lox_expr_literal* result = (struct lox_expr_literal*) lox_parser__get_expr__literal(self, &false_token);
    result->literal = (struct literal*) lox_parser__get_literal__boolean(self, false);
    return (struct expr*) result;
}

struct expr* lox_parser__get_expr__literal_nil(struct parser* self) {
    static const char nil_lexeme[] = "true";
    static struct token nil_token = {
        .lexeme = nil_lexeme,
        .lexeme_len = ARRAY_SIZE(nil_lexeme) - 1,
        .type = LOX_TOKEN_NIL,
        .line = -1
    };
    struct lox_expr_literal* result = (struct lox_expr_literal*) lox_parser__get_expr__literal(self, &nil_token);
    result->literal = (struct literal*) lox_parser__get_literal__nil(self);
    return (struct expr*) result;
}

struct expr* lox_parser__get_expr__logical(
    struct parser* self,
    struct expr* left,
    struct token* op,
    struct expr* right
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->logical_arr_fill == table->logical_arr_size) {
        error_code__exit(21437);
    }

    struct lox_expr_logical* result = &table->logical_arr[table->logical_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_LOGICAL;
    result->left = left;
    result->op = op;
    result->right = right;
    result->evaluated_literal = NULL;

    return (struct expr*) result;
}

void lox_parser__delete_expr__logical(struct parser* self, struct expr* logical_expr) {
    (void) self;
    (void) logical_expr;
}

struct lox_expr_node* lox_parser__get_expr__node(
    struct parser* self,
    struct expr* expr
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->node_arr_fill == table->node_arr_size) {
        error_code__exit(21437);
    }

    struct lox_expr_node* result = &table->node_arr[table->node_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_NODE;
    result->expression = expr;
    result->next = NULL;

    return result;
}

struct expr* lox_parser__get_expr__call(
    struct parser* self,
    struct expr* callee,
    struct token* closing_paren,
    struct lox_expr_node* parameters
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->call_arr_fill == table->call_arr_size) {
        error_code__exit(21437);
    }

    struct lox_expr_call* result = &table->call_arr[table->call_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_CALL;
    result->callee = callee;
    result->closing_paren = closing_paren;
    result->parameters = parameters;

    return (struct expr*) result;
}

struct expr* lox_parser__get_expr__var(
    struct parser* self,
    struct token* name,
    struct expr* value
) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);
    if (table->var_arr_fill == table->var_arr_size) {
        error_code__exit(21437);
    }

    struct lox_expr_var* result = &table->var_arr[table->var_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
    result->name = name;
    result->value = value;
    result->evaluated_literal = NULL;

    return (struct expr*) result;
}

void lox_parser__delete_expr__literal(struct parser* self, struct expr* expr) {
    struct lox_expressions_table* table = lox_parser__get_expressions_table(self);

    ASSERT(expr->type == LOX_PARSER_EXPRESSION_TYPE_LITERAL);
    struct lox_expr_literal* literal_expr = (struct lox_expr_literal*) expr;

    u32 hash_value = (u64) literal_expr->value % table->literal_arr_size;
    for (u32 literal_index = hash_value; literal_index < table->literal_arr_size; ++literal_index) {
        struct lox_expr_literal* literal_expr_to_delete = &table->literal_arr[literal_index];
        if (literal_expr_to_delete->value == literal_expr->value) {
            literal_expr_to_delete->value = NULL;
            --table->literal_arr_fill;

            return ;
        }
    }

    for (u32 literal_index = 0; literal_index < hash_value; ++literal_index) {
        struct lox_expr_literal* literal_expr_to_delete = &table->literal_arr[literal_index];
        if (literal_expr_to_delete->value == literal_expr->value) {
            literal_expr_to_delete->value = NULL;
            --table->literal_arr_fill;

            return ;
        }
    }

    error_code__exit(324342);
}

struct literal* lox_parser__get_literal__object(
    struct parser* self,
    struct object_header header,
    struct memory_slice value
) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    if (table->object_arr_fill == table->object_arr_size) {
        error_code__exit(234782);
    }

    struct lox_literal_obj* result = &table->object_arr[table->object_arr_fill++];
    result->base.type = LOX_LITERAL_TYPE_OBJECT;
    result->header = header;
    result->data = value;

    return (struct literal*) result;
}

struct literal* lox_parser__get_literal__nil(struct parser* self) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    return (struct literal*) table->nil_literal;
}

struct literal* lox_parser__get_literal__boolean(struct parser* self, bool value) {
    struct lox_literal_table* table = lox_parser__get_literal_table(self);
    return (struct literal*) (value == true ? table->boolean_literal_true : table->boolean_literal_false);
}

struct literal* lox_parser__get_literal__number(
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

    return (struct literal*) result;
}

struct literal* lox_parser__get_literal__string(
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

    return (struct literal*) result;
}

struct memory_slice lox_parser__convert_expr_to_string(struct expr* expr, struct memory_slice buffer) {
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
    struct token* token,
    struct memory_slice buffer,
    u32 expressions_count, ...
) {
    if (expressions_count) {
        va_list ap;

        va_start(ap, expressions_count);
        while (expressions_count > 0) {
            struct expr* expr = (struct expr*) va_arg(ap, void*);
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

struct memory_slice lox_parser_expr_evalute__op_unary(struct expr* expr, struct memory_slice buffer) {
    struct lox_expr_unary* unary_expr = (struct lox_expr_unary*) expr;
    return
    lox_parser__write_to_memory_expressions(
        unary_expr->op,
        buffer,
        1,
        unary_expr->expr
    );
}

struct memory_slice lox_parser_expr_evalute__op_binary(struct expr* expr, struct memory_slice buffer) {
    struct lox_expr_binary* binary_expr = (struct lox_expr_binary*) expr;
    return
    lox_parser__write_to_memory_expressions(
        binary_expr->op,
        buffer,
        2,
        binary_expr->left,
        binary_expr->right
    );
}

struct memory_slice lox_parser_expr_evalute__grouping(struct expr* expr, struct memory_slice buffer) {
    struct lox_expr_group* grouping_expr = (struct lox_expr_group*) expr;

    buffer = lox_parser__write_to_memory(buffer, "( ");

    buffer = lox_parser__write_to_memory_expressions(NULL, buffer, 1, grouping_expr->expr);

    buffer = lox_parser__write_to_memory(buffer, ") ");

    return buffer;
}

struct memory_slice lox_parser_expr_evalute__literal(struct expr* expr, struct memory_slice buffer) {
    struct lox_expr_literal* literal_expr = (struct lox_expr_literal*) expr;

    // if (literal_expr->value->type == LOX_TOKEN_STRING) {
    //     buffer = lox_parser__write_to_memory(buffer, "\"");
    // }

    buffer = lox_parser__write_to_memory_expressions(literal_expr->value, buffer, 0);

    // if (literal_expr->value->type == LOX_TOKEN_STRING) {
    //     buffer = lox_parser__write_to_memory(buffer, "\"");
    // }

    return buffer;
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
        "  if statements allocated: %u, total: %u\n"
        "  while statements allocated: %u, total: %u\n"
        "  fun_params statements allocated: %u, total: %u\n"
        "  fun statements allocated: %u, total: %u\n"
        "  ----------------------------\n",
        table->print_statements_arr_fill, table->print_statements_arr_size,
        table->expression_statements_arr_fill, table->expression_statements_arr_size,
        table->var_decl_statements_arr_fill, table->var_decl_statements_arr_size,
        table->lox_parser_statement_node_arr_fill, table->lox_parser_statement_node_arr_size,
        table->block_statements_arr_fill, table->block_statements_arr_size,
        table->if_statements_arr_fill, table->if_statements_arr_size,
        table->while_statements_arr_fill, table->while_statements_arr_size,
        table->fun_params_arr_fill, table->fun_params_arr_size,
        table->fun_arr_fill, table->fun_arr_size
    );
}

struct stmt* lox_parser__get_statement_print(
    struct parser* self,
    struct expr* expr
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->print_statements_arr_fill == table->print_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_print* result = &table->print_statements_arr[table->print_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_PRINT;
    result->expr = expr;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_expression(struct parser* self,struct expr* expr) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->expression_statements_arr_fill == table->expression_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_expr* result = &table->expression_statements_arr[table->expression_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_EXPRESSION;
    result->expr = expr;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_var_decl(struct parser* self, struct expr* var_expr) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->var_decl_statements_arr_fill == table->var_decl_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_var_decl* result = &table->var_decl_statements_arr[table->var_decl_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_VAR_DECL;
    result->var_expr = var_expr;

    return (struct stmt*) result;
}

struct lox_stmt_node* lox_parser__get_statement_node(
    struct parser* self,
    struct stmt* statement
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->lox_parser_statement_node_arr_fill == table->lox_parser_statement_node_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_node* result = &table->lox_parser_statement_node_arr[table->lox_parser_statement_node_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_NODE;
    result->statement = statement;
    result->next = NULL;

    return result;
}

struct stmt* lox_parser__get_statement_block(
    struct parser* self,
    struct lox_stmt_node* statement_list
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->block_statements_arr_fill == table->block_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_block* result = &table->block_statements_arr[table->block_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_BLOCK;
    result->statement_list = statement_list;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_if(
    struct parser* self,
    struct expr* condition,
    struct stmt* then_branch,
    struct stmt* else_branch
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->if_statements_arr_fill == table->if_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_if* result = &table->if_statements_arr[table->if_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_IF;
    result->condition = condition;
    result->then_branch = then_branch;
    result->else_branch = else_branch;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_while(
    struct parser* self,
    struct expr* condition,
    struct stmt* statement
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->while_statements_arr_fill == table->while_statements_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_while* result = &table->while_statements_arr[table->while_statements_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_WHILE;
    result->condition = condition;
    result->statement = statement;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_break(struct parser* self) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);

    return (struct stmt*) table->break_statement;
}

struct stmt* lox_parser__get_statement_continue(struct parser* self) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);

    return (struct stmt*) table->continue_statement;
}

struct lox_stmt_token_node* lox_parser__get_statement_fun_params_node(struct parser* self, struct token* name) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->fun_params_arr_fill == table->fun_params_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_token_node* result = &table->fun_params_arr[table->fun_params_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_FUN_PARAMS_NODE;
    result->name = name;
    result->next = NULL;

    return result;
}

struct stmt* lox_parser__get_statement_fun(
    struct parser* self,
    struct token* name,
    struct lox_stmt_token_node* params,
    struct lox_stmt_block* body
) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->fun_arr_fill == table->fun_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_fun* result = &table->fun_arr[table->fun_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_FUN_DECL;
    result->name = name;
    result->params = params;
    result->body = body;

    return (struct stmt*) result;
}

struct stmt* lox_parser__get_statement_return(struct parser* self, struct expr* expr) {
    struct lox_statements_table* table = lox_parser__get_statements_table(self);
    if (table->return_arr_fill == table->return_arr_size) {
        error_code__exit(21437);
    }

    struct lox_stmt_return* result = &table->return_arr[table->return_arr_fill++];
    result->base.type = LOX_PARSER_STATEMENT_TYPE_RETURN;
    result->expr = expr;

    return (struct stmt*) result;
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
        "  number literals allocated: %u, total: %u\n"
        "  string literals allocated: %u, total: %u\n"
        "  --------------------------\n",
        table->object_arr_fill, table->object_arr_size,
        table->number_arr_fill, table->number_arr_size,
        table->string_arr_fill, table->string_arr_size
    );
}

struct parser_ast lox_parser__parse_ast(struct parser* self) {
    struct parser_ast result;

    result.statement = lox_parser__declaration(self);

    return result;
}

bool lox_parser__ast_is_valid(struct parser_ast ast) {
    return ast.statement != NULL;
}
