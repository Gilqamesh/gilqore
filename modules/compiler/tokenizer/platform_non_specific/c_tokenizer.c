#include "compiler/tokenizer/tokenizer.h"

#include "tokenizer_platform_non_specific.h"

enum c_tokenizer_state {
    TEXT,
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
    enum c_tokenizer_state state = TEXT;
    const char* cur_str = str;
    u32 cur_token_len = 0;
    u32 cur_line = 0;
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
                    tokenizer__add(
                        tokenizer,
                        cur_str - cur_token_len,
                        cur_token_len,
                        COMMENT_TOKEN_TYPE_TOKEN,
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
                        tokenizer,
                        cur_str - 1 - cur_token_len,
                        cur_token_len,
                        COMMENT_TOKEN_TYPE_TOKEN,
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
