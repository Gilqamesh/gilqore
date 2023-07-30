#include "test_framework/test_framework.h"

#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"
#include "compiler/tokenizer/tokenizer.h"
#include "compiler/parser/parser.h"
#include "libc/libc.h"

void token_create(
    struct token* self,
    const char* lexeme,
    enum lox_token_type lexeme_type
) {
    char* lexeme_cpy = libc__malloc(64);
    u32 lexeme_len = libc__strlen(lexeme);
    self->lexeme = libc__strcpy(lexeme_cpy, lexeme) + lexeme_len;
    self->lexeme_len = lexeme_len;
    self->line = 0;
    self->type = lexeme_type;
}

int main() {
    // Expr expression = new Expr.Binary(
    //     new Expr.Unary(
    //         new Token(TokenType.MINUS, "-", null, 1),
    //         new Expr.Literal(123)),
    //     new Token(TokenType.STAR, "*", null, 1),
    //     new Expr.Grouping(
    //         new Expr.Literal(45.67)));

    // System.out.println(new AstPrinter().print(expression));

    // const char* expression_to_evaluate = "(45.67) * - 123";

    struct token _123_token;
    token_create(&_123_token, "123", LOX_TOKEN_NUMBER);
    struct lox_expr_literal _123 = {
        .base = {
            .type = LOX_PARSER_EXPRESSION_TYPE_LITERAL
        },
        .value = &_123_token
    };

    struct token _45_67_token;
    token_create(&_45_67_token, "45.67", LOX_TOKEN_NUMBER);
    struct lox_expr_literal _45_67 = {
        .base = {
            .type = LOX_PARSER_EXPRESSION_TYPE_LITERAL
        },
        .value = &_45_67_token
    };

    struct lox_expr_group grouping = {
        .base = {
            .type = LOX_PARSER_EXPRESSION_TYPE_GROUPING
        },
        .expr = (struct expr*) &_45_67
    };

    struct token unary_token;
    token_create(&unary_token, "-", LOX_TOKEN_MINUS);
    struct lox_expr_unary unary = {
        .base = {
            .type = LOX_PARSER_EXPRESSION_TYPE_OP_UNARY
        },
        .op = &unary_token,
        .expr = (struct expr*) &_123
    };

    struct token star_token;
    token_create(&star_token, "*", LOX_TOKEN_STAR);
    struct lox_expr_binary star = {
        .base = {
            .type = LOX_PARSER_EXPRESSION_TYPE_OP_BINARY
        },
        .op = &star_token,
        .left = (struct expr*) &unary,
        .right = (struct expr*) &grouping
    };

    const char* expr_star_result = lox_parser_expr_evalute__op_binary((struct expr*) &star);
    libc__printf("%s\n", expr_star_result);

    libc__printf("Size of struct token: %zu\n", sizeof(struct token));
    libc__printf("Size of struct expr: %zu\n", sizeof(struct expr));
    libc__printf("Size of struct lox_expr_unary: %zu\n", sizeof(struct lox_expr_unary));
    libc__printf("Size of struct lox_expr_binary: %zu\n", sizeof(struct lox_expr_binary));
    libc__printf("Size of struct lox_expr_group: %zu\n", sizeof(struct lox_expr_group));
    libc__printf("Size of struct lox_expr_literal: %zu\n", sizeof(struct lox_expr_literal));

    return 0;
}
