#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/parser/parser.h"
#include "compiler/tokenizer/tokenizer.h"
#include "libc/libc.h"

#include "lox_parse_state.h"

static char* lox_parser_expr_evalute__op_unary(struct parser_expression* expr, struct memory_slice buffer);
static char* lox_parser_expr_evalute__op_binary(struct parser_expression* expr, struct memory_slice buffer);
static char* lox_parser_expr_evalute__grouping(struct parser_expression* expr, struct memory_slice buffer);
static char* lox_parser_expr_evalute__literal(struct parser_expression* expr, struct memory_slice buffer);

char* parenthesize(
    const char* name,
    u32 name_len,
    struct memory_slice buffer,
    bool add_parentheses,
    u32 expressions_count, ...) {
    u64 result_size = memory_slice__size(&buffer);
    char* result = memory_slice__memory(&buffer);
    u64 bytes_written = 0;

    va_list ap;

    va_start(ap, expressions_count);
    if (add_parentheses) {
        bytes_written += libc__snprintf(
            result + bytes_written,
            result_size - bytes_written,
            "("
        );
    }
    while (expressions_count > 0) {
        struct parser_expression* expr = (struct parser_expression*) va_arg(ap, void*);
        parser__convert_to_string_fn lox_parser_expr_evalute_fn = NULL;
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
        bytes_written += lox_parser_expr_evalute_fn(
            expr,
            memory_slice__create(result + bytes_written, result_size - bytes_written)
        ) - (result + bytes_written);
        --expressions_count;
    }
    bytes_written += libc__snprintf(
        result + bytes_written,
        result_size - bytes_written,
        "%.*s ", name_len, name
    );
    if (add_parentheses) {
        bytes_written += libc__snprintf(
            result + bytes_written,
            result_size - bytes_written,
            ")"
        );
    }
    va_end(ap);

    return result + bytes_written;
}

bool lox_parser_clear_table(struct parser* self, struct tokenizer* tokenizer) {
    (void) tokenizer;
    // todo: need data from the tokenizer on how much tokens it has for each token type
    // todo: determine the kinds of expressions we have
    char* memory = memory_slice__memory(&self->parser_expression_table);
    u64 memory_size = memory_slice__size(&self->parser_expression_table);
    if (memory_size < sizeof(struct lox_expressions_table)) {
        return false;
    }
    struct lox_expressions_table* table = memory_slice__memory(&self->parser_expression_table);
    u64 subtable_memory_size = memory_size / 4;
    u64 memory_offset = 0;

    table->op_unary_arr = (void*) (memory + memory_offset);
    memory_offset += subtable_memory_size;
    table->op_unary_arr_fill = 0;
    memory_offset += sizeof(table->op_unary_arr_fill);
    table->op_unary_arr_size = subtable_memory_size / sizeof(*table->op_unary_arr);
    memory_offset += sizeof(table->op_unary_arr_size);

    table->op_binary_arr = (void*) (memory + memory_offset);
    memory_offset += subtable_memory_size;
    table->op_binary_arr_fill = 0;
    memory_offset += sizeof(table->op_binary_arr_fill);
    table->op_binary_arr_size = subtable_memory_size / sizeof(*table->op_binary_arr);
    memory_offset += sizeof(table->op_binary_arr_size);

    table->grouping_arr = (void*) (memory + memory_offset);
    memory_offset += subtable_memory_size;
    table->grouping_arr_fill = 0;
    memory_offset += sizeof(table->grouping_arr_fill);
    table->grouping_arr_size = subtable_memory_size / sizeof(*table->grouping_arr);
    memory_offset += sizeof(table->grouping_arr_size);

    table->literal_arr = (void*) (memory + memory_offset);
    memory_offset += subtable_memory_size;
    table->literal_arr_fill = 0;
    memory_offset += sizeof(table->literal_arr_fill);
    table->literal_arr_size = subtable_memory_size / sizeof(*table->literal_arr);
    memory_offset += sizeof(table->literal_arr_size);

    return true;
}

#include "lox_parse_state.inl"

struct parser_expression* lox_parser__parse_tokens(struct parser* self, struct tokenizer* tokenizer) {
    if (lox_parser_clear_table(self, tokenizer) == false) {
        return NULL;
    }
    struct lox_parse_state parse_state = {
        .parser = self,
        .tokenizer = tokenizer,
        .token_index = 0
    };
    return lox_parse_state__expression(&parse_state);
} 

struct lox_parser_expr_op_unary* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct tokenizer_token* op,
    struct parser_expression* expr
) {
    struct lox_expressions_table* table = (struct lox_expressions_table*) memory_slice__memory(&self->parser_expression_table);
    if (table->op_unary_arr_fill == table->op_unary_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_expr_op_unary* result = &table->op_unary_arr[table->op_unary_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY;
    result->expr = expr;
    result->op = op;

    return result;
}

struct lox_parser_expr_op_binary* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct parser_expression* left,
    struct tokenizer_token* op,
    struct parser_expression* right
) {
    struct lox_expressions_table* table = (struct lox_expressions_table*) memory_slice__memory(&self->parser_expression_table);
    if (table->op_binary_arr_fill == table->op_binary_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_expr_op_binary* result = &table->op_binary_arr[table->op_binary_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY;
    result->left = left;
    result->op = op;
    result->right = right;

    return result;
}

struct lox_parser_expr_grouping* lox_parser__get_expr__grouping(
    struct parser* self,
    struct parser_expression* expr
) {
    struct lox_expressions_table* table = (struct lox_expressions_table*) memory_slice__memory(&self->parser_expression_table);
    if (table->grouping_arr_fill == table->grouping_arr_size) {
        error_code__exit(21437);
    }

    struct lox_parser_expr_grouping* result = &table->grouping_arr[table->grouping_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_GROUPING;
    result->expr = expr;

    return result;
}

struct lox_parser_expr_literal* lox_parser__get_expr__literal(
    struct parser* self,
    struct tokenizer_token* value
) {
    struct lox_expressions_table* table = (struct lox_expressions_table*) memory_slice__memory(&self->parser_expression_table);
    if (table->literal_arr_fill == table->literal_arr_size) {
        error_code__exit(21437);
    }
    
    struct lox_parser_expr_literal* result = &table->literal_arr[table->literal_arr_fill++];
    result->base.type = LOX_PARSER_EXPRESSION_TYPE_LITERAL;
    result->value = value;

    return result;
}

char* lox_parser__convert_to_string(struct parser_expression* expr, struct memory_slice buffer) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: {
            lox_parser_expr_evalute__op_unary(expr, buffer);
            return (char*) memory_slice__memory(&buffer);
        }
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: {
            lox_parser_expr_evalute__op_binary(expr, buffer);
            return (char*) memory_slice__memory(&buffer);
        }
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: {
            lox_parser_expr_evalute__grouping(expr, buffer);
            return (char*) memory_slice__memory(&buffer);
        }
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: {
            lox_parser_expr_evalute__literal(expr, buffer);
            return (char*) memory_slice__memory(&buffer);
        }
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static char* lox_parser_expr_evalute__op_unary(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    return
    parenthesize(
        unary_expr->op->lexeme,
        unary_expr->op->lexeme_len,
        buffer,
        false,
        1,
        unary_expr->expr
    );
}

static char* lox_parser_expr_evalute__op_binary(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    return
    parenthesize(
        binary_expr->op->lexeme,
        binary_expr->op->lexeme_len,
        buffer,
        false,
        2,
        binary_expr->left,
        binary_expr->right
    );
}

static char* lox_parser_expr_evalute__grouping(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;
    return
    parenthesize(
        "",
        0,
        buffer,
        true,
        1,
        grouping_expr->expr
    );
}

static char* lox_parser_expr_evalute__literal(struct parser_expression* expr, struct memory_slice buffer) {
    struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;
    return
    parenthesize(
        literal_expr->value->lexeme,
        literal_expr->value->lexeme_len,
        buffer,
        false,
        0
    );
    // struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;
    // char* result_str = memory_slice__memory(&buffer);
    // u32 bytes_written = libc__snprintf(
    //     result_str, memory_slice__size(&buffer),
    //     "%.*s",
    //     literal_expr->value->lexeme_len,
    //     literal_expr->value->lexeme
    // );

    // return (char*) result_str + bytes_written;
}
