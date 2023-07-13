INLINE static void lox_tokenize_state__dispatch_text(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__advance(self);

    switch (c) {
        case '/': {
            self->state = STATE_SLASH;
        } break ;
        case '"': {
            // note: remove '"' from the beginning of the string token
            self->token_len = 0;
            self->state = STATE_INQUOTE;
        } break ;
        case '(': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_LEFT_PAREN);
        } break ;
        case ')': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_RIGHT_PAREN);
        } break ;
        case '{': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_LEFT_BRACE);
        } break ;
        case '}': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_RIGHT_BRACE);
        } break ;
        case ',': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_COMMA);
        } break ;
        case '.': {
            self->state = STATE_DOT;
        } break ;
        case '-': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_MINUS);
        } break ;
        case '+': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_PLUS);
        } break ;
        case ';': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_SEMICOLON);
        } break ;
        case '*': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_STAR);
        } break ;
        case '!': {
            self->state = STATE_EXCLAM;
        } break ;
        case '=': {
            self->state = STATE_EQUAL;
        } break ;
        case '<': {
            self->state = STATE_LESS_THAN;
        } break ;
        case '>': {
            self->state = STATE_GREATER_THAN;
        } break ;
        case '?': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_QUESTION_MARK);
        } break ;
        case '%': {
            lox_tokenize_state__add_token(self, LOX_TOKEN_PERCENTAGE);
        } break ;
        case ':': {
            self->state = STATE_COLON;
        } break ;
        case ' ':
        case '\t':
        case '\r': {
            self->token_len = 0;
        } break ;
        case '\n': {
            self->token_len = 0;
            ++self->line;
        } break ;
        default: {
            if (libc__isdigit(c)) {
                self->state = STATE_NUMBER;
            } else if (libc__isalpha(c) || c == '_') {
                self->state = STATE_IDENTIFIER;
            } else {
                self->token_len = 0;
                tokenizer__error(self->tokenizer, self->line, "Unexpected character: '%c'.", c);
            }
        }
    }
}

INLINE static void lox_tokenize_state__dispatch_slash(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, '/')) {
        self->token_len = 0;
        self->state = STATE_LINECOMMENT;
    } else if (lox_tokenize_state__advance_if(self, '*')) {
        self->token_len = 0;
        self->state = STATE_BLOCKCOMMENT;
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_SLASH);
        self->state = STATE_TEXT;
    }
}

INLINE static void lox_tokenize_state__dispatch_linecomment(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__peek(self);
    if (c == '\n') {
        lox_tokenize_state__add_token(self, LOX_TOKEN_COMMENT);
        ++self->line;
        self->state = STATE_TEXT;
        lox_tokenize_state__advance(self);
        self->token_len = 0;
    } else {
        lox_tokenize_state__advance(self);
    }
}

INLINE static void lox_tokenize_state__dispatch_blockcomment(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__advance(self);

    if (c == '*') {
        self->state = STATE_BLOCKSTAR;
    }
}

INLINE static void lox_tokenize_state__dispatch_blockstar(struct lox_tokenize_state* self) {

    if (lox_tokenize_state__peek(self) == '/') {
        // note: remove * char
        lox_tokenize_state__reverse(self);
        lox_tokenize_state__add_token(self, LOX_TOKEN_COMMENT);
        lox_tokenize_state__advance(self);

        lox_tokenize_state__advance(self);
        self->token_len = 0;
        self->state = STATE_TEXT;
    } else {
        self->state = STATE_BLOCKCOMMENT;
    }
}

INLINE static void lox_tokenize_state__dispatch_inquote(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__advance(self);

    if (c == '"') {
        // note: remove '"'
        lox_tokenize_state__reverse(self);
        lox_tokenize_state__add_token(self, LOX_TOKEN_STRING);
        lox_tokenize_state__advance(self);

        self->state = STATE_TEXT;
    } else if (c == '\\') {
        self->state = STATE_ESCAPE;
    } else if (c == '\n') {
        // note: allow multiline comments
        ++self->line;
    }
}

INLINE static void lox_tokenize_state__dispatch_escape(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__advance(self);
    (void) c;

    self->state = STATE_INQUOTE;
}

INLINE static void lox_tokenize_state__dispatch_exclam(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, '=')) {
        lox_tokenize_state__add_token(self, LOX_TOKEN_EXCLAM_EQUAL);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_EXCLAM);
    }

    self->state = STATE_TEXT;
}

INLINE static void lox_tokenize_state__dispatch_equal(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, '=')) {
        lox_tokenize_state__add_token(self, LOX_TOKEN_EQUAL_EQUAL);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_EQUAL);
    }

    self->state = STATE_TEXT;
}

INLINE static void lox_tokenize_state__dispatch_less_than(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, '=')) {
        lox_tokenize_state__add_token(self, LOX_TOKEN_LESS_EQUAL);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_LESS);
    }

    self->state = STATE_TEXT;
}

INLINE static void lox_tokenize_state__dispatch_greater_than(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, '=')) {
        lox_tokenize_state__add_token(self, LOX_TOKEN_GREATER_EQUAL);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_GREATER);
    }

    self->state = STATE_TEXT;
}

INLINE static void lox_tokenize_state__dispatch_dot(struct lox_tokenize_state* self) {
    if (libc__isdigit(lox_tokenize_state__peek(self))) {
        lox_tokenize_state__advance(self);
        self->state = STATE_NUMBER;
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_DOT);
        self->state = STATE_TEXT;
    }
}

INLINE static void lox_tokenize_state__dispatch_number(struct lox_tokenize_state* self) {
    if (libc__isdigit(lox_tokenize_state__peek(self))) {
        lox_tokenize_state__advance(self);
    } else if (lox_tokenize_state__advance_if(self, '.')) {
        self->state = STATE_NUMBER_DECIMAL;
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_NUMBER);
        self->state = STATE_TEXT;
    }
}

INLINE static void lox_tokenize_state__dispatch_number_decimal(struct lox_tokenize_state* self) {
    if (libc__isdigit(lox_tokenize_state__peek(self))) {
        lox_tokenize_state__advance(self);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_NUMBER);
        self->state = STATE_TEXT;
    }
}

INLINE static void lox_tokenize_state__dispatch_identifier(struct lox_tokenize_state* self) {
    char c = lox_tokenize_state__peek(self);

    if (libc__isalnum(c) || c == '_') {
        lox_tokenize_state__advance(self);
    } else {
        lox_tokenize_state__add_token(self, lox_tokenize_state__get_identifier_type(self));
        self->state = STATE_TEXT;
    }
}

INLINE static void lox_tokenize_state__dispatch_colon(struct lox_tokenize_state* self) {
    if (lox_tokenize_state__advance_if(self, ':')) {
        lox_tokenize_state__add_token(self, LOX_TOKEN_COLON_COLON);
    } else {
        lox_tokenize_state__add_token(self, LOX_TOKEN_COLON);
    }
    self->state = STATE_TEXT;
}
