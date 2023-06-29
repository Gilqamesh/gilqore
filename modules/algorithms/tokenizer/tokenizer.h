#ifndef TOKENIZER_H
# define TOKENIZER_H

# include "tokenizer_defs.h"

enum token_type {
    UNKNOWN
};

struct token {
    const char* start;
    u32 len;
    enum token_type type;
};

struct tokenizer {
    struct token* tokens;
    u32 tokens_fill;
    u32 tokens_size;
};

struct memory_slice;

PUBLIC_API bool tokenizer__create(
    struct tokenizer* self, struct memory_slice tokens_buffer, u32 max_number_of_tokens
);

#endif // TOKENIZER_H
