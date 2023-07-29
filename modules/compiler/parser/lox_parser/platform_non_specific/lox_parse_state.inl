struct parser_statement* lox_parser__declaration(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__var_declaration(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__expr_statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__for_statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__if_statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__while_statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__break_statement(struct parser* self);
struct parser_statement* lox_parser__continue_statement(struct parser* self);
struct parser_statement* lox_parser__print_statement(struct parser* self, struct lox_var_environment* env);
struct parser_statement* lox_parser__block_statement(struct parser* self);
struct parser_expression* lox_parser__expression(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__comma(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__assignment(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__ternary(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__logical_or(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__logical_and(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__equality(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__comparison(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__term(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__factor(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__unary(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__call(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__primary(struct parser* self, struct lox_var_environment* env);
struct parser_expression* lox_parser__error(struct parser* self);

struct parser_statement* lox_parser__declaration(struct parser* self, struct lox_var_environment* env) {
    // 
    struct tokenizer_token* var_token = lox_parser__advance_if(self, LOX_TOKEN_VAR);
    if (var_token) {
        return lox_parser__var_declaration(self, env);
    }

    return lox_parser__statement(self, env);
}

struct parser_statement* lox_parser__var_declaration(struct parser* self, struct lox_var_environment* env) {
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
        var_initializer = lox_parser__expression(self, env);
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

    struct lox_parser_expr_var* var_value = lox_parser__define_expr_var(self, env, var_token, var_initializer);

    return (struct parser_statement*) lox_parser__get_statement_var_decl(self, env, (struct parser_expression*) var_value);
}

struct parser_statement* lox_parser__statement(struct parser* self, struct lox_var_environment* env) {
    if (lox_parser__advance_if(self, LOX_TOKEN_IF) != NULL) {
        return lox_parser__if_statement(self, env);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_FOR) != NULL) {
        return lox_parser__for_statement(self, env);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_WHILE) != NULL) {
        return lox_parser__while_statement(self, env);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_PRINT) != NULL) {
        return lox_parser__print_statement(self, env);
    }

    // todo: syntax error if not in an iteration statement
    if (lox_parser__advance_if(self, LOX_TOKEN_BREAK) != NULL) {
        return lox_parser__break_statement(self);
    }

    // todo: syntax error if not in an iteration statement
    if (lox_parser__advance_if(self, LOX_TOKEN_CONTINUE) != NULL) {
        return lox_parser__continue_statement(self);
    }

    if (lox_parser__advance_if(self, LOX_TOKEN_LEFT_BRACE) != NULL) {
        struct parser_statement* block_statement = lox_parser__block_statement(self);
        if (block_statement == NULL) {
            return NULL;
        }
        return block_statement;
    }

    return lox_parser__expr_statement(self, env);
}

struct parser_statement* lox_parser__expr_statement(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* expression = lox_parser__expression(self, env);
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

    return (struct parser_statement*) lox_parser__get_statement_expression(self, env, expression);
}

struct parser_statement* lox_parser__for_statement(struct parser* self, struct lox_var_environment* env) {
    struct tokenizer_token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(self, "Expect '(' after 'for'.");
        return NULL;
    }

    struct lox_var_environment* wrapper_env = lox_parser__push_environment(self);

    struct parser_statement* initializer = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) != NULL) {
        initializer = NULL;
    } else if (lox_parser__advance_if(self, LOX_TOKEN_VAR) != NULL) {
        // todo: comma separated var declaration
        initializer = lox_parser__var_declaration(self, env);
        if (initializer == NULL) {
            return NULL;
        }
    } else {
        initializer = lox_parser__expr_statement(self, env);
        if (initializer == NULL) {
            return NULL;
        }
    }

    struct lox_var_environment* loop_wrapper_env = lox_parser__push_environment(self);

    struct parser_expression* condition = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        condition = lox_parser__expression(self, env);
        if (lox_parser__advance_err(
            self,
            LOX_TOKEN_SEMICOLON,
            "Expect ';' after loop condition."
        ) == NULL) {
            return NULL;
        }
    }

    struct parser_expression* increment = NULL;
    if (lox_parser__advance_if(self, LOX_TOKEN_RIGHT_PAREN) == NULL) {
        increment = lox_parser__expression(self, env);
        if (lox_parser__advance_err(
            self,
            LOX_TOKEN_RIGHT_PAREN,
            "Expect ')' after loop clauses."
        ) == NULL) {
            return NULL;
        }
    }

    struct parser_statement* loop_body = lox_parser__statement(self, env);
    if (loop_body == NULL) {
        return NULL;
    }

    lox_parser__decrement_environment(self);
    lox_parser__decrement_environment(self);

    // note: desugaring so that the backend can use its building blocks without supporting for loop evaluations

    struct lox_parser_statement_node* loop_body_node = lox_parser__get_statement_node(self, loop_body->env, loop_body);
    struct lox_parser_statement_node* initializer_node = NULL;
    struct lox_parser_statement_node* increment_node = NULL;

    if (increment != NULL) {
        increment_node = lox_parser__get_statement_node(
            self,
            loop_wrapper_env,
            (struct parser_statement*) lox_parser__get_statement_expression(self, loop_wrapper_env, increment)
        );
        // note: execute the body of the loop and then the increment
        loop_body_node->next = increment_node;
    }

    if (condition == NULL) {
        condition = (struct parser_expression*) lox_parser__get_expr__literal_true(self);
    }

    struct parser_statement* while_loop_stmt = (struct parser_statement*) lox_parser__get_statement_while(
        self,
        loop_body->env,
        condition,
        (struct parser_statement*) lox_parser__get_statement_block(
            self,
            loop_body->env,
            loop_body_node
        )
    );
    struct lox_parser_statement_node* whole_loop_stmt_node = lox_parser__get_statement_node(
        self,
        loop_body->env,
        while_loop_stmt
    );

    if (initializer != NULL) {
        initializer_node = lox_parser__get_statement_node(self, wrapper_env, initializer);
        // note: execute the initializer clause of the loop and then the loop body
        initializer_node->next = whole_loop_stmt_node;
        whole_loop_stmt_node = initializer_node;
    }

    return (struct parser_statement*) lox_parser__get_statement_block(self, wrapper_env, whole_loop_stmt_node);
}

struct parser_statement* lox_parser__if_statement(struct parser* self, struct lox_var_environment* env) {
    struct tokenizer_token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(
            self,
            "Expect '(' after '%s'.",
            lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_IF)
        );
        return NULL;
    }

    struct parser_expression* condition = lox_parser__expression(self, env);
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

    struct parser_statement* then_branch = lox_parser__statement(self, env);
    if (then_branch == NULL) {
        return NULL;
    }
    struct parser_statement* else_branch = NULL;
    struct tokenizer_token* else_token = lox_parser__advance_if(self, LOX_TOKEN_ELSE);
    if (else_token != NULL) {
        else_branch = lox_parser__statement(self, env);
        if (else_branch == NULL) {
            return NULL;
        }
    }

    return (struct parser_statement*) lox_parser__get_statement_if(self, env, condition, then_branch, else_branch);
}

struct parser_statement* lox_parser__while_statement(struct parser* self, struct lox_var_environment* env) {
    struct tokenizer_token* left_param = lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN);
    if (left_param == NULL) {
        parser__syntax_error(
            self,
            "Expect '(' after '%s' statement.",
            lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_WHILE)
        );
        return NULL;
    }

    struct parser_expression* condition = lox_parser__expression(self, env);
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

    struct parser_statement* while_body = lox_parser__statement(self, env);
    if (while_body == NULL) {
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_while(self, env, condition, while_body);
}

struct parser_statement* lox_parser__break_statement(struct parser* self) {
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        parser__syntax_error(
            self,
            "Expect ';' after '%s' statement.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_BREAK)
        );
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_break(self);
}

struct parser_statement* lox_parser__continue_statement(struct parser* self) {
    if (lox_parser__advance_if(self, LOX_TOKEN_SEMICOLON) == NULL) {
        parser__syntax_error(
            self,
            "Expect ';' after '%s' statement.", lox_parser__statement_type_to_str(LOX_PARSER_STATEMENT_TYPE_CONTINUE)
        );
        return NULL;
    }

    return (struct parser_statement*) lox_parser__get_statement_continue(self);
}

struct parser_statement* lox_parser__print_statement(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* expression = lox_parser__expression(self, env);
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

    return (struct parser_statement*) lox_parser__get_statement_print(self, env, expression);
}

struct parser_statement* lox_parser__block_statement(struct parser* self) {
    struct lox_parser_statement_node* block_statement_node = NULL;
    struct lox_parser_statement_node** pblock_statement_node = &block_statement_node;

    struct lox_var_environment* block_env = lox_parser__push_environment(self);

    while (
        lox_parser__peek(self) != LOX_TOKEN_RIGHT_BRACE &&  
        lox_parser__is_finished_parsing(self) == false
    ) {
        struct parser_statement* statement = lox_parser__declaration(self, block_env);
        if (statement == NULL) {
            // todo: free block_statement_node list
            return NULL;
        }
        *pblock_statement_node = lox_parser__get_statement_node(self, block_env, statement);
        pblock_statement_node = &(*pblock_statement_node)->next;
    }

    if (lox_parser__advance_err(self, LOX_TOKEN_RIGHT_BRACE, "Expect '}' after block.") == NULL) {
        // todo: free block_statement_node list
        // todo: undo block_env
        // todo: synchronize
        return NULL;
    }

    lox_parser__decrement_environment(self);

    return (struct parser_statement*) lox_parser__get_statement_block(self, block_env, block_statement_node);
}

struct parser_expression* lox_parser__expression(struct parser* self, struct lox_var_environment* env) {
    return lox_parser__comma(self, env);
}

struct parser_expression* lox_parser__comma(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* assignment_expr = lox_parser__assignment(self, env);
    if (assignment_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_COMMA) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* expression = lox_parser__expression(self, env);
        if (expression == NULL) {
            return NULL;
        }
        assignment_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(self, assignment_expr, op, expression);
    }

    return assignment_expr;
}

struct parser_expression* lox_parser__assignment(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_expr = lox_parser__ternary(self, env);
    if (left_expr == NULL) {
        return NULL;
    }

    struct tokenizer_token* equal_token = lox_parser__advance_if(self, LOX_TOKEN_EQUAL);
    if (equal_token != NULL) {
        struct parser_expression* right_expr = lox_parser__assignment(self, env);
        if (right_expr == NULL) {
            return NULL;
        }

        if (left_expr->type == LOX_PARSER_EXPRESSION_TYPE_VAR) {
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) left_expr;
            (void) var_expr;
            left_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_expr, equal_token, right_expr);
            // ASSERT(lox_parser__set_expr__var(self, env, var_expr->name, right_expr) != NULL);
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

struct parser_expression* lox_parser__ternary(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* conditional_expr = lox_parser__logical_or(self, env);
    if (conditional_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_QUESTION_MARK) {
        struct tokenizer_token* question_mark_op = lox_parser__advance(self);
        ASSERT(question_mark_op != NULL);
        struct parser_expression* left_expr = lox_parser__expression(self, env);
        if (left_expr == NULL) {
            return NULL;
        }
        struct tokenizer_token* colon_op = lox_parser__advance_err(self, LOX_TOKEN_COLON, "Expect ':' in ternary expression.");
        if (colon_op == NULL) {
            return NULL;
        }
        struct parser_expression* right_expr = lox_parser__expression(self, env);
        if (right_expr == NULL) {
            return NULL;
        }
        conditional_expr = (struct parser_expression*) lox_parser__get_expr__op_binary(
            self,
            conditional_expr,
            question_mark_op,
            (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_expr, colon_op, right_expr)
        );
    }

    return conditional_expr;
}

struct parser_expression* lox_parser__logical_or(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_logical_and_expr = lox_parser__logical_and(self, env);
    if (left_logical_and_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_OR) {
        struct tokenizer_token* or_token = lox_parser__advance_if(self, LOX_TOKEN_OR);
        ASSERT(or_token != NULL);
        struct parser_expression* right_logical_and_expr = lox_parser__logical_and(self, env);
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

struct parser_expression* lox_parser__logical_and(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_equality_expr = lox_parser__equality(self, env);
    if (left_equality_expr == NULL) {
        return NULL;
    }

    while (lox_parser__peek(self) == LOX_TOKEN_AND) {
        struct tokenizer_token* and_token = lox_parser__advance_if(self, LOX_TOKEN_AND);
        ASSERT(and_token != NULL);
        struct parser_expression* right_equality_expr = lox_parser__equality(self, env);
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

struct parser_expression* lox_parser__equality(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_comp = lox_parser__comparison(self, env);
    if (left_comp == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_EXCLAM_EQUAL ||
        lox_parser__peek(self) == LOX_TOKEN_EQUAL_EQUAL
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_comp = lox_parser__comparison(self, env);
        if (right_comp == NULL) {
            return NULL;
        }
        left_comp = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_comp, op, right_comp);
    }

    return left_comp;
}

struct parser_expression* lox_parser__comparison(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_term = lox_parser__term(self, env);
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
        struct parser_expression* right_term = lox_parser__term(self, env);
        if (right_term == NULL) {
            return NULL;
        }
        left_term = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_term, op, right_term);
    }

    return left_term;
}

struct parser_expression* lox_parser__term(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_factor = lox_parser__factor(self, env);
    if (left_factor == NULL) {
        return NULL;
    }

    while (
        lox_parser__peek(self) == LOX_TOKEN_MINUS ||
        lox_parser__peek(self) == LOX_TOKEN_PLUS
    ) {
        struct tokenizer_token* op = lox_parser__advance(self);
        ASSERT(op != NULL);
        struct parser_expression* right_factor = lox_parser__factor(self, env);
        if (right_factor == NULL) {
            return NULL;
        }
        left_factor = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_factor, op, right_factor);
    }

    return left_factor;
}

struct parser_expression* lox_parser__factor(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* left_unary = lox_parser__unary(self, env);
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
        struct parser_expression* right_unary = lox_parser__unary(self, env);
        if (right_unary == NULL) {
            return NULL;
        }
        left_unary = (struct parser_expression*) lox_parser__get_expr__op_binary(self, left_unary, op, right_unary);
    }

    return left_unary;
}

struct parser_expression* lox_parser__unary(struct parser* self, struct lox_var_environment* env) {
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
        struct parser_expression* expr = lox_parser__unary(self, env);
        if (expr == NULL) {
            return NULL;
        }
        return (struct parser_expression*) lox_parser__get_expr__op_unary(self, op, expr);
    }

    return lox_parser__call(self, env);
}

static struct parser_expression* lox_parser__finish_call(
    struct parser* self,
    struct lox_var_environment* env,
    struct parser_expression* callee
) {
    struct lox_parser_expr_call_node* args = NULL;
    struct lox_parser_expr_call_node** cur = &args;

    u32 number_of_arguments = 0;
    if (lox_parser__peek(self) != LOX_TOKEN_RIGHT_PAREN) {
        do {
            struct parser_expression* expr = lox_parser__expression(self, env);
            if (expr == NULL) {
                // todo: clean up args list
                return NULL;
            }
            ++number_of_arguments;
            if (number_of_arguments >= 255) {
                parser__warn_error(
                    self,
                    "Cannot have more than 255 arguments."
                );
            }
            *cur = lox_parser__get_expr__node(self, expr);
            cur = &((*cur)->next);
        } while (lox_parser__advance_if(self, LOX_TOKEN_COMMA) != NULL);
    }

    struct tokenizer_token* right_paren = lox_parser__advance_err(
        self,
        LOX_TOKEN_RIGHT_PAREN,
        "Expect '%s' after arguments.",
        lox_token__type_name(LOX_TOKEN_RIGHT_PAREN)
    );
    if (right_paren == NULL) {
        return NULL;
    }

    return (struct parser_expression*) lox_parser__get_expr__call(self, env, callee, right_paren, args);
}

struct parser_expression* lox_parser__call(struct parser* self, struct lox_var_environment* env) {
    struct parser_expression* primary_expr = lox_parser__primary(self, env);
    if (primary_expr == NULL) {
        return NULL;
    }

    while (true) {
        if (lox_parser__advance_if(self, LOX_TOKEN_LEFT_PAREN) != NULL) {
            primary_expr = lox_parser__finish_call(self, env, primary_expr);
        } else {
            break ;
        }
    }

    return primary_expr;
}

struct parser_expression* lox_parser__primary(struct parser* self, struct lox_var_environment* env) {
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
            struct parser_expression* expr = lox_parser__expression(self, env);
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
            struct lox_parser_expr_var* var_expr = lox_parser__get_expr__var(self, env, var_name);
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
        case LOX_TOKEN_BREAK: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'break' to appear inside an iteration statement's body.");
        } break ;
        case LOX_TOKEN_CONTINUE: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Expect 'continue' to appear inside an iteration statement's body.");
        } break ;
        default: {
            struct tokenizer_token* op = lox_parser__advance(self);
            ASSERT(op != NULL);
            parser__syntax_error(self, "Unknown token '%.*s'.", op->lexeme_len, op->lexeme);
        } break ;
    }

    return NULL;
}
