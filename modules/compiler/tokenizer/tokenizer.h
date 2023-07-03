#ifndef TOKENIZER_H
# define TOKENIZER_H

# include "tokenizer_defs.h"

struct token {
    const char* lexeme; // not null-terminated
    u32 lexeme_len : 32;
    u32 type : 8;
    u32 line : 24;
};

typedef const char* (*token__type_name_fn)(struct token* token);
const char* token__type_name_comment(struct token* token);
const char* token__type_name_c(struct token* token);
const char* token__type_name_lox(struct token* token);

struct tokenizer {
    struct token* tokens;
    u32 tokens_fill;
    u32 tokens_size;
    bool had_error;
};

struct memory_slice;

typedef bool (*tokenizer__tokenize_fn)(struct tokenizer* tokenizer, const char* source);
#define TOKENIZER_FN_DECLARE(NAME) bool NAME(struct tokenizer* tokenizer, const char* source)
PUBLIC_API TOKENIZER_FN_DECLARE(tokenizer__tokenize_comments);
PUBLIC_API TOKENIZER_FN_DECLARE(tokenizer__tokenize_c_source_code);
PUBLIC_API TOKENIZER_FN_DECLARE(tokenizer__tokenize_lox);

PUBLIC_API bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice tokens_memory
);
PUBLIC_API void tokenizer__destroy(struct tokenizer* self);

PUBLIC_API void tokenizer__clear_error(struct tokenizer* self);
PUBLIC_API bool tokenizer__had_error(struct tokenizer* self);
PUBLIC_API u32 tokenizer__fill(struct tokenizer* self);
PUBLIC_API u32 tokenizer__size(struct tokenizer* self);
PUBLIC_API void tokenizer__clear(struct tokenizer* self);

// Comments tokenizer to parse C-like comments
enum comment_token_type {
    COMMENT_TOKEN_TYPE_TOKEN
};

// lox tokenizer
enum lox_token_type {
    LOX_TOKEN_COMMENT,

    // Single-character tokens.
    LOX_TOKEN_LEFT_PAREN, LOX_TOKEN_RIGHT_PAREN, LOX_TOKEN_LEFT_BRACE, LOX_TOKEN_RIGHT_BRACE,
    LOX_TOKEN_COMMA, LOX_TOKEN_DOT, LOX_TOKEN_MINUS, LOX_TOKEN_PLUS,
    LOX_TOKEN_SEMICOLON, LOX_TOKEN_SLASH, LOX_TOKEN_STAR,

    // One or two character tokens.
    LOX_TOKEN_BANG, LOX_TOKEN_BANG_EQUAL,
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

// C-file tokenizer
enum c_token_type {
    C_TOKEN_TYPE_KEYWORD_AUTO,
    C_TOKEN_TYPE_KEYWORD_BREAK,
    C_TOKEN_TYPE_KEYWORD_CASE,
    C_TOKEN_TYPE_KEYWORD_CHAR,
    C_TOKEN_TYPE_KEYWORD_CONST,
    C_TOKEN_TYPE_KEYWORD_CONTINUE,
    C_TOKEN_TYPE_KEYWORD_DEFAULT,
    C_TOKEN_TYPE_KEYWORD_DO,
    C_TOKEN_TYPE_KEYWORD_DOUBLE,
    C_TOKEN_TYPE_KEYWORD_ELSE,
    C_TOKEN_TYPE_KEYWORD_ENUM,
    C_TOKEN_TYPE_KEYWORD_EXTERN,
    C_TOKEN_TYPE_KEYWORD_FLOAT,
    C_TOKEN_TYPE_KEYWORD_FOR,
    C_TOKEN_TYPE_KEYWORD_GOTO,
    C_TOKEN_TYPE_KEYWORD_IF,
    C_TOKEN_TYPE_KEYWORD_INT,
    C_TOKEN_TYPE_KEYWORD_LONG,
    C_TOKEN_TYPE_KEYWORD_REGISTER,
    C_TOKEN_TYPE_KEYWORD_RETURN,
    C_TOKEN_TYPE_KEYWORD_SHORT,
    C_TOKEN_TYPE_KEYWORD_SIGNED,
    C_TOKEN_TYPE_KEYWORD_SIZEOF,
    C_TOKEN_TYPE_KEYWORD_STATIC,
    C_TOKEN_TYPE_KEYWORD_STRUCT,
    C_TOKEN_TYPE_KEYWORD_SWITCH,
    C_TOKEN_TYPE_KEYWORD_TYPEDEF,
    C_TOKEN_TYPE_KEYWORD_UNION,
    C_TOKEN_TYPE_KEYWORD_UNSIGNED,
    C_TOKEN_TYPE_KEYWORD_VOID,
    C_TOKEN_TYPE_KEYWORD_VOLATILE,
    C_TOKEN_TYPE_KEYWORD_WHILE,

    C_TOKEN_TYPE_IDENTIFIER, // asd

    C_TOKEN_TYPE_CONSTANT_INTEGER, // 32, 32L, 32ULL
    C_TOKEN_TYPE_CONSTANT_FLOAT, // 23.4f, 234.12, .32, 6.022e23
    C_TOKEN_TYPE_CONSTANT_OCTAL, // 032
    C_TOKEN_TYPE_CONSTANT_HEXA, // 0x3
    C_TOKEN_TYPE_CONSTANT_CHARACTER, // 'a', '\n'
    C_TOKEN_TYPE_CONSTANT_STRING, // "asd"

    C_TOKEN_TYPE_OPERATOR_FUNCTION_POSTFIX_INCREMENT, // ++
    C_TOKEN_TYPE_OPERATOR_FUNCTION_POSTFIX_DECREMENT, // --
    C_TOKEN_TYPE_OPERATOR_MEMBER_SELECTOR_DOT, // .
    C_TOKEN_TYPE_OPERATOR_MEMBER_SELECTOR_ARROW, // ->
    C_TOKEN_TYPE_OPERATOR_PREFIX_INCREMENT, // ++
    C_TOKEN_TYPE_OPERATOR_PREFIX_DECREMENT, // --
    C_TOKEN_TYPE_OPERATOR_UNARY_PLUS, // +
    C_TOKEN_TYPE_OPERATOR_UNARY_MINUX, // -
    C_TOKEN_TYPE_OPERATOR_LOGICAL_NOT, // !
    C_TOKEN_TYPE_OPERATOR_BITWISE_NOT, // ~
    C_TOKEN_TYPE_OPERATOR_ADDRESS_OF, // 
    C_TOKEN_TYPE_OPERATOR_DIVISION, // /
    C_TOKEN_TYPE_OPERATOR_MODULO, // %
    C_TOKEN_TYPE_OPERATOR_BITWISE_LEFT_SHIFT, // <<
    C_TOKEN_TYPE_OPERATOR_BITWISE_RIGHT_SHIFT, // >>
    C_TOKEN_TYPE_OPERATOR_LESS_THAN, // <
    C_TOKEN_TYPE_OPERATOR_LESS_THAN_OR_EQUAL_TO, // <=
    C_TOKEN_TYPE_OPERATOR_GREATER_THAN, // >
    C_TOKEN_TYPE_OPERATOR_GREATER_THAN_OR_EQUAL_TO, // >=
    C_TOKEN_TYPE_OPERATOR_EQUAL_TO, // ==
    C_TOKEN_TYPE_OPERATOR_NOT_EQUAL_TO, // !=
    C_TOKEN_TYPE_OPERATOR_BITWISE_XOR, // ^
    C_TOKEN_TYPE_OPERATOR_BITWISE_OR, // |
    C_TOKEN_TYPE_OPERATOR_LOGICAL_AND, // &&
    C_TOKEN_TYPE_OPERATOR_LOGICAL_OR, // ||
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_DIRECT, // =
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_SUM, // +=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_DIFFERENCE, // -=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_PRODUCT, // *=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_QUOTIENT, // /=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_REMAINDER, // %=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_BITWISE_LEFT_SHIFT, // <<=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_BITWISE_RIGHT_SHIFT, // >>=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_BITWISE_AND, // &=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_BITWISE_XOR, // ^=
    C_TOKEN_TYPE_OPERATOR_ASSIGNMENT_BY_BITWISE_OR, // |=
    C_TOKEN_TYPE_OPERATOR_COMMA, // ,

    C_TOKEN_TYPE_SPECIAL_CHARACTER_SEMICOLON, // ;
    C_TOKEN_TYPE_SPECIAL_CHARACTER_COLON, // :
    C_TOKEN_TYPE_SPECIAL_CHARACTER_QUESTION_MARK, // ?
    C_TOKEN_TYPE_SPECIAL_CHARACTER_APOSTROPHE, // \'
    C_TOKEN_TYPE_SPECIAL_CHARACTER_DOUBLE_QUOTATION_MARK, // "
    C_TOKEN_TYPE_SPECIAL_CHARACTER_BACKWARD_SLASH,
    C_TOKEN_TYPE_SPECIAL_CHARACTER_OPENING_CURLY_BRACKET, // {
    C_TOKEN_TYPE_SPECIAL_CHARACTER_CLOSING_CURLY_BRACKET, // }
    C_TOKEN_TYPE_SPECIAL_CHARACTER_LEFT_BRACKET, // [
    C_TOKEN_TYPE_SPECIAL_CHARACTER_RIGHT_BRACKET, // ]
    C_TOKEN_TYPE_SPECIAL_CHARACTER_LEFT_PARAM, // (
    C_TOKEN_TYPE_SPECIAL_CHARACTER_RIGHT_PARAM, // )
    C_TOKEN_TYPE_SPECIAL_CHARACTER_AMPERSAND, // &
    C_TOKEN_TYPE_SPECIAL_CHARACTER_HASH_SIGN, // #
    C_TOKEN_TYPE_SPECIAL_STAR, // *

    C_TOKEN_TYPE_COMMENT, // either in between /**/ or after // till end of line

    C_TOKEN_TYPE_PREPROCESSOR_DEFINE, //#define <text>
    C_TOKEN_TYPE_PREPROCESSOR_INCLUDE, //#include <text>
    C_TOKEN_TYPE_PREPROCESSOR_INCLUDE_NEXT, //#include_next <text>
    C_TOKEN_TYPE_PREPROCESSOR_IF, //#if <text>
    C_TOKEN_TYPE_PREPROCESSOR_ELIF, //#elif
    C_TOKEN_TYPE_PREPROCESSOR_ELSE, //#else
    C_TOKEN_TYPE_PREPROCESSOR_ENDIF, //#endif
    C_TOKEN_TYPE_PREPROCESSOR_IFDEF, //#ifdef <text>
    C_TOKEN_TYPE_PREPROCESSOR_IFNDEF, //#ifndef <text>
    C_TOKEN_TYPE_PREPROCESSOR_IFDEFINED, //#if defined(<text>)
    C_TOKEN_TYPE_PREPROCESSOR_UNDEF, //#undef <text>
    C_TOKEN_TYPE_PREPROCESSOR_PRAGMA, //#pragma <text>
    C_TOKEN_TYPE_PREPROCESSOR_PRAGMA_ONCE, //#pragma once
    C_TOKEN_TYPE_PREPROCESSOR_ERROR, //#error <text>
    C_TOKEN_TYPE_PREPROCESSOR_LINE, //#line <text>
};

#endif // TOKENIZER_H
