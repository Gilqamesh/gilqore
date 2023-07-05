#ifndef LOX_PARSER_H
# define LOX_PARSER_H

# include "lox_parser_defs.h"

#include "compiler/parser/parser.h"

enum lox_parser_expression_type {
    LOX_PARSER_EXPRESSION_TYPE_OP_UNARY,
    LOX_PARSER_EXPRESSION_TYPE_OP_BINARY,
    LOX_PARSER_EXPRESSION_TYPE_GROUPING,
    LOX_PARSER_EXPRESSION_TYPE_LITERAL
};

struct tokenizer_token;

struct parser_expression* lox_parser__parse_tokens(struct parser* self, struct tokenizer* tokenizer);

packed_struct(1) lox_parser_expr_op_unary {
    struct parser_expression base;
    // u32 op_index;
    // u32 expr_index;
    struct tokenizer_token* op;
    struct parser_expression* expr;
};

packed_struct(1) lox_parser_expr_op_binary {
    struct parser_expression base;
    struct parser_expression* left;
    struct tokenizer_token* op;
    struct parser_expression* right;
};

packed_struct(1) lox_parser_expr_grouping {
    struct parser_expression base;
    struct parser_expression* expr;
};

packed_struct(1) lox_parser_expr_literal {
    struct parser_expression base;
    struct tokenizer_token* value;
};

struct lox_expressions_table {
    struct lox_parser_expr_op_unary* op_unary_arr;
    u32 op_unary_arr_fill;
    u32 op_unary_arr_size;

    struct lox_parser_expr_op_binary* op_binary_arr;
    u32 op_binary_arr_fill;
    u32 op_binary_arr_size;

    struct lox_parser_expr_grouping* grouping_arr;
    u32 grouping_arr_fill;
    u32 grouping_arr_size;

    struct lox_parser_expr_literal* literal_arr;
    u32 literal_arr_fill;
    u32 literal_arr_size;
};

struct lox_parser_expr_op_unary* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct tokenizer_token* op,
    struct parser_expression* expr
);
struct lox_parser_expr_op_binary* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct parser_expression* left,
    struct tokenizer_token* op,
    struct parser_expression* right
);
struct lox_parser_expr_grouping* lox_parser__get_expr__grouping(
    struct parser* self,
    struct parser_expression* expr
);
struct lox_parser_expr_literal* lox_parser__get_expr__literal(
    struct parser* self,
    struct tokenizer_token* value
);

char* lox_parser__convert_to_string(struct parser_expression* expr, struct memory_slice buffer);

#endif // LOX_PARSER_H
