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

struct interpreter;

// @brief evaluates the ast
// @note implement this function for every interpreter
typedef void (*interpreter__interpret_ast)(struct interpreter* self, struct parser_ast ast);

// @brief initializes itself
// @note implement this function for every interpreter
typedef bool (*interpreter__initialize)(struct interpreter* self, struct memory_slice internal_buffer);

struct interpreter {
    struct tokenizer tokenizer;
    tokenizer__tokenizer_fn tokenizer_fn;
    token__convert_token_to_string_fn convert_token_to_string_fn;

    struct parser parser;
    parser__clear parser_clear;
    parser__parse_ast parser_parse_ast;
    parser__ast_is_valid parser_ast_is_valid;
    parser__is_finished_parsing parser_is_finished_parsing;
    parser__convert_expr_to_string parser_convert_expr_to_string;

    struct memory_slice native_callables_memory;
    u32 native_callables_fill;
    u32 native_callables_size;

    bool had_runtime_error;
    interpreter__interpret_ast interpreter_interpret_ast;
};

PUBLIC_API bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
);
PUBLIC_API void interpreter__destroy(struct interpreter* self);

PUBLIC_API bool interpreter__run_file(struct interpreter* self, const char* path);
PUBLIC_API void interpreter__run_prompt(struct interpreter* self);

void interpreter__runtime_error(
    struct interpreter* self,
    const char* format, ...
);

void interpreter__print_tokens(struct interpreter* self);

#endif // INTERPRETER_H
