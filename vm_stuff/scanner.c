#include "scanner.h"

#include <stdbool.h>
#include <string.h>

#include "debug.h"

static bool         scanner__is_at_end(scanner_t* self);
static token_t      scanner__make_token(scanner_t* self, token_type_t type);
static token_t      scanner__make_error_token(scanner_t* self, const char* err_format, ...);
static char         scanner__peak(scanner_t* self);
static char         scanner__eat(scanner_t* self);
static bool         scanner__eat_if(scanner_t* self, char expected);
static void         scanner__skip_whitespaces(scanner_t* self);
static token_t      scanner__make_char(scanner_t* self);
static token_t      scanner__make_string(scanner_t* self);
static token_t      scanner__make_number(scanner_t* self, bool seen_dor);
static token_t      scanner__make_identifier(scanner_t* self);
static token_type_t scanner__identifier_type(scanner_t* self);

static bool scanner__is_digit(char c);
static bool scanner__is_alpha(char c);
static bool scanner__is_printable(char c);

static bool scanner__is_at_end(scanner_t* self) {
    return scanner__peak(self) == '\0' ||  self->cur == self->end;
}

static token_t scanner__make_token(scanner_t* self, token_type_t type) {
    token_t result = {
        .lexeme     = self->start,
        .lexeme_len = (uint32_t) (self->cur - self->start),
        .type       = type,
        .line_s     = self->line_s,
        .line_e     = self->line_e,
        .col_s      = self->col_s,
        .col_e      = self->col_e
    };

    // printf("[Scanner] %s", token_type__to_str(result.type));
    // if (result.lexeme_len) {
    //     printf(": [%.*s] %u:%u - %u:%u", result.lexeme_len, result.lexeme, result.line_s, result.col_s, result.line_e, result.col_e);
    // }
    // printf("\n");

    return result;
}

static token_t scanner__make_error_token(scanner_t* self, const char* err_format, ...) {
    va_list ap;
    va_start(ap, err_format);

    fprintf(stderr, "[Scanner] Warning: ");
    vfprintf(stderr, err_format, ap);
    fprintf(stderr, "\n");

    va_end(ap);

    return scanner__make_token(self, TOKEN_ERROR);
}

static char scanner__peak(scanner_t* self) {
    return *self->cur;
}

static char scanner__eat(scanner_t* self) {
    ++self->col_e;
    return *self->cur++;
}

static bool scanner__eat_if(scanner_t* self, char expected) {
    if (scanner__is_at_end(self) || scanner__peak(self) != expected) {
        return false;
    }

    ++self->cur;

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

    return scanner__make_error_token(self, "unterminated comment: [%.*s]", self->cur - self->start, self->start);
}

static void scanner__skip_whitespaces(scanner_t* self) {
    while (true) {
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

static token_t scanner__make_char(scanner_t* self) {
    if (scanner__is_at_end(self)) {
        return scanner__make_error_token(self, "unterminated character literal: [%c]", *self->start);
    }

    scanner__eat_if(self, '\\');
    scanner__eat(self);

    if (scanner__peak(self) != '\'') {
        return scanner__make_error_token(self, "unterminated character literal: [%.*s]", self->cur - self->start, self->start);
    }

    scanner__eat(self);

    return scanner__make_token(self, TOKEN_CHARACTER_LITERAL);
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
        return scanner__make_error_token(self, "unterminated string: [%.*s]", self->cur - self->start, self->start);
    }

    // Closing quote
    scanner__eat(self);

    return scanner__make_token(self, TOKEN_STRING_LITERAL);
}

static token_t scanner__make_number(scanner_t* self, bool seen_dot) {
    while (scanner__is_digit(scanner__peak(self))) {
        scanner__eat(self);
    }

    bool is_float = seen_dot;
    if (scanner__eat_if(self, '.')) {
        is_float = true;
    }

    while (scanner__is_digit(scanner__peak(self))) {
        scanner__eat(self);
    }

    if (is_float) {
        return scanner__make_token(self, TOKEN_FLOATING_LITERAL);
    } else {
        return scanner__make_token(self, TOKEN_INTEGRAL_LITERAL);
    }
}

static token_t scanner__make_identifier(scanner_t* self) {
    while (scanner__is_alpha(scanner__peak(self)) || scanner__is_digit(scanner__peak(self))) {
        scanner__eat(self);
    }

    return scanner__make_token(self, scanner__identifier_type(self));
}

static token_type_t scanner__identifier_type_helper(scanner_t* self, uint32_t start, const char* rest, token_type_t type) {
    uint32_t len = strlen(rest);
    if ((uint32_t) (self->cur - self->start != start + len)) {
        return TOKEN_IDENTIFIER;
    }

    if (strncmp(self->start + start, rest, len) == 0) {
        return type;
    }

    return TOKEN_IDENTIFIER;
}

static token_type_t scanner__identifier_type(scanner_t* self) {
    switch (*self->start) {
        case 'a': return scanner__identifier_type_helper(self, 1, "nd",   TOKEN_BITWISE_AND);
        case 'b': return scanner__identifier_type_helper(self, 1, "reak", TOKEN_BREAK);
        case 'c': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'o': {
                        if (self->cur - self->start > 2) {
                            switch (*(self->start + 2)) {
                                case 'n': {
                                    if (self->cur - self->start > 3) {
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
        case 'e': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'l': return scanner__identifier_type_helper(self, 2, "se", TOKEN_ELSE);
                    case 'n': return scanner__identifier_type_helper(self, 2, "um", TOKEN_ENUM);
                }
            }
        } break ;
        case 'f': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'a': return scanner__identifier_type_helper(self, 2, "lse", TOKEN_FALSE);
                    case 'o': return scanner__identifier_type_helper(self, 2, "r",   TOKEN_FOR);
                    case 'n': return TOKEN_FN;
                }
            }
        } break ;
        case 'i': return scanner__identifier_type_helper(self, 1, "f",     TOKEN_IF);
        case 'p': return scanner__identifier_type_helper(self, 1, "rint",  TOKEN_PRINT);
        case 'o': return scanner__identifier_type_helper(self, 1, "r",     TOKEN_BITWISE_OR);
        case 'r': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'e': return scanner__identifier_type_helper(self, 2, "turn", TOKEN_RETURN);
                    case '3': return scanner__identifier_type_helper(self, 2, "2", TOKEN_R32);
                    case '6': return scanner__identifier_type_helper(self, 2, "4", TOKEN_R64);
                }
            }
        } break ;
        case 's': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'w': return scanner__identifier_type_helper(self, 2, "itch", TOKEN_SWITCH);
                    case 't': return scanner__identifier_type_helper(self, 2, "ruct", TOKEN_STRUCT);
                    case '8': return TOKEN_S8;
                    case '1': return scanner__identifier_type_helper(self, 2, "6", TOKEN_S16);
                    case '3': return scanner__identifier_type_helper(self, 2, "2", TOKEN_S32);
                    case '6': return scanner__identifier_type_helper(self, 2, "4", TOKEN_S64);
                }
            }
        } break ;
        case 't': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case 'h': return scanner__identifier_type_helper(self, 2, "is", TOKEN_THIS);
                    case 'r': return scanner__identifier_type_helper(self, 2, "ue", TOKEN_TRUE);
                }
            }
        } break ;
        case 'u': {
            if (self->cur - self->start > 1) {
                switch (*(self->start + 1)) {
                    case '8': return TOKEN_U8;
                    case '1': return scanner__identifier_type_helper(self, 2, "6", TOKEN_U16);
                    case '3': return scanner__identifier_type_helper(self, 2, "2", TOKEN_U32);
                    case '6': return scanner__identifier_type_helper(self, 2, "4", TOKEN_U64);
                }
            }
        } break ;
        case 'v': return scanner__identifier_type_helper(self, 1, "oid",  TOKEN_VOID);
        case 'w': return scanner__identifier_type_helper(self, 1, "hile", TOKEN_WHILE);
    }

    return TOKEN_IDENTIFIER;
}

static bool scanner__is_digit(char c) {
    return c >= '0' && c <= '9';
}

static bool scanner__is_alpha(char c) {
    return (c >= 'a'&& c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}

static bool scanner__is_printable(char c) {
    return c >= ' ' && c <= '~';
}

void scanner__init(scanner_t* self, const char* source, uint64_t source_len) {
    self->start  = source;
    self->cur    = source;
    self->end    = source + source_len;
    self->line_s = 1;
    self->line_e = 1;
    self->col_s  = 1;
    self->col_e  = 1;
}

const char* token_type__to_str(token_type_t type) {
    switch (type) {
    case TOKEN_LEFT_PAREN: return "LEFT_PAREN";
    case TOKEN_RIGHT_PAREN: return "RIGHT_PAREN";
    case TOKEN_LEFT_CURLY: return "LEFT_CURLY";
    case TOKEN_RIGHT_CURLY: return "RIGHT_CURLY";
    case TOKEN_COMMA: return "COMMA";
    case TOKEN_DOT: return "DOT";
    case TOKEN_MINUS: return "MINUS";
    case TOKEN_PLUS: return "PLUS";
    case TOKEN_SEMICOLON: return "SEMICOLON";
    case TOKEN_FORWARD_SLASH: return "FORWARD_SLASH";
    case TOKEN_STAR: return "STAR";
    case TOKEN_QUESTION_MARK: return "QUESTION_MARK";
    case TOKEN_COLON: return "COLON";
    case TOKEN_PERCENTAGE: return "PERCENTAGE";
    case TOKEN_LOGICAL_NOT: return "LOGICAL_NOT";
    case TOKEN_EQUAL: return "EQUAL";
    case TOKEN_GREATER: return "GREATER";
    case TOKEN_LESS: return "LESS";
    case TOKEN_BITWISE_XOR: return "BITWISE_XOR";
    case TOKEN_BITWISE_AND: return "BITWISE_AND";
    case TOKEN_BITWISE_OR: return "BITWISE_OR";
    case TOKEN_BITWISE_NOT: return "BITWISE_NOT";
    case TOKEN_HASH: return "HASH";
    case TOKEN_LEFT_SQUARE: return "LEFT_SQUARE";
    case TOKEN_RIGHT_SQUARE: return "RIGHT_SQUARE";
    case TOKEN_BACKWARD_SLASH: return "BACKWARD_SLASH";
    case TOKEN_EXCLAM_EQUAL: return "EXCLAM_EQUAL";
    case TOKEN_EQUAL_EQUAL: return "EQUAL_EQUAL";
    case TOKEN_GREATER_EQUAL: return "GREATER_EQUAL";
    case TOKEN_LESS_EQUAL: return "LESS_EQUAL";
    case TOKEN_COLON_COLON: return "COLON_COLON";
    case TOKEN_LOGICAL_OR: return "LOGICAL_OR";
    case TOKEN_LOGICAL_AND: return "LOGICAL_AND";
    case TOKEN_IDENTIFIER: return "IDENTIFIER";
    case TOKEN_STRING_LITERAL: return "STRING_LITERAL";
    case TOKEN_CHARACTER_LITERAL: return "CHARACTER_LITERAL";
    case TOKEN_INTEGRAL_LITERAL: return "INTEGRAL_LITERAL";
    case TOKEN_FLOATING_LITERAL: return "FLOATING_LITERAL";
    case TOKEN_ELSE: return "ELSE";
    case TOKEN_PRINT: return "PRINT";
    case TOKEN_FALSE: return "FALSE";
    case TOKEN_FN: return "FN";
    case TOKEN_FOR: return "FOR";
    case TOKEN_IF: return "IF";
    case TOKEN_RETURN: return "RETURN";
    case TOKEN_THIS: return "THIS";
    case TOKEN_ENUM: return "ENUM";
    case TOKEN_TRUE: return "TRUE";
    case TOKEN_WHILE: return "WHILE";
    case TOKEN_BREAK: return "BREAK";
    case TOKEN_CONTINUE: return "CONTINUE";
    case TOKEN_CONST: return "CONST";
    case TOKEN_SWITCH: return "SWITCH";
    case TOKEN_CASE: return "CASE";
    case TOKEN_DEFAULT: return "DEFAULT";
    case TOKEN_STRUCT: return "STRUCT";
    case TOKEN_VOID: return "void";
    case TOKEN_U8: return "u8";
    case TOKEN_U16: return "u16";
    case TOKEN_U32: return "u32";
    case TOKEN_U64: return "u64";
    case TOKEN_S8: return "s8";
    case TOKEN_S16: return "s16";
    case TOKEN_S32: return "s32";
    case TOKEN_S64: return "s64";
    case TOKEN_R32: return "r32";
    case TOKEN_R64: return "r64";
    case TOKEN_ERROR: return "ERROR";
    case TOKEN_COMMENT: return "COMMENT";
    case TOKEN_EOF: return "EOF";
    default: ASSERT(false);
    }
}

token_t scanner__scan_token(scanner_t* self) {
    scanner__skip_whitespaces(self);

    self->start  = self->cur;
    self->line_s = self->line_e;
    self->col_s  = self->col_e;

    if (scanner__is_at_end(self)) {
        return scanner__make_token(self, TOKEN_EOF);
    }

    char c = scanner__eat(self);

    if (scanner__is_alpha(c)) {
        return scanner__make_identifier(self);
    }

    if (scanner__is_digit(c)) {
        return scanner__make_number(self, false);
    }

    switch (c) {
        case '(': return scanner__make_token(self, TOKEN_LEFT_PAREN);
        case ')': return scanner__make_token(self, TOKEN_RIGHT_PAREN);
        case '{': return scanner__make_token(self, TOKEN_LEFT_CURLY);
        case '}': return scanner__make_token(self, TOKEN_RIGHT_CURLY);
        case '[': return scanner__make_token(self, TOKEN_LEFT_SQUARE);
        case ']': return scanner__make_token(self, TOKEN_RIGHT_SQUARE);
        case ';': return scanner__make_token(self, TOKEN_SEMICOLON);
        case ',': return scanner__make_token(self, TOKEN_COMMA);
        case '.': {
            if (scanner__is_digit(scanner__peak(self))) {
                return scanner__make_number(self, true);
            } else {
                return scanner__make_token(self, TOKEN_DOT);
            }
        }
        case '-': return scanner__make_token(self, TOKEN_MINUS);
        case '+': return scanner__make_token(self, TOKEN_PLUS);
        case '/': {
            switch (scanner__peak(self)) {
                case '*':
                case '/': return scanner__make_comment(self);
                default: return scanner__make_token(self, TOKEN_FORWARD_SLASH);
            }
        } break ;
        case '*': return scanner__make_token(self, TOKEN_STAR);
        case '%': return scanner__make_token(self, TOKEN_PERCENTAGE);
        case ':': return scanner__make_token(self, TOKEN_COLON);
        case '?': return scanner__make_token(self, TOKEN_QUESTION_MARK);
        case '!': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_EXCLAM_EQUAL  : TOKEN_LOGICAL_NOT);
        case '=': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_EQUAL_EQUAL   : TOKEN_EQUAL);
        case '<': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_LESS_EQUAL    : TOKEN_LESS);
        case '>': return scanner__make_token(self, scanner__eat_if(self, '=') ? TOKEN_GREATER_EQUAL : TOKEN_GREATER);
        case '^': return scanner__make_token(self, TOKEN_BITWISE_XOR);
        case '~': return scanner__make_token(self, TOKEN_BITWISE_NOT);
        case '|': {
            switch (scanner__peak(self)) {
                case '|': return scanner__make_token(self, TOKEN_LOGICAL_OR);
                default: return scanner__make_token(self, TOKEN_BITWISE_OR);
            }
        } break ;
        case '&': {
            switch (scanner__peak(self)) {
                case '&': return scanner__make_token(self, TOKEN_LOGICAL_AND);
                default: return scanner__make_token(self, TOKEN_BITWISE_AND);
            }
        } break ;
        case '\'': return scanner__make_char(self);
        case '#': return scanner__make_token(self, TOKEN_HASH);
        case '\\': return scanner__make_token(self, TOKEN_BACKWARD_SLASH);
        case '"': return scanner__make_string(self);
    }

    return scanner__make_error_token(self, "unexpected character: [%c]", c);
}
