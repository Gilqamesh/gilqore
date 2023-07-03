#include "compiler/tokenizer/tokenizer.h"

#include "tokenizer_platform_non_specific.h"

enum lox_tokenizer_state {
    TEXT,
    LEFT_PARAM,
    SLASH,
    LINECOMMENT,
    BLOCKCOMMENT,
    BLOCKSTAR,
    INQUOTE,
    ESCAPE
};

bool tokenizer__tokenize_lox(struct tokenizer* self, const char* str) {
    enum lox_tokenizer_state state = TEXT;
    const char* cur_str = str;
    u32 cur_token_len = 0;
    u32 cur_line = 0;
    for (int i = 0; str[i] != '\0'; ++i, ++cur_str) {
        char c = *cur_str;

        switch (state) {
            case TEXT: {
                switch (c) {
                    case '/': {
                        state = SLASH;
                    } break ;
                    case '"': {
                        state = INQUOTE;
                    } break ;
                    case '(': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_LEFT_PAREN,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case ')': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_RIGHT_PAREN,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '{': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_LEFT_BRACE,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '}': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_RIGHT_BRACE,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case ',': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_COMMA,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '.': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_DOT,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '-': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_MINUS,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '+': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_PLUS,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case ';': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_SEMICOLON,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '*': {
                        tokenizer__add(
                            self,
                            cur_str - cur_token_len,
                            cur_token_len + 1,
                            LOX_TOKEN_STAR,
                            cur_line
                        );
                        cur_token_len = 0;
                    } break ;
                    case '\n': {
                        ++cur_line;
                    } break ;
                    default: {
                        tokenizer__error(self, cur_line, "Unexpected character: '%c'.", *cur_str);
                    }
                }
            } break ;
            case SLASH: {
                if (c == '/') {
                    state = LINECOMMENT;
                } else if (c == '*') {
                    state = BLOCKCOMMENT;
                } else {
                    state = TEXT;
                }
            } break ;
            case LINECOMMENT: {
                if (c == '\n') {
                    tokenizer__add(
                        self,
                        cur_str - cur_token_len,
                        cur_token_len,
                        LOX_TOKEN_COMMENT,
                        cur_line
                    );
                    cur_token_len = 0;
                    ++cur_line;
                    state = TEXT;
                } else {
                    ++cur_token_len;
                }
            } break ;
            case BLOCKCOMMENT: {
                if (c == '*') {
                    state = BLOCKSTAR;
                } else {
                    ++cur_token_len;
                }
            } break ;
            case BLOCKSTAR: {
                if (c == '/') {
                    tokenizer__add(
                        self,
                        cur_str - 1 - cur_token_len,
                        cur_token_len,
                        LOX_TOKEN_COMMENT,
                        cur_line
                    );
                    cur_token_len = 0;
                    state = TEXT;
                } else {
                    ++cur_token_len;
                    ++cur_token_len;
                    state = BLOCKCOMMENT;
                }
            } break ;
            case INQUOTE: {
                if (c == '"') {
                    state = TEXT;
                } else if (c == '\\') {
                    state = ESCAPE;
                }
            } break ;
            case ESCAPE: {
                if (c == '"') {
                    state = INQUOTE;
                } else {
                    state = INQUOTE;
                }
            } break ;
            default: {
            }
        }
    }

    return true;
}
