#include "lox_parse_state.h"

#include "compiler/tokenizer/tokenizer.h"
#include "compiler/parser/parser.h"

#include "libc/libc.h"

bool lox_parse_state__is_finished(struct lox_parse_state* self) {
    return self->tokenizer->tokens[self->parser->token_index].type == LOX_TOKEN_EOF;
}

enum lox_token_type lox_parse_state__peek(struct lox_parse_state* self) {
    return self->tokenizer->tokens[self->parser->token_index].type;
}

struct tokenizer_token* lox_parse_state__advance(struct lox_parse_state* self) {
    if (lox_parse_state__is_finished(self) == true) {
        return NULL;
    }

    return &self->tokenizer->tokens[self->parser->token_index++];
}

struct tokenizer_token* lox_parse_state__advance_if(struct lox_parse_state* self, enum lox_token_type token_type) {
    return lox_parse_state__peek(self) == token_type ? lox_parse_state__advance(self) : NULL;
}

struct tokenizer_token* lox_parse_state__advance_err(
    struct lox_parse_state* self,
    enum lox_token_type token_type,
    const char* format, ...
) {
    if (lox_parse_state__is_finished(self) == true) {
        return NULL;
    }

    struct tokenizer_token* token = lox_parse_state__advance(self);
    if (token->type != token_type) {
        va_list ap;

        va_start(ap, format);
        parser__verror(self->parser, self->tokenizer, token, format, ap);
        va_end(ap);

        return NULL;
    }

    return token;
}

struct tokenizer_token* lox_parse_state__get_previous(struct lox_parse_state* self) {
    if (self->parser->token_index == 0) {
        return NULL;
    }

    return &self->tokenizer->tokens[self->parser->token_index - 1];
}

void lox_parse_state__advance_till_next_statement(struct lox_parse_state* self) {
    enum lox_token_type token_type;
    while ((token_type = lox_parse_state__peek(self)) != LOX_TOKEN_EOF) {
        switch (token_type) {
            case LOX_TOKEN_CLASS:
            case LOX_TOKEN_FUN:
            case LOX_TOKEN_VAR:
            case LOX_TOKEN_FOR:
            case LOX_TOKEN_IF:
            case LOX_TOKEN_WHILE:
            case LOX_TOKEN_PRINT:
            case LOX_TOKEN_RETURN: {
                return ;
            } break ;
            default:
        }

        (void) lox_parse_state__advance(self);
    }
}

void lox_parse_state__reached_end_error(struct lox_parse_state* self, const char* format, ...) {
    struct tokenizer_token* previous_token = lox_parse_state__get_previous(self);

    va_list ap;

    va_start(ap, format);
    parser__verror(self->parser, self->tokenizer, previous_token, format, ap);
    va_end(ap);
}
