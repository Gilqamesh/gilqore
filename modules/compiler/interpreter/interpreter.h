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

struct interpreter {
    struct tokenizer tokenizer;
    tokenizer__tokenize_fn tokenizer_tokenize_fn;
    token__type_name_fn token_type_name_fn;

    struct parser parser;
    parser__parser_fn parser_fn;
    parser__convert_to_string_fn parser_convert_to_string_fn;
};

PUBLIC_API bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
);
PUBLIC_API void interpreter__destroy(struct interpreter* self);

PUBLIC_API bool interpreter__run_file(struct interpreter* self, const char* path);
PUBLIC_API void interpreter__run_prompt(struct interpreter* self);

#endif // INTERPRETER_H
