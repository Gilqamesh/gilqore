#include "scanner.h"

#include "libc/libc.h"

// TODO: .2 valid number, 2. valid number

// returns true if reached the end of the source string
static bool       scanner__is_at_end(scanner_t* self);
static token_t    scanner__make_token(scanner_t* self, token_type type);
static token_t    scanner__make_error_token(scanner_t* self, const char* msg);
static char       scanner__peak(scanner_t* self);
static char       scanner__peak_next(scanner_t* self);
static char       scanner__eat(scanner_t* self);
static bool       scanner__eat_if(scanner_t* self, char expected);
static void       scanner__skip_whitespaces(scanner_t* self);
static token_t    scanner__make_string(scanner_t* self);
static token_t    scanner__make_number(scanner_t* self);
static token_t    scanner__make_identifier(scanner_t* self);
static token_type scanner__identifier_type(scanner_t* self);

static bool    is_digit(char c);
static bool    is_alpha(char c);

static bool scanner__is_at_end(scanner_t* self) {
    return scanner__peak(self) == '\0';
}

static token_t scanner__make_token(scanner_t* self, token_type type) {
    token_t result = {
        .lexeme     = self->start,
        .lexeme_len = (u32) (self->top - self->start),
        .type       = type,
        .line_s     = self->line_s,
        .line_e     = self->line_e,
        .col_s      = self->col_s,
        .col_e      = self->col_e
    };

#if defined (DEBUG_TOKEN_TRACE)
    libc__printf("token: %u:%u %u:%u, type = %d, str = [%.*s]\n", result.line_s, result.col_s, result.line_e, result.col_e, result.type, result.lexeme_len, result.lexeme);
#endif

    return result;
}

static token_t scanner__make_error_token(scanner_t* self, const char* msg) {
    token_t result = {
        .lexeme     = msg,
        .lexeme_len = libc__strlen(msg),
        .type       = TOKEN_ERROR,
        .line_s     = self->line_s,
        .line_e     = self->line_e,
        .col_s      = self->col_s,
        .col_e      = self->col_e
    };

    return result;
}

static char scanner__peak(scanner_t* self) {
    return *self->top;
}

static char scanner__peak_next(scanner_t* self) {
    return *(self->top + 1);
}

static char scanner__eat(scanner_t* self) {
    ++self->col_e;
    return *self->top++;
}

static bool scanner__eat_if(scanner_t* self, char expected) {
    if (scanner__is_at_end(self) || scanner__peak(self) != expected) {
        return false;
    }

    ++self->top;

    return true;
}

static token_t scanner__make_comment(scanner_t* self) {
    switch (scanner__peak(self)) {
        case '/': {
            do {
                scanner__eat(self);
            } while (scanner__peak(self) != '\n' && !scanner__is_at_end(self));
            return scanner__make_token(self, TOKEN_COMMENT);
        } break ;
        case '*': {
            scanner__eat(self);
            do {
                char c = scanner__eat(self);

                if (c == '*' && scanner__eat_if(self, '/')) {
                    return scanner__make_token(self, TOKEN_COMMENT);
                } else if (c == '\n') {
                    ++self->line_e;
                    self->col_e = 1;
            }
        } while (!scanner__is_at_end(self));
        } break ;
        default: ASSERT(false);
    }

    return scanner__make_error_token(self, "Unterminated comment.");
}

static void scanner__skip_whitespaces(scanner_t* self) {
    while (42) {
        switch (scanner__peak(self)) {
            case ' ':
            case '\t':
            case '\r': {
                scanner__eat(self);
            } break ;
            case '\n': {
                ++self->line_e;
                self->col_e = 1;
                scanner__eat(self);
            } break ;
            default: return;
        }
    }
}

static token_t scanner__make_string(scanner_t* self) {
    while (scanner__peak(self) != '"' && !scanner__is_at_end(self)) {
        if (scanner__peak(self) == '\n') {
            ++self->line_e;
            self->col_e = 1;
        }
        scanner__eat(self);
    }

    if (scanner__is_at_end(self)) {
        return scanner__make_error_token(self, "Unterminated string.");
    }

    // Closing quote
    scanner__eat(self);

    return scanner__make_token(self, TOKEN_STRING);
}

static token_t scanner__make_number(scanner_t* self) {
    while (is_digit(scanner__peak(self))) {
        scanner__eat(self);
    }

    if (scanner__peak(self) == '.' && is_digit(scanner__peak_next(self))) {
        // Eat '.'
        scanner__eat(self);

        while (is_digit(scanner__peak(self))) {
            scanner__eat(self);
        }
    }

    return scanner__make_token(self, TOKEN_NUMBER);
}

static token_t scanner__make_identifier(scanner_t* self) {
    while (is_alpha(scanner__peak(self)) || is_digit(scanner__peak(self))) {
        scanner__eat(self);
    }

    return scanner__make_token(self, scanner__identifier_type(self));
}

static token_type scanner__identifier_type_helper(scanner_t* self, u32 start, const char* rest, token_type type) {
    u32 len = libc__strlen(rest);
    if ((u32) (self->top - self->start != start + len)) {
        return TOKEN_IDENTIFIER;
    }

    if (libc__strncmp(self->start + start, rest, len) == 0) {
        return type;
    }

    return TOKEN_IDENTIFIER;
}

static token_type scanner__identifier_type(scanner_t* self) {
    switch (*self->start) {
        case 'a': return scanner__identifier_type_helper(self, 1, "nd",   TOKEN_AND);
        case 'b': return scanner__identifier_type_helper(self, 1, "reak", TOKEN_BREAK);
        case 'c': {
            if (self->top - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'l': return scanner__identifier_type_helper(self, 2, "ass", TOKEN_CLASS);
                    case 'o': {
                        if (self->top - self->start > 2) {
                            switch (*(self->start + 2)) {
                                case 'n': {
                                    if (self->top - self->start > 3) {
                                        switch (*(self->start + 3)) {
                                            case 's': return scanner__identifier_type_helper(self, 4, "t",    TOKEN_CONST);
                                            case 't': return scanner__identifier_type_helper(self, 4, "inue", TOKEN_CONTINUE);
                                        }
                                    }
                                } break ;
                            }
                        }
                    } break ;
                    case 'a': return scanner__identifier_type_helper(self, 2, "se",  TOKEN_CASE);
                }
            }
        } break ;
        case 'd': return scanner__identifier_type_helper(self, 1, "efault", TOKEN_DEFAULT);
        case 'e': return scanner__identifier_type_helper(self, 1, "lse",    TOKEN_ELSE);
        case 'f': {
            if (self->top - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'a': return scanner__identifier_type_helper(self, 2, "lse", TOKEN_FALSE);
                    case 'o': return scanner__identifier_type_helper(self, 2, "r",   TOKEN_FOR);
                    case 'u': return scanner__identifier_type_helper(self, 2, "n",   TOKEN_FUN);
                }
            }
        } break ;
        case 'i': return scanner__identifier_type_helper(self, 1, "f",     TOKEN_IF);
        case 'n': return scanner__identifier_type_helper(self, 1, "il",    TOKEN_NIL);
        case 'o': return scanner__identifier_type_helper(self, 1, "r",     TOKEN_OR);
        case 'p': return scanner__identifier_type_helper(self, 1, "rint",  TOKEN_PRINT);
        case 'r': return scanner__identifier_type_helper(self, 1, "eturn", TOKEN_RETURN);
        case 's': {
        case 't': {
            if (self->top - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'h': return scanner__identifier_type_helper(self, 2, "is", TOKEN_THIS);
                    case 'r': return scanner__identifier_type_helper(self, 2, "ue", TOKEN_TRUE);
                }
            }
        } break ;
            if (self->top - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'u': return scanner__identifier_type_helper(self, 2, "per",  TOKEN_SUPER);
                    case 'w': return scanner__identifier_type_helper(self, 2, "itch", TOKEN_SWITCH);
                }
            }
        } break ;
        case 'v': return scanner__identifier_type_helper(self, 1, "ar",     TOKEN_VAR);
        case 'w': return scanner__identifier_type_helper(self, 1, "hile",   TOKEN_WHILE);
    }

    return TOKEN_IDENTIFIER;
}

static bool is_digit(char c) {
    return c >= '0' && c <= '9';
}

static bool is_alpha(char c) {
    return (c >= 'a'&& c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}

void scanner__init(scanner_t* self, const char* source) {
    self->start  = source;
    self->top    = source;
    self->line_s = 1;
    self->line_e = 1;
    self->col_s  = 1;
    self->col_e  = 1;
}

token_t scanner__scan_token(scanner_t* self) {
    scanner__skip_whitespaces(self);

    self->start  = self->top;
    self->line_s = self->line_e;
    self->col_s  = self->col_e;

    if (scanner__is_at_end(self)) {
        return scanner__make_token(self, TOKEN_EOF);
    }

    char c = scanner__eat(self);

    if (is_alpha(c)) {
        return scanner__make_identifier(self);
    }

    if (is_digit(c)) {
        return scanner__make_number(self);
    }

    switch (c) {
        case '(': return scanner__make_token(self, TOKEN_LEFT_PAREN);
        case ')': return scanner__make_token(self, TOKEN_RIGHT_PAREN);
        case '{': return scanner__make_token(self, TOKEN_LEFT_BRACE);
        case '}': return scanner__make_token(self, TOKEN_RIGHT_BRACE);
        case ';': return scanner__make_token(self, TOKEN_SEMICOLON);
        case ',': return scanner__make_token(self, TOKEN_COMMA);
        case '.': return scanner__make_token(self, TOKEN_DOT);
        case '-': return scanner__make_token(self, TOKEN_MINUS);
        case '+': return scanner__make_token(self, TOKEN_PLUS);
        case '/': {
            switch (scanner__peak(self)) {
                case '*':
                case '/': return scanner__make_comment(self);
                default: return scanner__make_token(self, TOKEN_SLASH);
            }
        } break ;
        case '*': return scanner__make_token(self, TOKEN_STAR);
        case '%': return scanner__make_token(self, TOKEN_PERCENTAGE);
        case ':': return scanner__make_token(self, TOKEN_COLON);
        case '!': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_EXCLAM_EQUAL  : TOKEN_EXCLAM);
        case '=': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_EQUAL_EQUAL   : TOKEN_EQUAL);
        case '<': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_LESS_EQUAL    : TOKEN_LESS);
        case '>': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_GREATER_EQUAL : TOKEN_GREATER);
        case '"': return scanner__make_string(self);
    }

    return scanner__make_error_token(self, "Unexpected character.");
}
