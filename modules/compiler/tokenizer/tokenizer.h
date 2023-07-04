#ifndef TOKENIZER_H
# define TOKENIZER_H

# include "tokenizer_defs.h"

struct memory_slice;

struct token {
    const char* lexeme; // not null-terminated
    u32 lexeme_len : 32;
    u32 type : 8;
    u32 line : 24;
};

struct tokenizer {
    struct token* tokens;
    u32 tokens_fill;
    u32 tokens_size;
    bool had_error;
};

// @brief returns the name of the token
// @note implement this function for every tokenizer
typedef const char* (*token__type_name_fn)(struct token* token);

// @brief parses source and stores the tokens from it
// @note implement this function for every tokenizer
typedef bool (*tokenizer__tokenize_fn)(struct tokenizer* tokenizer, const char* source);

PUBLIC_API bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice tokens_memory
);
PUBLIC_API void tokenizer__destroy(struct tokenizer* self);

PUBLIC_API void tokenizer__clear(struct tokenizer* self);

PUBLIC_API bool tokenizer__add(
    struct tokenizer* self,
    const char* lexeme,
    u32 lexeme_len,
    u32 token_type,
    u32 line
);

PUBLIC_API void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
);

#endif // TOKENIZER_H
