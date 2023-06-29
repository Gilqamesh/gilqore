#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_TOKENS 1000
#define MAX_TOKEN_LENGTH 100

enum token_type {
    UNKNOWN,
    CODE,
    ONESLASH,
    LINECOMMENT,
    BLOCKCOMMENT,
    BLOCKSTAR,
    INQUOTE,
    ESCAPE,

    COMMENT
};

struct token {
    const char* end; // excluding
    unsigned int len;
    enum token_type type;
};

struct tokenizer {
    struct token* tokens;
    unsigned int tokens_fill;
    unsigned int tokens_size;
};

bool tokenizer__create(struct tokenizer* self, unsigned int max_number_of_tokens) {
    self->tokens = malloc(max_number_of_tokens * sizeof(*self->tokens));
    self->tokens_fill = 0;
    self->tokens_size = max_number_of_tokens;

    return true;
}

void tokenizer__destroy(struct tokenizer* self) {
    free(self->tokens);
}

void tokenizer__clear(struct tokenizer* self) {
    self->tokens_fill = 0;
}

bool tokenizer__add(struct tokenizer* self, struct token* token) {
    if (self->tokens_fill == self->tokens_size) {
        printf("self->tokens_fill == self->tokens_size");
        exit(1);
    }

    self->tokens[self->tokens_fill].end = token->end;
    self->tokens[self->tokens_fill].len = token->len;
    self->tokens[self->tokens_fill].type = token->type;
    ++self->tokens_fill;

    return true;
}

void tokenizer__print_tokens(struct tokenizer* self) {
    for (unsigned int i = 0; i < self->tokens_fill; ++i) {
        if (self->tokens[i].type != COMMENT) {
            printf("Unknown token: ");
        }
        printf("[%.*s]\n", self->tokens[i].len, self->tokens[i].end - self->tokens[i].len);
    }
}

void tokenizer__tokenize_comments(struct tokenizer* self, const char* str) {
    struct token token;
    token.len = 0;

    enum token_type state = CODE;
    const char* cur_str = str;
    for (int i = 0; str[i] != '\0'; ++i, ++cur_str) {
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
                    token.type = COMMENT;
                    token.end = cur_str;
                    tokenizer__add(self, &token);
                    token.len = 0;
                    state = CODE;
                } else {
                    ++token.len;
                }
                break;
            case BLOCKCOMMENT:
                if (c == '*') {
                    state = BLOCKSTAR;
                } else {
                    ++token.len;
                }
                break;
            case BLOCKSTAR:
                if (c == '/') {
                    token.type = COMMENT;
                    token.end = cur_str - 1;
                    tokenizer__add(self, &token);
                    token.len = 0;
                    state = CODE;
                } else {
                    token.len++;
                    token.len++;
                    // token.start[token.len++] = '*';
                    // token.start[token.len++] = c;
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
            default: {
            }
        }
    }
}

void tokenizer__tokenize_commas(struct tokenizer* self, const char* str) {
    enum {
        TEXT, COMMA
    } state = COMMA;

    struct token token;
    token.end = NULL;
    token.len = 0;
    token.type = UNKNOWN;

    const char* cur_str = str;
    for (int i = 0; str[i] != '\0'; ++i, ++cur_str) {
        char c = str[i];

        switch (state) {
            case TEXT: {
                if (c == ',') {
                    token.end = cur_str;
                    tokenizer__add(self, &token);
                    token.len = 0;
                    state = COMMA;
                } else {
                    ++token.len;
                    state = TEXT;
                }
            } break ;
            case COMMA: {
                if (c == ',' || c == ' ' || c == '\t' || c == '\n') {
                    state = COMMA;
                } else {
                    ++token.len;
                    state = TEXT;
                }
            } break ;
        }
    }

    if (state == TEXT) {
        token.end = cur_str;
        tokenizer__add(self, &token);
    }
}

#include <intrin.h>

#define KILO(x) (x * (1 << 10))
#define MEGA(x) (x * (1 << 20))

// todo: tokenize both halves of the file at the same time
//   start from the middle, then the tokenizer can either be in the middle of a token or not
//   somehow we have to find a place where it isn't, but if all whitespaces are considered non-tokens, then just skip all whitespaces
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
    if (tokenizer__create(&comments_tokenizer, KILO(256)) == false) {
        exit(4);
    }

    tokenizer__clear(&comments_tokenizer);
    unsigned long long time_start = __rdtsc();
    tokenizer__tokenize_comments(&comments_tokenizer, text_buffer);
    unsigned long long time_end = __rdtsc();
    printf("Cy taken to tokenize: %.2lfM\n", (time_end - time_start) / (1000000.0));

    time_start = __rdtsc();
    for (unsigned int i = 0; i < comments_tokenizer.tokens_fill; ++i) {
        fwrite(comments_tokenizer.tokens[i].end - comments_tokenizer.tokens[i].len, sizeof(char), comments_tokenizer.tokens[i].len, out_file);
        fwrite("\n", sizeof(char), 1, out_file);
    }
    time_end = __rdtsc();
    printf("Cy taken to write out: %.2lfM\n", (time_end - time_start) / (1000000.0));

    fclose(out_file);

    printf("Comments:\n");
    tokenizer__print_tokens(&comments_tokenizer);

    // printf("---\n");
    // const char* list = "one, two,\n"
    //                    "three, four";

    // struct tokenizer commas_tokenizer;
    // tokenizer__create(&commas_tokenizer, strlen(list) + 1, 256);
    // tokenizer__tokenize_commas(&commas_tokenizer, list);


    // printf("Commas:\n");
    // tokenizer__print_tokens(&commas_tokenizer);

    free(text_buffer);

    return 0;
}
