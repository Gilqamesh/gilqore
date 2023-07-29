#include "compiler/interpreter/lox_interpreter/lox_interpreter.h"

#include "compiler/parser/lox_parser/lox_parser.h"
#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"

#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

static struct parser_literal* lox_interpreter__interpret_expression(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
);

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

static struct parser_literal* lox_interpreter__interpret_unary(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_op_unary* unary_expr = (struct lox_parser_expr_op_unary*) expr;
    // if (unary_expr->evaluated_literal != NULL) {
    //     return unary_expr->evaluated_literal;
    // }

    struct parser_literal* literal_base = lox_interpreter__interpret_expression(self, env, unary_expr->expr);

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

static struct parser_literal* lox_interpreter__interpret_ternary(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;

    ASSERT(binary_expr->right->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
    struct parser_literal* predicate_literal_base = lox_interpreter__interpret_expression(self, env, binary_expr->left);
    struct lox_parser_expr_op_binary* conditional_expr = (struct lox_parser_expr_op_binary*) binary_expr->right;
    if (lox_parser__literal_is_truthy(predicate_literal_base)) {
        return lox_interpreter__interpret_expression(self, env, conditional_expr->left);
    } else {
        return lox_interpreter__interpret_expression(self, env, conditional_expr->right);
    }
}

static struct parser_literal* lox_interpreter__interpret_binary(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_op_binary* binary_expr = (struct lox_parser_expr_op_binary*) expr;
    // if (binary_expr->evaluated_literal != NULL) {
    //     return binary_expr->evaluated_literal;
    // }

    if (binary_expr->op->type == LOX_TOKEN_QUESTION_MARK) {
        return lox_interpreter__interpret_ternary(self, env, expr);
    }

    // note: evaluate both before type checking with left to right associativity
    struct parser_literal* left_literal_base = lox_interpreter__interpret_expression(self, env, binary_expr->left);
    if (left_literal_base == NULL) {
        return NULL;
    }

    struct parser_literal* right_literal_base = lox_interpreter__interpret_expression(self, env, binary_expr->right);
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
            // note: ternary is handled in a different code path
            ASSERT(false);
            return NULL;
        } break ;
        case LOX_TOKEN_COLON: {
            // note: ternary (passed from the parses as question mark token) will select and evaluate either left or right of this binary expr
            ASSERT(false);
            return NULL;
        } break ;
        case LOX_TOKEN_EQUAL: {
            ASSERT(binary_expr->left->type == LOX_PARSER_EXPRESSION_TYPE_VAR);
            struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) binary_expr->left;
            var_expr->evaluated_literal = lox_interpreter__interpret_expression(self, env, binary_expr->right);
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

static struct parser_literal* lox_interpreter__interpret_grouping(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_grouping* grouping_expr = (struct lox_parser_expr_grouping*) expr;
    // if (grouping_expr->evaluated_literal != NULL) {
    //     return grouping_expr->evaluated_literal;
    // }

    return lox_interpreter__interpret_expression(self, env, grouping_expr->expr);
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

struct parser_literal* lox_interpreter__interpret_variable(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_var* var_expr = (struct lox_parser_expr_var*) expr;
    // note: expr is different in each env, so don't rely on it, however name is shared
    var_expr = lox_parser__get_expr__var(&self->parser, env, var_expr->name);
    if (var_expr->evaluated_literal != NULL) {
        return var_expr->evaluated_literal;
    }

    if (var_expr == NULL) {
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

    if (var_expr->value == NULL) {
        interpreter__runtime_error(self, "Uninitialized variable '%.*s'.", var_expr->name->lexeme_len, var_expr->name->lexeme);
        return NULL;
    }

    struct parser_literal* evaluated_literal = lox_interpreter__interpret_expression(self, env, var_expr->value);
    if (evaluated_literal == NULL) {
        return NULL;
    }

    var_expr->evaluated_literal = evaluated_literal;

    return evaluated_literal;
}

static struct parser_literal* lox_interpreter__interpret_logical(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_logical* logical_expr = (struct lox_parser_expr_logical*) expr;
    // if (logical_expr->evaluated_literal != NULL) {
    //     return logical_expr->evaluated_literal;
    // }

    if (logical_expr->op->type == LOX_TOKEN_OR) {
        struct parser_literal* left_literal = lox_interpreter__interpret_expression(self, env, logical_expr->left);
        if (left_literal == NULL) {
            return NULL;
        }
        if (lox_parser__literal_is_truthy(left_literal) == true) {
            logical_expr->evaluated_literal = left_literal;
            return left_literal;
        }
    } else {
        ASSERT(logical_expr->op->type == LOX_TOKEN_AND);
        struct parser_literal* left_literal = lox_interpreter__interpret_expression(self, env, logical_expr->left);
        if (left_literal == NULL) {
            return NULL;
        }
        if (lox_parser__literal_is_truthy(left_literal) == false) {
            logical_expr->evaluated_literal = left_literal;
            return left_literal;
        }
    }

    return lox_interpreter__interpret_expression(self, env, logical_expr->right);
}

static struct parser_literal* lox_interpreter__interpret_call(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    struct lox_parser_expr_call* call_expr = (struct lox_parser_expr_call*) expr;

    char buffer[512];
    u32 buffer_size = ARRAY_SIZE(buffer);

    struct parser_literal* callee = lox_interpreter__interpret_expression(self, env, call_expr->callee);
    if (callee->type != LOX_LITERAL_TYPE_OBJECT) {
        lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        interpreter__runtime_error(
            self,
            "Expected callee '%s' to be of type '%s', but is '%s'",
            buffer, lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_OBJECT), lox_parser__literal_type_to_str(callee->type)
        );
        return NULL;
    }

    struct lox_literal_object* callee_obj = (struct lox_literal_object*) lox_interpreter__interpret_expression(self, env, call_expr->callee);
    if (callee == NULL) {
        return NULL;
    }

    if (callee_obj->header.call == NULL) {
        lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        interpreter__runtime_error(self, "Object '%s' is not callable.", buffer);
        return NULL;
    }

    u32 arity = 0;
    struct lox_parser_expr_call_node* cur = call_expr->arguments;
    while (cur != NULL) {
        ++arity;
        cur = cur->next;
    }
    if (callee_obj->header.arity != arity) {
        char* buffer_end = lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        *buffer_end++ = '\0';
        char* args = buffer_end;
        lox_parser__expression_to_str((struct parser_expression*) call_expr->arguments, args, &buffer_size);
        interpreter__runtime_error(self, "Expected %u arguments for '%s' but got %u: %s(s).", callee_obj->header.arity, args, arity, callee_obj->header.arity, buffer);
        return NULL;
    }

    return callee_obj->header.call(self, call_expr);
}

static struct parser_literal* lox_interpreter__interpret_expression(
    struct interpreter* self,
    struct lox_var_environment* env,
    struct parser_expression* expr
) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_interpreter__interpret_unary(self, env, expr);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_interpreter__interpret_binary(self, env, expr);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_interpreter__interpret_grouping(self, env, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_interpreter__interpret_literal(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_VAR: return lox_interpreter__interpret_variable(self, env, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: return lox_interpreter__interpret_logical(self, env, expr);
        case LOX_PARSER_EXPRESSION_TYPE_NODE: {
            // should be handled in block statements
            ASSERT(false);
            return NULL;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_CALL: return lox_interpreter__interpret_call(self, env, expr);
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

enum statement_return_type {
    STATEMENT_RETURN_TYPE_CONTINUE,
    STATEMENT_RETURN_TYPE_BREAK,
    STATEMENT_RETURN_TYPE_NORMAL
};

static enum statement_return_type lox_interpreter__interpret_statement(
    struct interpreter* self,
    struct parser_statement* statement
) {
    enum statement_return_type result = STATEMENT_RETURN_TYPE_NORMAL;

    switch (statement->type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: {
            struct lox_parser_statement_print* print_statement = (struct lox_parser_statement_print*) statement;
            struct parser_literal* literal_base = lox_interpreter__interpret_expression(self, statement->env, print_statement->expr);
            if (literal_base != NULL) {
                lox_parser__literal_base_print(literal_base);
            }
            // lox_interpreter__interpret_expr(self, print_statement->expr);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: {
            struct lox_parser_statement_expression* expression_statement = (struct lox_parser_statement_expression*) statement;
            struct parser_literal* expr_literal_base = lox_interpreter__interpret_expression(self, statement->env, expression_statement->expr);
            (void) expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: {
            struct lox_parser_statement_var_decl* variable_statement = (struct lox_parser_statement_var_decl*) statement;
            struct parser_literal* var_expr_literal_base = lox_interpreter__interpret_expression(self, statement->env, variable_statement->var_expr);
            (void) var_expr_literal_base;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BLOCK: {
            struct lox_parser_statement_block* block_statement = (struct lox_parser_statement_block*) statement;
            // copy env in the block_statement and pass it with the interpret_statement function
            struct lox_var_environment* copied_env = lox_parser__copy_environment(&self->parser, block_statement->base.env);
            struct lox_parser_statement_node* cur_node = block_statement->statement_list;
            while (cur_node != NULL) {
                struct lox_var_environment* static_env = cur_node->statement->env;
                if (cur_node->statement->type != LOX_PARSER_STATEMENT_TYPE_BLOCK) {
                    cur_node->statement->env = copied_env;
                }
                enum statement_return_type return_type = lox_interpreter__interpret_statement(self, cur_node->statement);
                cur_node->statement->env = static_env;
                if (return_type == STATEMENT_RETURN_TYPE_CONTINUE) {
                    result = STATEMENT_RETURN_TYPE_CONTINUE;
                    break ;
                } else if (return_type == STATEMENT_RETURN_TYPE_BREAK) {
                    result = STATEMENT_RETURN_TYPE_BREAK;
                    break ;
                }
                cur_node = cur_node->next;
            }
            // delete copied env
            lox_parser__delete_environment(&self->parser, copied_env);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_NODE: {
            struct lox_parser_statement_node* node_statement = (struct lox_parser_statement_node*) statement;
            (void) node_statement;
            ASSERT(false);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_IF: {
            struct lox_parser_statement_if* if_statement = (struct lox_parser_statement_if*) statement;
            struct parser_literal* condition_expr = lox_interpreter__interpret_expression(self, statement->env, if_statement->condition);
            if (lox_parser__literal_is_truthy(condition_expr)) {
                lox_interpreter__interpret_statement(self, if_statement->then_branch);
            } else if (if_statement->else_branch) {
                lox_interpreter__interpret_statement(self, if_statement->else_branch);
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_WHILE: {
            struct lox_parser_statement_while* while_statement = (struct lox_parser_statement_while*) statement;
            while (lox_parser__literal_is_truthy(lox_interpreter__interpret_expression(self, statement->env, while_statement->condition))) {
                enum statement_return_type ret_type = lox_interpreter__interpret_statement(self, while_statement->statement);
                if (ret_type == STATEMENT_RETURN_TYPE_BREAK) {
                    break ;
                }
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BREAK: {
            result = STATEMENT_RETURN_TYPE_BREAK;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_CONTINUE: {
            result = STATEMENT_RETURN_TYPE_CONTINUE;
        } break ;
        default: ASSERT(false);
    }

    return result;
}
void lox_interpreter__interpret_ast(struct interpreter* self, struct parser_ast ast) {
    ASSERT(ast.statement != NULL);
    lox_interpreter__interpret_statement(self, ast.statement);
}

struct tokenizer_token* lox_interpreter__get_native(struct interpreter* self, const char* native_name) {
    if (self->native_callables_fill == self->native_callables_size) {
        error_code__exit(234782);
    }

    struct tokenizer_token* result = (struct tokenizer_token*) memory_slice__memory(&self->native_callables_memory) + self->native_callables_fill++;
    result->lexeme = native_name;
    result->lexeme_len = libc__strlen(native_name);
    result->type = LOX_TOKEN_IDENTIFIER;
    result->line = -1;

    return result;
}

static void lox_interpreter__add_native(
    struct interpreter* self,
    const char* name,
    u32 arity,
    struct parser_literal* (*call)(struct interpreter* interpreter, struct lox_parser_expr_call* call)
) {
    struct parser* parser = &self->parser;

    struct lox_var_environment* global_env = lox_parser__get_global_environment(parser);
    struct tokenizer_token* native_token = lox_interpreter__get_native(self, name);
    struct object_header header = {
        .arity = arity,
        .call = call
    };
    struct lox_literal_object* call_obj = lox_parser__get_literal__object(parser, header, memory_slice__create(NULL, 0));
    struct lox_parser_expr_literal* native_literal_expr = lox_parser__get_expr__literal(parser, native_token);
    native_literal_expr->literal = (struct parser_literal*) call_obj;
    lox_parser__define_expr_var(
        parser,
        global_env,
        native_token,
        (struct parser_expression*) native_literal_expr
    );

    ++self->native_callables_fill;

}

#include "lox_interpreter_native.inl"

bool lox_interpreter__init_native_callables(struct interpreter* self) {
    lox_interpreter__add_native(self, "clock", 0, &lox_interpreter__native_clock);
    lox_interpreter__add_native(self, "usleep", 1, &lox_interpreter__native_usleep);
    lox_interpreter__add_native(self, "sleep", 1, &lox_interpreter__native_sleep);

    return true;
}

bool lox_interpreter__initialize(struct interpreter* self, struct memory_slice internal_buffer) {
    self->tokenizer_fn = &lox_tokenizer__tokenize;
    self->convert_token_to_string_fn = &lox_token__type_name;

    self->parser_clear = &lox_parser__clear;
    self->parser_parse_ast = &lox_parser__parse_ast;
    self->parser_ast_is_valid = &lox_parser__ast_is_valid;
    self->parser_is_finished_parsing = &lox_parser__is_finished_parsing;
    self->parser_convert_expr_to_string = &lox_parser__convert_expr_to_string;

    self->interpreter_interpret_ast = &lox_interpreter__interpret_ast;
    
    u64 total_memory_size = memory_slice__size(&internal_buffer);
    void* total_memory = memory_slice__memory(&internal_buffer);
    
    u64 cur_memory_size = total_memory_size;
    void* cur_memory = total_memory;

    self->native_callables_size = 256;
    u32 native_callables_memory_size = self->native_callables_size * sizeof(struct tokenizer_token);
    self->native_callables_memory = memory_slice__create(cur_memory, native_callables_memory_size);
    self->native_callables_fill = 0;
    cur_memory_size -= native_callables_memory_size;
    cur_memory = (char*) cur_memory + native_callables_memory_size;

    u64 tokenizer_memory_size = cur_memory_size / 2;
    struct memory_slice tokenizer_memory = {
        .memory = cur_memory,
        .size = tokenizer_memory_size
    };
    cur_memory_size -= tokenizer_memory_size;
    cur_memory = (char*) cur_memory + tokenizer_memory_size;

    if (tokenizer__create(&self->tokenizer, tokenizer_memory) == false) {
        return false;
    }

    u64 parser_memory_size = cur_memory_size;
    struct memory_slice parser_memory = {
        .memory = cur_memory,
        .size = parser_memory_size
    };
    cur_memory_size -= parser_memory_size;
    cur_memory = (char*) cur_memory + parser_memory_size;

    if (parser__create(&self->parser, &self->tokenizer, parser_memory) == false) {
        tokenizer__destroy(&self->tokenizer);
        return false;
    }

    return true;
}
