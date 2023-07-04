#ifndef LOX_TOKENIZE_STATE_H
# define LOX_TOKENIZE_STATE_H

# include "lox_tokenizer_platform_non_specific_defs.h"

# include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

enum lox_tokenizer_state {
    STATE_TEXT,

    STATE_SLASH,
    STATE_LINECOMMENT,
    STATE_BLOCKCOMMENT,
    STATE_BLOCKSTAR,
    STATE_INQUOTE,
    STATE_ESCAPE,
    STATE_EQUAL,
    STATE_LESS_THAN,
    STATE_GREATER_THAN,
    STATE_DOT,
    STATE_NUMBER,
    STATE_NUMBER_DECIMAL,
    STATE_IDENTIFIER,

    STATE_EXCLAM
};

struct lox_tokenize_state {
    const char* cur_str;
    enum lox_tokenizer_state state;
    u32 token_len;
    u32 line;

    struct tokenizer* tokenizer;
};

void lox_tokenize_state__add_token(struct lox_tokenize_state* self, enum lox_token_type token_type);
enum lox_token_type lox_tokenize_state__get_identifier_type(struct lox_tokenize_state* self);

void lox_tokenize_state__process_token(struct lox_tokenize_state* self);
bool lox_tokenize_state__is_finished(struct lox_tokenize_state* self);

char lox_tokenize_state__peek(struct lox_tokenize_state* self);
char lox_tokenize_state__advance(struct lox_tokenize_state* self);
bool lox_tokenize_state__advance_if(struct lox_tokenize_state* self, char c);
char lox_tokenize_state__reverse(struct lox_tokenize_state* self);

const char* lox_tokenize_state__state_name(enum lox_tokenizer_state state);

#endif // LOX_TOKENIZE_STATE_H
