#include "algorithms/tokenizer/tokenizer.h"

#include "memory/memory.h"

bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice tokens_memory
) {
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

bool tokenizer__add(struct tokenizer* self, struct token token) {
    if (self->tokens_fill == self->tokens_size) {
        // error_code__exit(CAPACITY_REACHED_IN_ADD);
        error_code__exit(3492);
    }

    self->tokens[self->tokens_fill].end = token.end;
    self->tokens[self->tokens_fill].len = token.len;
    self->tokens[self->tokens_fill].type = token.type;
    ++self->tokens_fill;

    return true;
}

u32 tokenizer__fill(struct tokenizer* self) {
    return self->tokens_fill;
}

u32 tokenizer__size(struct tokenizer* self) {
    return self->tokens_size;
}

void tokenizer__clear(struct tokenizer* self) {
    self->tokens_fill = 0;
}
