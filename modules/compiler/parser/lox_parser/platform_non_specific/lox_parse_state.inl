struct parser_expression* lox_parse_state__expression(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__comma(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__ternary(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__equality(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__comparison(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__term(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__factor(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__unary(struct lox_parse_state* self);
struct parser_expression* lox_parse_state__primary(struct lox_parse_state* self);

struct parser_expression* lox_parse_state__expression(struct lox_parse_state* self) {
    return lox_parse_state__comma(self);
}

struct parser_expression* lox_parse_state__comma(struct lox_parse_state* self) {
    struct parser_expression* ternary_expr = lox_parse_state__ternary(self);
    if (ternary_expr == NULL) {
        return NULL;
    }

    while (lox_parse_state__peek(self) == LOX_TOKEN_COMMA) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* expression = lox_parse_state__expression(self);
        if (expression == NULL) {
            return NULL;
        }
        ternary_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, ternary_expr, op, expression);
    }

    return ternary_expr;
}

struct parser_expression* lox_parse_state__ternary(struct lox_parse_state* self) {
    struct parser_expression* equality_expr = lox_parse_state__equality(self);
    if (equality_expr == NULL) {
        return NULL;
    }

    while (lox_parse_state__peek(self) == LOX_TOKEN_QUESTION_MARK) {
        struct tokenizer_token* question_mark_op = lox_parse_state__advance(self);
        ASSERT(question_mark_op != NULL);
        struct parser_expression* left_expr = lox_parse_state__expression(self);
        if (left_expr == NULL) {
            return NULL;
        }
        struct tokenizer_token* colon_op = lox_parse_state__advance_err(self, LOX_TOKEN_COLON, "Expect ':' in ternary expression.");
        if (colon_op == NULL) {
            // lox_parse_state__advance_till_next_statement(self);
            return NULL;
        }
        struct parser_expression* right_expr = lox_parse_state__expression(self);
        if (right_expr == NULL) {
            return NULL;
        }
        equality_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(
            self->parser,
            equality_expr,
            question_mark_op,
            (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, left_expr, colon_op, right_expr)
        );
    }

    return equality_expr;
}

struct parser_expression* lox_parse_state__equality(struct lox_parse_state* self) {
    struct parser_expression* left_comp = lox_parse_state__comparison(self);
    if (left_comp == NULL) {
        return NULL;
    }

    while (
        lox_parse_state__peek(self) == LOX_TOKEN_EXCLAM_EQUAL ||
        lox_parse_state__peek(self) == LOX_TOKEN_EQUAL_EQUAL
    ) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_comp = lox_parse_state__comparison(self);
        if (right_comp == NULL) {
            return NULL;
        }
        left_comp = (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, left_comp, op, right_comp);
    }

    return left_comp;
}

struct parser_expression* lox_parse_state__comparison(struct lox_parse_state* self) {
    struct parser_expression* left_term = lox_parse_state__term(self);
    if (left_term == NULL) {
        return NULL;
    }

    while (
        lox_parse_state__peek(self) == LOX_TOKEN_GREATER ||
        lox_parse_state__peek(self) == LOX_TOKEN_GREATER_EQUAL ||
        lox_parse_state__peek(self) == LOX_TOKEN_LESS ||
        lox_parse_state__peek(self) == LOX_TOKEN_LESS_EQUAL
    ) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_term = lox_parse_state__term(self);
        if (right_term == NULL) {
            return NULL;
        }
        left_term = (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, left_term, op, right_term);
    }

    return left_term;
}

struct parser_expression* lox_parse_state__term(struct lox_parse_state* self) {
    struct parser_expression* left_factor = lox_parse_state__factor(self);
    if (left_factor == NULL) {
        return NULL;
    }

    while (
        lox_parse_state__peek(self) == LOX_TOKEN_MINUS ||
        lox_parse_state__peek(self) == LOX_TOKEN_PLUS
    ) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_factor = lox_parse_state__factor(self);
        if (right_factor == NULL) {
            return NULL;
        }
        left_factor = (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, left_factor, op, right_factor);
    }

    return left_factor;
}

struct parser_expression* lox_parse_state__factor(struct lox_parse_state* self) {
    struct parser_expression* left_unary = lox_parse_state__unary(self);
    if (left_unary == NULL) {
        return NULL;
    }

    while (
        lox_parse_state__peek(self) == LOX_TOKEN_SLASH ||
        lox_parse_state__peek(self) == LOX_TOKEN_STAR
    ) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_unary = lox_parse_state__unary(self);
        if (right_unary == NULL) {
            return NULL;
        }
        left_unary = (struct parser_expression*) lox_parser__get_expr__op_binary(self->parser, left_unary, op, right_unary);
    }

    return left_unary;
}

struct parser_expression* lox_parse_state__unary(struct lox_parse_state* self) {
    if (lox_parse_state__peek(self) == LOX_TOKEN_EOF) {
        lox_parse_state__reached_end_error(self, "Expected unary expression.");
        return NULL;
    }

    if (
        lox_parse_state__peek(self) == LOX_TOKEN_EXCLAM ||
        lox_parse_state__peek(self) == LOX_TOKEN_MINUS
    ) {
        struct tokenizer_token* op = lox_parse_state__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* expr = lox_parse_state__unary(self);
        if (expr == NULL) {
            return NULL;
        }
        return (struct parser_expression*) lox_parser__get_expr__op_unary(self->parser, op, expr);
    }

    return lox_parse_state__primary(self);
}

struct parser_expression* lox_parse_state__primary(struct lox_parse_state* self) {
    if (lox_parse_state__peek(self) == LOX_TOKEN_EOF) {
        lox_parse_state__reached_end_error(self, "Expected primary expression.");
        return NULL;
    }

    switch (lox_parse_state__peek(self)) {
        case LOX_TOKEN_NUMBER:
        case LOX_TOKEN_STRING:
        case LOX_TOKEN_TRUE:
        case LOX_TOKEN_FALSE:
        case LOX_TOKEN_NIL: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            return (struct parser_expression*) lox_parser__get_expr__literal(self->parser, op);
        } break ;
        case LOX_TOKEN_LEFT_PAREN: {
            ASSERT(lox_parse_state__advance(self) != NULL);
            struct parser_expression* expr = lox_parse_state__expression(self);
            if (expr == NULL) {
                return NULL;
            }
            if (lox_parse_state__advance_err(self, LOX_TOKEN_RIGHT_PAREN, "Expect ')' after expression.") == NULL) {
                // lox_parse_state__advance_till_next_statement(self);
                return NULL;
            } else {
                return (struct parser_expression*) lox_parser__get_expr__grouping(self->parser, expr);
            }
        } break ;
        case LOX_TOKEN_COMMA: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect ternary before comma ',' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect equality before ternary '?' binary operator.");
            // todo: discard right-hand operand with the same precedence
            // discard expression
            // discard : operator if exists
            // discard expression
            return NULL;
        } break ;
        case LOX_TOKEN_COLON: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect 'equality ? expression' before ternary semicolon ':' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_EXCLAM_EQUAL: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect comparison expression before '!=' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect comparison expression before '==' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_GREATER: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect term expression before '>' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_GREATER_EQUAL: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect term expression before '>=' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_LESS: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect term expression before '<' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_LESS_EQUAL: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect term expression before '<=' binary operator.");
            return NULL;
        } break ;
        case LOX_TOKEN_PLUS: {
            struct tokenizer_token* op = lox_parse_state__advance(self);
            ASSERT(op != NULL);
            parser__error(self->parser, self->tokenizer, op, "Expect factor expression before '+' binary operator.");
            return NULL;
        } break ;
        default: {
            return NULL;
        }
    }
}
