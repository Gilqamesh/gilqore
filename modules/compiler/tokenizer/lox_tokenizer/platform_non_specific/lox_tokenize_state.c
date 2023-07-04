#include "lox_tokenize_state.h"

#include "compiler/tokenizer/tokenizer.h"

char tokenize_state__step_forward(struct tokenize_state* self) {
    ++self->token_len;
    return *self->cur_str++;
}

char tokenize_state__step_forward_if(struct tokenize_state* self, bool condition) {
    return condition ? tokenize_state__step_forward(self) : '\0';
}

char tokenize_state__step_backward(struct tokenize_state* self) {
    self->token_len = self->token_len > 0 ? self->token_len - 1 : 0;
    return *self->cur_str--;
}

void tokenize_state__add_token(struct tokenize_state* self, enum lox_token_type token_type) {
    tokenizer__add(
        self->tokenizer,
        self->cur_str - self->token_len,
        self->token_len,
        token_type,
        self->line
    );
    self->token_len = 0;
}

bool tokenize_state__is_finished(struct tokenize_state* self) {
    return *self->cur_str == '\0';
}

#include "lox_tokenize_state.inl"

void tokenize_state__process_token(struct tokenize_state* self) {
    switch (self->state) {
        case STATE_TEXT: {
            tokenize_state__dispatch_text(self);
        } break ;
        case STATE_EXCLAM: {
            tokenize_state__dispatch_exclam(self);
        } break ;
        case STATE_SLASH: {
            tokenize_state__dispatch_slash(self);
        } break ;
        case STATE_LINECOMMENT: {
            tokenize_state__dispatch_linecomment(self);
        } break ;
        case STATE_BLOCKCOMMENT: {
            tokenize_state__dispatch_blockcomment(self);
        } break ;
        case STATE_BLOCKSTAR: {
            tokenize_state__dispatch_blockstart(self);
        } break ;
        case STATE_INQUOTE: {
            tokenize_state__dispatch_inquote(self);
        } break ;
        case STATE_ESCAPE: {
            tokenize_state__dispatch_escape(self);
        } break ;
        default: {
        }
    }
}
