INLINE static void tokenize_state__dispatch_text(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    switch (c) {
        case '/': {
            self->state = STATE_SLASH;
        } break ;
        case '"': {
            self->state = STATE_INQUOTE;
        } break ;
        case '(': {
            tokenize_state__add_token(self, LOX_TOKEN_LEFT_PAREN);
        } break ;
        case ')': {
            tokenize_state__add_token(self, LOX_TOKEN_RIGHT_PAREN);
        } break ;
        case '{': {
            tokenize_state__add_token(self, LOX_TOKEN_LEFT_BRACE);
        } break ;
        case '}': {
            tokenize_state__add_token(self, LOX_TOKEN_RIGHT_BRACE);
        } break ;
        case ',': {
            tokenize_state__add_token(self, LOX_TOKEN_COMMA);
        } break ;
        case '.': {
            tokenize_state__add_token(self, LOX_TOKEN_DOT);
        } break ;
        case '-': {
            tokenize_state__add_token(self, LOX_TOKEN_MINUS);
        } break ;
        case '+': {
            tokenize_state__add_token(self, LOX_TOKEN_PLUS);
        } break ;
        case ';': {
            tokenize_state__add_token(self, LOX_TOKEN_COMMA);
        } break ;
        case '*': {
            tokenize_state__add_token(self, LOX_TOKEN_STAR);
        } break ;
        case '\n': {
            self->token_len = 0;
            ++self->line;
        } break ;
        case '!': {
            self->state = STATE_EXCLAM;
        } break ;
        default: {
            tokenizer__error(self->tokenizer, self->line, "Unexpected character: '%c'.", c);
        }
    }
}

INLINE static void tokenize_state__dispatch_slash(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '/') {
        self->state = STATE_LINECOMMENT;
    } else if (c == '*') {
        self->state = STATE_BLOCKCOMMENT;
    } else {
        self->state = STATE_TEXT;
    }
}

INLINE static void tokenize_state__dispatch_linecomment(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '\n') {
        tokenize_state__add_token(self, LOX_TOKEN_COMMENT);
        ++self->line;
        self->state = STATE_TEXT;
    } else {
        ++self->token_len;
    }
}

INLINE static void tokenize_state__dispatch_blockcomment(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '*') {
        self->state = STATE_BLOCKSTAR;
    } else {
        ++self->token_len;
    }
}

INLINE static void tokenize_state__dispatch_blockstart(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '/') {
        tokenize_state__add_token(self, LOX_TOKEN_COMMENT);
        self->state = STATE_TEXT;
    } else {
        ++self->token_len;
        ++self->token_len;
        self->state = STATE_BLOCKCOMMENT;
    }
}

INLINE static void tokenize_state__dispatch_inquote(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '"') {
        self->state = STATE_TEXT;
    } else if (c == '\\') {
        self->state = STATE_ESCAPE;
    }
}

INLINE static void tokenize_state__dispatch_escape(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '"') {
        self->state = STATE_INQUOTE;
    } else {
        self->state = STATE_INQUOTE;
    }
}

INLINE static void tokenize_state__dispatch_exclam(struct tokenize_state* self) {
    char c = tokenize_state__step_forward(self);

    if (c == '=') {
        tokenize_state__step_backward(self);
        tokenize_state__add_token(self, LOX_TOKEN_EXCLAM_EQUAL);
    } else {
        tokenize_state__add_token(self, LOX_TOKEN_EXCLAM);
    }

    self->state = STATE_TEXT;
}
