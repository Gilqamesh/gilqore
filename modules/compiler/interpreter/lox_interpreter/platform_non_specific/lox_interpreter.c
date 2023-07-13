#include "compiler/interpreter/lox_interpreter/lox_interpreter.h"

#include "compiler/parser/lox_parser/lox_parser.h"
#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

static struct parser_literal* lox_interpreter__interpret_expression(struct interpreter* self, struct parser_expression* expr);

static bool lox_parser__literal_is_truthy(struct parser_literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            return true;
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            return false;
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* boolean_literal = (struct lox_literal_boolean*) literal;
            return boolean_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal;
            return number_literal->data != 0.0;
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            return true;
        } break ;
        default: {
            ASSERT(false);
            return false;
        }
    }
}

static struct parser_literal* lox_interpreter__interpret_unary(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    // if (unary_expr->evaluated_literal != NULL) {
    //     return unary_expr->evaluated_literal;
    // }

    struct parser_literal* literal_base = lox_interpreter__interpret_expression(self, unary_expr->expr);

    switch (unary_expr->op->type) {
        case LOX_TOKEN_MINUS: {
            if (literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                interpreter__runtime_error(
                    self,
                    "Expect operand to be '%s' for operator: '%s', but it was of type '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(unary_expr->op->type),
                    lox_parser__literal_type_to_str(literal_base->type)
                );
                return NULL;
            }
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal_base;
            unary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(&self->parser, -number_literal->data);
            return unary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EXCLAM: {
            unary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(&self->parser, !lox_parser__literal_is_truthy(literal_base));
            return unary_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static bool lox_parser__literal_is_equal(struct parser_literal* left, struct parser_literal* right) {
    if (left->type != right->type) {
        return false;
    }

    switch (left->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            // todo: when are two objects equal to each other?
            return false;
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            return right->type == LOX_LITERAL_TYPE_NIL;
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* left_boolean_literal = (struct lox_literal_boolean*) left;
            struct lox_literal_boolean* right_boolean_literal = (struct lox_literal_boolean*) right;
            return left_boolean_literal->data == right_boolean_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* left_number_literal = (struct lox_literal_number*) left;
            struct lox_literal_number* right_number_literal = (struct lox_literal_number*) right;
            return left_number_literal->data == right_number_literal->data;
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            struct lox_literal_string* left_string_literal = (struct lox_literal_string*) left;
            struct lox_literal_string* right_string_literal = (struct lox_literal_string*) right;
            return libc__strcmp(left_string_literal->data, right_string_literal->data) == 0;
        } break ;
        default: {
            ASSERT(false);
            return false;
        }
    }
}

static struct parser_literal* lox_interpreter__interpret_binary(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    // if (binary_expr->evaluated_literal != NULL) {
    //     return binary_expr->evaluated_literal;
    // }

    // note: evaluate both before type checking with left to right associativity
    struct parser_literal* left_literal_base = lox_interpreter__interpret_expression(self, binary_expr->left);
    if (left_literal_base == NULL) {
        return NULL;
    }

    struct parser_literal* right_literal_base = lox_interpreter__interpret_expression(self, binary_expr->right);
    if (right_literal_base == NULL) {
        return NULL;
    }

    switch (binary_expr->op->type) {
        case LOX_TOKEN_MINUS: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                interpreter__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                &self->parser,
                 ((struct lox_literal_number*)left_literal_base)->data - ((struct lox_literal_number*)right_literal_base)->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_SLASH: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                interpreter__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
            struct lox_literal_number* right_literal = (struct lox_literal_number*) right_literal_base;
            if (right_literal->data == 0.0) {
                interpreter__runtime_error(
                    self,
                    "Cannot divide by 0."
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                &self->parser,
                left_literal->data / right_literal->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_STAR: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                interpreter__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                &self->parser,
                ((struct lox_literal_number*)left_literal_base)->data * ((struct lox_literal_number*)right_literal_base)->data
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_PERCENTAGE: {
            if (left_literal_base->type != LOX_LITERAL_TYPE_NUMBER || right_literal_base->type != LOX_LITERAL_TYPE_NUMBER) {
                interpreter__runtime_error(
                    self,
                    "Expect both operands to be '%s' for operand: '%s', but operands were of type '%s' and '%s'.",
                    lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER),
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type), lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
            struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
            struct lox_literal_number* right_literal = (struct lox_literal_number*) right_literal_base;
            s32 left_data = (s32) left_literal->data;
            s32 right_data = (s32) right_literal->data;
            if (right_data == 0) {
                interpreter__runtime_error(
                    self,
                    "Cannot divide by 0."
                );
                return NULL;
            }
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(&self->parser, left_data % right_data);
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_PLUS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__number(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data + ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                    &self->parser,
                    "%s%s", ((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
                struct lox_literal_string* right_literal = (struct lox_literal_string*) right_literal_base;
                if (r64__fractional_part(left_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                        &self->parser,
                        "%.0lf%s", left_literal->data, right_literal->data
                    );
                    return binary_expr->evaluated_literal;
                } else {
                    interpreter__runtime_error(
                        self,
                        "Cannot add fractional number '%lf' to string '%s'.",
                        left_literal->data,
                        right_literal->data
                    );
                    return NULL;
                }
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                struct lox_literal_string* left_literal = (struct lox_literal_string*) left_literal_base;
                struct lox_literal_number* right_literal = (struct lox_literal_number*) right_literal_base;
                if (r64__fractional_part(right_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__string(
                        &self->parser,
                        "%s%.0lf", left_literal->data, right_literal->data
                    );
                    return binary_expr->evaluated_literal;
                } else {
                    interpreter__runtime_error(
                        self,
                        "Cannot add string '%s' to fractional number '%lf'.",
                        left_literal->data,
                        right_literal->data
                    );
                    return NULL;
                }
            } else {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__nil(&self->parser);
                interpreter__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_GREATER: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data > ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) > 0
                );
                return binary_expr->evaluated_literal;
            } else {
                interpreter__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_GREATER_EQUAL: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data >= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) >= 0
                );
                return binary_expr->evaluated_literal;
            } else {
                interpreter__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_LESS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data < ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) < 0
                );
                return binary_expr->evaluated_literal;
            } else {
                interpreter__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_LESS_EQUAL: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data <= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    libc__strcmp(((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data) <= 0
                );
                return binary_expr->evaluated_literal;
            } else {
                interpreter__runtime_error(
                    self,
                    "Binary operator '%s' is not implemented between operands '%s' and '%s'.",
                    lox_token__type_name(binary_expr->op->type),
                    lox_parser__literal_type_to_str(left_literal_base->type),
                    lox_parser__literal_type_to_str(right_literal_base->type)
                );
                return NULL;
            }
        } break ;
        case LOX_TOKEN_EXCLAM_EQUAL: {
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                &self->parser,
                !lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            binary_expr->evaluated_literal = (struct parser_literal*) lox_parser__get_literal__boolean(
                &self->parser,
                lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_QUESTION_MARK: {
            ASSERT(binary_expr->right->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
            struct parser_literal* predicate_literal_base = lox_interpreter__interpret_expression(self, binary_expr->left);
            if (lox_parser__literal_is_truthy(predicate_literal_base)) {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_interpreter__interpret_expression(self, conditional_expr->left);
            } else {
                struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
                return lox_interpreter__interpret_expression(self, conditional_expr->right);
            }
            // evaluate condition
            // return either left expr or right expr
        } break ;
        case LOX_TOKEN_COLON: {
            // note: ternary will select and evaluate either left or right of this binary expr
            return NULL;
        }
        case LOX_TOKEN_EQUAL: {
            ASSERT(binary_expr->left->type == LOX_PARSER_EXPRESSION_TYPE_VAR);
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) binary_expr->left;
            var_expr->evaluated_literal = lox_interpreter__interpret_expression(self, binary_expr->right);
            return var_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return NULL;
}

static void lox_parser__literal_base_print(struct parser_literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            libc__printf("(object)\n");
            ASSERT(false && "todo: implement");
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            libc__printf("nil\n");
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_boolean* boolean_literal = (struct lox_literal_boolean*) literal;
            libc__printf("%s\n", boolean_literal->data ? "true" : "false");
        } break ;
        case LOX_LITERAL_TYPE_NUMBER: {
            struct lox_literal_number* number_literal = (struct lox_literal_number*) literal;
            libc__printf("%lf\n", number_literal->data);
        } break ;
        case LOX_LITERAL_TYPE_STRING: {
            struct lox_literal_string* string_literal = (struct lox_literal_string*) literal;
            libc__printf("%s\n", string_literal->data);
        } break ;
        default: ASSERT(false);
    }
}

static struct parser_literal* lox_interpreter__interpret_grouping(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;
    // if (grouping_expr->evaluated_literal != NULL) {
    //     return grouping_expr->evaluated_literal;
    // }

    return lox_interpreter__interpret_expression(self, grouping_expr->expr);
}

static struct parser_literal* lox_interpreter__interpret_literal(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_literal* literal_expr = (struct lox_parser_expr_literal*) expr;
    if (literal_expr->literal != NULL) {
        return literal_expr->literal;
    }

    // convert token to literal
    switch (literal_expr->value->type) {
        case LOX_TOKEN_NIL: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__nil(&self->parser);
        } break ;
        case LOX_TOKEN_FALSE: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__boolean(&self->parser, false);
        } break ;
        case LOX_TOKEN_TRUE: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__boolean(&self->parser, true);
        } break ;
        case LOX_TOKEN_NUMBER: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__number(&self->parser, libc__strntod(literal_expr->value->lexeme, literal_expr->value->lexeme_len));
        } break ;
        case LOX_TOKEN_STRING: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__string(&self->parser, "%.*s", literal_expr->value->lexeme_len, literal_expr->value->lexeme);
        } break ;
        case LOX_TOKEN_IDENTIFIER: {
            literal_expr->literal = (struct parser_literal*) lox_parser__get_literal__nil(&self->parser);
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return literal_expr->literal;
}

struct parser_literal* lox_interpreter__interpret_variable(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) expr;
    if (var_expr->evaluated_literal != NULL) {
        return var_expr->evaluated_literal;
    }

    struct lox_parser_expr_var* env_var = lox_parser__get_expr__var(&self->parser, var_expr->name);

    if (env_var == NULL) {
        // note: if it was syntax error, we wouldn't be able to reference variables without forward declaration,
        // for example when referencing to functions in a function body
        // making it a runtime error, we can refer to variables that aren't declared yet, so this'd be a runtime error
        //   print a;
        //   var a = 3;
        interpreter__runtime_error(
            self,
            "Undefined variable '%.*s'.",
            var_expr->name->lexeme_len, var_expr->name->lexeme
        );
        return NULL;
    }

    if (env_var->value == NULL) {
        interpreter__runtime_error(self, "Uninitialized variable '%.*s'.", env_var->name->lexeme_len, env_var->name->lexeme);
        return NULL;
    }

    struct parser_literal* evaluated_literal = lox_interpreter__interpret_expression(self, env_var->value);
    if (evaluated_literal == NULL) {
        return NULL;
    }

    env_var->evaluated_literal = evaluated_literal;

    return evaluated_literal;
}

static struct parser_literal* lox_interpreter__interpret_logical(struct interpreter* self, struct parser_expression* expr) {
    struct lox_parser_expr_logical* logical_expr = (struct lox_parser_expr_logical*) expr;
    // if (logical_expr->evaluated_literal != NULL) {
    //     return logical_expr->evaluated_literal;
    // }

    if (logical_expr->op->type == LOX_TOKEN_OR) {
        struct parser_literal* left_literal = lox_interpreter__interpret_expression(self, logical_expr->left);
        if (left_literal == NULL) {
            return NULL;
        }
        if (lox_parser__literal_is_truthy(left_literal) == true) {
            logical_expr->evaluated_literal = left_literal;
            return left_literal;
        }
    } else {
        ASSERT(logical_expr->op->type == LOX_TOKEN_AND);
        struct parser_literal* left_literal = lox_interpreter__interpret_expression(self, logical_expr->left);
        if (left_literal == NULL) {
            return NULL;
        }
        if (lox_parser__literal_is_truthy(left_literal) == false) {
            logical_expr->evaluated_literal = left_literal;
            return left_literal;
        }
    }

    return lox_interpreter__interpret_expression(self, logical_expr->right);
}

static struct parser_literal* lox_interpreter__interpret_expression(struct interpreter* self, struct parser_expression* expr) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_interpreter__interpret_unary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_interpreter__interpret_binary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_interpreter__interpret_grouping(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_interpreter__interpret_literal(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_VAR: return lox_interpreter__interpret_variable(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: return lox_interpreter__interpret_logical(self, expr);
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static void lox_interpreter__interpret_statement(struct interpreter* self, struct parser_statement* statement) {
    switch (statement->type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: {
            struct lox_parser_statement_print* print_statement = (struct lox_parser_statement_print*) statement;
            struct parser_literal* literal_base = lox_interpreter__interpret_expression(self, print_statement->expr);
            if (literal_base != NULL) {
                lox_parser__literal_base_print(literal_base);
            }
            // lox_interpreter__interpret_expr(self, print_statement->expr);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: {
            struct lox_parser_statement_expression* expression_statement = (struct lox_parser_statement_expression*) statement;
            struct parser_literal* expr_literal_base = lox_interpreter__interpret_expression(self, expression_statement->expr);
            (void) expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: {
            struct lox_parser_statement_var_decl* variable_statement = (struct lox_parser_statement_var_decl*) statement;
            struct parser_literal* var_expr_literal_base = lox_interpreter__interpret_expression(self, variable_statement->var_expr);
            (void) var_expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BLOCK: {
            struct lox_parser_statement_block* block_statement = (struct lox_parser_statement_block*) statement;
            // todo: later when blocks that can be revisited are introduced, this won't need to increment in that case
            lox_parser__increment_environment(&self->parser);
            struct lox_parser_statement_node* cur_node = block_statement->statement_list;
            while (cur_node != NULL) {
                lox_interpreter__interpret_statement(self, cur_node->statement);
                cur_node = cur_node->next;
            }
            lox_parser__decrement_environment(&self->parser);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_NODE: {
            struct lox_parser_statement_node* node_statement = (struct lox_parser_statement_node*) statement;
            (void) node_statement;
            ASSERT(false);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_IF: {
            struct lox_parser_statement_if* if_statement = (struct lox_parser_statement_if*) statement;
            struct parser_literal* condition_expr = lox_interpreter__interpret_expression(self, if_statement->condition);
            if (lox_parser__literal_is_truthy(condition_expr)) {
                lox_interpreter__interpret_statement(self, if_statement->then_branch);
            } else if (if_statement->else_branch) {
                lox_interpreter__interpret_statement(self, if_statement->else_branch);
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_WHILE: {
            struct lox_parser_statement_while* while_statement = (struct lox_parser_statement_while*) statement;
            while (lox_parser__literal_is_truthy(lox_interpreter__interpret_expression(self, while_statement->condition))) {
                lox_interpreter__interpret_statement(self, while_statement->statement);
            }
        } break ;
        default: ASSERT(false);
    }
}

void lox_interpreter__interpret_program(struct interpreter* self, struct parser_program program) {
    struct parser* parser = &self->parser;
    parser->env_parse_id = program.starting_env_parse_id;
    parser->env_stack_ids_fill = program.starting_env_stack_ids_fill;
    lox_interpreter__interpret_statement(self, program.statement);
}