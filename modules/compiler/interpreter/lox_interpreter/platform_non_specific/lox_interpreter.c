#include "compiler/interpreter/lox_interpreter/lox_interpreter.h"

#include "compiler/parser/lox_parser/lox_parser.h"
#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"
#include "algorithms/hash/hash.h"

#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

static struct literal* lox_interpreter__interpret_expression(struct interpreter* self, struct expr* expr);

static struct lox_expr_var* lox_interpreter__bind_fn_decl(struct interpreter* self, struct lox_stmt_fun_decl* fun_decl);

static bool lox_interpreter__bind_global_fn(
    struct interpreter* self,
    const char* name, u32 arity, lox_call_fn call, struct memory_slice context
);

enum statement_return_type {
    STATEMENT_RETURN_TYPE_CONTINUE,
    STATEMENT_RETURN_TYPE_BREAK,
    STATEMENT_RETURN_TYPE_RETURN,
    STATEMENT_RETURN_TYPE_LITERAL,
    STATEMENT_RETURN_TYPE_ERROR
};

struct stmt_return {
    enum statement_return_type type;
    struct literal* literal; // for return
};

static struct stmt_return lox_interpreter__interpret_statement(struct interpreter* self, struct stmt* statement);

static bool lox_parser__literal_is_truthy(struct literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            return true;
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            return false;
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_bool* boolean_literal = (struct lox_literal_bool*) literal;
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

static struct literal* lox_interpreter__interpret_unary(struct interpreter* self, struct expr* expr) {
    struct lox_expr_unary* unary_expr = (struct lox_expr_unary*) expr;
    // if (unary_expr->evaluated_literal != NULL) {
    //     return unary_expr->evaluated_literal;
    // }

    struct literal* literal_base = lox_interpreter__interpret_expression(self, unary_expr->expr);

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
            unary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(&self->parser, -number_literal->data);
            return unary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EXCLAM: {
            unary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(&self->parser, !lox_parser__literal_is_truthy(literal_base));
            return unary_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static bool lox_parser__literal_is_equal(struct literal* left, struct literal* right) {
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
            struct lox_literal_bool* left_boolean_literal = (struct lox_literal_bool*) left;
            struct lox_literal_bool* right_boolean_literal = (struct lox_literal_bool*) right;
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

static struct literal* lox_interpreter__interpret_ternary(struct interpreter* self, struct expr* expr) {
    struct lox_expr_binary* binary_expr = (struct lox_expr_binary*) expr;

    ASSERT(binary_expr->right->type == LOX_PARSER_EXPRESSION_TYPE_OP_BINARY);
    struct literal* predicate_literal_base = lox_interpreter__interpret_expression(self, binary_expr->left);
    if (predicate_literal_base == NULL) {
        return NULL;
    }

    struct lox_expr_binary* conditional_expr = (struct lox_expr_binary*) binary_expr->right;
    if (lox_parser__literal_is_truthy(predicate_literal_base)) {
        return lox_interpreter__interpret_expression(self, conditional_expr->left);
    } else {
        return lox_interpreter__interpret_expression(self, conditional_expr->right);
    }
}

static struct literal* lox_interpreter__interpret_binary(struct interpreter* self, struct expr* expr) {
    struct lox_expr_binary* binary_expr = (struct lox_expr_binary*) expr;
    // if (binary_expr->evaluated_literal != NULL) {
    //     return binary_expr->evaluated_literal;
    // }

    if (binary_expr->op->type == LOX_TOKEN_QUESTION_MARK) {
        return lox_interpreter__interpret_ternary(self, expr);
    }

    // note: evaluate both before type checking with left to right associativity
    struct literal* left_literal_base = lox_interpreter__interpret_expression(self, binary_expr->left);
    if (left_literal_base == NULL) {
        return NULL;
    }

    struct literal* right_literal_base = lox_interpreter__interpret_expression(self, binary_expr->right);
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
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(
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
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(
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
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(
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
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(&self->parser, left_data % right_data);
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_PLUS: {
            if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_NUMBER) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__number(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data + ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__string(
                    &self->parser,
                    "%s%s", ((struct lox_literal_string*)left_literal_base)->data, ((struct lox_literal_string*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_NUMBER && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                struct lox_literal_number* left_literal = (struct lox_literal_number*) left_literal_base;
                struct lox_literal_string* right_literal = (struct lox_literal_string*) right_literal_base;
                if (r64__fractional_part(left_literal->data) == 0.0) {
                    binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__string(
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
                    binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__string(
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
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__nil(&self->parser);
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
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data > ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data >= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data < ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
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
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
                    &self->parser,
                    ((struct lox_literal_number*)left_literal_base)->data <= ((struct lox_literal_number*)right_literal_base)->data
                );
                return binary_expr->evaluated_literal;
            } else if (left_literal_base->type == LOX_LITERAL_TYPE_STRING && right_literal_base->type == LOX_LITERAL_TYPE_STRING) {
                binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
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
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
                &self->parser,
                !lox_parser__literal_is_equal(left_literal_base, right_literal_base)
            );
            return binary_expr->evaluated_literal;
        } break ;
        case LOX_TOKEN_EQUAL_EQUAL: {
            binary_expr->evaluated_literal = (struct literal*) lox_parser__get_literal__boolean(
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
            struct lox_expr_var* var_expr = (struct lox_expr_var*) binary_expr->left;
            var_expr = lox_interpreter__get_var(self, var_expr->name);
            var_expr->evaluated_literal = lox_interpreter__interpret_expression(self, binary_expr->right);
            return var_expr->evaluated_literal;
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return NULL;
}

static void lox_parser__literal_base_print(struct literal* literal) {
    switch (literal->type) {
        case LOX_LITERAL_TYPE_OBJECT: {
            libc__printf("(object)\n");
            ASSERT(false && "todo: implement");
        } break ;
        case LOX_LITERAL_TYPE_NIL: {
            libc__printf("nil\n");
        } break ;
        case LOX_LITERAL_TYPE_BOOLEAN: {
            struct lox_literal_bool* boolean_literal = (struct lox_literal_bool*) literal;
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

static struct literal* lox_interpreter__interpret_grouping(struct interpreter* self, struct expr* expr) {
    struct lox_expr_group* grouping_expr = (struct lox_expr_group*) expr;
    // if (grouping_expr->evaluated_literal != NULL) {
    //     return grouping_expr->evaluated_literal;
    // }

    return lox_interpreter__interpret_expression(self, grouping_expr->expr);
}

static struct literal* lox_interpreter__interpret_literal(struct interpreter* self, struct expr* expr) {
    struct lox_expr_literal* literal_expr = (struct lox_expr_literal*) expr;
    if (literal_expr->literal != NULL) {
        return literal_expr->literal;
    }

    // convert token to literal
    switch (literal_expr->value->type) {
        case LOX_TOKEN_NIL: {
            literal_expr->literal = (struct literal*) lox_parser__get_literal__nil(&self->parser);
        } break ;
        case LOX_TOKEN_FALSE: {
            literal_expr->literal = (struct literal*) lox_parser__get_literal__boolean(&self->parser, false);
        } break ;
        case LOX_TOKEN_TRUE: {
            literal_expr->literal = (struct literal*) lox_parser__get_literal__boolean(&self->parser, true);
        } break ;
        case LOX_TOKEN_NUMBER: {
            literal_expr->literal = (struct literal*) lox_parser__get_literal__number(&self->parser, libc__strntod(literal_expr->value->lexeme, literal_expr->value->lexeme_len));
        } break ;
        case LOX_TOKEN_STRING: {
            literal_expr->literal = (struct literal*) lox_parser__get_literal__string(&self->parser, "%.*s", literal_expr->value->lexeme_len, literal_expr->value->lexeme);
        } break ;
        case LOX_TOKEN_IDENTIFIER: {
            ASSERT(false && "identifier is not a literal type");
            // literal_expr->literal = (struct literal*) lox_parser__get_literal__nil(&self->parser);
        } break ;
        default: {
            ASSERT(false && "not implemented");
        }
    }

    return literal_expr->literal;
}

struct literal* lox_interpreter__interpret_variable(struct interpreter* self, struct expr* expr) {
    struct lox_expr_var* var_expr = (struct lox_expr_var*) expr;

    var_expr = lox_interpreter__get_var(self, var_expr->name);
    if (var_expr->evaluated_literal != NULL) {
        return var_expr->evaluated_literal;
    }

    if (var_expr->value == NULL) {
        interpreter__runtime_error(self, "Uninitialized variable '%.*s'.", var_expr->name->lexeme_len, var_expr->name->lexeme);
        return NULL;
    }

    struct literal* evaluated_literal = lox_interpreter__interpret_expression(self, var_expr->value);
    if (evaluated_literal == NULL) {
        return NULL;
    }

    var_expr->evaluated_literal = evaluated_literal;

    return evaluated_literal;
}

static struct literal* lox_interpreter__interpret_logical(struct interpreter* self, struct expr* expr) {
    struct lox_expr_logical* logical_expr = (struct lox_expr_logical*) expr;
    // if (logical_expr->evaluated_literal != NULL) {
    //     return logical_expr->evaluated_literal;
    // }

    if (logical_expr->op->type == LOX_TOKEN_OR) {
        struct literal* left_literal = lox_interpreter__interpret_expression(self, logical_expr->left);
        if (left_literal == NULL) {
            return NULL;
        }
        if (lox_parser__literal_is_truthy(left_literal) == true) {
            logical_expr->evaluated_literal = left_literal;
            return left_literal;
        }
    } else {
        ASSERT(logical_expr->op->type == LOX_TOKEN_AND);
        struct literal* left_literal = lox_interpreter__interpret_expression(self, logical_expr->left);
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

static struct literal* lox_interpreter__interpret_call(struct interpreter* self, struct expr* expr) {
    struct lox_expr_call* call_expr = (struct lox_expr_call*) expr;

    char buffer[512];
    u32 buffer_size = ARRAY_SIZE(buffer);

    struct literal* callee = lox_interpreter__interpret_expression(self, call_expr->callee);
    if (callee == NULL) {
        return NULL;
    }

    if (callee->type != LOX_LITERAL_TYPE_OBJECT) {
        lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        interpreter__runtime_error(
            self,
            "Expected callee '%s' to be of type '%s', but is '%s'",
            buffer, lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_OBJECT), lox_parser__literal_type_to_str(callee->type)
        );
        return NULL;
    }

    struct lox_literal_obj* callee_obj = (struct lox_literal_obj*) callee;
    if (callee_obj->header.call == NULL) {
        lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        interpreter__runtime_error(self, "Object '%s' is not callable.", buffer);
        return NULL;
    }

    u32 arity = 0;
    struct lox_expr_node* cur = call_expr->parameters;
    while (cur != NULL) {
        ++arity;
        cur = cur->next;
    }
    if (callee_obj->header.arity != arity) {
        char* buffer_end = lox_parser__expression_to_str(call_expr->callee, buffer, &buffer_size);
        *buffer_end++ = '\0';
        char* args = buffer_end;
        if (call_expr->parameters == NULL) {
            *args = '\0';
        } else {
            lox_parser__expression_to_str((struct expr*) call_expr->parameters, args, &buffer_size);
        }
        interpreter__runtime_error(
            self,
            "Expected %u parameters for '%s' but got %u: %s(%s).",
            callee_obj->header.arity, buffer, arity, buffer, args
        );
        return NULL;
    }

    return callee_obj->header.call(self, call_expr);
}

static struct literal* lox_interpreter__interpret_expression(struct interpreter* self, struct expr* expr) {
    switch (expr->type) {
        case LOX_PARSER_EXPRESSION_TYPE_OP_UNARY: return lox_interpreter__interpret_unary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_OP_BINARY: return lox_interpreter__interpret_binary(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_GROUPING: return lox_interpreter__interpret_grouping(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LITERAL: return lox_interpreter__interpret_literal(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_VAR: return lox_interpreter__interpret_variable(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LOGICAL: return lox_interpreter__interpret_logical(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_NODE: {
            // evaluate all and return right-most node (comma)
            struct lox_expr_node* expr_node = (struct lox_expr_node*) expr;
            struct literal* last_evaluated_literal = NULL;
            while (expr_node) {
                last_evaluated_literal = lox_interpreter__interpret_expression(self, expr_node->expression);
                if (last_evaluated_literal == NULL) {
                    return NULL;
                }
                expr_node = expr_node->next;
            }
            return last_evaluated_literal;
        } break ;
        case LOX_PARSER_EXPRESSION_TYPE_CALL: return lox_interpreter__interpret_call(self, expr);
        case LOX_PARSER_EXPRESSION_TYPE_LAMBDA: {
            struct lox_expr_lambda* lambda_expr = (struct lox_expr_lambda*) expr;
            // bind lambda to lambda_expr
            struct lox_expr_var* fn_decl = lox_interpreter__bind_fn_decl(self, lambda_expr->fun_decl);
            if (fn_decl == NULL) {
                return NULL;
            }
            return fn_decl->evaluated_literal;
        }
        default: {
            ASSERT(false);
            return NULL;
        }
    }
}

static struct literal* lox_interpreter__interpret_generic_call(struct interpreter* self, struct lox_expr_call* call_site) {
    /*
    struct lox_expr_call {
        struct expr base;
        struct expr* callee;
        struct token* closing_paren;
        struct lox_expr_node* parameters;
    };
    struct lox_stmt_fun_decl {
        struct stmt base;
        struct token* name;
        struct lox_stmt_token_node* params;
        struct lox_stmt_block* body;
    };
    */
    ASSERT(call_site->callee->type == LOX_PARSER_EXPRESSION_TYPE_VAR);
    struct literal* callee_literal = lox_interpreter__interpret_expression(self, call_site->callee);
    ASSERT(callee_literal->type == LOX_LITERAL_TYPE_OBJECT);
    struct lox_literal_obj* fn_obj = (struct lox_literal_obj*) callee_literal;
    struct lox_stmt_fun_decl* fn_decl = (struct lox_stmt_fun_decl*) memory_slice__memory(&fn_obj->data);

    struct lox_env* caller_env = self->env;
    struct lox_env* fn_decl_env = fn_obj->header.env;
    struct lox_env* fn_env = lox_interpreter__env_pool_get(self);
    fn_env->parent = fn_decl_env;

    struct lox_expr_node* argument = call_site->parameters;
    // define params
    struct lox_stmt_token_node* fn_parameter = fn_decl->params;
    while (fn_parameter != NULL) {
        ASSERT(argument != NULL);

        self->env = caller_env;
        struct literal* evaluated_arg = lox_interpreter__interpret_expression(self, argument->expression);
        self->env = fn_env;

        struct lox_expr_var* arg_var = lox_interpreter__define_var(self, fn_parameter->name, NULL);
        if (arg_var == NULL) {
            return NULL;
        }

        arg_var->evaluated_literal = evaluated_arg;

        fn_parameter = fn_parameter->next;
        argument = argument->next;
    }
    // execute body
    self->env = fn_env;
    struct stmt_return stmt_return = lox_interpreter__interpret_statement(self, (struct stmt*) fn_decl->body);
    self->env = caller_env;

    lox_interpreter__env_pool_put(self, fn_env);

    // todo: get call result
    if (stmt_return.literal != NULL) {
        ASSERT(stmt_return.type == STATEMENT_RETURN_TYPE_RETURN);
        return stmt_return.literal;
    } else {
        return lox_parser__get_literal__nil(&self->parser);
    }
}

static struct stmt_return lox_interpreter__interpret_statement(struct interpreter* self, struct stmt* statement) {
    struct stmt_return result = {
        .type = STATEMENT_RETURN_TYPE_LITERAL,
        .literal = NULL
    };

    switch (statement->type) {
        case LOX_PARSER_STATEMENT_TYPE_PRINT: {
            struct lox_stmt_print* print_statement = (struct lox_stmt_print*) statement;
            struct literal* literal_base = lox_interpreter__interpret_expression(self, print_statement->expr);
            if (literal_base != NULL) {
                lox_parser__literal_base_print(literal_base);
            } else {
                result.type = STATEMENT_RETURN_TYPE_ERROR;
            }
            // lox_interpreter__interpret_expr(self, print_statement->expr);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_EXPRESSION: {
            struct lox_stmt_expr* expression_statement = (struct lox_stmt_expr*) statement;
            if (lox_interpreter__interpret_expression(self, expression_statement->expr) == NULL) {
                result.type = STATEMENT_RETURN_TYPE_ERROR;
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_VAR_DECL: {
            struct lox_stmt_var_decl* variable_statement = (struct lox_stmt_var_decl*) statement;
            struct lox_expr_var* var_expr = (struct lox_expr_var*) variable_statement->var_expr;
            struct lox_expr_var* env_var_expr = lox_interpreter__define_var(self, var_expr->name, var_expr->value);
            if (env_var_expr == NULL) {
                result.type = STATEMENT_RETURN_TYPE_ERROR;
                result.literal = NULL;
                return result;
            }

            if (lox_interpreter__interpret_expression(self, (struct expr*) env_var_expr) == NULL) {
                result.type = STATEMENT_RETURN_TYPE_ERROR;
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BLOCK: {
            struct lox_stmt_block* block_statement = (struct lox_stmt_block*) statement;
            struct lox_stmt_node* cur_node = block_statement->statement_list;

            // these are considered closures
            lox_interpreter__env_push(self);
            while (cur_node != NULL) {
                struct stmt_return stmt_return = lox_interpreter__interpret_statement(self, cur_node->statement);
                if (stmt_return.type == STATEMENT_RETURN_TYPE_RETURN) {
                    return stmt_return;
                }
                if (stmt_return.type != STATEMENT_RETURN_TYPE_LITERAL) {
                    result = stmt_return;
                    break ;
                }
                if (cur_node->statement->type == LOX_PARSER_STATEMENT_TYPE_FUN_DECL) {
                    lox_interpreter__env_push(self);
                }
                cur_node = cur_node->next;
            }
            cur_node = block_statement->statement_list;
            while (cur_node != NULL) {
                if (cur_node->statement->type == LOX_PARSER_STATEMENT_TYPE_FUN_DECL) {
                    lox_interpreter__env_pop(self);
                }
                cur_node = cur_node->next;
            }
            lox_interpreter__env_pop(self);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_NODE: {
            result.type = STATEMENT_RETURN_TYPE_ERROR;
            struct lox_stmt_node* node_statement = (struct lox_stmt_node*) statement;
            (void) node_statement;
            ASSERT(false);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_IF: {
            struct lox_stmt_if* if_statement = (struct lox_stmt_if*) statement;
            struct literal* condition_expr = lox_interpreter__interpret_expression(self, if_statement->condition);
            if (lox_parser__literal_is_truthy(condition_expr)) {
                result = lox_interpreter__interpret_statement(self, if_statement->then_branch);
            } else if (if_statement->else_branch) {
                result = lox_interpreter__interpret_statement(self, if_statement->else_branch);
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_WHILE: {
            struct lox_stmt_while* while_statement = (struct lox_stmt_while*) statement;
            while (lox_parser__literal_is_truthy(lox_interpreter__interpret_expression(self, while_statement->condition))) {
                struct stmt_return stmt_return = lox_interpreter__interpret_statement(self, while_statement->statement);
                if (stmt_return.type == STATEMENT_RETURN_TYPE_RETURN) {
                    return stmt_return;
                }
                if (stmt_return.type != STATEMENT_RETURN_TYPE_LITERAL) {
                    result = stmt_return;
                    break ;
                }
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_BREAK: {
            result.type = STATEMENT_RETURN_TYPE_BREAK;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_CONTINUE: {
            result.type = STATEMENT_RETURN_TYPE_CONTINUE;
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_FUN_PARAMS_NODE: {
            // handled in LOX_PARSER_STATEMENT_TYPE_FUN_DECL
            result.type = STATEMENT_RETURN_TYPE_ERROR;
            ASSERT(false);
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_FUN_DECL: {
            struct lox_stmt_fun_decl* fn_decl = (struct lox_stmt_fun_decl*) statement;
            if (lox_interpreter__bind_fn_decl(self, fn_decl) == NULL) {
                result.type = STATEMENT_RETURN_TYPE_ERROR;
            }
        } break ;
        case LOX_PARSER_STATEMENT_TYPE_RETURN: {
            struct lox_stmt_return* return_stmt = (struct lox_stmt_return*) statement;
            struct literal* return_value = lox_interpreter__interpret_expression(self, return_stmt->expr);
            result.type = STATEMENT_RETURN_TYPE_RETURN;
            result.literal = return_value;
        } break ;
        default: ASSERT(false);
    }

    return result;
}
void lox_interpreter__interpret_ast(struct interpreter* self, struct parser_ast ast) {
    ASSERT(ast.statement != NULL);
    lox_interpreter__interpret_statement(self, ast.statement);
}

// maybe have this in tokenizer?
// todo: bind token line
struct token* lox_interpreter__get_token(struct interpreter* self, const char* token_name) {
    struct token* result = tokenizer__get(&self->tokenizer);

    result->lexeme = token_name;
    result->lexeme_len = libc__strlen(token_name);
    result->type = LOX_TOKEN_IDENTIFIER;
    result->line = -1;

    return result;
}

static struct lox_expr_var* lox_interpreter__bind_fn_decl(struct interpreter* self, struct lox_stmt_fun_decl* fun_decl) {
    struct parser* parser = &self->parser;

    // check arity
    u32 fn_arity = 0;
    struct lox_stmt_token_node* params = fun_decl->params;
    struct lox_stmt_token_node* cur_params = params;
    while (cur_params != NULL) {
        ++fn_arity;
        cur_params = cur_params->next;
    }
    ASSERT(fn_arity < LOX_MAX_NUMBER_OF_FN_ARGUMENTS);

    // bind fn
    struct object_header header = {
        .env = self->env,
        .arity = fn_arity,
        .call = &lox_interpreter__interpret_generic_call
    };
    struct lox_literal_obj* obj_literal = (struct lox_literal_obj*) lox_parser__get_literal__object(
        parser, header, memory_slice__create(fun_decl, sizeof(fun_decl))
    );
    struct lox_expr_var* fn_decl = lox_interpreter__define_var(self, fun_decl->name, NULL);
    if (fn_decl != NULL) {
        fn_decl->evaluated_literal = (struct literal*) obj_literal;
    }

    return fn_decl;
}

static bool lox_interpreter__bind_global_fn(
    struct interpreter* self,
    const char* name, u32 arity, lox_call_fn call, struct memory_slice context
) {
    struct parser* parser = &self->parser;

    struct lox_env* global_env = lox_interpreter__global_env(self);
    ASSERT(self->env == global_env);

    struct token* fn_name = lox_interpreter__get_token(self, name);
    struct object_header header = {
        .arity = arity,
        .call = call
    };
    struct lox_literal_obj* obj_literal = (struct lox_literal_obj*) lox_parser__get_literal__object(parser, header, context);
    struct lox_expr_var* fn_decl = lox_interpreter__define_var(self, fn_name, NULL);
    if (fn_decl == NULL) {
        return false;
    }

    fn_decl->evaluated_literal = (struct literal*) obj_literal;

    return true;
}

#include "lox_interpreter_native.inl"

bool lox_interpreter__initialize(struct interpreter* self, struct memory_slice internal_memory) {
    self->tokenizer_fn = &lox_tokenizer__tokenize;
    self->convert_token_to_string_fn = &lox_token__type_name;

    self->parser_clear = &lox_parser__clear;
    self->parser_parse_ast = &lox_parser__parse_ast;
    self->parser_ast_is_valid = &lox_parser__ast_is_valid;
    self->parser_ast_print = &lox_parser__ast_print;
    self->parser_is_finished_parsing = &lox_parser__is_finished_parsing;
    self->parser_convert_expr_to_string = &lox_parser__convert_expr_to_string;

    self->interpreter_interpret_ast = &lox_interpreter__interpret_ast;
    self->interpreter_clear = &lox_interpreter__clear;
    
    void* memory = memory_slice__memory(&internal_memory);
    u64 memory_size = memory_slice__size(&internal_memory);

    u64 individual_memory_size = memory_size / 3;

    self->internal_memory = memory_slice__create(
        memory,
        individual_memory_size
    );

    if (
        tokenizer__create(
            &self->tokenizer,
            memory_slice__create((char*) memory + individual_memory_size, individual_memory_size)
        ) == false
    ) {
        return false;
    }

    if (
        parser__create(
            &self->parser, &self->tokenizer,
            memory_slice__create((char*) memory + 2 * individual_memory_size, individual_memory_size)
        ) == false
    ) {
        tokenizer__destroy(&self->tokenizer);
        return false;
    }

    return true;
}

static bool lox_interpreter__init_native_callables(struct interpreter* self) {
    struct memory_slice empty_context = memory_slice__create(NULL, 0);
    ASSERT(lox_interpreter__bind_global_fn(self, "clock", 0, &lox_interpreter__native_clock, empty_context));
    ASSERT(lox_interpreter__bind_global_fn(self, "usleep", 1, &lox_interpreter__native_usleep, empty_context));
    ASSERT(lox_interpreter__bind_global_fn(self, "sleep", 1, &lox_interpreter__native_sleep, empty_context));

    return true;
}

struct lox_interpreter_env_table* lox_interpreter__get_env_table(struct interpreter* self) {
    char* memory = memory_slice__memory(&self->internal_memory);
    u64 memory_size = memory_slice__size(&self->internal_memory);
    u64 table_size = memory_size;
    if (table_size < sizeof(struct lox_interpreter_env_table)) {
        error_code__exit(214332);
    }

    struct lox_interpreter_env_table* table = (struct lox_interpreter_env_table*) memory;
    table->table_memory_size = table_size;

    return table;
}

static void lox_interpreter__clear_env(struct interpreter* self, struct lox_env* env) {
    struct lox_interpreter_env_table* table = lox_interpreter__get_env_table(self);
    libc__memset(env, 0, table->env_memory_size);
    env->var_arr = (void*) ((char*) env + sizeof(*env));
    env->var_arr_fill = 0;
    env->next = NULL;
    env->parent = NULL;
    env->var_arr_size = (table->env_memory_size - sizeof(*env)) / sizeof(*env->var_arr);
}

void lox_interpreter__env_push(struct interpreter* self) {
    struct lox_env* env = lox_interpreter__env_pool_get(self);

    env->parent = self->env;
    self->env = env;
}

void lox_interpreter__env_pop(struct interpreter* self) {
    struct lox_env* env = self->env;
    ASSERT(env);
    self->env = env->parent;
    lox_interpreter__env_pool_put(self, env);
}

struct lox_env* lox_interpreter__env_pool_get(struct interpreter* self) {
    struct lox_interpreter_env_table* table = lox_interpreter__get_env_table(self);

    struct lox_env* result = NULL;
    if (table->env_pool_free_list != NULL) {
        result = table->env_pool_free_list;
        struct lox_env* next_free = table->env_pool_free_list ? table->env_pool_free_list->next : NULL;
        lox_interpreter__clear_env(self, result);
        table->env_pool_free_list = next_free;
    } else {
        if (table->env_pool_arr_fill == table->env_pool_arr_size) {
            error_code__exit(324234);
        }
        result = (struct lox_env*) ((char*) table->env_pool_arr + table->env_pool_arr_fill++ * table->env_memory_size);
        lox_interpreter__clear_env(self, result);
    }

    return result;
}

void lox_interpreter__env_pool_put(struct interpreter* self, struct lox_env* env) {
    struct lox_interpreter_env_table* table = lox_interpreter__get_env_table(self);
    while (env != NULL) {
        struct lox_env* next = env->next;
        env->next = table->env_pool_free_list;
        table->env_pool_free_list = env;
        env = next;
    }
}

struct lox_env* lox_interpreter__global_env(struct interpreter* self) {
    struct lox_interpreter_env_table* env_table = lox_interpreter__get_env_table(self);
    ASSERT(0 < env_table->env_pool_arr_fill);
    return &env_table->env_pool_arr[0];
}

struct lox_expr_var* lox_interpreter__get_var(struct interpreter* self, struct token* var_name) {
    struct lox_env* env = (struct lox_env*) self->env;
    ASSERT(env != NULL);
    u32 var_hash = hash__sum_n(var_name->lexeme, var_name->lexeme_len) % env->var_arr_size;

    while (env != NULL) {
        struct lox_env* cur_env = env;
        while (
            cur_env != NULL &&
            cur_env->var_arr_fill > 0
        ) {
            for (u32 var_index = var_hash; var_index < cur_env->var_arr_size; ++var_index) {
                struct lox_expr_var* cur_var = &cur_env->var_arr[var_index];
                if (
                    cur_var->name != NULL &&
                    cur_var->name->lexeme_len == var_name->lexeme_len &&
                    libc__strncmp(
                        cur_var->name->lexeme,
                        var_name->lexeme,
                        var_name->lexeme_len
                    ) == 0
                ) {
                    return cur_var;
                }
            }

            for (u32 var_index = 0; var_index < var_hash; ++var_index) {
                struct lox_expr_var* cur_var = &cur_env->var_arr[var_index];
                if (
                    cur_var->name != NULL &&
                    cur_var->name->lexeme_len == var_name->lexeme_len &&
                    libc__strncmp(
                        cur_var->name->lexeme,
                        var_name->lexeme,
                        var_name->lexeme_len
                    ) == 0
                ) {
                    return cur_var;
                }
            }

            cur_env = cur_env->next;
        }
        env = env->parent;
    }

    return NULL;
}

struct lox_expr_var* lox_interpreter__define_var(struct interpreter* self, struct token* var_name, struct expr* var_value) {
    struct lox_env* env = (struct lox_env*) self->env;
    while (
        env != NULL &&
        env->var_arr_fill == env->var_arr_size
    ) {
        env = env->next;
    }
    if (env == NULL) {
        env = lox_interpreter__env_pool_get(self);
    }

    u32 var_hash = hash__sum_n(var_name->lexeme, var_name->lexeme_len) % env->var_arr_size;
    for (u32 var_index = var_hash; var_index < env->var_arr_size; ++var_index) {
        struct lox_expr_var* cur_var = &env->var_arr[var_index];
        if (cur_var->name == NULL) {
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_arr_fill;
            
            return cur_var;
        } else if (
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            interpreter__runtime_error(self, "Already defined symbol in scope: '%.*s'.", var_name->lexeme_len, var_name->lexeme);
            return NULL;
        }
    }

    for (u32 var_index = 0; var_index < var_hash; ++var_index) {
        struct lox_expr_var* cur_var = &env->var_arr[var_index];
        if (cur_var->name == NULL) {
            cur_var->base.type = LOX_PARSER_EXPRESSION_TYPE_VAR;
            cur_var->name = var_name;
            cur_var->value = var_value;
            cur_var->evaluated_literal = NULL;

            ++env->var_arr_fill;

            return cur_var;
        } else if (
            cur_var->name->lexeme_len == var_name->lexeme_len &&
            libc__strncmp(
                cur_var->name->lexeme,
                var_name->lexeme,
                var_name->lexeme_len
            ) == 0
        ) {
            interpreter__runtime_error(self, "Already defined symbol in scope: '%.*s'.", var_name->lexeme_len, var_name->lexeme);
            return NULL;
        }
    }

    // delete var_value

    // var declaration arr is full
    error_code__exit(12434);
    return NULL;
}

bool lox_interpreter__clear_tables(struct interpreter* self) {
    // environment table
    {
        struct lox_interpreter_env_table* env_table = lox_interpreter__get_env_table(self);
        u64 env_table_size = env_table->table_memory_size;
        u64 memory_offset = sizeof(*env_table);
        ASSERT(env_table_size >= memory_offset);
        env_table_size -= memory_offset;
        u64 subtable_memory_size = env_table_size / 1;

        const u32 number_of_environments = 256;
        env_table->env_memory_size = subtable_memory_size / number_of_environments;
        env_table->env_pool_free_list = NULL;
        env_table->env_pool_arr = (void*) ((char*) env_table + memory_offset);
        env_table->env_pool_arr_fill = 0;
        env_table->env_pool_arr_size = subtable_memory_size / sizeof(*env_table->env_pool_arr);
        memory_offset += subtable_memory_size;
    }

    return true;
}

bool lox_interpreter__clear(struct interpreter* self) {
    if (lox_interpreter__clear_tables(self) == false) {
        return false;
    }

    // init global env
    self->env = lox_interpreter__env_pool_get(self);

    if (lox_interpreter__init_native_callables(self) == false) {
        return false;
    }

    return true;
}
