#include "compiler/tokenizer/tokenizer.h"
#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

#include "lox_tokenize_state.h"

bool lox_tokenizer__tokenize(struct tokenizer* self, const char* str) {
    struct lox_tokenize_state lox_tokenize_state = {
        .cur_str = str,
        .state = STATE_TEXT,
        .token_len = 0,
        .line = 0,
        .tokenizer = self
    };

    while (lox_tokenize_state__is_finished(&lox_tokenize_state) == false) {
        lox_tokenize_state__process_token(&lox_tokenize_state);
    }

    lox_tokenize_state__add_token(&lox_tokenize_state, LOX_TOKEN_EOF);

    if (lox_tokenize_state.state != STATE_TEXT) {
        tokenizer__error(
            self,
            lox_tokenize_state.line,
            "Unterminated %s.",
            lox_tokenize_state__state_name(lox_tokenize_state.state)
        );
    }

    return true;
}

const char* lox_token__type_name(u8 token_type) {
    switch (token_type) {
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
        case LOX_TOKEN_QUESTION_MARK: return "?";
        case LOX_TOKEN_COLON: return ":";
        case LOX_TOKEN_COLON_COLON: return "::";
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
