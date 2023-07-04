#include "compiler/tokenizer/tokenizer.h"
#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

#include "lox_tokenize_state.h"

bool tokenizer__tokenize_lox(struct tokenizer* self, const char* str) {
    struct tokenize_state tokenize_state = {
        .original_str = str,
        .cur_str = str,
        .state = STATE_TEXT,
        .token_len = 0,
        .line = 0,
        .tokenizer = self
    };

    while (tokenize_state__is_finished(&tokenize_state) == false) {
        tokenize_state__process_token(&tokenize_state);
    }

    return true;
}

const char* token__type_name_lox(struct token* token) {
    switch (token->type) {
        case LOX_TOKEN_COMMENT: return "comment";
        case LOX_TOKEN_LEFT_PAREN: return "left paren";
        case LOX_TOKEN_RIGHT_PAREN: return "right parent";
        case LOX_TOKEN_LEFT_BRACE: return "left brace";
        case LOX_TOKEN_RIGHT_BRACE: return "right brace";
        case LOX_TOKEN_COMMA: return "comma";
        case LOX_TOKEN_DOT: return "dot";
        case LOX_TOKEN_MINUS: return "minus";
        case LOX_TOKEN_PLUS: return "plus";
        case LOX_TOKEN_SEMICOLON: return "semicolon";
        case LOX_TOKEN_SLASH: return "slash";
        case LOX_TOKEN_STAR: return "star";
        case LOX_TOKEN_EXCLAM: return "exclam";
        case LOX_TOKEN_EXCLAM_EQUAL: return "exclam equal";
        case LOX_TOKEN_EQUAL: return "equal";
        case LOX_TOKEN_EQUAL_EQUAL: return "double equal";
        case LOX_TOKEN_GREATER: return "greater";
        case LOX_TOKEN_GREATER_EQUAL: return "greater equal";
        case LOX_TOKEN_LESS: return "less";
        case LOX_TOKEN_LESS_EQUAL: return "less equal";
        case LOX_TOKEN_IDENTIFIER: return "identifier";
        case LOX_TOKEN_STRING: return "string";
        case LOX_TOKEN_NUMBER: return "number";
        case LOX_TOKEN_AND: return "and";
        case LOX_TOKEN_CLASS: return "class";
        case LOX_TOKEN_ELSE: return "else";
        case LOX_TOKEN_FALSE: return "false";
        case LOX_TOKEN_FUN: return "function";
        case LOX_TOKEN_FOR: return "for";
        case LOX_TOKEN_IF: return "if";
        case LOX_TOKEN_NIL: return "nil";
        case LOX_TOKEN_OR: return "or";
        case LOX_TOKEN_PRINT: return "print";
        case LOX_TOKEN_RETURN: return "return";
        case LOX_TOKEN_SUPER: return "super";
        case LOX_TOKEN_THIS: return "this";
        case LOX_TOKEN_TRUE: return "true";
        case LOX_TOKEN_VAR: return "variable";
        case LOX_TOKEN_WHILE: return "while";
        case LOX_TOKEN_EOF: return "eof";
        default: return "unknown";
    }
}
