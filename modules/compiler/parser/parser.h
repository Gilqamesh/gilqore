#ifndef PARSER_H
# define PARSER_H

# include "parser_defs.h"

# include "compiler/tokenizer/tokenizer.h"
# include "memory/memory.h"

struct parser {
    struct memory_slice internal_buffer;

    struct tokenizer* tokenizer;
    u32 token_index;

    u32 env_id;

    bool had_syntax_error;

    bool had_runtime_error;
    // todo: write into this instead of printing in 'parser__runtime_error'
    char runtime_error[256];
};

struct parser_expression {
    u8 type;
};

struct parser_literal {
    u8 type;
};

struct parser_statement {
    u8 type;
};

PUBLIC_API bool parser__create(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct memory_slice internal_buffer
);
PUBLIC_API void parser__destroy(struct parser* self);

// @note implement this function for every parser
typedef bool (*parser__clear)(struct parser* self);

// @brief parses tokens, stores the statements and expressions
// @returns next statement or NULL if reached EOF
// @note implement this function for every parser
typedef struct parser_statement* (*parser__parse_statement)(struct parser* self);

// @brief evaluates a statement
// @note implement this function for every parser
typedef void (*parser__evaluate_statement)(struct parser* self, struct parser_statement* statement);

// @returns true if parsed all tokens
// @note implement this function for every parser
typedef bool (*parser__is_finished_parsing)(struct parser* self);

// @brief stores the string representation of the expression in the buffer
// @returns end memory after writing into the buffer
// @note implement this function for every parser
typedef struct memory_slice (*parser__convert_expr_to_string)(struct parser_expression* expr, struct memory_slice buffer);

// @brief evaluates an expression
// @note implement this function for every parser
typedef void (*parser__evaluate_expr)(struct parser* self, struct parser_expression* expr);

PUBLIC_API void parser__syntax_error(
    struct parser* self,
    const char* message, ...
);

PUBLIC_API void parser__syntax_verror(
    struct parser* self,
    const char* message, va_list ap
);

PUBLIC_API void parser__runtime_error(
    struct parser* self,
    const char* format, ...
);

#endif // PARSER_H
