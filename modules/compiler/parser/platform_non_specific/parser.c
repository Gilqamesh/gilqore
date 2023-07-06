#include "compiler/parser/parser.h"

#include "compiler/tokenizer/tokenizer.h"

#include "libc/libc.h"

bool parser__create(struct parser* parser, struct memory_slice internal_buffer) {
    parser->internal_buffer = internal_buffer;
    parser->had_error = false;
    parser->had_runtime_error = false;
    parser->token_index = 0;

    return true;
}

void parser__destroy(struct parser* parser) {
    (void) parser;
}

void parser__error(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct tokenizer_token* token,
    const char* message, ...
) {
    va_list ap;

    va_start(ap, message);
    parser__verror(self, tokenizer, token, message, ap);
    va_end(ap);
}

void parser__verror(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct tokenizer_token* token,
    const char* message, va_list ap
) {
    self->had_error = true;
    u32 token_line = token ? token->line : 0;
    tokenizer__verror(tokenizer, token_line, message, ap);
}

void parser__runtime_error(struct parser* self, const char* format, ...) {
    self->had_runtime_error = true;
    va_list ap;

    libc__printf("Runtime error: ");

    va_start(ap, format);
    libc__vprintf(format, ap);
    va_end(ap);

    libc__printf("\n");
}
