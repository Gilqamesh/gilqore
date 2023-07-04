#ifndef LOX_TOKENIZER_H
# define LOX_TOKENIZER_H

# include "lox_tokenizer_defs.h"

struct tokenizer;
struct token;

PUBLIC_API bool tokenizer__tokenize_lox(struct tokenizer* tokenizer, const char* source);
PUBLIC_API const char* token__type_name_lox(struct token* token);

// lox tokenizer
enum lox_token_type {
    LOX_TOKEN_COMMENT,

    // Single-character tokens.
    LOX_TOKEN_LEFT_PAREN, LOX_TOKEN_RIGHT_PAREN, LOX_TOKEN_LEFT_BRACE, LOX_TOKEN_RIGHT_BRACE,
    LOX_TOKEN_COMMA, LOX_TOKEN_DOT, LOX_TOKEN_MINUS, LOX_TOKEN_PLUS,
    LOX_TOKEN_SEMICOLON, LOX_TOKEN_SLASH, LOX_TOKEN_STAR,

    // One or two character tokens.
    LOX_TOKEN_EXCLAM, LOX_TOKEN_EXCLAM_EQUAL,
    LOX_TOKEN_EQUAL, LOX_TOKEN_EQUAL_EQUAL,
    LOX_TOKEN_GREATER, LOX_TOKEN_GREATER_EQUAL,
    LOX_TOKEN_LESS, LOX_TOKEN_LESS_EQUAL,

    // Literals.
    LOX_TOKEN_IDENTIFIER, LOX_TOKEN_STRING, LOX_TOKEN_NUMBER,

    // Keywords.
    LOX_TOKEN_AND, LOX_TOKEN_CLASS, LOX_TOKEN_ELSE, LOX_TOKEN_FALSE,
    LOX_TOKEN_FUN, LOX_TOKEN_FOR, LOX_TOKEN_IF, LOX_TOKEN_NIL, LOX_TOKEN_OR,
    LOX_TOKEN_PRINT, LOX_TOKEN_RETURN, LOX_TOKEN_SUPER, LOX_TOKEN_THIS,
    LOX_TOKEN_TRUE, LOX_TOKEN_VAR, LOX_TOKEN_WHILE,

    LOX_TOKEN_EOF
};


#endif // LOX_TOKENIZER_H
