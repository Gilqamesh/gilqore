#ifndef LOX_PARSE_STATE_H
# define LOX_PARSE_STATE_H

# include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

struct parser;

bool lox_parser__is_finished(struct parser* self);

struct lox_expressions_table* lox_parser__get_expressions_table(struct parser* self);
struct lox_literal_table* lox_parser__get_literal_table(struct parser* self);
struct lox_statements_table* lox_parser__get_statements_table(struct parser* self);
struct lox_native_table* lox_parser__get_native_table(struct parser* self);

bool lox_parser_clear_tables(struct parser* self);

enum lox_token_type lox_parser__peek(struct parser* self);
struct token* lox_parser__advance(struct parser* self);
struct token* lox_parser__advance_if(struct parser* self, enum lox_token_type token_type);
struct token* lox_parser__advance_err(
    struct parser* self,
    enum lox_token_type token_type,
    const char* format, ...
);
struct token* lox_parser__get_previous(struct parser* self);

void lox_parser__advance_till_next_statement(struct parser* self);

#endif // LOX_PARSE_STATE_H
