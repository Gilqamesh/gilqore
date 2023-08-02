#ifndef LOX_PARSER_H
# define LOX_PARSER_H

# include "lox_parser_defs.h"

# include "compiler/parser/parser.h"

struct token;
struct interpreter;

#define LOX_MAX_NUMBER_OF_FN_ARGUMENTS 255

PUBLIC_API bool lox_parser__clear(struct parser* self);

PUBLIC_API struct parser_ast lox_parser__parse_ast(struct parser* self);
PUBLIC_API bool lox_parser__ast_is_valid(struct parser_ast ast);

PUBLIC_API bool lox_parser__is_finished_parsing(struct parser* self);

PUBLIC_API struct memory_slice lox_parser__convert_expr_to_string(struct expr* expr, struct memory_slice buffer);

// STATEMENTS TYPES, METHODS AND TABLE START

enum lox_parser_statement_type {
    LOX_PARSER_STATEMENT_TYPE_PRINT,
    LOX_PARSER_STATEMENT_TYPE_EXPRESSION,
    LOX_PARSER_STATEMENT_TYPE_VAR_DECL,
    LOX_PARSER_STATEMENT_TYPE_NODE,
    LOX_PARSER_STATEMENT_TYPE_BLOCK,
    LOX_PARSER_STATEMENT_TYPE_IF,
    LOX_PARSER_STATEMENT_TYPE_WHILE,
    LOX_PARSER_STATEMENT_TYPE_BREAK,
    LOX_PARSER_STATEMENT_TYPE_CONTINUE,
    LOX_PARSER_STATEMENT_TYPE_FUN_PARAMS_NODE,
    LOX_PARSER_STATEMENT_TYPE_FUN_DECL,
    LOX_PARSER_STATEMENT_TYPE_RETURN
};

const char* lox_parser__statement_type_to_str(enum lox_parser_statement_type type);

struct lox_stmt_print {
    struct stmt base;
    struct expr* expr;
};

struct lox_stmt_expr {
    struct stmt base;
    struct expr* expr;
};

struct lox_stmt_var_decl {
    struct stmt base;
    struct expr* var_expr;
};

struct lox_stmt_node {
    struct stmt base;
    struct stmt* statement;
    struct lox_stmt_node* next;
};

struct lox_stmt_block {
    struct stmt base;
    struct lox_stmt_node* statement_list;
};

struct lox_stmt_if {
    struct stmt base;
    struct expr* condition;
    struct stmt* then_branch;
    struct stmt* else_branch;
};

struct lox_stmt_while {
    struct stmt base;
    struct expr* condition;
    struct stmt* statement;
};

struct lox_stmt_break {
    struct stmt base;
};

struct lox_stmt_continue {
    struct stmt base;
};

struct lox_stmt_token_node {
    struct stmt base;
    struct token* name;
    struct lox_stmt_token_node* next;
};

struct lox_stmt_return {
    struct stmt base;
    struct expr* expr;
};

struct lox_stmt_fun {
    struct stmt base;
    struct token* name;
    struct lox_stmt_token_node* params;
    struct lox_stmt_block* body;
};

struct lox_statements_table {
    struct lox_stmt_print* print_statements_arr;
    u32 print_statements_arr_fill;
    u32 print_statements_arr_size;

    struct lox_stmt_expr* expression_statements_arr;
    u32 expression_statements_arr_fill;
    u32 expression_statements_arr_size;

    struct lox_stmt_var_decl* var_decl_statements_arr;
    u32 var_decl_statements_arr_fill;
    u32 var_decl_statements_arr_size;

    struct lox_stmt_node* lox_parser_statement_node_arr;
    u32 lox_parser_statement_node_arr_fill;
    u32 lox_parser_statement_node_arr_size;

    struct lox_stmt_block* block_statements_arr;
    u32 block_statements_arr_fill;
    u32 block_statements_arr_size;

    struct lox_stmt_if* if_statements_arr;
    u32 if_statements_arr_fill;
    u32 if_statements_arr_size;

    struct lox_stmt_while* while_statements_arr;
    u32 while_statements_arr_fill;
    u32 while_statements_arr_size;

    struct lox_stmt_break* break_statement;
    
    struct lox_stmt_continue* continue_statement;

    struct lox_stmt_token_node* fun_params_arr;
    u32 fun_params_arr_fill;
    u32 fun_params_arr_size;

    struct lox_stmt_fun* fun_arr;
    u32 fun_arr_fill;
    u32 fun_arr_size;

    struct lox_stmt_return* return_arr;
    u32 return_arr_fill;
    u32 return_arr_size;

    u64 table_memory_size;
};

void lox_parser__print_statements_table_stats(struct parser* self);

struct stmt* lox_parser__get_statement_print(struct parser* self, struct expr* expr);
struct stmt* lox_parser__get_statement_expression(struct parser* self, struct expr* expr);
struct stmt* lox_parser__get_statement_var_decl(struct parser* self, struct expr* var_expr);
struct lox_stmt_node* lox_parser__get_statement_node(struct parser* self, struct stmt* statement);
struct stmt* lox_parser__get_statement_block(struct parser* self, struct lox_stmt_node* statement_list);
struct stmt* lox_parser__get_statement_if(
    struct parser* self,
    struct expr* condition, struct stmt* then_branch, struct stmt* else_branch
);
struct stmt* lox_parser__get_statement_while(
    struct parser* self,
    struct expr* condition, struct stmt* statement
);
struct stmt* lox_parser__get_statement_break(struct parser* self);
struct stmt* lox_parser__get_statement_continue(struct parser* self);
struct lox_stmt_token_node* lox_parser__get_statement_fun_params_node(struct parser* self, struct token* name);
struct stmt* lox_parser__get_statement_fun(
    struct parser* self,
    struct token* name, struct lox_stmt_token_node* params, struct lox_stmt_block* body
);

struct stmt* lox_parser__get_statement_return(struct parser* self, struct expr* expr);

// STATEMENTS TYPES, METHODS AND TABLE END

// EXPRESSION TYPES, METHODS AND TABLE START

enum lox_parser_expression_type {
    LOX_PARSER_EXPRESSION_TYPE_OP_UNARY,
    LOX_PARSER_EXPRESSION_TYPE_OP_BINARY,
    LOX_PARSER_EXPRESSION_TYPE_GROUPING,
    LOX_PARSER_EXPRESSION_TYPE_LITERAL,
    LOX_PARSER_EXPRESSION_TYPE_VAR,
    LOX_PARSER_EXPRESSION_TYPE_LOGICAL,
    LOX_PARSER_EXPRESSION_TYPE_NODE,
    LOX_PARSER_EXPRESSION_TYPE_CALL,
    LOX_PARSER_EXPRESSION_TYPE_LAMBDA
};

const char* lox_parser__expression_type_to_str(enum lox_parser_expression_type expr_type);
char* lox_parser__expression_to_str(struct expr* expr, char* buffer, u32 *buffer_size);

packed_struct(1) lox_expr_unary {
    struct expr base;
    // todo: change these to indices into the tables as it's smaller
    // u32 op_index;
    // u32 expr_index;
    // u32 value_index;
    struct token* op;
    struct expr* expr;

    struct literal* evaluated_literal;
};

packed_struct(1) lox_expr_binary {
    struct expr base;
    struct expr* left;
    struct token* op;
    struct expr* right;

    struct literal* evaluated_literal;
};

packed_struct(1) lox_expr_group {
    struct expr base;
    struct expr* expr;

    struct literal* evaluated_literal;
};

packed_struct(1) lox_expr_literal {
    struct expr base;
    struct token* value;

    struct literal* literal;
};

packed_struct(1) lox_expr_var {
    struct expr base;
    struct token* name;
    struct expr* value;

    struct literal* evaluated_literal;
};

packed_struct(1) lox_expr_logical {
    struct expr base;
    struct expr* left;
    struct token* op;
    struct expr* right;

    struct literal* evaluated_literal;
};

struct lox_expr_node {
    struct expr base;
    struct expr* expression;
    struct lox_expr_node* next;
};

packed_struct(1) lox_expr_call {
    struct expr base;
    struct expr* callee;
    struct token* closing_paren;
    struct lox_expr_node* parameters;
};

struct lox_expr_lambda {
    struct expr base;
    struct stmt* stmt;

    struct literal* evaluated_literal;
};

struct lox_expressions_table {
    struct lox_expr_unary* op_unary_arr;
    u32 op_unary_arr_fill;
    u32 op_unary_arr_size;

    struct lox_expr_binary* op_binary_arr;
    u32 op_binary_arr_fill;
    u32 op_binary_arr_size;

    struct lox_expr_group* grouping_arr;
    u32 grouping_arr_fill;
    u32 grouping_arr_size;

    struct lox_expr_literal* literal_arr;
    u32 literal_arr_fill;
    u32 literal_arr_size;

    struct lox_expr_logical* logical_arr;
    u32 logical_arr_fill;
    u32 logical_arr_size;

    struct lox_expr_node* node_arr;
    u32 node_arr_fill;
    u32 node_arr_size;

    struct lox_expr_call* call_arr;
    u32 call_arr_fill;
    u32 call_arr_size;

    struct lox_expr_var* var_arr;
    u32 var_arr_fill;
    u32 var_arr_size;

    struct lox_expr_lambda* lambda_arr;
    u32 lambda_arr_fill;
    u32 lambda_arr_size;

    u64 table_memory_size;
};

void lox_parser__delete_from_expressions_table(struct parser* self, struct expr* expression);

void lox_parser__print_expressions_table_stats(struct parser* self);

struct expr* lox_parser__copy_expression(struct parser* self, struct expr* expr);

struct expr* lox_parser__get_expr__op_unary(
    struct parser* self,
    struct token* op, struct expr* expr
);
void lox_parser__delete_expr__op_unary(struct parser* self, struct expr* op_unary_expr);

struct expr* lox_parser__get_expr__op_binary(
    struct parser* self,
    struct expr* left, struct token* op, struct expr* right
);
void lox_parser__delete_expr__op_binary(struct parser* self, struct expr* op_binary_expr);

struct expr* lox_parser__get_expr__grouping(struct parser* self, struct expr* expr);
void lox_parser__delete_expr__grouping(struct parser* self, struct expr* grouping_expr);

struct expr* lox_parser__get_expr__literal(struct parser* self, struct token* value);
struct expr* lox_parser__get_expr__literal_true(struct parser* self);
struct expr* lox_parser__get_expr__literal_false(struct parser* self);
struct expr* lox_parser__get_expr__literal_nil(struct parser* self);
void lox_parser__delete_expr__literal(struct parser* self, struct expr* literal_expr);

struct expr* lox_parser__get_expr__logical(
    struct parser* self,
    struct expr* left,
    struct token* op,
    struct expr* right
);
void lox_parser__delete_expr__logical(struct parser* self, struct expr* logical_expr);

struct lox_expr_node* lox_parser__get_expr__node(struct parser* self, struct expr* expr);
struct expr* lox_parser__get_expr__call(
    struct parser* self,
    struct expr* callee, struct token* closing_paren, struct lox_expr_node* parameters
);

struct expr* lox_parser__get_expr__var(
    struct parser* self,
    struct token* name, struct expr* value
);

struct expr* lox_parser__get_expr__lambda(struct parser* self, struct stmt* stmt);

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

typedef struct literal* (*lox_call_fn)(struct interpreter*, struct lox_expr_call*);
struct object_header {
    struct lox_env* env;
    lox_call_fn call;
    u32 arity;
};

struct lox_literal_obj {
    struct literal base;
    struct object_header header;
    struct memory_slice data;
};

packed_struct(1) lox_literal_nil {
    struct literal base;
};

packed_struct(1) lox_literal_bool {
    struct literal base;
    bool data;
};

packed_struct(1) lox_literal_number {
    struct literal base;
    r64 data;
};

packed_struct(1) lox_literal_string {
    struct literal base;
    char* data;
};

struct lox_literal_table {
    struct lox_literal_obj* object_arr;
    u32 object_arr_fill;
    u32 object_arr_size;

    struct lox_literal_nil* nil_literal;

    struct lox_literal_bool* boolean_literal_true;
    struct lox_literal_bool* boolean_literal_false;

    struct lox_literal_number* number_arr;
    u32 number_arr_fill;
    u32 number_arr_size;

    struct lox_literal_string* string_arr;
    u32 string_arr_fill;
    u32 string_arr_size;

    u64 table_memory_size;
};

void lox_parser__print_literal_table_stats(struct parser* self);

struct literal* lox_parser__get_literal__object(
    struct parser* self,
    struct object_header header,
    struct memory_slice value
);
struct literal* lox_parser__get_literal__nil(struct parser* self);
struct literal* lox_parser__get_literal__boolean(struct parser* self, bool value);
struct literal* lox_parser__get_literal__number(struct parser* self, r64 value);
struct literal* lox_parser__get_literal__string(struct parser* self, char* format, ...);

// LITERAL TYPES, METHODS AND TABLE END

#endif // LOX_PARSER_H
