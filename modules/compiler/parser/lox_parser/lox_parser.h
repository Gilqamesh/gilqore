#ifndef LOX_PARSER_H
# define LOX_PARSER_H

# include "lox_parser_defs.h"

# include "compiler/parser/parser.h"

struct tokenizer_token;

PUBLIC_API bool lox_parser__clear(struct parser* self);

PUBLIC_API struct parser_statement* lox_parser__parse_statement(struct parser* self);

PUBLIC_API void lox_parser__evaluate_statement(struct parser* self, struct parser_statement* statement);

PUBLIC_API bool lox_parser__is_finished_parsing(struct parser* self);

PUBLIC_API struct memory_slice lox_parser__convert_expr_to_string(struct parser_expression* expr, struct memory_slice buffer);

PUBLIC_API void lox_parser__interpret_expr(struct parser* self, struct parser_expression* expr);


// STATEMENTS TYPES, METHODS AND TABLE START

enum lox_parser_statement_type {
    LOX_PARSER_STATEMENT_TYPE_PRINT,
    LOX_PARSER_STATEMENT_TYPE_EXPRESSION,
    LOX_PARSER_STATEMENT_TYPE_VAR_DECL,
    LOX_PARSER_STATEMENT_TYPE_NODE,
    LOX_PARSER_STATEMENT_TYPE_BLOCK
};

const char* lox_parser__statement_type_to_str(enum lox_parser_statement_type type);

packed_struct(1) lox_parser_statement_print {
    struct parser_statement base;
    struct parser_expression* expr;
};

packed_struct(1) lox_parser_statement_expression {
    struct parser_statement base;
    struct parser_expression* expr;
};

packed_struct(1) lox_parser_statement_var_decl {
    struct parser_statement base;
    struct parser_expression* var_expr;
};

packed_struct(1) lox_parser_statement_node {
    struct parser_statement base;
    struct parser_statement* statement;
    struct lox_parser_statement_node* next;
};

packed_struct(1) lox_parser_statement_block {
    struct parser_statement base;
    struct lox_parser_statement_node* statement_list;
};

struct lox_statements_table {
    struct lox_parser_statement_print* print_statements_arr;
    u32 print_statements_arr_fill;
    u32 print_statements_arr_size;

    struct lox_parser_statement_expression* expression_statements_arr;
    u32 expression_statements_arr_fill;
    u32 expression_statements_arr_size;

    struct lox_parser_statement_var_decl* var_decl_statements_arr;
    u32 var_decl_statements_arr_fill;
    u32 var_decl_statements_arr_size;

    struct lox_parser_statement_node* lox_parser_statement_node_arr;
    u32 lox_parser_statement_node_arr_fill;
    u32 lox_parser_statement_node_arr_size;

    struct lox_parser_statement_block* block_statements_arr;
    u32 block_statements_arr_fill;
    u32 block_statements_arr_size;

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

struct lox_parser_statement_var_decl* lox_parser__get_statement_var_decl(
    struct parser* self,
    struct parser_expression* var_expr
);

struct lox_parser_statement_node* lox_parser__get_statement_node(
    struct parser* self,
    struct parser_statement* statement
);

struct lox_parser_statement_block* lox_parser__get_statement_block(
    struct parser* self,
    struct lox_parser_statement_node* statement_node
);

// STATEMENTS TYPES, METHODS AND TABLE END

// EXPRESSION TYPES, METHODS AND TABLE START

enum lox_parser_expression_type {
    LOX_PARSER_EXPRESSION_TYPE_OP_UNARY,
    LOX_PARSER_EXPRESSION_TYPE_OP_BINARY,
    LOX_PARSER_EXPRESSION_TYPE_GROUPING,
    LOX_PARSER_EXPRESSION_TYPE_LITERAL,
    LOX_PARSER_EXPRESSION_TYPE_VAR
};

const char* lox_parser__expression_type_to_str(enum lox_parser_expression_type expr_type);

packed_struct(1) lox_parser_expr_op_unary {
    struct parser_expression base;
    // todo: change these to indices into the tables as it's smaller
    // u32 op_index;
    // u32 expr_index;
    // u32 value_index;
    struct tokenizer_token* op;
    struct parser_expression* expr;

    struct parser_literal* evaluated_literal;
};

packed_struct(1) lox_parser_expr_op_binary {
    struct parser_expression base;
    struct parser_expression* left;
    struct tokenizer_token* op;
    struct parser_expression* right;

    struct parser_literal* evaluated_literal;
};

packed_struct(1) lox_parser_expr_grouping {
    struct parser_expression base;
    struct parser_expression* expr;

    struct parser_literal* evaluated_literal;
};

packed_struct(1) lox_parser_expr_literal {
    struct parser_expression base;
    struct tokenizer_token* value;

    struct parser_literal* literal;
};

packed_struct(1) lox_parser_expr_var {
    struct parser_expression base;
    u16 env_index;
    struct tokenizer_token* name;
    struct parser_expression* value;

    struct parser_literal* evaluated_literal;
};

struct lox_var_environment {
    struct lox_parser_expr_var* var_expressions_arr;
    struct lox_var_environment* parent;
    struct lox_var_environment* next;

    u32 var_expressions_arr_fill;
    u32 var_expressions_arr_size;
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

    // ENVIRONMENT START
    u32 var_environment_memory_size; // size of one env
    struct lox_var_environment* var_env_arr;
    u32 var_env_arr_fill;
    u32 var_env_arr_size;

    struct lox_var_environment* var_env_pool_free_list;
    struct lox_var_environment* var_env_pool_arr;
    u32 var_env_pool_arr_fill;
    u32 var_env_pool_arr_size;

    // ENVIRONMENT END

    u64 table_memory_size;
};

void lox_parser__delete_from_expressions_table(
    struct parser* self,
    struct lox_var_environment* env,
    struct parser_expression* expression
);

void lox_parser__print_expressions_table_stats(struct parser* self);

struct lox_parser_expr_op_unary* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct tokenizer_token* op,
    struct parser_expression* expr
);
void lox_parser__delete_expr__op_unary(struct parser* self, struct lox_parser_expr_op_unary* op_unary_expr);

struct lox_parser_expr_op_binary* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct parser_expression* left,
    struct tokenizer_token* op,
    struct parser_expression* right
);
void lox_parser__delete_expr__op_binary(struct parser* self, struct lox_parser_expr_op_binary* op_binary_expr);

struct lox_parser_expr_grouping* lox_parser__get_expr__grouping(
    struct parser* self,
    struct parser_expression* expr
);
void lox_parser__delete_expr__grouping(struct parser* self, struct lox_parser_expr_grouping* grouping_expr);

struct lox_parser_expr_literal* lox_parser__get_expr__literal(
    struct parser* self,
    struct tokenizer_token* value
);
void lox_parser__delete_expr__literal(struct parser* self, struct lox_parser_expr_literal* literal_expr);

struct lox_var_environment* lox_parser__get_environment(struct parser* self);
struct lox_var_environment* lox_var_environment__push(struct parser* self);

struct lox_var_environment* lox_var_environment__get_from_pool(struct parser* self);
void lox_var_environment__put_to_pool(struct parser* self, struct lox_var_environment* env);

struct lox_parser_expr_var* lox_parser__get_expr__var(
    struct parser* self,
    struct tokenizer_token* var_name
);
struct lox_parser_expr_var* lox_parser__set_expr__var(
    struct parser* self,
    struct tokenizer_token* var_name,
    struct parser_expression* var_value
);
// EXPRESSION TYPES, METHODS AND TABLE END

// LITERAL TYPES, METHODS AND TABLE START

enum lox_literal_type {
    LOX_LITERAL_TYPE_OBJECT,
    LOX_LITERAL_TYPE_NIL,
    LOX_LITERAL_TYPE_BOOLEAN,
    LOX_LITERAL_TYPE_NUMBER,
    LOX_LITERAL_TYPE_STRING
};

const char* lox_parser__literal_type_to_str(enum lox_literal_type literal_type);

packed_struct(1) lox_literal_object {
    struct parser_literal base;
    struct memory_slice data;
};

packed_struct(1) lox_literal_nil {
    struct parser_literal base;
};

packed_struct(1) lox_literal_boolean {
    struct parser_literal base;
    bool data;
};

packed_struct(1) lox_literal_number {
    struct parser_literal base;
    r64 data;
};

packed_struct(1) lox_literal_string {
    struct parser_literal base;
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

struct parser_literal* lox_parser__evaluate_expression(struct parser* self, struct parser_expression* expr);

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

// LITERAL TYPES, METHODS AND TABLE START

#endif // LOX_PARSER_H
