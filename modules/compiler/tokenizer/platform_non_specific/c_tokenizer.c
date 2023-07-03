#include "compiler/tokenizer/tokenizer.h"

#include "tokenizer_platform_non_specific.h"

enum c_tokenizer_state {
    TOKEN_TYPE_UNKNOWN,
    UNIDENTIFIED,
    SLASH,
    LINECOMMENT,
    BLOCKCOMMENT,
    BLOCKSTAR,
    INQUOTE,
    ESCAPE,

    WHITESPACE
};

static inline bool is_whitespace(char c) {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r' || c == '\v' || c == '\f';
}

bool tokenizer__tokenize_c_source_code(struct tokenizer* tokenizer, const char* str) {
    struct token token;
    token.end = NULL;
    token.len = 0;
    token.type = TOKEN_TYPE_UNKNOWN;

    enum c_tokenizer_state state = UNIDENTIFIED;
    const char* cur_str = str;
    for (int i = 0; str[i] != '\0'; ++i, ++cur_str) {
        char c = str[i];

        switch (state) {
            case UNIDENTIFIED: {
                if (is_whitespace(c)) {
                    state = WHITESPACE;
                } else if (c == '/') {
                    state = SLASH;
                } else if (c == '"') {
                    state = INQUOTE;
                } else if (c == '(') {
                    token.type = COMMENT_TOKEN_TYPE_TOKEN;
                    state = UNIDENTIFIED;
                }
            } break ;
            case SLASH: {
                if (c == '/') {
                    state = LINECOMMENT;
                } else if (c == '*') {
                    state = BLOCKCOMMENT;
                } else {
                    state = UNIDENTIFIED;
                }
            } break ;
            case LINECOMMENT: {
                if (c == '\n') {
                    token.type = COMMENT_TOKEN_TYPE_TOKEN;
                    token.end = cur_str;
                    tokenizer__add(tokenizer, token);
                    token.len = 0;
                    state = UNIDENTIFIED;
                } else {
                    ++token.len;
                }
            } break ;
            case BLOCKCOMMENT: {
                if (c == '*') {
                    state = BLOCKSTAR;
                } else {
                    ++token.len;
                }
            } break ;
            case BLOCKSTAR: {
                if (c == '/') {
                    token.type = COMMENT_TOKEN_TYPE_TOKEN;
                    token.end = cur_str - 1;
                    tokenizer__add(tokenizer, token);
                    token.len = 0;
                    state = UNIDENTIFIED;
                } else {
                    token.len++;
                    token.len++;
                    // token.start[token.len++] = '*';
                    // token.start[token.len++] = c;
                    state = BLOCKCOMMENT;
                }
            } break ;
            case INQUOTE: {
                if (c == '"') {
                    state = UNIDENTIFIED;
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
