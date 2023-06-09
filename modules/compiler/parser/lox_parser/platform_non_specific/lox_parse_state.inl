struct parser_statement* lox_parser__declaration(struct parser* self);
struct parser_statement* lox_parser__var_declaration(struct parser* self);
struct parser_statement* lox_parser__statement(struct parser* self);
struct parser_statement* lox_parser__expr_statement(struct parser* self);
struct parser_statement* lox_parser__if_statement(struct parser* self);
struct parser_statement* lox_parser__while_statement(struct parser* self);
struct parser_statement* lox_parser__print_statement(struct parser* self);
struct lox_parser_statement_node* lox_parser__block_statement(struct parser* self);
struct parser_expression* lox_parser__expression(struct parser* self);
struct parser_expression* lox_parser__comma(struct parser* self);
struct parser_expression* lox_parser__assignment(struct parser* self);
struct parser_expression* lox_parser__ternary(struct parser* self);
struct parser_expression* lox_parser__logical_or(struct parser* self);
struct parser_expression* lox_parser__logical_and(struct parser* self);
struct parser_expression* lox_parser__equality(struct parser* self);
struct parser_expression* lox_parser__comparison(struct parser* self);
struct parser_expression* lox_parser__term(struct parser* self);
struct parser_expression* lox_parser__factor(struct parser* self);
struct parser_expression* lox_parser__unary(struct parser* self);
struct parser_expression* lox_parser__primary(struct parser* self);
struct parser_expression* lox_parser__error(struct parser* self);

struct parser_statement* lox_parser__declaration(struct parser* self) {
    struct tokenizer_token* var_token = lox_parser__advance_if(self, LOX_TOKEN_VAR);
    if (var_token) {
        return lox_parser__var_declaration(self);
    }

    return lox_parser__statement(self);
}

struct parser_statement* lox_parser__var_declaration(struct parser* self) {
    struct tokenizer_token* var_token = lox_parser__advance_err(
        self,
        LOX_TOKEN_IDENTIFIER,
        "Expect variable name"
    );

    if (var_token == NULL) {
        return NULL;
    }

    struct parser_expression* var_initializer = NULL;

    if (lox_parser__advance_if(self, LOX_TOKEN_EQUAL) != NULL) {
        var_initializer = lox_parser__expression(self);
        if (var_initializer == NULL) {
            return NULL;
        }
        if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
            parser__syntax_error(
                self,
                "Expect ';' after '%s'.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_VAR_DECL)
            );
            return NULL;
        }
    } else {
        if (
            lox_parser__advance_err(
                self,
                LOX_TOKEN_SEMICOLON,
                "Expect ';' or variable initializer expression after '%.*s' '%s'.",
                var_token->lexeme_len, var_token->lexeme, lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_VAR_DECL)
            ) == NULL
        ) {
            return NULL;
        }
    }

    struct lox_parser_expr_var* var_value = lox_parser__define_expr_var(self, var_token, var_initializer);

    return (struct parser_statement*) lox_parser__get_statement_var_decl(self, (struct parser_expression*) var_value);
}

struct parser_statement* lox_parser__statement(struct parser* self) {
    if (lox_parser__advance_if(self, LOX_TOKEN_IF) != NULL) {
        return lox_parser__if_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_WHILE) != NULL) {
        return lox_parser__while_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_PRINT) != NULL) {
        return lox_parser__print_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_LEFT_BRACE) != NULL) {
        struct lox_parser_statement_node* statement_list = lox_parser__block_statement(self);
        if (statement_list == NULL) {
            // todo: free statement_list
            return NULL;
        }
        return (struct parser_statement*) lox_parser__get_statement_block(self, statement_list);
    }

    return lox_parser__expr_statement(self);
}

struct parser_statement* lox_parser__expr_statement(struct parser* self) {
    struct parser_expression* expression = lox_parser__expression(self);
    if (expression == NULL) {
        return NULL;
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        parser__syntax_error(
            self,
            "Expect ';' after '%s' expression.", lox_parser__expression_type_to_str(expression->type)
        );
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_expression(self, expression);
}

struct parser_statement* lox_parser__if_statement(struct parser* self) {
    struct tokenizer_token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(
            self,
            "Expect '(' after '%s'.",
            lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_IF)
        );
        return NULL;
    }

    struct parser_expression* condition = lox_parser__expression(self);
    if (condition == NULL) {
        return NULL;
    }

    struct tokenizer_token* right_param = lox_parser__advance_if(self, LOX_TOKEN_RIGHT_PAREN);
    if (right_param == NULL) {
        parser__syntax_error(
            self,
            "Expect ')' after '%s' expression.",
            lox_parser__expression_type_to_str(condition->type)
        );
        return NULL;
    }

    struct parser_statement* then_branch = lox_parser__statement(self);
    if (then_branch == NULL) {
        return NULL;
    }
    struct parser_statement* else_branch = NULL;
    struct tokenizer_token* else_token = lox_parser__advance_if(self, LOX_TOKEN_ELSE);
    if (else_token != NULL) {
        else_branch = lox_parser__statement(self);
        if (else_branch == NULL) {
            return NULL;
        }
    }

    return (struct parser_statement*) lox_parser__get_statement_if(self, condition, then_branch, else_branch);
}

struct parser_statement* lox_parser__while_statement(struct parser* self) {
    struct tokenizer_token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(
            self,
            "Expect '(' after '%s' statement.",
            lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_WHILE)
        );
        return NULL;
    }

    struct parser_expression* condition = lox_parser__expression(self);
    if (condition == NULL) {
        return NULL;
    }

    struct tokenizer_token* right_param = lox_parser__advance_if(self, LOX_TOKEN_RIGHT_PAREN);
    if (right_param == NULL) {
        parser__syntax_error(
            self,
            "Expect ')' after '%s' expression.",
            lox_parser__expression_type_to_str(condition->type)
        );
        return NULL;
    }

    struct parser_statement* while_body = lox_parser__statement(self);
    if (while_body == NULL) {
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_while(self, condition, while_body);
}

struct parser_statement* lox_parser__print_statement(struct parser* self) {
    struct parser_expression* expression = lox_parser__expression(self);
    if (expression == NULL) {
        return NULL;
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        parser__syntax_error(
            self,
            "Expect ';' after '%s' operator.", lox_token__type_name(LOX_TOKEN_PRINT)
        );
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_print(self, expression);
}

struct lox_parser_statement_node* lox_parser__block_statement(struct parser* self) {
    struct lox_parser_statement_node* cur = NULL;
    struct lox_parser_statement_node* result = cur;

    lox_parser__push_environment(self);

    while (
        lox_parser__peek(self) != LOX_TOKEN_RIGHT_BRACE &&
        lox_parser__is_finished_parsing(self) == false
    ) {
        struct parser_statement* statement = lox_parser__declaration(self);
        if (statement == NULL) {
            // todo: free result list
            return NULL;
        }
        if (cur == NULL) {
            cur = lox_parser__get_statement_node(self, statement);
            result = cur;
        } else {
            cur->next = lox_parser__get_statement_node(self, statement);
            cur = cur->next;
        }
    }

    if (lox_parser__advance_err(self, LOX_TOKEN_RIGHT_BRACE, "Expect '}' after block.") == NULL) {
        // todo: free result list
        // todo: synchronize
        return NULL;
    }
    
    lox_parser__decrement_environment(self);

    return result;
}

struct parser_expression* lox_parser__expression(struct parser* self) {
    return lox_parser__comma(self);
}

struct parser_expression* lox_parser__comma(struct parser* self) {
    struct parser_expression* assignment_expr = lox_parser__assignment(self);
    if (assignment_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_COMMA) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* expression = lox_parser__expression(self);
        if (expression == NULL) {
            return NULL;
        }
        assignment_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(self, assignment_expr, op, expression);
    }

    return assignment_expr;
}

struct parser_expression* lox_parser__assignment(struct parser* self) {
    struct parser_expression* left_expr = lox_parser__ternary(self);
    if (left_expr == NULL) {
        return NULL;
    }

    struct tokenizer_token* equal_token = lox_parser__advance_if(self, LOX_TOKEN_EQUAL);
    if (equal_token != NULL) {
        struct parser_expression* right_expr = lox_parser__assignment(self);
        if (right_expr == NULL) {
            return NULL;
        }

        if (left_expr->type == LOX_PARSER_EXPRESSION_TYPE_VAR) {
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) left_expr;
            left_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_expr, equal_token, right_expr);
            ASSERT(lox_parser__set_expr__var(self, var_expr->name, right_expr) != NULL);
        } else {
            parser__syntax_error(
                self,
                "Expression '%s' is not lvalue expression.",
                lox_parser__expression_type_to_str(left_expr->type)
            );
            // return NULL;
        }
    }

    return left_expr;
}

struct parser_expression* lox_parser__ternary(struct parser* self) {
    struct parser_expression* logical_or_expr = lox_parser__logical_or(self);
    if (logical_or_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_QUESTION_MARK) {
        struct tokenizer_token* question_mark_op = lox_parser__advance(self);
        ASSERT(question_mark_op != NULL);
        struct parser_expression* left_expr = lox_parser__expression(self);
        if (left_expr == NULL) {
            return NULL;
        }
        struct tokenizer_token* colon_op = lox_parser__advance_err(self, LOX_TOKEN_COLON, "Expect ':' in ternary expression.");
        if (colon_op == NULL) {
            return NULL;
        }
        struct parser_expression* right_expr = lox_parser__expression(self);
        if (right_expr == NULL) {
            return NULL;
        }
        logical_or_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(
            self,
            logical_or_expr,
            question_mark_op,
            (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_expr, colon_op, right_expr)
        );
    }

    return logical_or_expr;
}

struct parser_expression* lox_parser__logical_or(struct parser* self) {
    struct parser_expression* left_logical_and_expr = lox_parser__logical_and(self);
    if (left_logical_and_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_OR) {
        struct tokenizer_token* or_token = lox_parser__advance_if(self, LOX_TOKEN_OR);
        ASSERT(or_token != NULL);
        struct parser_expression* right_logical_and_expr = lox_parser__logical_and(self);
        if (right_logical_and_expr == NULL) {
            return NULL;
        }
        left_logical_and_expr = (struct parser_expression*) lox_parser__get_expr__logical(
            self,
            (struct parser_expression*) left_logical_and_expr,
            or_token,
            (struct parser_expression*) right_logical_and_expr
        );
    }

    return left_logical_and_expr;
}

struct parser_expression* lox_parser__logical_and(struct parser* self) {
    struct parser_expression* left_equality_expr = lox_parser__equality(self);
    if (left_equality_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_AND) {
        struct tokenizer_token* and_token = lox_parser__advance_if(self, LOX_TOKEN_AND);
        ASSERT(and_token != NULL);
        struct parser_expression* right_equality_expr = lox_parser__equality(self);
        if (right_equality_expr == NULL) {
            return NULL;
        }
        left_equality_expr = (struct parser_expression*) lox_parser__get_expr__logical(
            self,
            (struct parser_expression*) left_equality_expr,
            and_token,
            (struct parser_expression*) right_equality_expr
        );
    }

    return left_equality_expr;
}

struct parser_expression* lox_parser__equality(struct parser* self) {
    struct parser_expression* left_comp = lox_parser__comparison(self);
    if (left_comp == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_EXCLAM_EQUAL ||
        lox_parser__peek(self) == LOX_TOKEN_EQUAL_EQUAL
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_comp = lox_parser__comparison(self);
        if (right_comp == NULL) {
            return NULL;
        }
        left_comp = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_comp, op, right_comp);
    }

    return left_comp;
}

struct parser_expression* lox_parser__comparison(struct parser* self) {
    struct parser_expression* left_term = lox_parser__term(self);
    if (left_term == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_GREATER ||
        lox_parser__peek(self) == LOX_TOKEN_GREATER_EQUAL ||
        lox_parser__peek(self) == LOX_TOKEN_LESS ||
        lox_parser__peek(self) == LOX_TOKEN_LESS_EQUAL
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_term = lox_parser__term(self);
        if (right_term == NULL) {
            return NULL;
        }
        left_term = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_term, op, right_term);
    }

    return left_term;
}

struct parser_expression* lox_parser__term(struct parser* self) {
    struct parser_expression* left_factor = lox_parser__factor(self);
    if (left_factor == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_MINUS ||
        lox_parser__peek(self) == LOX_TOKEN_PLUS
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_factor = lox_parser__factor(self);
        if (right_factor == NULL) {
            return NULL;
        }
        left_factor = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_factor, op, right_factor);
    }

    return left_factor;
}

struct parser_expression* lox_parser__factor(struct parser* self) {
    struct parser_expression* left_unary = lox_parser__unary(self);
    if (left_unary == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_SLASH ||
        lox_parser__peek(self) == LOX_TOKEN_STAR ||
        lox_parser__peek(self) == LOX_TOKEN_PERCENTAGE
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_unary = lox_parser__unary(self);
        if (right_unary == NULL) {
            return NULL;
        }
        left_unary = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_unary, op, right_unary);
    }

    return left_unary;
}

struct parser_expression* lox_parser__unary(struct parser* self) {
    if (lox_parser__peek(self) == LOX_TOKEN_EOF) {
        parser__syntax_error(self, "Expect unary expression.");
        return NULL;
    }

    if (
        lox_parser__peek(self) == LOX_TOKEN_EXCLAM ||
        lox_parser__peek(self) == LOX_TOKEN_MINUS
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* expr = lox_parser__unary(self);
        if (expr == NULL) {
            return NULL;
        }
        return (struct parser_expression*) lox_parser__get_expr__op_unary(self, op, expr);
    }

    return lox_parser__primary(self);
}

struct parser_expression* lox_parser__primary(struct parser* self) {
    if (lox_parser__peek(self) == LOX_TOKEN_EOF) {
        parser__syntax_error(self, "Expect primary expression.");
        return NULL;
    }

    switch (lox_parser__peek(self)) {
        case LOX_TOKEN_NUMBER:
        case LOX_TOKEN_STRING:
        case LOX_TOKEN_TRUE:
        case LOX_TOKEN_FALSE:
        case LOX_TOKEN_NIL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            return (struct parser_expression*) lox_parser__get_expr__literal(self, op);
        } break ;
        case LOX_TOKEN_LEFT_PAREN: {
            ASSERT(lox_parser__advance(self) != NULL);
            struct parser_expression* expr = lox_parser__expression(self);
            if (expr == NULL) {
                return NULL;
            }
            if (lox_parser__advance_err(self, LOX_TOKEN_RIGHT_PAREN, "Expect ')' after expression.") == NULL) {
                return NULL;
            } else {
                return (struct parser_expression*) lox_parser__get_expr__grouping(self, expr);
            }
        } break ;
        case LOX_TOKEN_IDENTIFIER: {
            struct tokenizer_token* var_name = lox_parser__advance(self);
            ASSERT(var_name != NULL);
            struct lox_parser_expr_var* var_expr = lox_parser__get_expr__var(self, var_name);
            if (var_expr == NULL) {
                parser__syntax_error(
                    self,
                    "Undefined variable '%.*s'.",
                    var_name->lexeme_len, var_name->lexeme
                );
            }

            return (struct parser_expression*) var_expr; 
        } break ;
        default: {
            return lox_parser__error(self);
        }
    }
}

struct parser_expression* lox_parser__error(struct parser* self) {
    if (lox_parser__peek(self) == LOX_TOKEN_EOF) {
        parser__syntax_error(self, "Expect primary token.");
        return NULL;
    }

    switch (lox_parser__peek(self)) {
        case LOX_TOKEN_COMMA: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect ternary before comma ',' binary operator.");
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect equality before ternary '?' binary operator.");
        } break ;
        case LOX_TOKEN_COLON: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'equality ? expression' before ternary semicolon ':' binary operator.");
        } break ;
        case LOX_TOKEN_EXCLAM_EQUAL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect comparison expression before '!=' binary operator.");
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect comparison expression before '==' binary operator.");
        } break ;
        case LOX_TOKEN_GREATER: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '>' binary operator.");
        } break ;
        case LOX_TOKEN_GREATER_EQUAL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '>=' binary operator.");
        } break ;
        case LOX_TOKEN_LESS: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '<' binary operator.");
        } break ;
        case LOX_TOKEN_LESS_EQUAL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '<=' binary operator.");
        } break ;
        case LOX_TOKEN_PLUS: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect factor expression before '+' binary operator.");
        } break ;
        case LOX_TOKEN_EQUAL: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect lvalue expression before '=' binary operator.");
        } break ;
        default: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Unknown token '%.*s'.", op->lexeme_len, op->lexeme);
        } break ;
    }

    return NULL;
}
