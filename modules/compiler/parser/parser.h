#ifndef PARSER_H
# define PARSER_H

# include "parser_defs.h"

# include "memory/memory.h"

struct tokenizer;
struct tokenizer_token;

struct parser {
    struct memory_slice parser_expression_table;
    bool had_error;
};

struct parser_expression {
    u8 type;
};

PUBLIC_API bool parser__create(struct parser* parser, struct memory_slice internal_buffer);
PUBLIC_API void parser__destroy(struct parser* parser);

// @brief parses tokens and stores the expressions in the table
// @note implement this function for every parser
typedef struct parser_expression* (*parser__parser_fn)(struct parser* self, struct tokenizer* tokenizer);

// @brief allocates and returns the string equivalent of the parsed expression
// @note implement this function for every parser
typedef char* (*parser__convert_to_string_fn)(struct parser_expression* expr, struct memory_slice buffer);

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

#endif // PARSER_H
