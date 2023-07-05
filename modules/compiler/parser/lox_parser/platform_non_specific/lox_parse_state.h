#ifndef LOX_PARSE_STATE_H
# define LOX_PARSE_STATE_H

# include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

struct parser;

// enum lox_parser_state {
// };

struct lox_parse_state {
    struct parser* parser;
    struct tokenizer* tokenizer;
    u32 token_index;
    // enum lox_parser_state state;
};

bool lox_parse_state__is_finished(struct lox_parse_state* self);

enum lox_token_type lox_parse_state__peek(struct lox_parse_state* self);
struct tokenizer_token* lox_parse_state__advance(struct lox_parse_state* self);
struct tokenizer_token* lox_parse_state__advance_if(struct lox_parse_state* self, enum lox_token_type token_type);
struct tokenizer_token* lox_parse_state__advance_err(
    struct lox_parse_state* self,
    enum lox_token_type token_type,
    const char* format, ...
);
struct tokenizer_token* lox_parse_state__get_previous(struct lox_parse_state* self);

void lox_parse_state__advance_till_next_statement(struct lox_parse_state* self);

void lox_parse_state__reached_end_error(struct lox_parse_state* self, const char* format, ...);

// struct tokenizer_token* lox_parse_state__reverse(struct lox_parse_state* self);

#endif // LOX_PARSE_STATE_H
