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

static bool compiler__is_at_end(compiler_t* self);
static token_type_t compiler__peak(compiler_t* self);
static token_type_t compiler__eat(compiler_t* self);
static token_type_t compiler__ate(compiler_t* self);
// @returns true if matched token_type
static bool compiler__eat_if(compiler_t* self, token_type_t token_type);
// @returns false if there was an error
static bool compiler__eat_err(compiler_t* self, token_type_t token_type, const char* err_msg, ...);
// @brief treats current token as an error
static void compiler__err(compiler_t* self, const char* err_msg, ...);
static void compiler__verr(compiler_t* self, const char* err_msg, va_list ap);
static void compiler__sync(compiler_t* self);

static void compiler__flag_add(const char* flag, compiler_flag_t compiler_flag);

static void compiler__begin_scope(compiler_t* self);
static void compiler__end_scope(compiler_t* self);

static type_t* compiler__emit_with_prec(compiler_t* self, type_t* type, precedence_t precedence);
static type_t* compiler__emit_expr(compiler_t* self, type_t* type);
static type_t* compiler__emit_args(compiler_t* self, type_t* type);
static void compiler__emit_print_stmt(compiler_t* self);
static type_t* compiler__emit_implicit_convert(compiler_t* self, type_t* left, type_t* right);
static void compiler__emit_decl_stmt(compiler_t* self, token_type_t token_type);
static type_t* compiler__emit_lnot(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_bnot(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_neg(compiler_t* self, type_t* type, bool can_assign);

static type_t* compiler__emit_grouping(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_call(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_unary(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_binary(compiler_t* self, type_t* left, bool can_assign);
static type_t* compiler__emit_ternary(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_identifier(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_string_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_character_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_integral_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_floating_literal(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_bitwise_and(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_bitwise_xor(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_bitwise_or(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_logical_and(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_logical_or(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_bitwise_not(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_false(compiler_t* self, type_t* type, bool can_assign);
static type_t* compiler__emit_true(compiler_t* self, type_t* type, bool can_assign);

static compile_rule_t compile_rules[] = {
/*   token type                    prefix emitter                       infix emitter               precedence  */
    [TOKEN_LEFT_PAREN]          = {compiler__emit_grouping,             compiler__emit_call,        PREC_CALL},
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
    [TOKEN_INTEGRAL_LITERAL]    = {compiler__emit_integral_literal,     NULL,                       PREC_NONE},
    [TOKEN_FLOATING_LITERAL]    = {compiler__emit_floating_literal,     NULL,                       PREC_NONE},
    [TOKEN_BITWISE_AND]         = {NULL,                                compiler__emit_bitwise_and, PREC_BITWISE_AND},
    [TOKEN_BITWISE_XOR]         = {NULL,                                compiler__emit_bitwise_xor, PREC_BITWISE_XOR},
    [TOKEN_BITWISE_OR]          = {NULL,                                compiler__emit_bitwise_or,  PREC_BITWISE_OR},
    [TOKEN_LOGICAL_AND]         = {NULL,                                compiler__emit_logical_and, PREC_LOGICAL_AND},
    [TOKEN_LOGICAL_OR]          = {NULL,                                compiler__emit_logical_or,  PREC_LOGICAL_OR},
    [TOKEN_BITWISE_NOT]         = {compiler__emit_bitwise_not,          NULL,                       PREC_UNARY},
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

static void compiler__emit_print_stmt(compiler_t* self) {
    ASSERT(compiler__ate(self) == TOKEN_PRINT);
    type_t* type = compiler__emit_expr(self, 0);
    if (!type) {
        return ;
    }

    if (type__is_integral(type)) {
        type_internal_function__add_ins(self->compiled_fn, INS_PRINT);
    } else if (type__is_floating(type)) {
        type_internal_function__add_ins(self->compiled_fn, INS_PRINTF);
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

static type_t* compiler__emit_unary(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    token_type_t unary_token_type = compiler__ate(self);
    type = compiler__emit_with_prec(self, type, PREC_UNARY);

    switch (unary_token_type) {
        case TOKEN_MINUS: {
            type = compiler__emit_neg(self, type, can_assign);
        } break ;
        case TOKEN_LOGICAL_NOT: {
            type = compiler__emit_lnot(self, type, can_assign);
        } break ;
        case TOKEN_BITWISE_NOT: {
            type = compiler__emit_bnot(self, type, can_assign);
        } break ;
        default: ASSERT(false);
    }

    return type;
}

static type_t* compiler__emit_implicit_convert(compiler_t* self, type_t* left, type_t* right) {
    if (left->type_specifier != TYPE_ATOM || right->type_specifier != TYPE_ATOM) {
        compiler__err(
            self,
            "no implicit conversion between types [%s] and [%s]",
            left->abbreviated_name,
            right->abbreviated_name
        );
        return 0;
    }
    const bool is_left_float = type__is_floating(left);
    const bool is_right_float = type__is_floating(right);
    type_t* bigger_type = type__size(left) > type__size(right) ? left : right;
    if (is_left_float && is_right_float) {
        return bigger_type;
    } else if (is_left_float) {
        type_internal_function__add_ins(self->compiled_fn, INT_CVTI2F);
        return left;
    } else if (is_right_float) {
        type_internal_function__add_ins(self->compiled_fn, INT_CVTI2F);
        return right;
    } else {
        const bool is_left_unsigned = type__is_unsigned(left);
        const bool is_right_unsigned = type__is_unsigned(right);
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

static type_t* compiler__emit_binary(compiler_t* self, type_t* left, bool can_assign) {
    (void) can_assign;

    ASSERT(left);

    token_type_t binary_token_type = compiler__ate(self);
    compile_rule_t* rule = compiler__get_compile_rule(binary_token_type);
    type_t* right = compiler__emit_with_prec(self, left, rule->precedence + 1);
    if (!right) {
        return 0;
    }

    switch (binary_token_type) {
        case TOKEN_PLUS: {
            left = compiler__emit_implicit_convert(self, left, right);
            if (!left) {
                return 0;
            }

            if (type__is_integral(left)) {
                type_internal_function__add_ins(self->compiled_fn, INS_ADD);
            } else if (type__is_floating(left)) {
                type_internal_function__add_ins(self->compiled_fn, INS_ADDF);
            } else {
                compiler__err(
                    self,
                    "[%s] binary operator is not defined for types [%s] and [%s]",
                    token_type__to_str(binary_token_type),
                    left->abbreviated_name,
                    right->abbreviated_name
                );
                return 0;
            }
        } break ;
        default: ASSERT(false && "this binary operator is not supported");
    }
    
    return left;
}

static type_t* compiler__emit_ternary(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_identifier(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_string_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) type;
    (void) can_assign;
    ASSERT(compiler__ate(self) == TOKEN_STRING_LITERAL);

    return 0;
}

static type_t* compiler__emit_character_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) type;
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_CHARACTER_LITERAL);
    char c = *self->token_prev.lexeme;
    type_internal_function__add_ins(self->compiled_fn, INS_PUSH, (reg_t) c);

    return t_s8;
}

static type_t* compiler__emit_integral_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_INTEGRAL_LITERAL);
    double result = strntod(self->token_prev.lexeme, self->token_prev.lexeme_len);
    type_internal_function__add_ins(self->compiled_fn, INS_PUSH, (reg_t) result);

    // determine signed/unsigned and length of type
    (void) type;

    return t_u64;
}

static type_t* compiler__emit_floating_literal(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    ASSERT(compiler__ate(self) == TOKEN_FLOATING_LITERAL);
    double result = strntod(self->token_prev.lexeme, self->token_prev.lexeme_len);
    type_internal_function__add_ins(self->compiled_fn, INS_PUSHF, (regf_t) result);

    // determine float/double
    (void) type;

    return t_r64;
}

static type_t* compiler__emit_bitwise_and(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_bitwise_xor(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;
    
    return type;
}

static type_t* compiler__emit_bitwise_or(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_logical_and(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_logical_or(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_bitwise_not(compiler_t* self, type_t* type, bool can_assign) {
    (void) self;
    (void) can_assign;

    return type;
}

static type_t* compiler__emit_false(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    type_internal_function__add_ins(self->compiled_fn, INS_PUSH, 0);

    return type;
}

static type_t* compiler__emit_true(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    type_internal_function__add_ins(self->compiled_fn, INS_PUSH, 1);

    return type;
}

static void compiler__begin_scope(compiler_t* self) {
    if (self->scope_cur == self->scope_end) {
        if (self->scope_cur == self->scope_start) {
            uint32_t scopes_size = 8;
            self->scope_start = malloc(scopes_size * sizeof(*self->scope_start));
            self->scope_end = self->scope_start + scopes_size;
            self->scope_cur = self->scope_start;
        } else {
            uint32_t old_scope_size = self->scope_end - self->scope_start;
            uint32_t scopes_size = old_scope_size << 1;
            self->scope_start = realloc(self->scope_start, scopes_size * sizeof(*self->scope_start));
            self->scope_end = self->scope_start + scopes_size;
            self->scope_cur = self->scope_start + old_scope_size;
        }
        hash_map_t* scope = self->scope_cur;
        while (scope < self->scope_end) {
            const uint32_t size_of_scope_key = sizeof(const char*);
            const uint32_t size_of_scope_value = sizeof(function_local_t);
            const uint32_t scope_entry_size = hash_map__entry_size(size_of_scope_key, size_of_scope_value);
            const uint32_t scope_n_of_entries = 128;
            void* scope_memory = malloc(scope_entry_size * scope_n_of_entries);
            ASSERT(scope_memory);
            ASSERT(
                hash_map__create(
                    scope, scope_memory, scope_n_of_entries,
                    size_of_scope_key, size_of_scope_value,
                    hash_fn__string, eq_fn__string
                )
            );
            ++scope;
        }
    }

    ++self->scope_cur;
    ASSERT(self->scope_cur < self->scope_end);
}

static void compiler__end_scope(compiler_t* self) {
    ASSERT(self->scope_cur > self->scope_start);

    hash_map_t* scope = self->scope_cur;
    hash_map__clear(scope);

    --self->scope_cur;
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

#define COMPILER_FLAG_MAX_ERRORS "fmax-errors"
#define COMPILER_FLAG_MAX_ERRORS_HELP_MESSAGE "Maximum number of errors to report."
#define COMPILER_FLAG_LONG_FORM_HELP "-help"
#define COMPILER_FLAG_SHORT_FORM_HELP "h"
#define COMPILER_FLAG_HELP_MESSAGE "Display this information."
bool compiler__flag_help(const char* arg, compiler_flags_t* compiler_flags) {
    (void) arg;
    (void) compiler_flags;

    printf("Usage: app [options] [files]\n");
    printf("Options:\n");
    hash_map_key_t* cur = hash_map__begin(compiler_flag_fns);
    const uint32_t col_pad_len = 4;
    const uint32_t option_col_len = 20;
    while (cur != hash_map__end(compiler_flag_fns)) {
        compiler_flag_t* compiler_flag = (compiler_flag_t*) hash_map__value(compiler_flag_fns, cur);
        printf(
            "  -%-*s%*c%-s\n",
            option_col_len, *(char**) cur,
            col_pad_len, ' ',
            compiler_flag->help_message
        );
        cur = hash_map__next(compiler_flag_fns, cur);
    }

    return false;
}

bool compiler__flag_fn_max_errors(const char* arg, compiler_flags_t* compiler_flags) {
    arg = strchr(arg, '=');
    if (!arg) {
        fprintf(stderr, "missing argument to [-%s=]\n", COMPILER_FLAG_MAX_ERRORS);

        return false;
    } else {
        compiler_flags->compiler_flag_limit_errors_n = atoi((arg + strlen(COMPILER_FLAG_MAX_ERRORS)));

        return true;
    }
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

    compiler__flag_add(COMPILER_FLAG_MAX_ERRORS, (compiler_flag_t) { &compiler__flag_fn_max_errors, COMPILER_FLAG_MAX_ERRORS_HELP_MESSAGE });
    compiler__flag_add(COMPILER_FLAG_SHORT_FORM_HELP, (compiler_flag_t) { &compiler__flag_help, COMPILER_FLAG_HELP_MESSAGE });
    compiler__flag_add(COMPILER_FLAG_LONG_FORM_HELP, (compiler_flag_t) { &compiler__flag_help, COMPILER_FLAG_HELP_MESSAGE});

    return true;
}

bool compiler__create(compiler_t* self, compiler_flags_t* compiler_flags, const char* source, uint64_t source_len) {
    memset(self, 0, sizeof(*self));

    self->flags = compiler_flags;

    scanner__init(&self->scanner, source, source_len);

    if (!types__create(&self->types)) {
        return false;
    }

    return true;
}

void compiler__destroy(compiler_t* self) {
    hash_map_t* scope = self->scope_cur;
    while (scope < self->scope_end) {
        free(scope->memory);
        ++scope;
    }
}

bool compiler__compile(compiler_t* self, const char* fn_name, uint8_t* ip_start, uint8_t* ip_end) {
    self->ip_start = ip_start;
    self->ip_cur = ip_start;
    self->ip_end = ip_end;

    self->compiled_fn = type_internal_function__create(fn_name);
    type_internal_function__set_ip(self->compiled_fn, self->ip_cur);

    compiler__eat(self);
    while (!compiler__is_at_end(self)) {
        compiler__emit_decl_stmt(self, compiler__eat(self));
    }

    compiler__eat_err(self, TOKEN_EOF, "expected eof token");

    if (self->had_error) {
        return false;
    }

    type_internal_function__add_ins(self->compiled_fn, INS_RET);

    return true;
}

#include "builtin_fns.c"
void compiler__define_builtins(compiler_t* self) {
    type_t* t_voidp = (type_t*) type_pointer__create("void_p", NULL);
    types__type_add(&self->types, t_voidp);

    type_builtin_function_t* builtin_malloc = type_builtin_function__create("malloc", &builtin__execute_malloc);
    type_function__add_argument(&builtin_malloc->function_base, "size", t_u64);
    type_function__set_return(&builtin_malloc->function_base, t_voidp);

    type_builtin_function_t* builtin_free = type_builtin_function__create("free", &builtin__execute_free);
    type_function__add_argument(&builtin_free->function_base, "addr", t_voidp);

    type_builtin_function_t* builtin_print = type_builtin_function__create("print", &builtin__execute_print);
    type_function__add_argument(&builtin_print->function_base, "type", t_voidp);
    type_function__add_argument(&builtin_print->function_base, "addr", t_voidp);

    types__type_add(&self->types, (type_t*) builtin_malloc);
    types__type_add(&self->types, (type_t*) builtin_free);
    types__type_add(&self->types, (type_t*) builtin_print);
}

void compiler__patch_jmp(uint8_t* jmp_ip, uint8_t* new_addr) {
    *(uint64_t*)(jmp_ip + 1) = (uint64_t) new_addr;
}

static bool compiler__is_at_end(compiler_t* self) {
    return compiler__peak(self) == TOKEN_EOF;
}

static token_type_t compiler__peak(compiler_t* self) {
    return self->token_cur.type;
}

static void compiler__err(compiler_t* self, const char* err_msg, ...) {
    if (self->panic_mode || self->flags->compiler_flag_limit_errors_n == 0) {
        return ;
    }

    va_list ap;
    va_start(ap, err_msg);

    compiler__verr(self, err_msg, ap);

    va_end(ap);

    compiler__sync(self);
}

static void compiler__verr(compiler_t* self, const char* err_msg, va_list ap) {
    ASSERT(self->flags->compiler_flag_limit_errors_n > 0);
    ASSERT(!self->panic_mode);

    self->had_error  = true;
    self->panic_mode = true;

    fprintf(stderr, "[Compiler]: Error: ");
    vfprintf(stderr, err_msg, ap);
    fprintf(
        stderr,
        "\n[Compiler]: %u:%u - %u:%u: [%.*s]\n",
        self->token_cur.line_s, self->token_cur.col_s,
        self->token_cur.line_e, self->token_cur.col_e,
        self->token_cur.lexeme_len, self->token_cur.lexeme
    );
}

static void compiler__sync(compiler_t* self) {
    if (self->flags->compiler_flag_limit_errors_n > 0) {
        --self->flags->compiler_flag_limit_errors_n;
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

ins_t function_ins__to_ins(function_ins_t function_ins) {
    switch (function_ins) {
        case FUNCTION_INS_LOAD_ADDRESS: return INS_LREA;
        case FUNCTION_INS_STORE_INTEGRAL: return INS_SAR;
        case FUNCTION_INS_STORE_FLOAT: return INS_SARF;
        case FUNCTION_INS_LOAD_INTEGRAL: return INS_LRA;
        case FUNCTION_INS_LOAD_FLOAT: return INS_LRAF;
        default: ASSERT(false);
    }

    return 0;
}

void compiler__emit_internal_function_arg(compiler_t* self, type_function_t* target_function, function_ins_t function_ins, uint32_t arg_index, ...) {
    ASSERT(arg_index < target_function->arguments_top);

    va_list ap;
    va_start(ap, arg_index);

    type_t* atom = target_function->arguments[arg_index].type;
    uint64_t offset_of_atom_uint64_t = type__member_offsetv(&atom, ap);
    ASSERT(offset_of_atom_uint64_t <= UINT32_MAX);
    uint32_t offset_of_atom = (uint32_t) offset_of_atom_uint64_t;
    ASSERT(atom);

    ins_t ins = function_ins__to_ins(function_ins);
    if (function_ins == FUNCTION_INS_LOAD_ADDRESS) {
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK, target_function->arguments_top - arg_index - 1, offset_of_atom);
    } else {
        ASSERT(!type__is_aggregate_type(atom));
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK, target_function->arguments_top - arg_index - 1, offset_of_atom, type__size(atom));
    }

    va_end(ap);
}

void compiler__emit_internal_function_ret(compiler_t* self, type_function_t* target_function, function_ins_t function_ins, ...) {
    va_list ap;
    va_start(ap, function_ins);

    type_t* atom = target_function->return_type;
    ASSERT(atom);
    uint64_t offset_of_atom_uint64_t = type__member_offsetv(&atom, ap);
    ASSERT(offset_of_atom_uint64_t <= UINT32_MAX);
    uint32_t offset_of_atom = (uint32_t) offset_of_atom_uint64_t;
    ASSERT(atom);

    ins_t ins = function_ins__to_ins(function_ins);
    if (function_ins == FUNCTION_INS_LOAD_ADDRESS) {
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK, 0, offset_of_atom);
    } else {
        ASSERT(!type__is_aggregate_type(atom));
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK, 0, offset_of_atom, type__size(atom));
    }

    va_end(ap);
}

void compiler__emit_internal_function_local(compiler_t* self, function_ins_t function_ins, const char* local_name, ...) {
    va_list ap;
    va_start(ap, local_name);

    type_t* atom = 0;
    uint8_t atom_index_from_top = 0;
    ASSERT(self->compiled_fn->locals_top < UINT8_MAX);
    for (int32_t local_index = self->compiled_fn->locals_top - 1; local_index >= 0; --local_index) {
        if (strcmp(local_name, self->compiled_fn->locals[local_index].name) == 0) {
            atom = self->compiled_fn->locals[local_index].type;
            break ;
        }
        ++atom_index_from_top;
    }
    ASSERT(atom);

    uint64_t offset_of_atom_uint64_t = type__member_offsetv(&atom, ap);
    ASSERT(offset_of_atom_uint64_t <= UINT32_MAX);
    uint32_t offset_of_atom = (uint32_t) offset_of_atom_uint64_t;
    ASSERT(atom);

    ins_t ins = function_ins__to_ins(function_ins);
    if (function_ins == FUNCTION_INS_LOAD_ADDRESS) {
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK, atom_index_from_top, offset_of_atom);
    } else {
        ASSERT(!type__is_aggregate_type(atom));
        type_internal_function__add_ins(self->compiled_fn, ins, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK, atom_index_from_top, offset_of_atom, type__size(atom));
    }

    va_end(ap);
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

    type_internal_function__add_ins(self->compiled_fn, call_ins, target_function);
    for (uint32_t arg_index = 0; arg_index < target_function->arguments_top; ++arg_index) {
        type_internal_function__add_ins(self->compiled_fn, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    }
}

static void compiler__emit_decl_stmt(compiler_t* self, token_type_t token_type) {
    switch (token_type) {
        case TOKEN_FN: {
            compiler__emit_decl_fn(self);
        } break ;
        case TOKEN_CONST: {
            compiler__emit_type_decl_stmt(self, TOKEN_CONST);
        } break ;
        default: {
            compiler__emit_stmt(self, token_type);
        }
    }
}

static type_t* compiler__emit_lnot(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    type_internal_function__add_ins(self->compiled_fn, INS_LNOT);

    return type;
}

static type_t* compiler__emit_bnot(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    type_internal_function__add_ins(self->compiled_fn, INS_BNOT);

    return type;
}

static type_t* compiler__emit_neg(compiler_t* self, type_t* type, bool can_assign) {
    (void) can_assign;

    ASSERT(type);
    if (type__is_floating(type)) {
        type_internal_function__add_ins(self->compiled_fn, INS_NEGF);
    } else if (type__is_integral(type)) {
        type_internal_function__add_ins(self->compiled_fn, INS_NEG);
    } else {
        compiler__err(
            self,
            "negate unary operator is not defined for type [%s]",
            type->abbreviated_name
        );

        return 0;
    }

    return type;
}

void compiler__emit_decl_fn(compiler_t* self) {
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

    debug__set_fn(&debug, fn_name);

    self->compiled_fn = type_internal_function__create(fn_name);
    type_internal_function__set_ip(self->compiled_fn, self->ip_cur);
    
    // compile fn body
    compiler__eat(self);

    // pop locals
    if (self->compiled_fn->locals_top == 1) {
        type_internal_function__add_ins(self->compiled_fn, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK);
    } else if (self->compiled_fn->locals_top > 1) {
        type_internal_function__add_ins(self->compiled_fn, INS_POPN_TYPE, ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK, self->compiled_fn->locals_top);
    }

    // pop arguments
    if (self->compiled_fn->function_base.arguments_top == 1) {
        type_internal_function__add_ins(self->compiled_fn, INS_POP_TYPE, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK);
    } else if (self->compiled_fn->function_base.arguments_top > 1) {
        type_internal_function__add_ins(self->compiled_fn, INS_POPN_TYPE, ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK, self->compiled_fn->function_base.arguments_top);
    }

    type_internal_function__add_ins(self->compiled_fn, INS_RET);
}

void compiler__emit_stmt(compiler_t* self, token_type_t token_type) {
    switch (token_type) {
        case TOKEN_IF: {
        } break ;
        case TOKEN_WHILE: {
        } break ;
        case TOKEN_FOR: {
        } break ;
        case TOKEN_SWITCH: {
        } break ;
        case TOKEN_LEFT_CURLY: {
        } break ;
        case TOKEN_CONTINUE: {
        } break ;
        case TOKEN_BREAK: {
        } break ;
        case TOKEN_RETURN: {
        } break ;
        case TOKEN_PRINT: {
            compiler__emit_print_stmt(self);
        } break ;
        default: {
            compiler__emit_expr_stmt(self);
        }
    }
}

void compiler__emit_type_decl_stmt(compiler_t* self, token_type_t token_type) {
    (void) self;
    (void) token_type;

    compiler__eat(self);
}

void compiler__emit_expr_stmt(compiler_t* self) {
    compiler__emit_expr(self, 0);
    compiler__eat_err(self, TOKEN_SEMICOLON, "expected ';' at the end of statement");
    // todo: pop
}
