#include "compiler/tokenizer/tokenizer.h"

#include "memory/memory.h"
#include "libc/libc.h"

void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
) {
    self->had_error = true;

    va_list ap;

    libc__printf("%u | Error: ", line);

    va_start(ap, message);
    libc__vprintf(message, ap);
    va_end(ap);

    libc__printf("\n");
}

bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice tokens_memory
) {
    self->had_error = false;
    self->tokens_fill = 0;
    self->tokens_size = memory_slice__size(&tokens_memory) / sizeof(*self->tokens);
    if (self->tokens_size == 0) {
        return false;
    }

    self->tokens = (struct token*) memory_slice__memory(&tokens_memory);

    return true;
}

void tokenizer__destroy(struct tokenizer* self) {
    (void) self;
}

bool tokenizer__add(
    struct tokenizer* self,
    const char* lexeme,
    u32 lexeme_len,
    u32 token_type,
    u32 line
) {
    if (self->tokens_fill == self->tokens_size) {
        // error_code__exit(CAPACITY_REACHED_IN_ADD);
        error_code__exit(3492);
    }

    self->tokens[self->tokens_fill].lexeme = lexeme;
    self->tokens[self->tokens_fill].lexeme_len = lexeme_len;
    self->tokens[self->tokens_fill].type = token_type;
    self->tokens[self->tokens_fill].line = line;
    ++self->tokens_fill;

    return true;
}

void tokenizer__clear(struct tokenizer* self) {
    self->tokens_fill = 0;
    self->had_error = false;
}
