#ifndef PARSER_H
# define PARSER_H

# include "parser_defs.h"

# include "compiler/tokenizer/tokenizer.h"
# include "memory/memory.h"

struct parser {
    struct memory_slice internal_buffer;

    struct tokenizer* tokenizer;
    u32 token_index;

    bool had_syntax_error;

    bool had_runtime_error;
    // todo: write into this instead of printing in 'parser__runtime_error'
    char runtime_error[256];
};

struct expr {
    u8 type;
};

struct literal {
    u8 type;
};

struct stmt {
    u8 type;
};

struct parser_ast {
    struct stmt* statement;
};

PUBLIC_API bool parser__create(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct memory_slice internal_buffer
);
PUBLIC_API void parser__destroy(struct parser* self);

// @note implement this function for every parser
typedef bool (*parser__clear)(struct parser* self);

// @brief parses the tokens received from the tokenizer
// @returns next ast parsed or NULL if nothing more to parse
// @note implement this function for every parser
typedef struct parser_ast (*parser__parse_ast)(struct parser* self);

// @returns true if the ast is valid
// @note implement this function for every parser
typedef bool (*parser__ast_is_valid)(struct parser_ast ast);

// @brief prints the ast
// @note implement this function for every parser
typedef void (*parser__ast_print)(struct parser_ast ast);

// @returns true if parsed all tokens
// @note implement this function for every parser
typedef bool (*parser__is_finished_parsing)(struct parser* self);

// @brief stores the string representation of the expression in the buffer
// @returns end memory after writing into the buffer
// @note implement this function for every parser
typedef struct memory_slice (*parser__convert_expr_to_string)(struct expr* expr, struct memory_slice buffer);

PUBLIC_API void parser__syntax_error(
    struct parser* self,
    const char* format, ...
);

PUBLIC_API void parser__syntax_verror(
    struct parser* self,
    const char* format, va_list ap
);

PUBLIC_API void parser__warn_error(
    struct parser* self,
    const char* format, ...
);

PUBLIC_API void parser__warn_verror(
    struct parser* self,
    const char* format, va_list ap
);

#endif // PARSER_H
