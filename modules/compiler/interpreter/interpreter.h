#ifndef INTERPRETER_H
# define INTERPRETER_H

# include "interpreter_defs.h"

# include "compiler/tokenizer/tokenizer.h"
# include "compiler/parser/parser.h"

struct memory_slice;

enum interpreter_type {
    INTERPRETER_TYPE_COMMENT,
    INTERPRETER_TYPE_C,
    INTERPRETER_TYPE_LOX
};

// @brief interprets an expression
// @note implement this function for every parser (todo: for every interpreter)
typedef void (*interpreter__interpret_expr_fn)(struct parser* self, struct parser_expression* expr);

struct interpreter {
    struct tokenizer tokenizer;
    tokenizer__tokenizer_fn tokenizer_fn;
    token__convert_token_to_string_fn convert_token_to_string_fn;

    struct parser parser;
    parser__token_parser_fn token_parser_fn;
    parser__convert_expr_to_string_fn convert_expr_to_string_fn;

    interpreter__interpret_expr_fn interpret_expr_fn;
};

PUBLIC_API bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
);
PUBLIC_API void interpreter__destroy(struct interpreter* self);

PUBLIC_API bool interpreter__run_file(struct interpreter* self, const char* path);
PUBLIC_API void interpreter__run_prompt(struct interpreter* self);

void interpreter__print_tokens(struct interpreter* self);

#endif // INTERPRETER_H
