#ifndef TOKENIZER_H
# define TOKENIZER_H

# include "tokenizer_defs.h"

# define TOKENIZER_TOKEN_TYPE_BITS 8
# define TOKENIZER_TOKEN_LINE_BITS 24

struct tokenizer_token {
    const char* lexeme; // not null-terminated
    u32 lexeme_len : 32;
    u32 type : TOKENIZER_TOKEN_TYPE_BITS;
    u32 line : TOKENIZER_TOKEN_LINE_BITS;
};

struct tokenizer_token_type_metadata {
    u32 number_of_tokens;
};

struct tokenizer {
    struct tokenizer_token* tokens;
    u32 tokens_fill;
    u32 tokens_size;

    struct tokenizer_token_type_metadata* tokens_metadata;
    u32 tokens_metadata_size; // note: could remove as the size of tokens_metadata is implicitly defined by TOKENIZER_TOKEN_TYPE_BITS

    bool had_error;
};

struct memory_slice;

// @brief returns the name of the token
// @note implement this function for every tokenizer
typedef const char* (*token__convert_token_to_string_fn)(struct tokenizer_token* token);

// @brief parses source and stores the tokens from it
// @note implement this function for every tokenizer
typedef bool (*tokenizer__tokenizer_fn)(struct tokenizer* tokenizer, const char* source);

PUBLIC_API bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice internal_memory
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

// @brief returns the number of occurances of the token at the current stage of tokenization
PUBLIC_API u32 tokenizer__occurance_counter(struct tokenizer* self, struct tokenizer_token* token);

PUBLIC_API void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
);

PUBLIC_API void tokenizer__verror(
    struct tokenizer* self,
    u32 line,
    const char* format, va_list ap
);

#endif // TOKENIZER_H
