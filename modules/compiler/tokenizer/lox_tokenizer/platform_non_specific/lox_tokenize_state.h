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

    STATE_EXCLAM
};

struct tokenize_state {
    const char* original_str;
    const char* cur_str;
    enum lox_tokenizer_state state;
    u32 token_len;
    u32 line;

    struct tokenizer* tokenizer;
};

void tokenize_state__add_token(struct tokenize_state* self, enum lox_token_type token_type);

void tokenize_state__process_token(struct tokenize_state* self);
bool tokenize_state__is_finished(struct tokenize_state* self);

char tokenize_state__step_forward(struct tokenize_state* self);
char tokenize_state__step_forward_if(struct tokenize_state* self, bool condition);

#endif // LOX_TOKENIZE_STATE_H
