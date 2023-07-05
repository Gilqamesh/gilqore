#include "compiler/tokenizer/tokenizer.h"

#include "memory/memory.h"
#include "libc/libc.h"

u32 tokenizer__occurance_counter(struct tokenizer* self, struct tokenizer_token* token) {
    ASSERT(token->type < self->tokens_metadata_size);
    return self->tokens_metadata[token->type].number_of_tokens;
}

bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice internal_memory
) {
    self->had_error = false;

    u64 internal_memory_size = memory_slice__size(&internal_memory);
    u32 tokens_metadata_size = 1 << TOKENIZER_TOKEN_TYPE_BITS;
    u32 tokens_metadata_memory_size = tokens_metadata_size * sizeof(struct tokenizer_token_type_metadata);
    self->tokens_metadata_size = tokens_metadata_size;
    if (internal_memory_size < tokens_metadata_memory_size) {
        return false;
    }
    self->tokens_metadata = memory_slice__memory(&internal_memory);

    u32 remaining_memory_for_tokens = internal_memory_size - tokens_metadata_memory_size;
    self->tokens_fill = 0;
    self->tokens_size = remaining_memory_for_tokens / sizeof(*self->tokens);
    if (self->tokens_size == 0) {
        return false;
    }
    self->tokens = (void*) ((char*) memory_slice__memory(&internal_memory) + tokens_metadata_memory_size);

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
    if (
        self->tokens_fill == self->tokens_size ||
        (1 << TOKENIZER_TOKEN_TYPE_BITS) <= token_type
    ) {
        // error_code__exit(CAPACITY_REACHED_IN_ADD);
        error_code__exit(3492);
    }

    self->tokens[self->tokens_fill].lexeme = lexeme;
    self->tokens[self->tokens_fill].lexeme_len = lexeme_len;
    self->tokens[self->tokens_fill].type = token_type;
    self->tokens[self->tokens_fill].line = line;
    ++self->tokens_fill;

    ++self->tokens_metadata[token_type].number_of_tokens;

    return true;
}

void tokenizer__clear(struct tokenizer* self) {
    self->tokens_fill = 0;
    self->had_error = false;
    libc__memset(
        self->tokens_metadata,
        0,
        self->tokens_metadata_size * sizeof(*self->tokens_metadata)
    );
}

void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
) {
    va_list ap;

    va_start(ap, message);
    tokenizer__verror(self, line, message, ap);
    va_end(ap);
}

PUBLIC_API void tokenizer__verror(
    struct tokenizer* self,
    u32 line,
    const char* format, va_list ap
) {
    self->had_error = true;

    libc__printf("%u | Error: ", line);

    libc__vprintf(format, ap);
    
    libc__printf("\n");
}
