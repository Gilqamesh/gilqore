struct stmt* lox_parser__declaration(struct parser* self);
struct stmt* lox_parser__fun_declaration(struct parser* self, const char* kind);
struct stmt* lox_parser__var_declaration(struct parser* self);
struct stmt* lox_parser__statement(struct parser* self);
struct stmt* lox_parser__expr_statement(struct parser* self);
struct stmt* lox_parser__for_statement(struct parser* self);
struct stmt* lox_parser__if_statement(struct parser* self);
struct stmt* lox_parser__while_statement(struct parser* self);
struct stmt* lox_parser__break_statement(struct parser* self);
struct stmt* lox_parser__continue_statement(struct parser* self);
struct stmt* lox_parser__return_statement(struct parser* self);
struct stmt* lox_parser__print_statement(struct parser* self);
struct stmt* lox_parser__block_statement(struct parser* self);
struct expr* lox_parser__expression(struct parser* self);
struct expr* lox_parser__comma(struct parser* self);
struct expr* lox_parser__assignment(struct parser* self);
struct expr* lox_parser__ternary(struct parser* self);
struct expr* lox_parser__logical_or(struct parser* self);
struct expr* lox_parser__logical_and(struct parser* self);
struct expr* lox_parser__equality(struct parser* self);
struct expr* lox_parser__comparison(struct parser* self);
struct expr* lox_parser__term(struct parser* self);
struct expr* lox_parser__factor(struct parser* self);
struct expr* lox_parser__unary(struct parser* self);
struct expr* lox_parser__call(struct parser* self);
struct expr* lox_parser__primary(struct parser* self);
struct expr* lox_parser__error(struct parser* self);

struct stmt* lox_parser__declaration(struct parser* self) {
    if (lox_parser__advance_if(self, LOX_TOKEN_VAR)) {
        return lox_parser__var_declaration(self);
    } else if (lox_parser__advance_if(self, LOX_TOKEN_FUN)) {
        return lox_parser__fun_declaration(self, "function");
    }

    return lox_parser__statement(self);
}

struct stmt* lox_parser__fun_declaration(struct parser* self, const char* kind) {
    struct token* fn_name = lox_parser__advance_err(self, LOX_TOKEN_IDENTIFIER, "Expect '%s' name.", kind);
    if (fn_name == NULL) {
        return NULL;
    }

    if (lox_parser__advance_err(self, LOX_TOKEN_LEFT_PAREN, "Expect '(' after '%s' name.", kind) == NULL) {
        return NULL;
    }

    struct lox_stmt_token_node* params = NULL;
    struct lox_stmt_token_node** pparams = &params;
    if (lox_parser__peek(self) != LOX_TOKEN_RIGHT_PAREN) {
        u32 parameters_size = 0;
        do {
            if (parameters_size >= 255) {
                parser__warn_error(self, "Cannot have more than %u arguments.", LOX_MAX_NUMBER_OF_FN_ARGUMENTS);
            }
            struct token* parameter = lox_parser__advance(self);
            if (parameter == NULL) {
                return NULL;
            }
            if (parameter->type != LOX_TOKEN_IDENTIFIER) {
                parser__syntax_error(
                    self, "Expect parameter name in function declaration '%.*s', but got '%s'.",
                    fn_name->lexeme_len, fn_name->lexeme, lox_token__type_name(parameter->type)
                );
                // todo: clean up params
                return NULL;
            }
            *pparams = lox_parser__get_statement_fun_params_node(self, parameter);
            pparams = &(*pparams)->next;
        } while (lox_parser__advance_if(self, LOX_TOKEN_COMMA) != NULL);
    }

    if (lox_parser__advance_err(
        self, LOX_TOKEN_RIGHT_PAREN,
        "Expect ')' after parameters in function declaration '%.*s'.",
        fn_name->lexeme_len, fn_name->lexeme
    ) == NULL) {
        // todo: clean up params
        return NULL;
    }

    if (lox_parser__advance_err(
        self, LOX_TOKEN_LEFT_BRACE,
        "Expect '{' after function declaration '%.*s'.",
        fn_name->lexeme_len, fn_name->lexeme
    ) == NULL) {
        // todo: clean up params
        return NULL;
    }

    struct stmt* fun_block_statement = lox_parser__block_statement(self);
    if (fun_block_statement == NULL) {
        // todo: clean up params
        return NULL;
    }

    return lox_parser__get_statement_fun(self, fn_name, params, (struct lox_stmt_block*) fun_block_statement);
}

struct stmt* lox_parser__var_declaration(struct parser* self) {
    struct token* var_token = lox_parser__advance_err(self, LOX_TOKEN_IDENTIFIER, "Expect variable name.");

    if (var_token == NULL) {
        return NULL;
    }

    struct expr* var_initializer = NULL;

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

    return lox_parser__get_statement_var_decl(self, lox_parser__get_expr__var(self, var_token, var_initializer));
}

struct stmt* lox_parser__statement(struct parser* self) {
    if (lox_parser__advance_if(self, LOX_TOKEN_IF) != NULL) {
        return lox_parser__if_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_FOR) != NULL) {
        return lox_parser__for_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_WHILE) != NULL) {
        return lox_parser__while_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_PRINT) != NULL) {
        return lox_parser__print_statement(self);
    }

    // todo: syntax error if not in an iteration statement
    if (lox_parser__advance_if(self, LOX_TOKEN_BREAK) != NULL) {
        return lox_parser__break_statement(self);
    }

    // todo: syntax error if not in an iteration statement
    if (lox_parser__advance_if(self, LOX_TOKEN_CONTINUE) != NULL) {
        return lox_parser__continue_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_RETURN) != NULL) {
        return lox_parser__return_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_LEFT_BRACE) != NULL) {
        struct stmt* block_statement = lox_parser__block_statement(self);
        if (block_statement == NULL) {
            return NULL;
        }
        return block_statement;
    }

    return lox_parser__expr_statement(self);
}

struct stmt* lox_parser__expr_statement(struct parser* self) {
    struct expr* expression = lox_parser__expression(self);
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

    return lox_parser__get_statement_expression(self, expression);
}

struct stmt* lox_parser__for_statement(struct parser* self) {
    struct token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(self, "Expect '(' after 'for'.");
        return NULL;
    }

    struct stmt* initializer = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) != NULL) {
        initializer = NULL;
    } else if (lox_parser__advance_if(self, LOX_TOKEN_VAR) != NULL) {
        // todo: comma separated var declaration
        initializer = lox_parser__var_declaration(self);
        if (initializer == NULL) {
            return NULL;
        }
    } else {
        initializer = lox_parser__expr_statement(self);
        if (initializer == NULL) {
            return NULL;
        }
    }

    struct expr* condition = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        condition = lox_parser__expression(self);
        if (lox_parser__advance_err(
            self,
            LOX_TOKEN_SEMICOLON,
            "Expect ';' after loop condition."
        ) == NULL) {
            return NULL;
        }
    }

    struct expr* increment = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_RIGHT_PAREN) == NULL) {
        increment = lox_parser__expression(self);
        if (lox_parser__advance_err(
            self,
            LOX_TOKEN_RIGHT_PAREN,
            "Expect ')' after loop clauses."
        ) == NULL) {
            return NULL;
        }
    }

    struct stmt* loop_body = lox_parser__statement(self);
    if (loop_body == NULL) {
        return NULL;
    }

    // note: desugaring so that the backend can use its building blocks without supporting for loop evaluations

    struct lox_stmt_node* loop_body_node = lox_parser__get_statement_node(self, loop_body);
    struct lox_stmt_node* initializer_node = NULL;
    struct lox_stmt_node* increment_node = NULL;

    if (increment != NULL) {
        increment_node = lox_parser__get_statement_node(self, lox_parser__get_statement_expression(self, increment));
        // note: execute the body of the loop and then the increment
        loop_body_node->next = increment_node;
    }

    if (condition == NULL) {
        condition = (struct expr*) lox_parser__get_expr__literal_true(self);
    }

    struct stmt* while_loop_stmt = lox_parser__get_statement_while(
        self,
        condition,
        lox_parser__get_statement_block(
            self,
            loop_body_node
        )
    );
    struct lox_stmt_node* whole_loop_stmt_node = lox_parser__get_statement_node(self, while_loop_stmt);

    if (initializer != NULL) {
        initializer_node = lox_parser__get_statement_node(self, initializer);
        // note: execute the initializer clause of the loop and then the loop body
        initializer_node->next = whole_loop_stmt_node;
        whole_loop_stmt_node = initializer_node;
    }

    return lox_parser__get_statement_block(self, whole_loop_stmt_node);
}

struct stmt* lox_parser__if_statement(struct parser* self) {
    struct token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(
            self,
            "Expect '(' after '%s'.",
            lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_IF)
        );
        return NULL;
    }

    struct expr* condition = lox_parser__expression(self);
    if (condition == NULL) {
        return NULL;
    }

    struct token* right_param = lox_parser__advance_if(self, LOX_TOKEN_RIGHT_PAREN);
    if (right_param == NULL) {
        parser__syntax_error(
            self,
            "Expect ')' after '%s' expression.",
            lox_parser__expression_type_to_str(condition->type)
        );
        return NULL;
    }

    struct stmt* then_branch = lox_parser__statement(self);
    if (then_branch == NULL) {
        return NULL;
    }
    struct stmt* else_branch = NULL;
    struct token* else_token = lox_parser__advance_if(self, LOX_TOKEN_ELSE);
    if (else_token != NULL) {
        else_branch = lox_parser__statement(self);
        if (else_branch == NULL) {
            return NULL;
        }
    }

    return lox_parser__get_statement_if(self, condition, then_branch, else_branch);
}

struct stmt* lox_parser__while_statement(struct parser* self) {
    if (
        lox_parser__advance_err(
            self, LOX_TOKEN_LEFT_PAREN,
            "Expect '(' after '%s' statement.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_WHILE)
        ) == NULL
    ) {
        return NULL;
    }

    struct expr* condition = lox_parser__expression(self);
    if (condition == NULL) {
        return NULL;
    }

    if (
        lox_parser__advance_err(
            self, LOX_TOKEN_RIGHT_PAREN,
            "Expect ')' after '%s' expression.", lox_parser__expression_type_to_str(condition->type)
        ) == NULL
    ) {
        return NULL;
    }

    struct stmt* while_body = lox_parser__statement(self);
    if (while_body == NULL) {
        return NULL;
    }

    return lox_parser__get_statement_while(self, condition, while_body);
}

struct stmt* lox_parser__break_statement(struct parser* self) {
    if (
        lox_parser__advance_err(
            self, LOX_TOKEN_SEMICOLON,
            "Expect ';' after '%s' statement.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_BREAK)
        ) == NULL
    ) {
        return NULL;
    }

    return lox_parser__get_statement_break(self);
}

struct stmt* lox_parser__continue_statement(struct parser* self) {
    if (
        lox_parser__advance_err(
            self, LOX_TOKEN_SEMICOLON,
            "Expect ';' after '%s' statement.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_CONTINUE)
        ) == NULL
    ) {
        return NULL;
    }

    return lox_parser__get_statement_continue(self);
}

struct stmt* lox_parser__return_statement(struct parser* self) {
    struct expr* expr = NULL;
    if (lox_parser__peek(self) != LOX_TOKEN_SEMICOLON) {
        expr = lox_parser__expression(self);
        if (expr == NULL) {
            return NULL;
        }
    }

    if (lox_parser__advance_err(self, LOX_TOKEN_SEMICOLON, "Expect ';' after return statement.") == NULL) {
        return NULL;
    }
    return lox_parser__get_statement_return(self, expr);
}

struct stmt* lox_parser__print_statement(struct parser* self) {
    struct expr* expression = lox_parser__expression(self);
    if (expression == NULL) {
        return NULL;
    }

    if (
        lox_parser__advance_err(
            self, LOX_TOKEN_SEMICOLON,
            "Expect ';' after '%s' operator.", lox_token__type_name(LOX_TOKEN_PRINT)
        ) == NULL
    ) {
        return NULL;
    }

    return (struct stmt*) lox_parser__get_statement_print(self, expression);
}

struct stmt* lox_parser__block_statement(struct parser* self) {
    struct lox_stmt_node* block_statement_node = NULL;
    struct lox_stmt_node** pblock_statement_node = &block_statement_node;

    while (
        lox_parser__peek(self) != LOX_TOKEN_RIGHT_BRACE &&  
        lox_parser__is_finished_parsing(self) == false
    ) {
        struct stmt* statement = lox_parser__declaration(self);
        if (statement == NULL) {
            // todo: free block_statement_node list
            return NULL;
        }
        *pblock_statement_node = lox_parser__get_statement_node(self, statement);
        pblock_statement_node = &(*pblock_statement_node)->next;
    }

    if (lox_parser__advance_err(self, LOX_TOKEN_RIGHT_BRACE, "Expect '}' after block.") == NULL) {
        // todo: free block_statement_node list
        // todo: synchronize
        return NULL;
    }

    return (struct stmt*) lox_parser__get_statement_block(self, block_statement_node);
}

struct expr* lox_parser__expression(struct parser* self) {
    return lox_parser__comma(self);
}

struct expr* lox_parser__comma(struct parser* self) {
    struct expr* assignment_expr = lox_parser__assignment(self);
    if (assignment_expr == NULL) {
        return NULL;
    }

    struct lox_expr_node* result_node = lox_parser__get_expr__node(self, assignment_expr);
    struct lox_expr_node** presult_node = (struct lox_expr_node**) &result_node->next;
    while (lox_parser__peek(self) == LOX_TOKEN_COMMA) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* expression = lox_parser__expression(self);
        if (expression == NULL) {
            return NULL;
        }
        *presult_node = lox_parser__get_expr__node(self, expression);
        presult_node = (struct lox_expr_node**) &(*presult_node)->next;
    }

    return (struct expr*) result_node;
}

struct expr* lox_parser__assignment(struct parser* self) {
    struct expr* left_expr = lox_parser__ternary(self);
    if (left_expr == NULL) {
        return NULL;
    }

    struct token* equal_token = lox_parser__advance_if(self, LOX_TOKEN_EQUAL);
    if (equal_token != NULL) {
        struct expr* right_expr = lox_parser__assignment(self);
        if (right_expr == NULL) {
            return NULL;
        }

        if (left_expr->type == LOX_PARSER_EXPRESSION_TYPE_VAR) {
            struct lox_expr_var* var_expr = (struct lox_expr_var*) left_expr;
            (void) var_expr;
            left_expr = (struct expr*) lox_parser__get_expr__op_binary(self, left_expr, equal_token, right_expr);
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

struct expr* lox_parser__ternary(struct parser* self) {
    struct expr* conditional_expr = lox_parser__logical_or(self);
    if (conditional_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_QUESTION_MARK) {
        struct token* question_mark_op = lox_parser__advance(self);
        ASSERT(question_mark_op != NULL);
        struct expr* left_expr = lox_parser__expression(self);
        if (left_expr == NULL) {
            return NULL;
        }
        struct token* colon_op = lox_parser__advance_err(self, LOX_TOKEN_COLON, "Expect ':' in ternary expression.");
        if (colon_op == NULL) {
            return NULL;
        }
        struct expr* right_expr = lox_parser__expression(self);
        if (right_expr == NULL) {
            return NULL;
        }
        conditional_expr = (struct expr*) lox_parser__get_expr__op_binary(
            self,
            conditional_expr,
            question_mark_op,
            (struct expr*) lox_parser__get_expr__op_binary(self, left_expr, colon_op, right_expr)
        );
    }

    return conditional_expr;
}

struct expr* lox_parser__logical_or(struct parser* self) {
    struct expr* left_logical_and_expr = lox_parser__logical_and(self);
    if (left_logical_and_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_OR) {
        struct token* or_token = lox_parser__advance_if(self, LOX_TOKEN_OR);
        ASSERT(or_token != NULL);
        struct expr* right_logical_and_expr = lox_parser__logical_and(self);
        if (right_logical_and_expr == NULL) {
            return NULL;
        }
        left_logical_and_expr = (struct expr*) lox_parser__get_expr__logical(
            self,
            (struct expr*) left_logical_and_expr,
            or_token,
            (struct expr*) right_logical_and_expr
        );
    }

    return left_logical_and_expr;
}

struct expr* lox_parser__logical_and(struct parser* self) {
    struct expr* left_equality_expr = lox_parser__equality(self);
    if (left_equality_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_AND) {
        struct token* and_token = lox_parser__advance_if(self, LOX_TOKEN_AND);
        ASSERT(and_token != NULL);
        struct expr* right_equality_expr = lox_parser__equality(self);
        if (right_equality_expr == NULL) {
            return NULL;
        }
        left_equality_expr = (struct expr*) lox_parser__get_expr__logical(
            self,
            (struct expr*) left_equality_expr,
            and_token,
            (struct expr*) right_equality_expr
        );
    }

    return left_equality_expr;
}

struct expr* lox_parser__equality(struct parser* self) {
    struct expr* left_comp = lox_parser__comparison(self);
    if (left_comp == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_EXCLAM_EQUAL ||
        lox_parser__peek(self) == LOX_TOKEN_EQUAL_EQUAL
    ) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* right_comp = lox_parser__comparison(self);
        if (right_comp == NULL) {
            return NULL;
        }
        left_comp = (struct expr*) lox_parser__get_expr__op_binary(self, left_comp, op, right_comp);
    }

    return left_comp;
}

struct expr* lox_parser__comparison(struct parser* self) {
    struct expr* left_term = lox_parser__term(self);
    if (left_term == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_GREATER ||
        lox_parser__peek(self) == LOX_TOKEN_GREATER_EQUAL ||
        lox_parser__peek(self) == LOX_TOKEN_LESS ||
        lox_parser__peek(self) == LOX_TOKEN_LESS_EQUAL
    ) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* right_term = lox_parser__term(self);
        if (right_term == NULL) {
            return NULL;
        }
        left_term = (struct expr*) lox_parser__get_expr__op_binary(self, left_term, op, right_term);
    }

    return left_term;
}

struct expr* lox_parser__term(struct parser* self) {
    struct expr* left_factor = lox_parser__factor(self);
    if (left_factor == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_MINUS ||
        lox_parser__peek(self) == LOX_TOKEN_PLUS
    ) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* right_factor = lox_parser__factor(self);
        if (right_factor == NULL) {
            return NULL;
        }
        left_factor = (struct expr*) lox_parser__get_expr__op_binary(self, left_factor, op, right_factor);
    }

    return left_factor;
}

struct expr* lox_parser__factor(struct parser* self) {
    struct expr* left_unary = lox_parser__unary(self);
    if (left_unary == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_SLASH ||
        lox_parser__peek(self) == LOX_TOKEN_STAR ||
        lox_parser__peek(self) == LOX_TOKEN_PERCENTAGE
    ) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* right_unary = lox_parser__unary(self);
        if (right_unary == NULL) {
            return NULL;
        }
        left_unary = (struct expr*) lox_parser__get_expr__op_binary(self, left_unary, op, right_unary);
    }

    return left_unary;
}

struct expr* lox_parser__unary(struct parser* self) {
    if (lox_parser__peek(self) == LOX_TOKEN_EOF) {
        parser__syntax_error(self, "Expect unary expression.");
        return NULL;
    }

    if (
        lox_parser__peek(self) == LOX_TOKEN_EXCLAM ||
        lox_parser__peek(self) == LOX_TOKEN_MINUS
    ) {
        struct token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct expr* expr = lox_parser__unary(self);
        if (expr == NULL) {
            return NULL;
        }
        return (struct expr*) lox_parser__get_expr__op_unary(self, op, expr);
    }

    return lox_parser__call(self);
}

static struct expr* lox_parser__finish_call(struct parser* self, struct expr* callee) {
    struct lox_expr_node* args = NULL;

    if (lox_parser__peek(self) != LOX_TOKEN_RIGHT_PAREN) {
        struct expr* expr = lox_parser__expression(self);
        if (expr == NULL) {
            // todo: clean up args list
            return NULL;
        }
        u32 number_of_arguments = 1;
        if (expr->type == LOX_PARSER_EXPRESSION_TYPE_NODE) {
            struct lox_expr_node* node = (struct lox_expr_node*) expr;
            args = node;
            node = node->next;
            while (node) {
                ++number_of_arguments;
                node = node->next;
            }
        }
        if (number_of_arguments >= 255) {
            parser__warn_error(self, "Cannot have more than %u arguments.", LOX_MAX_NUMBER_OF_FN_ARGUMENTS);
        }
    }

    struct token* right_paren = lox_parser__advance_err(
        self,
        LOX_TOKEN_RIGHT_PAREN,
        "Expect '%s' after arguments.",
        lox_token__type_name(LOX_TOKEN_RIGHT_PAREN)
    );
    if (right_paren == NULL) {
        return NULL;
    }

    return lox_parser__get_expr__call(self, callee, right_paren, args);
}

struct expr* lox_parser__call(struct parser* self) {
    struct expr* primary_expr = lox_parser__primary(self);
    if (primary_expr == NULL) {
        return NULL;
    }

    while (true) {
        if (lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN) != NULL) {
            primary_expr = lox_parser__finish_call(self, primary_expr);
        } else {
            break ;
        }
    }

    return primary_expr;
}

struct expr* lox_parser__primary(struct parser* self) {
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
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            return (struct expr*) lox_parser__get_expr__literal(self, op);
        } break ;
        case LOX_TOKEN_LEFT_PAREN: {
            ASSERT(lox_parser__advance(self) != NULL);
            struct expr* expr = lox_parser__expression(self);
            if (expr == NULL) {
                return NULL;
            }
            if (lox_parser__advance_err(self, LOX_TOKEN_RIGHT_PAREN, "Expect ')' after expression.") == NULL) {
                return NULL;
            } else {
                return (struct expr*) lox_parser__get_expr__grouping(self, expr);
            }
        } break ;
        case LOX_TOKEN_IDENTIFIER: {
            struct token* var_name = lox_parser__advance(self);
            ASSERT(var_name != NULL);
            struct expr* var_expr = lox_parser__get_expr__var(self, var_name, NULL);
            if (var_expr == NULL) {
                parser__syntax_error(
                    self,
                    "Undefined variable '%.*s'.",
                    var_name->lexeme_len, var_name->lexeme
                );
            }

            return (struct expr*) var_expr; 
        } break ;
        default: {
            return lox_parser__error(self);
        }
    }
}

struct expr* lox_parser__error(struct parser* self) {
    if (lox_parser__peek(self) == LOX_TOKEN_EOF) {
        parser__syntax_error(self, "Expect primary token.");
        return NULL;
    }

    switch (lox_parser__peek(self)) {
        case LOX_TOKEN_COMMA: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect ternary before comma ',' binary operator.");
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect equality before ternary '?' binary operator.");
        } break ;
        case LOX_TOKEN_COLON: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'equality ? expression' before ternary semicolon ':' binary operator.");
        } break ;
        case LOX_TOKEN_EXCLAM_EQUAL: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect comparison expression before '!=' binary operator.");
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect comparison expression before '==' binary operator.");
        } break ;
        case LOX_TOKEN_GREATER: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '>' binary operator.");
        } break ;
        case LOX_TOKEN_GREATER_EQUAL: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '>=' binary operator.");
        } break ;
        case LOX_TOKEN_LESS: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '<' binary operator.");
        } break ;
        case LOX_TOKEN_LESS_EQUAL: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect term expression before '<=' binary operator.");
        } break ;
        case LOX_TOKEN_PLUS: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect factor expression before '+' binary operator.");
        } break ;
        case LOX_TOKEN_EQUAL: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect lvalue expression before '=' binary operator.");
        } break ;
        case LOX_TOKEN_BREAK: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'break' to appear inside an iteration statement's body.");
        } break ;
        case LOX_TOKEN_CONTINUE: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'continue' to appear inside an iteration statement's body.");
        } break ;
        default: {
            struct token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Unknown token '%.*s'.", op->lexeme_len, op->lexeme);
        } break ;
    }

    return NULL;
}
