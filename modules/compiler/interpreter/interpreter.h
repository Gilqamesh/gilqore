#ifndef INTERPRETER_H
# define INTERPRETER_H

# include "interpreter_defs.h"

# include "compiler/tokenizer/tokenizer.h"
# include "compiler/parser/parser.h"

struct memory_slice;

enum interpreter_type {
    INTERPRETER_TYPE_COMMENT,
    INTERPRETER_TYPE_LOX
};

struct interpreter {
    struct tokenizer tokenizer;
    tokenizer__tokenizer_fn tokenizer_fn;
    token__convert_token_to_string_fn convert_token_to_string_fn;

    struct parser parser;
    parser__clear parser_clear;
    parser__parse_statement parser_parse_statement;
    parser__is_finished_parsing parser_is_finished_parsing;
    parser__convert_expr_to_string parser_convert_expr_to_string;

    u32 env_id;
    interpreter__interpret_statement parser_evaluate_statement;
};

PUBLIC_API bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
);
PUBLIC_API void interpreter__destroy(struct interpreter* self);

PUBLIC_API bool interpreter__run_file(struct interpreter* self, const char* path);
PUBLIC_API void interpreter__run_prompt(struct interpreter* self);

// @brief evaluates a statement
// @note implement this function for every interpreter
typedef void (*interpreter__interpret_statement)(struct interpreter* self, struct parser_statement* statement);

void interpreter__print_tokens(struct interpreter* self);

#endif // INTERPRETER_H
