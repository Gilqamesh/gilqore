#include "lox_tokenize_state.h"

#include "compiler/tokenizer/tokenizer.h"
#include "libc/libc.h"

char lox_tokenize_state__peek(struct lox_tokenize_state* self) {
    return *self->cur_str;
}

char lox_tokenize_state__advance(struct lox_tokenize_state* self) {
    ++self->token_len;
    return *self->cur_str++;
}

bool lox_tokenize_state__advance_if(struct lox_tokenize_state* self, char c) {
    if (lox_tokenize_state__peek(self) == c) {
        lox_tokenize_state__advance(self);
        return true;
    }

    return false;
}

char lox_tokenize_state__step_backward(struct lox_tokenize_state* self) {
    self->token_len = self->token_len > 0 ? self->token_len - 1 : 0;
    return *self->cur_str--;
}

void lox_tokenize_state__add_token(struct lox_tokenize_state* self, enum lox_token_type token_type) {
    tokenizer__add(
        self->tokenizer,
        self->cur_str - self->token_len,
        self->token_len,
        token_type,
        self->line
    );
    self->token_len = 0;
}

enum lox_token_type lox_tokenize_state__get_identifier_type(struct lox_tokenize_state* self) {
    // todo: optimize this method

    struct lox_identifier {
        const char* lexeme;
        enum lox_token_type token_type;
    };

    static struct lox_identifier identifiers[] = {
        { "and", LOX_TOKEN_AND },
        { "class", LOX_TOKEN_CLASS },
        { "else", LOX_TOKEN_ELSE },
        { "false", LOX_TOKEN_FALSE },
        { "fun", LOX_TOKEN_FUN },
        { "for", LOX_TOKEN_FOR },
        { "if", LOX_TOKEN_IF },
        { "nil", LOX_TOKEN_NIL },
        { "or", LOX_TOKEN_OR },
        { "print", LOX_TOKEN_PRINT },
        { "return", LOX_TOKEN_RETURN },
        { "super", LOX_TOKEN_SUPER },
        { "this", LOX_TOKEN_THIS },
        { "true", LOX_TOKEN_TRUE },
        { "var", LOX_TOKEN_VAR },
        { "while", LOX_TOKEN_WHILE }
    };
    for (u32 identifier_index = 0; identifier_index < ARRAY_SIZE(identifiers); ++identifier_index) {
        u32 token_index = 0;
        struct lox_identifier* identifier = &identifiers[identifier_index];
        const char* cur_str = self->cur_str - self->token_len;
        while (
            token_index < self->token_len &&
            identifier->lexeme[token_index] != '\0' &&
            identifier->lexeme[token_index] == *cur_str++
        ) {
            ++token_index;
        }
        if (
            token_index == self->token_len &&
            identifier->lexeme[token_index] == '\0'
        ) {
            return identifier->token_type;
        }
    }

    return LOX_TOKEN_IDENTIFIER;
}

bool lox_tokenize_state__is_finished(struct lox_tokenize_state* self) {
    return *self->cur_str == '\0';
}

#include "lox_tokenize_state.inl"

void lox_tokenize_state__process_token(struct lox_tokenize_state* self) {
    switch (self->state) {
        case STATE_TEXT: {
            lox_tokenize_state__dispatch_text(self);
        } break ;
        case STATE_EXCLAM: {
            lox_tokenize_state__dispatch_exclam(self);
        } break ;
        case STATE_SLASH: {
            lox_tokenize_state__dispatch_slash(self);
        } break ;
        case STATE_LINECOMMENT: {
            lox_tokenize_state__dispatch_linecomment(self);
        } break ;
        case STATE_BLOCKCOMMENT: {
            lox_tokenize_state__dispatch_blockcomment(self);
        } break ;
        case STATE_BLOCKSTAR: {
            lox_tokenize_state__dispatch_blockstar(self);
        } break ;
        case STATE_INQUOTE: {
            lox_tokenize_state__dispatch_inquote(self);
        } break ;
        case STATE_ESCAPE: {
            lox_tokenize_state__dispatch_escape(self);
        } break ;
        case STATE_EQUAL: {
            lox_tokenize_state__dispatch_equal(self);
        } break ;
        case STATE_LESS_THAN: {
            lox_tokenize_state__dispatch_less_than(self);
        } break ;
        case STATE_GREATER_THAN: {
            lox_tokenize_state__dispatch_greater_than(self);
        } break ;
        case STATE_DOT: {
            lox_tokenize_state__dispatch_dot(self);
        } break ;
        case STATE_NUMBER: {
            lox_tokenize_state__dispatch_number(self);
        } break ;
        case STATE_NUMBER_DECIMAL: {
            lox_tokenize_state__dispatch_number_decimal(self);
        } break ;
        case STATE_IDENTIFIER: {
            lox_tokenize_state__dispatch_identifier(self);
        } break ;
        case STATE_COLON: {
            lox_tokenize_state__dispatch_colon(self);
        } break ;
        default: {
        }
    }
}

char lox_tokenize_state__reverse(struct lox_tokenize_state* self) {
    self->token_len = self->token_len > 0 ? self->token_len - 1 : 0;
    return *--self->cur_str;
}

const char* lox_tokenize_state__state_name(enum lox_tokenizer_state state) {
    switch (state) {
        case STATE_TEXT: {
            return "text";
        } break ;
        case STATE_SLASH: {
            return "slash";
        } break ;
        case STATE_LINECOMMENT: {
            return "line comment";
        } break ;
        case STATE_BLOCKCOMMENT: {
            return "block comment";
        } break ;
        case STATE_BLOCKSTAR: {
            return "block star";
        } break ;
        case STATE_INQUOTE: {
            return "inquote";
        } break ;
        case STATE_ESCAPE: {
            return "escape";
        } break ;
        case STATE_EQUAL: {
            return "equal";
        } break ;
        case STATE_LESS_THAN: {
            return "less than";
        } break ;
        case STATE_GREATER_THAN: {
            return "greater than";
        } break ;
        case STATE_DOT: {
            return "dot";
        } break ;
        case STATE_NUMBER: {
            return "number";
        } break ;
        case STATE_NUMBER_DECIMAL: {
            return "number decimal";
        } break ;
        case STATE_IDENTIFIER: {
            return "identifier";
        } break ;
        case STATE_EXCLAM: {
            return "exclam";
        } break ;
        default: return "unknown";
    }
}
