#include "algorithms/tokenizer/tokenizer.h"

#include "tokenizer_platform_non_specific.h"

enum comment_tokenizer_state {
    TOKEN_TYPE_UNKNOWN,
    TEXT,
    SLASH,
    LINECOMMENT,
    BLOCKCOMMENT,
    BLOCKSTAR,
    INQUOTE,
    ESCAPE
};

bool tokenizer__tokenize_comments(struct tokenizer* tokenizer, const char* str) {
    struct token token;
    token.end = NULL;
    token.len = 0;
    token.type = TOKEN_TYPE_UNKNOWN;

    enum comment_tokenizer_state state = TEXT;
    const char* cur_str = str;
    for (int i = 0; str[i] != '\0'; ++i, ++cur_str) {
        char c = str[i];

        switch (state) {
            case TEXT: {
                if (c == '/') {
                    state = SLASH;
                } else if (c == '"') {
                    state = INQUOTE;
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
                    token.type = COMMENT_TOKEN_TYPE_TOKEN;
                    token.end = cur_str;
                    tokenizer__add(tokenizer, token);
                    token.len = 0;
                    state = TEXT;
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
                    state = TEXT;
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
