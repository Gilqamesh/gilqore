#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_TOKENS 1000
#define MAX_TOKEN_LENGTH 100

struct token {
    char* start;
    int len;
};

struct tokenizer {
    struct token* tokens;
    char* buffer;
    int buffer_fill;
    int buffer_size;
    int tokens_fill;
    int tokens_size;
};

bool tokenizer__create(struct tokenizer* self, int buffer_size, int max_number_of_tokens) {
    self->tokens = malloc(max_number_of_tokens * sizeof(*self->tokens));
    self->buffer = malloc(buffer_size);
    self->buffer_fill = 0;
    self->buffer_size = buffer_size;
    self->tokens_fill = 0;
    self->tokens_size = max_number_of_tokens;

    return true;
}

void tokenizer__destroy(struct tokenizer* self) {
    free(self->buffer);
    free(self->tokens);
}

bool tokenizer__add(struct tokenizer* self, struct token token) {
    if (self->tokens_fill == self->tokens_size) {
        printf("self->tokens_fill == self->tokens_size");
        exit(1);
    }

    int fill_increment = token.len + 1;
    if (self->buffer_size < self->buffer_fill + fill_increment) {
        printf("self->buffer_size < self->buffer_fill + fill_increment");
        exit(1);
    }

    char* dest = self->buffer + self->buffer_fill;
    memcpy(dest, token.start, token.len);
    dest[token.len] = '\0';
    self->buffer_fill += fill_increment;

    self->tokens[self->tokens_fill].start = dest;
    self->tokens[self->tokens_fill].len = token.len;
    ++self->tokens_fill;

    return true;
}

void tokenizer__print_tokens(struct tokenizer* self) {
    for (int i = 0; i < self->tokens_fill; ++i) {
        printf("%s\n", self->tokens[i].start);
    }
}

enum tokenizer_comment_state {
    CODE,
    ONESLASH,
    LINECOMMENT,
    BLOCKCOMMENT,
    BLOCKSTAR,
    INQUOTE,
    ESCAPE,

    TOKENIZER_COMMENT_STATE_SIZE
};

enum tokenizer_comment_state tokenizer_comment_state__code(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    (void) tokenizer;
    (void) token;

    if (c == '/') {
        return ONESLASH;
    } else if (c == '"') {
        return INQUOTE;
    } else {
        return CODE;
    }
}

enum tokenizer_comment_state tokenizer_comment_state__oneslash(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    (void) tokenizer;
    (void) token;

    if (c == '/') {
        return LINECOMMENT;
    } else if (c == '*') {
        return BLOCKCOMMENT;
    } else {
        return CODE;
    }
}

enum tokenizer_comment_state tokenizer_comment_state__linecomment(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    if (c == '\n') {
        token->start[token->len] = '\0';
        tokenizer__add(tokenizer, *token);
        token->len = 0;
        return CODE;
    }

    token->start[token->len++] = c;
    return LINECOMMENT;
}

enum tokenizer_comment_state tokenizer_comment_state__blockcomment(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    (void) tokenizer;

    if (c == '*') {
        return BLOCKSTAR;
    } else {
        token->start[token->len++] = c;
        return BLOCKCOMMENT;
    }
}

enum tokenizer_comment_state tokenizer_comment_state__blockstar(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    if (c == '/') {
        token->start[token->len] = '\0';
        tokenizer__add(tokenizer, *token);
        token->len = 0;
        return CODE;
    } else {
        token->start[token->len++] = '*';
        token->start[token->len++] = c;
        return BLOCKCOMMENT;
    }
}

enum tokenizer_comment_state tokenizer_comment_state__inquote(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    (void) tokenizer;
    (void) token;

    if (c == '"') {
        return CODE;
    } else if (c == '\\') {
        return ESCAPE;
    } else {
        return INQUOTE;
    }
}

enum tokenizer_comment_state tokenizer_comment_state__escape(
    struct tokenizer* tokenizer,
    struct token* token,
    char c
) {
    (void) tokenizer;
    (void) token;

    if (c == '"') {
        return INQUOTE;
    } else {
        return INQUOTE;
    }
}

void tokenizer__tokenize_comments2(struct tokenizer* self, const char* str) {
    struct token token;
    token.start = (char*)malloc(MAX_TOKEN_LENGTH);
    token.len = 0;

    static enum tokenizer_comment_state (*dispatch_state[TOKENIZER_COMMENT_STATE_SIZE])(
        struct tokenizer* tokenizer,
        struct token* token,
        char c
    ) = {
        &tokenizer_comment_state__code,
        &tokenizer_comment_state__oneslash,
        &tokenizer_comment_state__linecomment,
        &tokenizer_comment_state__blockcomment,
        &tokenizer_comment_state__blockstar,
        &tokenizer_comment_state__inquote,
        &tokenizer_comment_state__escape
    };

    enum tokenizer_comment_state state = CODE;
    for (int i = 0; str[i] != '\0'; i++) {
        if (state > sizeof(dispatch_state)/sizeof(dispatch_state[0])) {
            exit(2);
        }
        state = dispatch_state[state](self, &token, str[i]);
    }

    free(token.start);
}

void tokenizer__tokenize_comments(struct tokenizer* self, const char* str) {
    enum {
        CODE,
        ONESLASH,
        LINECOMMENT,
        BLOCKCOMMENT,
        BLOCKSTAR,
        INQUOTE,
        ESCAPE
    } state = CODE;

    struct token token;
    token.start = (char*)malloc(MAX_TOKEN_LENGTH);
    token.len = 0;

    for (int i = 0; str[i] != '\0'; i++) {
        char c = str[i];

        switch (state) {
            case CODE:
                if (c == '/') {
                    state = ONESLASH;
                } else if (c == '"') {
                    state = INQUOTE;
                }
                break;
            case ONESLASH:
                if (c == '/') {
                    state = LINECOMMENT;
                } else if (c == '*') {
                    state = BLOCKCOMMENT;
                } else {
                    state = CODE;
                }
                break;
            case LINECOMMENT:
                if (c == '\n') {
                    token.start[token.len] = '\0';
                    tokenizer__add(self, token);
                    token.len = 0;
                    state = CODE;
                } else {
                    token.start[token.len++] = c;
                }
                break;
            case BLOCKCOMMENT:
                if (c == '*') {
                    state = BLOCKSTAR;
                } else {
                    token.start[token.len++] = c;
                }
                break;
            case BLOCKSTAR:
                if (c == '/') {
                    token.start[token.len] = '\0';
                    tokenizer__add(self, token);
                    token.len = 0;
                    state = CODE;
                } else {
                    token.start[token.len++] = '*';
                    token.start[token.len++] = c;
                    state = BLOCKCOMMENT;
                }
                break;
            case INQUOTE:
                if (c == '"') {
                    state = CODE;
                } else if (c == '\\') {
                    state = ESCAPE;
                }
                break;
            case ESCAPE:
                if (c == '"') {
                    state = INQUOTE;
                } else {
                    state = INQUOTE;
                }
                break;
        }
    }

    free(token.start);
}

void tokenizer__tokenize_commas(struct tokenizer* self, const char* str) {
    enum {
        TEXT, COMMA
    } state = COMMA;

    struct token token;
    token.start = (char*)malloc(MAX_TOKEN_LENGTH);
    token.len = 0;

    for (int i = 0; str[i] != '\0'; i++) {
        char c = str[i];

        switch (state) {
            case TEXT: {
                if (c == ',') {
                    token.start[token.len] = '\0';
                    tokenizer__add(self, token);
                    token.len = 0;
                    state = COMMA;
                } else {
                    token.start[token.len++] = c;
                    state = TEXT;
                }
            } break ;
            case COMMA: {
                if (c == ',' || c == ' ' || c == '\t' || c == '\n') {
                    state = COMMA;
                } else {
                    token.start[token.len++] = c;
                    state = TEXT;
                }
            } break ;
        }
    }

    if (state == TEXT) {
        token.start[token.len] = '\0';
        tokenizer__add(self, token);
    }

    free(token.start);
}

#include <intrin.h>

#define KILO(x) (x * (1 << 10))
#define MEGA(x) (x * (1 << 20))

int main() {
    FILE* text_file = fopen("test_file", "r");
    if (text_file == NULL) {
        exit(1);
    }

    FILE* out_file = fopen("out", "w");
    if (out_file == NULL) {
        exit(2);
    }

    int text_buffer_size = MEGA(10);
    char* text_buffer = malloc(text_buffer_size);
    if (text_buffer == NULL) {
        exit(3);
    }
    int text_buffer_len = fread(text_buffer, sizeof(char), text_buffer_size - 1, text_file);
    text_buffer[text_buffer_len] = '\0';
    fclose(text_file);

    printf("File size: %.2lfMB\n", text_buffer_len / 1000000.0);

    struct tokenizer comments_tokenizer;
    if (tokenizer__create(&comments_tokenizer, text_buffer_len + 1, KILO(256)) == false) {
        exit(4);
    }

    unsigned long long time_start = __rdtsc();
    tokenizer__tokenize_comments2(&comments_tokenizer, text_buffer);
    unsigned long long time_end = __rdtsc();
    printf("Cy taken to tokenize: %.2lfM\n", (time_end - time_start) / (1000000.0));

    time_start = __rdtsc();
    for (int i = 0; i < comments_tokenizer.tokens_fill; ++i) {
        fwrite(comments_tokenizer.tokens[i].start, sizeof(char), comments_tokenizer.tokens[i].len, out_file);
        fwrite("\n", sizeof(char), 1, out_file);
    }
    time_end = __rdtsc();
    printf("Cy taken to write out: %.2lfM\n", (time_end - time_start) / (1000000.0));

    fclose(out_file);

    // printf("Comments:\n");
    // tokenizer__print_tokens(&comments_tokenizer);

    // printf("---\n");
    // const char* list = "one, two,\n"
    //                    "three, four";

    // struct tokenizer commas_tokenizer;
    // tokenizer__create(&commas_tokenizer, strlen(list) + 1, 256);
    // tokenizer__tokenize_commas(&commas_tokenizer, list);


    // printf("Commas:\n");
    // tokenizer__print_tokens(&commas_tokenizer);

    return 0;
}
