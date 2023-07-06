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

const char* lox_parser__expression_type_to_str(enum lox_parser_expression_type expr_type);

enum lox_parser_statement_type {
    LOX_PARSER_STATEMENT_TYPE_PRINT,
    LOX_PARSER_STATEMENT_TYPE_EXPRESSION
};

// todo: implement
const char* lox_parser__statement_type_to_str(enum lox_parser_statement_type type);

struct tokenizer_token;
struct lox_literal_base;

PUBLIC_API struct parser_statement* lox_parser__parse_tokens(struct parser* self, struct tokenizer* tokenizer);

PUBLIC_API struct memory_slice lox_parser__convert_to_string(struct parser_expression* expr, struct memory_slice buffer);

PUBLIC_API void lox_parser__evaluate_expr_fn(struct parser* self, struct parser_expression* expr);

PUBLIC_API void lox_parser__evaluate_statement_fn(struct parser* self, struct parser_statement* statement);

// STATEMENTS TYPES, STATEMENTS TABLE START

packed_struct(1) lox_parser_statement_print {
    struct parser_statement base;
    struct parser_expression* expr;
};

packed_struct(1) lox_parser_statement_expression {
    struct parser_statement base;
    struct parser_expression* expr;
};

struct lox_statements_table {
    struct lox_parser_statement_print* print_statements_arr;
    u32 print_statements_arr_fill;
    u32 print_statements_arr_size;

    struct lox_parser_statement_expression* expression_statements_arr;
    u32 expression_statements_arr_fill;
    u32 expression_statements_arr_size;

    u64 table_memory_size;
};

void lox_parser__print_statements_table_stats(struct parser* self);

struct lox_parser_statement_print* lox_parser__get_statement_print(
    struct parser* self,
    struct parser_expression* expr
);

struct lox_parser_statement_expression* lox_parser__get_statement_expression(
    struct parser* self,
    struct parser_expression* expr
);

// STATEMENTS TYPES, STATEMENTS TABLE END

// EXPRESSION TYPES, EXPRESSION TABLE START

packed_struct(1) lox_parser_expr_op_unary {
    struct parser_expression base;
    // todo: change these to indices into the tables as it's smaller
    // u32 op_index;
    // u32 expr_index;
    // u32 value_index;
    struct tokenizer_token* op;
    struct parser_expression* expr;

    struct lox_literal_base* evaluated_literal;
};

packed_struct(1) lox_parser_expr_op_binary {
    struct parser_expression base;
    struct parser_expression* left;
    struct tokenizer_token* op;
    struct parser_expression* right;

    struct lox_literal_base* evaluated_literal;
};

packed_struct(1) lox_parser_expr_grouping {
    struct parser_expression base;
    struct parser_expression* expr;

    struct lox_literal_base* evaluated_literal;
};

packed_struct(1) lox_parser_expr_literal {
    struct parser_expression base;
    struct tokenizer_token* value;

    struct lox_literal_base* literal;
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

    u64 table_memory_size;
};

void lox_parser__print_expressions_table_stats(struct parser* self);

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

// EXPRESSION TYPES, EXPRESSION TABLE END

// TYPE SYSTEM, LITERAL TABLE START

enum lox_literal_type {
    LOX_LITERAL_TYPE_OBJECT,
    LOX_LITERAL_TYPE_NIL,
    LOX_LITERAL_TYPE_BOOLEAN,
    LOX_LITERAL_TYPE_NUMBER,
    LOX_LITERAL_TYPE_STRING
};

struct lox_literal_base {
    u8 type;
};

const char* lox_parser__literal_type_to_str(enum lox_literal_type literal_type);

struct lox_literal_object {
    struct lox_literal_base base;
    struct memory_slice data;
};

struct lox_literal_nil {
    struct lox_literal_base base;
};

struct lox_literal_boolean {
    struct lox_literal_base base;
    bool data;
};

struct lox_literal_number {
    struct lox_literal_base base;
    r64 data;
};

struct lox_literal_string {
    struct lox_literal_base base;
    char* data;
};

struct lox_literal_table {
    struct lox_literal_object* object_arr;
    u32 object_arr_fill;
    u32 object_arr_size;

    struct lox_literal_nil* nil_arr;
    u32 nil_arr_fill;
    u32 nil_arr_size;

    struct lox_literal_boolean* boolean_arr;
    u32 boolean_arr_fill;
    u32 boolean_arr_size;

    struct lox_literal_number* number_arr;
    u32 number_arr_fill;
    u32 number_arr_size;

    struct lox_literal_string* string_arr;
    u32 string_arr_fill;
    u32 string_arr_size;

    u64 table_memory_size;
};

void lox_parser__print_literal_table_stats(struct parser* self);

struct lox_literal_base* lox_parser__interpret_expression(struct parser* self, struct parser_expression* expr);

struct lox_literal_object* lox_parser__get_literal__object(
    struct parser* self,
    struct memory_slice value
);

struct lox_literal_nil* lox_parser__get_literal__nil(
    struct parser* self
);

struct lox_literal_boolean* lox_parser__get_literal__boolean(
    struct parser* self,
    bool value
);

struct lox_literal_number* lox_parser__get_literal__number(
    struct parser* self,
    r64 value
);

struct lox_literal_string* lox_parser__get_literal__string(
    struct parser* self,
    char* format, ...
);

// TYPE SYSTEM, LITERAL TABLE START

#endif // LOX_PARSER_H
