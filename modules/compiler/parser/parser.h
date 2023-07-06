#ifndef PARSER_H
# define PARSER_H

# include "parser_defs.h"

# include "memory/memory.h"

struct tokenizer;
struct tokenizer_token;

struct parser {
    struct memory_slice internal_buffer;

    bool had_error;
    bool had_runtime_error;

    // todo: write into this instead of printing in 'parser__runtime_error'
    char runtime_error[256];
};

struct parser_expression {
    u8 type;
};

PUBLIC_API bool parser__create(struct parser* parser, struct memory_slice internal_buffer);
PUBLIC_API void parser__destroy(struct parser* parser);

// @brief parses tokens and stores the expressions in the table
// @note implement this function for every parser
typedef struct parser_expression* (*parser__token_parser_fn)(struct parser* self, struct tokenizer* tokenizer);

// @brief stores the string representation of the expression in the buffer
// @returns end memory after writing into the buffer
// @note implement this function for every parser
typedef struct memory_slice (*parser__convert_expr_to_string_fn)(struct parser_expression* expr, struct memory_slice buffer);

PUBLIC_API void parser__error(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct tokenizer_token* token,
    const char* message, ...
);

PUBLIC_API void parser__verror(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct tokenizer_token* token,
    const char* message, va_list ap
);

PUBLIC_API void parser__runtime_error(struct parser* self, const char* format, ...);

#endif // PARSER_H
