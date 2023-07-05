#include "compiler/parser/parser.h"

#include "compiler/tokenizer/tokenizer.h"

#include "libc/libc.h"

bool parser__create(struct parser* parser, struct memory_slice internal_buffer) {
    parser->parser_expression_table = internal_buffer;

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
