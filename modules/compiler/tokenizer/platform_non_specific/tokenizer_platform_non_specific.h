#ifndef TOKENIZER_PLATFORM_NON_SPECIFIC_H
# define TOKENIZER_PLATFORM_NON_SPECIFIC_H

bool tokenizer__add(
    struct tokenizer* self,
    const char* lexeme,
    u32 lexeme_len,
    u32 token_type,
    u32 line
);

void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
);

#endif // TOKENIZER_PLATFORM_NON_SPECIFIC_H
