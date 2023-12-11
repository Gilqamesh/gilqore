#include "compiler.h"

#include <stdarg.h>
#include <string.h>
#include <stdlib.h>

#include "state.h"
#include "types.h"
#include "libc.h"

hash_map_t* compiler_flag_fns = 0;
hash_map_t* compiler_flag_help = 0;

// operator precedence table (top to bottom, in ascending precedence)
typedef enum precedence {
    PREC_NONE,
    PREC_COMMA,
    PREC_ASSIGNMENT,
    PREC_TERNARY,
    PREC_LOGICAL_OR,
    PREC_LOGICAL_AND,
    PREC_BITWISE_OR,
    PREC_BITWISE_XOR,
    PREC_BITWISE_AND,
    PREC_EQUALITY,
    PREC_COMPARISON,
    PREC_TERM,
    PREC_FACTOR,
    PREC_UNARY,
    PREC_CALL,
    PREC_PRIMARY
} precedence_t;

typedef struct compile_rule {
    type_t* (*prefix)(compiler_t* self, type_t* type, bool can_assign);
    type_t* (*infix)(compiler_t* self, type_t* type, bool can_assign);
    precedence_t precedence;
} compile_rule_t;

static void compiler__emit_ins(compiler_t* self, ins_t ins, ...);
static uint8_t* compiler__cur_ip(compiler_t* self);
static bool compiler__is_at_end(compiler_t* self);
static token_type_t compiler__peak(compiler_t* self);
static token_type_t compiler__eat(compiler_t* self);
static token_type_t compiler__ate(compiler_t* self);
// @returns true if matched token_type
static bool compiler__eat_if(compiler_t* self, token_type_t token_type);
// @returns false if there was an error
static bool compiler__eat_err(compiler_t* self, token_type_t token_type, const char* err_msg, ...);
static void compiler__out(compiler_t* self, const char* msg, ...);
static void compiler__vout(compiler_t* self, const char* msg, va_list ap);
// @brief treats current token as an error
static void compiler__err(compiler_t* self, const char* err_msg, ...);
static void compiler__verr(compiler_t* self, const char* err_msg, va_list ap);
static void compiler__warn(compiler_t* self, const char* warn_msg, ...);
static void compiler__vwarn(compiler_t* self, const char* warn_msg, va_list ap);
static void compiler__sync(compiler_t* self);

static void compiler__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr);
static void compiler__flag_add(const char* flag, compiler_flag_t compiler_flag);
static void compiler__destroy(compiler_t* self);
static void compiler__emit_pop(compiler_t* self, uint32_t n);
static void compiler__emit_grow(compiler_t* self, type_t* type);

static local_t* compiler__add_local(compiler_t* self, token_t token, type_t* type);
static local_t* compiler__get_local(compiler_t* self, token_t local_token);
static void compiler__begin_scope(compiler_t* self);
static void compiler__end_scope(compiler_t* self);

typedef enum local_ins {
    LOCAL_INS_LOAD,
    LOCAL_INS_STORE,
    LOCAL_INS_LEA
} local_ins_t;
static void compiler__emit_local(compiler_t* self, local_ins_t local_ins, local_t* local, ...);
static void compiler__emit_internal_function_call(compiler_t* self, type_function_t* target_function);
static type_t* compiler__emit_with_prec(compiler_t* self, type_t* type, precedence_t precedence);
static type_t* compiler__emit_expr(compiler_t* self, type_t* type);
static type_t* compiler__emit_args(compiler_t* self, type_t* type);
static void compiler__emit_block_stmt(compiler_t* self);
static void compiler__emit_print_stmt(compiler_t* self);
static type_t* compiler__emit_implicit_convert(compiler_t* self, type_t* from, type_t* to);
static type_t* compiler__emit_explicit_convert(compiler_t* self, type_t* from, type_t* to);
static void compiler__emit_decl_stmt(compiler_t* self, token_type_t token_type);
static type_t* compiler__find_type_of_token(compiler_t* self, token_t token);
static void compiler__emit_type_decl_stmt(compiler_t* self, token_type_t token_type);
static local_t* compiler__parse_local_decl(compiler_t* self, token_type_t token_type);
static void compiler__emit_expr_stmt(compiler_t* self);
static void compiler__emit_stmt(compiler_t* self, token_type_t token_type);
static void compiler__emit_decl_fn_stmt(compiler_t* self);
static void compiler__emit_if_stmt(compiler_t* self);
static void compiler__emit_while_stmt(compiler_t* self);
static void compiler__emit_for_stmt(compiler_t* self);

static type_t* compiler__emit_cast(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_grouping(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_call(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_unary(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_binary(compiler_t* self, type_t* left, bool can_assign);
static type_t* compiler__emit_ternary(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_string_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_character_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_integral_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_floating_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_false(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_true(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_identifier(compiler_t* self, type_t* type, bool can_assign);

static compile_rule_t compile_rules[] = {
/*   token type                    prefix emitter                       infix emitter               precedence  */
    [TOKEN_LEFT_PAREN]          = {compiler__emit_cast,                 compiler__emit_call,        PREC_CALL},
    [TOKEN_RIGHT_PAREN]         = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_LEFT_CURLY]          = {NULL,                                NULL,                       PREC_NONE}, 
    [TOKEN_RIGHT_CURLY]         = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_COMMA]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_DOT]                 = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_MINUS]               = {compiler__emit_unary,                compiler__emit_binary,      PREC_TERM},
    [TOKEN_PLUS]                = {NULL,                                compiler__emit_binary,      PREC_TERM},
    [TOKEN_SEMICOLON]           = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_FORWARD_SLASH]       = {NULL,                                compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_STAR]                = {NULL,                                compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_QUESTION_MARK]       = {NULL,                                compiler__emit_ternary,     PREC_TERNARY},
    [TOKEN_COLON]               = {NULL,                                NULL,                       PREC_TERNARY},
    [TOKEN_PERCENTAGE]          = {NULL,                                compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_LOGICAL_NOT]         = {compiler__emit_unary,                NULL,                       PREC_NONE},
    [TOKEN_EXCLAM_EQUAL]        = {NULL,                                compiler__emit_binary,      PREC_EQUALITY},
    [TOKEN_EQUAL]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_EQUAL_EQUAL]         = {NULL,                                compiler__emit_binary,      PREC_EQUALITY},
    [TOKEN_GREATER]             = {NULL,                                compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_GREATER_EQUAL]       = {NULL,                                compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_LESS]                = {NULL,                                compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_LESS_EQUAL]          = {NULL,                                compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_IDENTIFIER]          = {compiler__emit_identifier,           NULL,                       PREC_NONE},
    [TOKEN_STRING_LITERAL]      = {compiler__emit_string_literal,       NULL,                       PREC_NONE},
    [TOKEN_CHARACTER_LITERAL]   = {compiler__emit_character_literal,    NULL,                       PREC_NONE},
    [TOKEN_SINT_LITERAL]        = {compiler__emit_integral_literal,     NULL,                       PREC_NONE},
    [TOKEN_UINT_LITERAL]        = {compiler__emit_integral_literal,     NULL,                       PREC_NONE},
    [TOKEN_R32_LITERAL]         = {compiler__emit_floating_literal,     NULL,                       PREC_NONE},
    [TOKEN_R64_LITERAL]         = {compiler__emit_floating_literal,     NULL,                       PREC_NONE},
    [TOKEN_AND]                 = {NULL,                                compiler__emit_binary,      PREC_BITWISE_AND},
    [TOKEN_HAT]                 = {NULL,                                compiler__emit_binary,      PREC_BITWISE_XOR},
    [TOKEN_PIPE]                = {NULL,                                compiler__emit_binary,      PREC_BITWISE_OR},
    [TOKEN_LOGICAL_AND]         = {NULL,                                compiler__emit_binary,      PREC_LOGICAL_AND},
    [TOKEN_LOGICAL_OR]          = {NULL,                                compiler__emit_binary,      PREC_LOGICAL_OR},
    [TOKEN_BITWISE_NOT]         = {compiler__emit_unary,                NULL,                       PREC_UNARY},
    [TOKEN_ELSE]                = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_FALSE]               = {compiler__emit_false,                NULL,                       PREC_NONE},
    [TOKEN_TRUE]                = {compiler__emit_true,                 NULL,                       PREC_NONE},
    [TOKEN_FN]                  = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_FOR]                 = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_IF]                  = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_RETURN]              = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_THIS]                = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_WHILE]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_BREAK]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_CONTINUE]            = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_CONST]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_SWITCH]              = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_CASE]                = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_DEFAULT]             = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_STRUCT]              = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_ERROR]               = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_COMMENT]             = {NULL,                                NULL,                       PREC_NONE},
    [TOKEN_EOF]                 = {NULL,                                NULL,                       PREC_NONE},
};
static compile_rule_t* compiler__get_compile_rule(token_type_t token_type) {
    ASSERT(token_type < sizeof(compile_rules) / sizeof(compile_rules[0]));

    return &compile_rules[token_type];
}

static type_t* compiler__emit_with_prec(compiler_t* self, type_t* type, precedence_t precedence) {
    compile_rule_t* prefix_rule = compiler__get_compile_rule(compiler__eat(self));
    if (!prefix_rule->prefix) {
        compiler__err(self, "expected expression");
        return type;
    }

    bool can_assign = precedence <= PREC_ASSIGNMENT;
    type = prefix_rule->prefix(self, type, can_assign);

    compile_rule_t* infix_rule = compiler__get_compile_rule(compiler__peak(self));
    ASSERT(infix_rule);
    while (precedence <= infix_rule->precedence) {
        compiler__eat(self);

        ASSERT(infix_rule->infix);
        type = infix_rule->infix(self, type, can_assign);

        infix_rule = compiler__get_compile_rule(compiler__peak(self));
        ASSERT(infix_rule);
    }

    return type;
}

static type_t* compiler__emit_expr(compiler_t* self, type_t* type) {
    return compiler__emit_with_prec(self, type, PREC_ASSIGNMENT);
}

static type_t* compiler__emit_args(compiler_t* self, type_t* type) {
    (void) self;

    return type;

    // ASSERT(compiler__ate(self) == TOKEN_LEFT_PAREN);
    // if (compiler__peak(self) != TOKEN_RIGHT_PAREN) {
    //     do {

    //         compiler__emit_expr(self, compiler__peak(self));
    //     } while (compiler__eat_if(self, TOKEN_COMMA));
    // }

    // compiler__eat_err(self, TOKEN_RIGHT_PAREN, "expected ')' after arguments");
}

static void compiler__emit_block_stmt(compiler_t* self, compiled_statement_t* stmt) {
    ASSERT(compiler__ate(self) == TOKEN_LEFT_CURLY);
    while (
        compiler__peak(self) != TOKEN_RIGHT_CURLY &&
        !compiler__is_at_end(self)
    ) {
        compiler__emit_decl_stmt(self, compiler__eat(self), stmt);
    }

    compiler__eat_err(self, TOKEN_RIGHT_CURLY, "expected '}' after block");
}

static void compiler__emit_print_stmt(compiler_t* self, compiled_statement_t* stmt) {
    ASSERT(compiler__ate(self) == TOKEN_PRINT);
    type_t* type = compiler__emit_expr(self, 0, stmt);
    if (!type) {
        return ;
    }

    if (type__is_integral(type)) {
        compiler__emit_ins(self, INS_PRINT);
    } else if (type__is_floating(type)) {
        compiler__emit_ins(self, INS_PRINTF);
    } else {
        compiler__err(self, "cannot print non-builtin types");
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "expected ';' at the end of statement");
}

static type_t* compiler__emit_grouping(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_LEFT_PAREN);
    type_t* result = compiler__emit_expr(self, type);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "expected ')' after expression");

    return result;
}

static type_t* compiler__emit_call(compiler_t* self, type_t* type, bool can_assign) {
    ASSERT(compiler__ate(self) == TOKEN_LEFT_PAREN);
    (void) can_assign;

    return compiler__emit_args(self, type);
}

static type_t* compiler__find_type_of_token(compiler_t* self, token_t token) {
    type_t* type = 0;
    while (self) {
        ASSERT(self->scanner.source_is_mutable);
        // temporarily null-terminate the token
        char tmp_c = token.lexeme[token.lexeme_len];
        *((char*) token.lexeme + token.lexeme_len) = '\0';
        type = types__type_find(&self->types, token.lexeme);
        *((char*) token.lexeme + token.lexeme_len) = tmp_c;
        if (type) {
            break ;
        }
        self = self->parent;
    }

    return type;
}

static type_t* compiler__emit_cast(compiler_t* self, type_t* type, bool can_assign) {
    if (compiler__peak(self) == TOKEN_IDENTIFIER) {
        // if identifier is a type after left paren, then by definition it must be an explicit type-cast
        type_t* cast_type = compiler__find_type_of_token(self, self->token_cur);
        if (cast_type) {
            // it must be an explicit type-cast
            compiler__eat(self);
            if (!compiler__eat_err(self, TOKEN_RIGHT_PAREN, "expected ')' after type-cast to (%s)", cast_type->abbreviated_name)) {
                return 0;
            }
            type = compiler__emit_with_prec(self, type, PREC_UNARY);
            return compiler__emit_explicit_convert(self, type, cast_type);
        } else {
            return compiler__emit_grouping(self, type, can_assign);
        }
    } else {
        return compiler__emit_grouping(self, type, can_assign);
    }
}

static type_t* compiler__emit_unary(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    token_type_t unary_token_type = compiler__ate(self);
    type = compiler__emit_with_prec(self, type, PREC_UNARY);

    if (!type) {
        return 0;
    }
    
    bool is_undefined = false;

    switch (unary_token_type) {
        case TOKEN_MINUS: {
            if (type__is_floating(type)) {
                compiler__emit_ins(self, INS_NEGF);
            } else if (type__is_integral(type)) {
                compiler__emit_ins(self, INS_NEG);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_LOGICAL_NOT: {
            if (type__is_integral(type)) {
                compiler__emit_ins(self, INS_LNOT);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_BITWISE_NOT: {
            if (type__is_integral(type)) {
                compiler__emit_ins(self, INS_BNOT);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_STAR: {
            if (type->type_specifier == TYPE_POINTER) {
                // type_pointer_t* type_pointer = (type_pointer_t*) type;
                // emit type_pointer->pointed_type;
                // load effective address of local into reg
                //      it doesn't have to be local, what about *some_fn?
                //      or fn(int* a) {  *a = 2; }
                //      -> we want to know where the emitted expression lives
                // "dereference" the address that was in reg, and where to store it?
                // we need to pass around more than just the type of the compiled expressions
                // compiler__emit_type(self, type_pointer->pointed_type);
            } else {
                compiler__err(self, "");
            }
        } break ;
        case TOKEN_AND: {
            // take the address of the local and store it into reg
        } break ;
        default: ASSERT(false);
    }

    if (is_undefined) {
        compiler__err(
            self,
            "[%s] unary operator is not defined for type [%s]",
            type->abbreviated_name
        );
        return 0;
    }

    return type;
}

static type_t* compiler__emit_implicit_convert(compiler_t* self, type_t* from, type_t* to) {
    ASSERT(from && to);

    if (from->type_specifier != TYPE_ATOM || to->type_specifier != TYPE_ATOM) {
        compiler__err(
            self,
            "no implicit conversion between types [%s] and [%s]",
            from->abbreviated_name,
            to->abbreviated_name
        );
        return 0;
    }
    const bool is_left_float = type__is_floating(from);
    const bool is_right_float = type__is_floating(to);
    type_t* bigger_type = type__size(from) > type__size(to) ? from : to;
    if (is_left_float && is_right_float) {
        return bigger_type;
    } else if (is_left_float) {
        if (type__is_signed(to)) {
            compiler__emit_ins(self, INT_CVTS2F);
        } else {
            compiler__emit_ins(self, INT_CVTU2F);
        }
        return from;
    } else if (is_right_float) {
        if (type__is_signed(from)) {
            compiler__emit_ins(self, INT_CVTS2F);
        } else {
            compiler__emit_ins(self, INT_CVTU2F);
        }
        return to;
    } else {
        const bool is_left_unsigned = type__is_unsigned(from);
        const bool is_right_unsigned = type__is_unsigned(to);
        if (is_left_unsigned || is_right_unsigned) {
            // return unsigned with the same size as the biggest type
            const uint64_t bigger_type_size = type__size(bigger_type);
            if (bigger_type_size == type__size(t_u8)) {
                return t_u8;
            } else if (bigger_type_size == type__size(t_u16)) {
                return t_u16;
            } else if (bigger_type_size == type__size(t_u32)) {
                return t_u32;
            } else if (bigger_type_size == type__size(t_u64)) {
                return t_u64;
            } else {
                ASSERT(false);
            }
        } else {
            return bigger_type;
        }
    }
}

static type_t* compiler__emit_explicit_convert(compiler_t* self, type_t* from, type_t* to) {
    (void) self;

    if (to->type_specifier == TYPE_POINTER) {
        if (from->type_specifier != TYPE_POINTER) {
            compiler__err(
                self,
                "cast from [%s] to type [%s] is not allowed",
                from->abbreviated_name,
                to->abbreviated_name
            );

            return 0;
        } else {
            return to;
        }
    }

    if (to->type_specifier != TYPE_ATOM) {
        compiler__err(
            self,
            "cast from [%s] to type [%s] is not allowed",
            from->abbreviated_name,
            to->abbreviated_name
        );
        return 0;
    }

    const bool is_from_float = type__is_floating(from);
    const bool is_to_float = type__is_floating(to);
    // type_t* bigger_type = type__size(from) > type__size(to) ? from : to;
    if (is_from_float && is_to_float) {
    } else if (is_from_float) {
        if (type__is_signed(to)) {
            compiler__emit_ins(self, INS_CVTF2U);
        } else {
            compiler__emit_ins(self, INS_CVTF2U);
        }
    } else if (is_to_float) {
        if (type__is_signed(from)) {
            compiler__emit_ins(self, INT_CVTS2F);
        } else {
            compiler__emit_ins(self, INT_CVTU2F);
        }
    } else {
    }

    return to;
}

static type_t* compiler__emit_binary(compiler_t* self, type_t* left, bool can_assign) {
    (void) can_assign;

    ASSERT(left);

    token_type_t binary_token_type = compiler__ate(self);
    compile_rule_t* rule = compiler__get_compile_rule(binary_token_type);
    type_t* right = compiler__emit_with_prec(self, left, rule->precedence + 1);
    if (!right) {
        return 0;
    }

    left = compiler__emit_implicit_convert(self, left, right);
    if (!left) {
        return 0;
    }

    const bool is_integral = type__is_integral(left);
    const bool is_floating = type__is_floating(left);
    bool is_undefined = false;

    switch (binary_token_type) {
        case TOKEN_PLUS: {
            if (is_integral) {
                compiler__emit_ins(self, INS_ADD);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_ADDF);
            } else {
                is_undefined = true;
            }

        } break ;
        case TOKEN_MINUS: {
            if (is_integral) {
                compiler__emit_ins(self, INS_SUB);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_SUBF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_STAR: {
            if (is_integral) {
                compiler__emit_ins(self, INS_MUL);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_MULF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_FORWARD_SLASH: {
            if (is_integral) {
                compiler__emit_ins(self, INS_DIV);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_DIVF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_PERCENTAGE: {
            if (is_integral) {
                compiler__emit_ins(self, INS_MOD);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_MODF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_LOGICAL_AND: {
            if (is_integral) {
                compiler__emit_ins(self, INS_LAND);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_LOGICAL_OR: {
            if (is_integral) {
                compiler__emit_ins(self, INS_LOR);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_AND: {
            if (is_integral) {
                compiler__emit_ins(self, INS_BAND);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_PIPE: {
            if (is_integral) {
                compiler__emit_ins(self, INS_BOR);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_HAT: {
            if (is_integral) {
                compiler__emit_ins(self, INS_BXOR);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_GREATER: {
            if (is_integral) {
                compiler__emit_ins(self, INS_GT);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_GTF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_GREATER_EQUAL: {
            if (is_integral) {
                compiler__emit_ins(self, INS_LT);
                compiler__emit_ins(self, INS_LNOT);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_LTF);
                compiler__emit_ins(self, INS_LNOT);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_LESS: {
            if (is_integral) {
                compiler__emit_ins(self, INS_LT);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_LTF);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_LESS_EQUAL: {
            if (is_integral) {
                compiler__emit_ins(self, INS_GT);
                compiler__emit_ins(self, INS_LNOT);
            } else if (is_floating) {
                compiler__emit_ins(self, INS_GTF);
                compiler__emit_ins(self, INS_LNOT);
            } else {
                is_undefined = true;
            }
        } break ;
        case TOKEN_EQUAL_EQUAL: {
            if (is_integral) {
                compiler__emit_ins(self, INS_EQ);
            } else if (is_floating) {
                compiler__emit_ins(self, INT_EQF);
            } else {
                is_undefined = true;
            }
        } break ;
        default: ASSERT(false && "this binary operator is not supported");
    }

    if (is_undefined) {
        compiler__err(
            self,
            "[%s] binary operator is not defined for types [%s] and [%s]",
            token_type__to_str(binary_token_type),
            left->abbreviated_name,
            right->abbreviated_name
        );
        return 0;
    }
    
    return left;
}

static type_t* compiler__emit_ternary(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_identifier(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;
    (void) type;

    ASSERT(compiler__ate(self) == TOKEN_IDENTIFIER);

    local_t* local = compiler__get_local(self, self->token_prev);
    if (!local) {
        compiler__err(self, "undeclared identifier");
        return 0;
    }

    type_t* local_type = local->type;
    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        if (local->is_const) {
            compiler__err(self, "cannot assign to constant variable [%.*s]", local->token.lexeme_len, local->token.lexeme);
            return 0;
        }

        local_type = compiler__emit_expr(self, local_type);
        if (!local_type) {
            return 0;
        }

        compiler__emit_local(self, LOCAL_INS_STORE, local, NULL);
        compiler__emit_local(self, LOCAL_INS_LOAD, local, NULL);
    } else {
        compiler__emit_local(self, LOCAL_INS_LOAD, local, NULL);
    }

    return local_type;
}

static type_t* compiler__emit_string_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) type;
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_STRING_LITERAL);

    ASSERT(false && "implement");
    compiler__emit_grow(self, t_reg);
    // todo: store string and emit the pointer

    return 0;
}

static type_t* compiler__emit_character_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) type;
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_CHARACTER_LITERAL);
    char c = *self->token_prev.lexeme;
    compiler__emit_grow(self, t_reg);
    compiler__emit_ins(self, INS_MOV_IMM, (reg_t) c);

    return t_s8;
}

static type_t* compiler__emit_integral_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;
    (void) type;

    token_type_t token_type = compiler__ate(self);
    ASSERT(token_type == TOKEN_SINT_LITERAL || token_type == TOKEN_UINT_LITERAL);

    double result = strntod(self->token_prev.lexeme, self->token_prev.lexeme_len);
    compiler__emit_grow(self, t_reg);
    compiler__emit_ins(self, INS_MOV_IMM, (reg_t) result);

    // todo(?): determine length of type
    if (token_type == TOKEN_SINT_LITERAL) {
        return t_s64;
    } else if (token_type == TOKEN_UINT_LITERAL) {
        return t_u64;
    } else {
        ASSERT(false);
    }
}

static type_t* compiler__emit_floating_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;
    (void) type;
    
    token_type_t token_type = compiler__ate(self);
    ASSERT(token_type == TOKEN_R32_LITERAL || token_type == TOKEN_R64_LITERAL);

    double result = strntod(self->token_prev.lexeme, self->token_prev.lexeme_len);

    compiler__emit_grow(self, t_regf);
    compiler__emt_ins(self, INS_MOV_IMM, (regf_t) result);

    if (token_type == TOKEN_R32_LITERAL) {
        return t_r32;
    } else if (token_type == TOKEN_R64_LITERAL) {
        return t_r64;
    } else {
        ASSERT(false);
    }
}

static void compiler__emit_grow(compiler_t* self, type_t* type) {
    uint64_t grow = type__size(type);
    uint64_t alignment = type__alignment(type);
    uint64_t remainder = (size_t) self->total_offset_from_bp % alignment;
    if (remainder) {
        grow += alignment - remainder;
    }

    self->total_offset_from_bp += grow;
    ASSERT((size_t) self->total_offset_from_bp % alignment == 0);

    compiler__emit_ins(self, INS_GROW, grow);
}

static type_t* compiler__emit_false(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    self->total_offset_from_bp;

    compiler__emit_grow(self, t_reg);
    compiler__emit_ins(self, INS_MOV_IMM, (reg_t) 0);

    return type;
}

static type_t* compiler__emit_true(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    compiler__emit_grow(self, t_reg);
    compiler__emit_ins(self, INS_MOV_IMM, (reg_t) 1);

    return type;
}

static local_t* compiler__add_local(compiler_t* self, token_t token, type_t* type) {
    local_t* result = 0;

    ASSERT(self->scopes_top > 0);
    scope_t* scope = &self->scopes[self->scopes_top - 1];
    if (scope->locals_size == 0) {
        scope->locals_size = 8;
        scope->locals = malloc(scope->locals_size * sizeof(*scope->locals));
    } else if (scope->locals_top == scope->locals_size) {
        scope->locals_size <<= 1;
        scope->locals = realloc(scope->locals, scope->locals_size * sizeof(*scope->locals));
    }

    ASSERT(scope->locals_top != scope->locals_size);
    result = &scope->locals[scope->locals_top++];
    memset(result, 0, sizeof(*result));
    result->token = token;
    result->type = type;
    result->is_const = false;
    result->transient_data.is_defined = false;

    compiler__emit_grow(self, type);
    result->offset_from_bp = self->total_offset_from_bp - type__size(type);
    scope->end_offset_from_bp = self->total_offset_from_bp;

    return result;
}

static local_t* compiler__get_local(compiler_t* self, token_t local_token) {
    uint8_t index_of_local = 0;
    while (self) {
        if (self->scopes_top > 0) {
            scope_t* scope = &self->scopes[self->scopes_top - 1];
            if (scope->locals_top > 0) {
                local_t* local = &scope->locals[scope->locals_top - 1];
                local_t* local_end = &scope->locals[0];
                do {
                    if (strncmp(local->token.lexeme, local_token.lexeme, max(local->token.lexeme_len, local_token.lexeme_len)) == 0) {
                        local->transient_data.stack_index = index_of_local;
                        return local;
                    }
                    --local;
                } while (local != local_end);
            }
        }
        self = self->parent;
    }

    return 0;
}

static void compiler__begin_scope(compiler_t* self) {
    if (self->scopes_top == self->scopes_size) {
        if (self->scopes_size == 0) {
            self->scopes_size = 4;
            self->scopes = malloc(self->scopes_size * sizeof(*self->scopes));
        } else {
            self->scopes_size <<= 1;
            self->scopes = realloc(self->scopes, self->scopes_size * sizeof(*self->scopes));
        }
        memset(self->scopes + self->scopes_top, 0, (self->scopes_size - self->scopes_top) * sizeof(*self->scopes));
    }

    ASSERT(self->scopes_top < self->scopes_size);
    ++self->scopes_top;
    scope_t* cur_scope = &self->scopes[self->scopes_top - 1];
    cur_scope->locals_top = 0;
}

static void compiler__end_scope(compiler_t* self) {
    ASSERT(self->scopes_top > 0);
    --self->scopes_top;
    scope_t* scope_to_end = &self->scopes[self->scopes_top];

    if (self->scopes_top == 0) {
        self->total_offset_from_bp = 0;
    } else {
        scope_t* prev_scope = &self->scopes[self->scopes_top - 1];
        self->total_offset_from_bp = prev_scope->end_offset_from_bp;
    }

    compiler__emit_pop(self, scope_to_end->locals_top);
}

void compiler_flags__create(compiler_flags_t* self) {
    memset(self, 0, sizeof(*self));

    self->err_stream = stderr;
    self->warn_stream = stderr;
    self->out_stream = stdout;
    self->show_warnings = true;
    self->error_limit = UINT32_MAX;
}

static void compiler__flag_add(const char* flag, compiler_flag_t compiler_flag) {
    ASSERT(compiler_flag_fns);

    uint64_t flag_addr = (uint64_t) flag;
    if (!hash_map__insert(compiler_flag_fns, &flag_addr, &compiler_flag)) {
        ASSERT(false);
    }
}

// todo: based on % chars matched, give suggestion on what flags might the user wanted to pass
compiler_flag_t* compiler__flag_find(const char* flag) {
    ASSERT(compiler_flag_fns);

    uint64_t flag_addr = (uint64_t) flag;
    compiler_flag_t* compiler_fn = (compiler_flag_t*) hash_map__find(compiler_flag_fns, &flag_addr);

    return compiler_fn;
}

uint32_t compiler_flag_fns__hash_fn(const hash_map_key_t* string_key) {
    const char* _string_key = *(const char**) string_key;
    uint32_t result = 0;
    
    while (*_string_key != '\0' && *_string_key != '=') {
        result += *_string_key++;
    }

    return result;
}

bool compiler_flag_fns__eq_fn(const hash_map_key_t* string_key_a, const hash_map_key_t* string_key_b) {
    const char* _string_key_a = *(const char**) string_key_a;
    const char* _string_key_b = *(const char**) string_key_b;

    while (
        *_string_key_a != '\0' && *_string_key_a != '=' &&
        *_string_key_b != '\0' && *_string_key_b != '=' &&
        *_string_key_a == *_string_key_b
    ) {
        if (*_string_key_a++ != *_string_key_b++) {
            return false;
        }
    }

    return (*_string_key_a == '\0' || *_string_key_a == '=') && (*_string_key_b == '\0' || *_string_key_b == '=');
}

bool compiler__flag_help(const char* arg, compiler_flags_t* compiler_flags, compiler_flag_t* compiler_flag) {
    (void) arg;
    (void) compiler_flags;

    printf("Usage: app [options] [files]\n");
    printf("Options:\n");
    hash_map_key_t* cur = hash_map__begin(compiler_flag_fns);
    const uint32_t col_pad_len = 4;
    const uint32_t option_usage_len = 25;
    while (cur != hash_map__end(compiler_flag_fns)) {
        compiler_flag = (compiler_flag_t*) hash_map__value(compiler_flag_fns, cur);
        printf(
            "  %-*s%*c%-s\n",
            option_usage_len, compiler_flag->option_usage,
            col_pad_len, ' ',
            compiler_flag->option_description
        );
        cur = hash_map__next(compiler_flag_fns, cur);
    }

    return false;
}

static bool compiler__flag_fn_max_errors(const char* arg, compiler_flags_t* compiler_flags, compiler_flag_t* compiler_flag) {
    const char* flag = (const char*) hash_map__key(compiler_flag_fns, compiler_flag);
    arg = strchr(arg, '=');
    if (!arg) {
        fprintf(stderr, "missing argument to [-%s=]\n", flag);

        return false;
    } else {
        compiler_flags->error_limit = atoi((arg + strlen(flag)));
        if (compiler_flags->error_limit == 0) {
            compiler_flags->error_limit = 1;
        }

        return true;
    }
}

static bool compiler__flag_wall(const char* arg, compiler_flags_t* compiler_flags, compiler_flag_t* compiler_flag) {
    (void) arg;
    (void) compiler_flag;
    compiler_flags->show_warnings = true;

    return true;
}

static bool compiler__flag_wno_all(const char* arg, compiler_flags_t* compiler_flags, compiler_flag_t* compiler_flag) {
    (void) arg;
    (void) compiler_flag;
    compiler_flags->show_warnings = false;

    return true;
}

bool compiler__module_init() {
    compiler_flag_fns = malloc(sizeof(*compiler_flag_fns));

    uint32_t compiler_flag_fns_size_of_key = sizeof(const char*);
    uint32_t compiler_flag_fns_size_of_value = sizeof(compiler_flag_t);
    uint64_t compiler_flag_fns_memory_size = 1024 * hash_map__entry_size(compiler_flag_fns_size_of_key, compiler_flag_fns_size_of_value);
    void* types_memory = malloc(compiler_flag_fns_memory_size);
    if (!hash_map__create(
        compiler_flag_fns, types_memory, compiler_flag_fns_memory_size, compiler_flag_fns_size_of_key,
        compiler_flag_fns_size_of_value, compiler_flag_fns__hash_fn, compiler_flag_fns__eq_fn
        )
    ) {
        return false;
    }

    compiler__flag_add(
        "fmax-errors",
        (compiler_flag_t) {
            &compiler__flag_fn_max_errors, "-fmax-errors=<number>", "Maximum number of errors to report."
        }
    );
    compiler__flag_add(
        "h",
        (compiler_flag_t) {
            &compiler__flag_help, "-h", "Display this information."
        }
    );
    compiler__flag_add(
        "-help",
        (compiler_flag_t) {
            &compiler__flag_help, "--help", "Display this information."
        }
    );
    compiler__flag_add(
        "Wall",
        (compiler_flag_t) {
            &compiler__flag_wall, "-Wall", "Enable most warning messages."
        }
    );
    compiler__flag_add(
        "Wno-all",
        (compiler_flag_t) {
            &compiler__flag_wno_all, "-Wno-all", "Disable all warning messages."
        }
    );

    return true;
}

static void compiler__destroy(compiler_t* self) {
    (void) self;
}

// static void compiler__emit_pop(compiler_t* self, uint32_t n) {
//     if (n == 1) {
//         compiler__emit_ins(self, INS_POP);
//     } else if (n > 1) {
//         compiler__emit_ins(self, INS_POPN, n);
//     }
// }

type_internal_function_t* compiler__create_and_compile(
    compiler_t* self,
    compiler_flags_t* compiler_flags,
    const char* fn_source, uint64_t fn_source_len, bool source_is_mutable,
    const char* fn_name
) {
    memset(self, 0, sizeof(*self));

    self->flags = compiler_flags;

    scanner__init(&self->scanner, fn_source, fn_source_len, source_is_mutable);

    if (!types__create(&self->types)) {
        return 0;
    }

    compiler__begin_scope(self);

    debug__set_fn(&debug, fn_name);
    self->compiled_fn = type_internal_function__create(fn_name);

    compiler__eat(self);
    while (!compiler__is_at_end(self)) {
        compiler__emit_decl_stmt(self, compiler__eat(self));
    }

    compiler__eat_err(self, TOKEN_EOF, "expected eof token");

    if (self->had_error) {
        return 0;
    }

    compiler__end_scope(self);

    compiler__emit_ins(self, INS_RET);

    compiler__destroy(self);

    return self->compiled_fn;

}

static void compiler__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr) {
    *(uint64_t*)(jmp_ip + 1) = (uint64_t) new_addr;
}

static void compiler__emit_ins(compiler_t* self, ins_t ins, ...) {
    va_list ap;
    va_start(ap, ins);

    type_internal_function__vadd_ins(self->compiled_fn, ins, ap);

    va_end(ap);
}

static uint8_t* compiler__cur_ip(compiler_t* self) {
    return type_internal_function__cur_ip(self->compiled_fn);
}

static bool compiler__is_at_end(compiler_t* self) {
    return compiler__peak(self) == TOKEN_EOF;
}

static token_type_t compiler__peak(compiler_t* self) {
    return self->token_cur.type;
}

/*
    fn() {
        u32 a = 2;
        fn2() {
            a = 3;
        }
        fn2();
    }

    fn();

    ---
        0xcb (ret addr for fn2)
        fn2
        2
        0xab (ret addr for fn)
    ---
*/

static void compiler__out(compiler_t* self, const char* msg, ...) {
    va_list ap;
    va_start(ap, msg);

    compiler__vout(self, msg, ap);

    va_end(ap);
}

static void compiler__vout(compiler_t* self, const char* msg, va_list ap) {
    const uint32_t fp_size = 2;
    uint32_t fp_top = 0;
    FILE* fp[fp_size];
    for (uint32_t fp_index = 0; fp_index < fp_size; ++fp_index) {
        fp[fp_index] = 0;
    }

    ASSERT(fp_top < fp_size);
    fp[fp_top++] = self->flags->out_stream;
    if (debug.is_debug_mode_on) {
        ASSERT(fp_top < fp_size);
        fp[fp_top++] = debug.compiler_out_dump;
    }

    for (uint32_t fp_index = 0; fp_index < fp_top; ++fp_index) {
        va_list ap_copy;
        va_copy(ap_copy, ap);
        ASSERT(fp[fp_index]);
        fprintf(fp[fp_index], "[Compiler]: ");
        vfprintf(fp[fp_index], msg, ap_copy);
        fprintf(fp[fp_index], "\n");
        fflush(fp[fp_index]);
    }
}

static void compiler__err(compiler_t* self, const char* err_msg, ...) {
    if (self->panic_mode || self->flags->error_limit == 0) {
        return ;
    }

    va_list ap;
    va_start(ap, err_msg);

    compiler__verr(self, err_msg, ap);

    va_end(ap);

    compiler__sync(self);
}

static void compiler__verr(compiler_t* self, const char* err_msg, va_list ap) {
    ASSERT(self->flags->error_limit > 0);
    ASSERT(!self->panic_mode);

    self->had_error  = true;
    self->panic_mode = true;

    const uint32_t fp_size = 2;
    uint32_t fp_top = 0;
    FILE* fp[fp_size];
    for (uint32_t fp_index = 0; fp_index < fp_size; ++fp_index) {
        fp[fp_index] = 0;
    }

    ASSERT(fp_top < fp_size);
    fp[fp_top++] = self->flags->err_stream;

    if (debug.is_debug_mode_on) {
        ASSERT(fp_top < fp_size);
        fp[fp_top++] = debug.compiler_out_dump;
    }

    for (uint32_t fp_index = 0; fp_index < fp_top; ++fp_index) {
        va_list ap_copy;
        va_copy(ap_copy, ap);
        ASSERT(fp[fp_index]);
        const char* line_start = self->token_prev.lexeme;
        while (line_start > self->scanner.source_start) {
            if (*(line_start - 1) == '\n') {
                break ;
            }
            --line_start;
        }
        const char* line_end = self->token_prev.lexeme;
        while (line_end < self->scanner.source_end) {
            if (
                (line_end < self->scanner.source_end && *line_end == '\n') ||
                (line_end + 1 < self->scanner.source_end && *line_end == '\r' && *(line_end + 1) == '\n')
            ) {
                break ;
            }
            ++line_end;
        }
        const char* error_at = self->token_prev.lexeme;
        fprintf(
            fp[fp_index],
            "Error: %u:%u - %u:%u: ",
            self->token_cur.line_s, self->token_cur.col_s,
            self->token_cur.line_e, self->token_cur.col_e
        );
        vfprintf(fp[fp_index], err_msg, ap_copy);
        fprintf(fp[fp_index], "\n%.*s\n", (uint32_t) (line_end - line_start), line_start);
        fprintf(fp[fp_index], "%*c^\n", (uint32_t) (error_at - line_start), ' ');
        fflush(fp[fp_index]);
    }
}

static void compiler__warn(compiler_t* self, const char* warn_msg, ...) {
    va_list ap;
    va_start(ap, warn_msg);

    compiler__vwarn(self, warn_msg, ap);

    va_end(ap);
}

static void compiler__vwarn(compiler_t* self, const char* warn_msg, va_list ap) {
    if (!self->flags->show_warnings) {
        return ;
    }

    const uint32_t fp_size = 2;
    uint32_t fp_top = 0;
    FILE* fp[fp_size];
    for (uint32_t fp_index = 0; fp_index < fp_size; ++fp_index) {
        fp[fp_index] = 0;
    }

    ASSERT(fp_top < fp_size);
    fp[fp_top++] = self->flags->warn_stream;

    if (debug.is_debug_mode_on) {
        ASSERT(fp_top < fp_size);
        fp[fp_top++] = debug.compiler_out_dump;
    }

    for (uint32_t fp_index = 0; fp_index < fp_top; ++fp_index) {
        va_list ap_copy;
        va_copy(ap_copy, ap);
        ASSERT(fp[fp_index]);
        const char* line_start = self->token_prev.lexeme;
        while (line_start > self->scanner.source_start) {
            if (*(line_start - 1) == '\n') {
                break ;
            }
            --line_start;
        }
        const char* line_end = self->token_prev.lexeme;
        while (line_end < self->scanner.source_end) {
            if (
                (line_end < self->scanner.source_end && *line_end == '\n') ||
                (line_end + 1 < self->scanner.source_end && *line_end == '\r' && *(line_end + 1) == '\n')
            ) {
                break ;
            }
            ++line_end;
        }
        const char* warn_at = self->token_prev.lexeme;
        fprintf(
            fp[fp_index],
            "Warning: %u:%u - %u:%u: ",
            self->token_cur.line_s, self->token_cur.col_s,
            self->token_cur.line_e, self->token_cur.col_e
        );
        vfprintf(fp[fp_index], warn_msg, ap_copy);
        fprintf(fp[fp_index], "\n%.*s\n", (uint32_t) (line_end - line_start), line_start);
        fprintf(fp[fp_index], "%*c^\n", (uint32_t) (warn_at - line_start), ' ');
        fflush(fp[fp_index]);
    }
}

static void compiler__sync(compiler_t* self) {
    if (self->flags->error_limit > 0) {
        --self->flags->error_limit;
        self->panic_mode = false;
    }

    token_type_t token_type = compiler__peak(self);
    while (token_type != TOKEN_EOF) {
        if (compiler__ate(self) == TOKEN_SEMICOLON) {
            // we are at the next stmt
            return ;
        }

        switch (token_type) {
            case TOKEN_STRUCT:
            case TOKEN_FN:
            case TOKEN_FOR:
            case TOKEN_IF:
            case TOKEN_WHILE:
            case TOKEN_RETURN: {
                return ;
            }
            default:
        }

        token_type = compiler__eat(self);
    }
}

static token_type_t compiler__eat(compiler_t* self) {
    if (compiler__is_at_end(self)) {
        return TOKEN_EOF;
    }

    self->token_prev = self->token_cur;

    while (true) {
        self->token_cur = scanner__scan_token(&self->scanner);
        if (compiler__peak(self) != TOKEN_ERROR) {
            break ;
        }

        compiler__err(self, "received error token");
    }

    return compiler__ate(self);
}

static token_type_t compiler__ate(compiler_t* self) {
    return self->token_prev.type;
}

static bool compiler__eat_if(compiler_t* self, token_type_t token_type) {
    if (compiler__peak(self) != token_type) {
        return false;
    }

    compiler__eat(self);

    return true;
}

static bool compiler__eat_err(compiler_t* self, token_type_t token_type, const char* err_msg, ...) {
    va_list ap;
    va_start(ap, err_msg);

    if (!compiler__eat_if(self, token_type)) {
        compiler__err(self, err_msg, ap);
    }

    va_end(ap);

    return true;
}

static void compiler__emit_store_local(compiler_t* self, type_t* top_of_stack, local_t* local, ...) {
    ASSERT(self)

    va_list ap;
    va_start(ap, local);

    type_t* member = local->type;
    uint64_t offset_of_member = type__member_offsetv(&member, ap);
    ASSERT(member);

    va_end(ap);

    ASSERT(offset_of_member <= UINT32_MAX && "ins_load, ins_store, and ins_lea expects u32 offset");

    uint32_t dst_offset_from_bp = local->offset_from_bp + offset_of_member;
    uint32_t src_offset_from_bp = compiled_statement__current_offset();
    uint32_t src_size = type__size(what);
    compiler__emit_ins(self, INS_MOV, dst_offset_from_bp, src_offset_from_bp, src_size);
    compiler__emit_grow(self, member);
}

static void compiler__emit_local(compiler_t* self, local_ins_t local_ins, local_t* local, ...) {
    va_list ap;
    va_start(ap, local);

    type_t* member = local->type;
    uint64_t offset_of_member = type__member_offsetv(&member, ap);
    ASSERT(member);

    va_end(ap);

    ASSERT(offset_of_member <= UINT32_MAX && "ins_load, ins_store, and ins_lea expects u32 offset");

    switch (local_ins) {
        case LOCAL_INS_LOAD: {
            uint32_t dst_offset_from_bp;
            uint32_t src_offset_from_bp = local->offset_from_bp + offset_of_member;
            uint32_t src_size = type__size(member);
            compiler__emit_grow(self, member);
            compiler__emit_ins(self, INS_MOV, dst_offset_from_bp, src_offset_from_bp, src_size);
        } break ;
        case LOCAL_INS_STORE: {
            uint32_t dst_offset_from_bp;
            uint32_t src_offset_from_bp;
            uint32_t src_size = type__size(t_reg);
            compiler__emit_ins(self, INS_MOV, dst_offset_from_bp, src_offset_from_bp, src_size);
            compiler__emit_grow(self, member);
        } break ;
        case LOCAL_INS_LEA: {
            // grow stack by reg_t
            compiler__emit_grow(self, t_reg);
            uint32_t offset_from_bp;
            compiler__emit_ins(self, INS_LEA, offset_from_bp);
        } break ;
        default: ASSERT(false);
    }
}

void compiler__emit_internal_function_call(compiler_t* self, type_function_t* target_function) {
    ins_t call_ins;
    switch (type_function__type(target_function)) {
        case TYPE_FUNCTION_INTERNAL: {
            call_ins = INS_CALL_INTERNAL;
        } break ;
        case TYPE_FUNCTION_EXTERNAL: {
            call_ins = INS_CALL_EXTERNAL;
        } break ;
        case TYPE_FUNCTION_BUILTIN: {
            call_ins = INS_CALL_BUILTIN;
        } break ;
        default: ASSERT(false);
    }

    compiler__emit_ins(self, call_ins, target_function);
    compiler__emit_pop(self, target_function->arguments_top);
}

static void compiler__emit_decl_stmt(compiler_t* self, token_type_t token_type) {
    switch (token_type) {
        case TOKEN_FN: {
            compiler__emit_decl_fn_stmt(self);
        } break ;
        case TOKEN_CONST: {
            compiler__emit_type_decl_stmt(self, token_type);
        } break ;
        case TOKEN_IDENTIFIER: {
            type_t* type = compiler__find_type_of_token(self, self->token_prev);
            if (type) {
                compiler__emit_type_decl_stmt(self, token_type);
                // type declaration
            } else {
                if (compiler__emit_identifier(self, 0, 0)) {
                    compiler__eat_err(self, TOKEN_SEMICOLON, "expected ';' at the end of statement");
                }
            }
        } break ;
        default: {
            compiler__emit_stmt(self, token_type);
        }
    }
}

static void compiler__emit_decl_fn_stmt(compiler_t* self) {
    compiler_t compiler;
    (void) compiler;
    // ...
    
    ASSERT(compiler__ate(self) == TOKEN_FN);

    token_t fn_token = self->token_prev;
    uint32_t fn_name_size = 256;
    char* fn_name = malloc(fn_name_size);
    ASSERT(fn_token.lexeme_len + 1 < fn_name_size);
    memcpy(fn_name, fn_token.lexeme, fn_token.lexeme_len);
    fn_name[fn_token.lexeme_len] = '\0';
    
    // compile fn body
    compiler__eat(self);
    // if (!compiler__create_and_compile(&compiler, )) {
    //     // todo: error
    // }

    // pop locals
    // if (self->compiled_fn->locals_top == 1) {
    //     compiler__emit_ins(self, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK);
    // } else if (self->compiled_fn->locals_top > 1) {
    //     compiler__emit_ins(self, INS_POPN_TYPE, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK, self->compiled_fn->locals_top);
    // }

    compiler__emit_pop(self, self->compiled_fn->function_base.arguments_top);
    compiler__emit_ins(self, INS_RET);
}

static void compiler__emit_if_stmt(compiler_t* self, compiled_statement_t* stmt) {
    ASSERT(compiler__ate(self) == TOKEN_IF);
    
    compiler__emit_expr(self, 0, stmt);

    uint8_t* then_ip = compiler__cur_ip(self);
    compiler__emit_ins(self, INS_JF, NULL);

    compiler__emit_stmt(self, compiler__eat(self));

    uint8_t* exit_ip = compiler__cur_ip(self);
    compiler__emit_ins(self, INS_JMP, NULL);

    compiler__patch_jmp(then_ip, compiler__cur_ip(self));

    if (compiler__eat_if(self, TOKEN_ELSE)) {
        compiler__emit_stmt(self, compiler__eat(self), stmt);
    }

    compiler__patch_jmp(exit_ip, compiler__cur_ip(self));
}

static void compiler__emit_while_stmt(compiler_t* self, compiled_statement_t* stmt) {
    ASSERT(compiler__ate(self) == TOKEN_WHILE);

    uint8_t* loop_start = compiler__cur_ip(self);

    compiler__emit_expr(self, 0, stmt);

    uint8_t* exit_ip = compiler__cur_ip(self);
    compiler__emit_ins(self, INS_JF, NULL);

    compiler__emit_stmt(self, compiler__eat(self), stmt);
    compiler__emit_ins(self, INS_JMP, loop_start);

    compiler__patch_jmp(exit_ip, compiler__cur_ip(self));
}

static void compiler__emit_stmt(compiler_t* self, token_type_t token_type, compiled_statement_t* stmt) {
    compiled_statement_t stmt;
    compiled_statement__create(&stmt);

    switch (token_type) {
        case TOKEN_IF: {
            compiler__emit_if_stmt(self, &stmt);
        } break ;
        case TOKEN_WHILE: {
            compiler__emit_while_stmt(self, &stmt);
        } break ;
        case TOKEN_FOR: {
        } break ;
        case TOKEN_SWITCH: {
        } break ;
        case TOKEN_LEFT_CURLY: {
            compiler__begin_scope(self);
            compiler__emit_block_stmt(self, &stmt);
            compiler__end_scope(self);
        } break ;
        case TOKEN_CONTINUE: {
        } break ;
        case TOKEN_BREAK: {
        } break ;
        case TOKEN_RETURN: {
        } break ;
        case TOKEN_PRINT: {
            compiler__emit_print_stmt(self, &stmt);
        } break ;
        default: {
            compiler__emit_expr_stmt(self, &stmt);
        }
    }

    compiled_statement__destroy(&stmt);
}

static local_t* compiler__parse_local_decl(compiler_t* self, token_type_t token_type) {
    if (token_type == TOKEN_CONST) {
        // todo: turn the declaration into const
        token_type = compiler__eat(self);
    } else {
        ASSERT(token_type == TOKEN_IDENTIFIER);
    }

    if (token_type != TOKEN_IDENTIFIER) {
        compiler__err(self, "expected [%s] for declaration, but got [%s]", token_type__to_str(TOKEN_IDENTIFIER), token_type__to_str(token_type));
        return 0;
    }

    token_t type_token = self->token_prev;
    type_t* type = compiler__find_type_of_token(self, type_token);
    if (!type) {
        compiler__err(self, "type [%.*s] is not defined in declaration", type_token.lexeme_len, type_token.lexeme);
        return 0;
    }

    token_type = compiler__eat(self);
    if (token_type != TOKEN_IDENTIFIER) {
        compiler__err(self, "expected [%s] for declaration, but got [%s]", token_type__to_str(TOKEN_IDENTIFIER), token_type__to_str(token_type));
        return 0;
    }

    token_t variable_token = self->token_prev;
    local_t* local = compiler__get_local(self, variable_token);
    if (local) {
        // todo: show where the previous definition is
        compiler__err(self, "declaration [%.*s] already exists in current scope with type of [%s]", variable_token.lexeme_len, variable_token.lexeme, local->type->abbreviated_name);
        return 0;
    }

    local = compiler__add_local(self, variable_token, type);

    return local;
}

static void compiler__emit_type_decl_stmt(compiler_t* self, token_type_t token_type) {
    bool is_const = false;
    if (token_type == TOKEN_CONST) {
        is_const = true;
        token_type = compiler__eat(self);
    }

    local_t* local = compiler__parse_local_decl(self, token_type);
    if (!local) {
        return ;
    }
    local->is_const = is_const;

    type_t* initializer_type = 0;
    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        initializer_type = compiler__emit_expr(self, 0);
        type_t* type = compiler__emit_explicit_convert(self, initializer_type, local->type);
        if (!type) {
            return ;
        }

        compiler__emit_local(self, LOCAL_INS_STORE, local, NULL);
    } else {
        if (local->is_const) {
            compiler__err(self, "constant variable [%.*s] requires an initializer", local->token.lexeme_len, local->token.lexeme);
            return ;
        }
    }

    if (!initializer_type) {
        // todo: 0-initialize or report error?
        compiler__warn(self, "variable declaration is uninitialized: [%.*s]", local->token.lexeme_len, local->token.lexeme);
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "expected ';' at the end of variable declaration");
}

static void compiler__emit_expr_stmt(compiler_t* self, compiled_statement_t* stmt) {
    compiler__emit_expr(self, 0, stmt);
    compiler__eat_err(self, TOKEN_SEMICOLON, "expected ';' at the end of statement");
    compiler__emit_pop(self, 1);
}
