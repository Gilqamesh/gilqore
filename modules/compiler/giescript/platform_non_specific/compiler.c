#include "compiler.h"
#include "scanner.h"
#include "chunk.h"
#include "obj.h"
#include "vm.h"
#include "debug.h"

#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

// todo: move to param
static scanner_t  g_scanner;
static token_t    g_current;
static token_t    g_previous;
static vm_t*      g_vm = NULL;
bool              g_had_error;
bool              g_panic_mode;

// operator precedence table (top to bottom, in ascending precedence)
typedef enum {
    PREC_NONE,
    PREC_COMMA,
    PREC_ASSIGNMENT,
    PREC_TERNARY,
    PREC_OR,
    PREC_AND,
    PREC_EQUALITY,
    PREC_COMPARISON,
    PREC_TERM,
    PREC_FACTOR,
    PREC_UNARY,
    PREC_CALL,
    PREC_PRIMARY
} precedence;

typedef struct {
    void (*prefix)(compiler_t* self, bool can_assign);
    void (*infix)(compiler_t* self, bool can_assign);
    precedence prec;
} compile_rule;

static compile_rule* compiler__get_rule(token_type type);

// compiles from the specified precedence till the highest precedence
static void compiler__emit_prec(compiler_t* self, precedence prec);

static void compiler__emit_ins(compiler_t* self, ins_mnemonic_t ins);
static void compiler__emit_decl_stmt(compiler_t* self);
static void compiler__emit_var_decl_stmt(compiler_t* self);
static void compiler__emit_fun_decl_stmt(compiler_t* self);
static void compiler__emit_stmt(compiler_t* self);
static void compiler__emit_print_stmt(compiler_t* self);
static void compiler__emit_if_stmt(compiler_t* self);
static void compiler__emit_while_stmt(compiler_t* self);
static void compiler__emit_for_stmt(compiler_t* self);
static void compiler__emit_switch_stmt(compiler_t* self);
static void compiler__emit_expr_stmt(compiler_t* self);
static void compiler__emit_block_stmt(compiler_t* self);
static void compiler__emit_continue_stmt(compiler_t* self);
static void compiler__emit_break_stmt(compiler_t* self);
static void compiler__emit_return_stmt(compiler_t* self);
static void compiler__emit_expr(compiler_t* self);

static void compiler__emit_grouping(compiler_t* self, bool can_assign);
static void compiler__emit_unary(compiler_t* self, bool can_assign);
static void compiler__emit_binary(compiler_t* self, bool can_assign);
static void compiler__emit_ternary(compiler_t* self, bool can_assign);

// these define the instruction stream interface between vm/compiler
static void compiler__emit_return(compiler_t* self, bool can_assign);
static void compiler__emit_imm(compiler_t* self, bool can_assign);
static void compiler__emit_nil(compiler_t* self, bool can_assign);
static void compiler__emit_true(compiler_t* self, bool can_assign);
static void compiler__emit_false(compiler_t* self, bool can_assign);
static void compiler__emit_neg(compiler_t* self, bool can_assign);
static void compiler__emit_add(compiler_t* self, bool can_assign);
static void compiler__emit_sub(compiler_t* self, bool can_assign);
static void compiler__emit_mul(compiler_t* self, bool can_assign);
static void compiler__emit_div(compiler_t* self, bool can_assign);
static void compiler__emit_mod(compiler_t* self, bool can_assign);
static void compiler__emit_not(compiler_t* self, bool can_assign);
static void compiler__emit_eq(compiler_t* self, bool can_assign);
static void compiler__emit_lt(compiler_t* self, bool can_assign);
static void compiler__emit_gt(compiler_t* self, bool can_assign);
static void compiler__emit_print(compiler_t* self, bool can_assign);
static void compiler__emit_pop(compiler_t* self, bool can_assign);
static void compiler__emit_get_var(compiler_t* self, bool can_assign);
static void compiler__emit_set_var(compiler_t* self, bool can_assign);
static void compiler__emit_and(compiler_t* self, bool can_assign);
static void compiler__emit_or(compiler_t* self, bool can_assign);
static void compiler__emit_dup(compiler_t* self, bool can_assign);
static void compiler__emit_call(compiler_t* self, bool can_assign);

static void compiler__emit_str(compiler_t* self, bool can_assign);
static void compiler__emit_identifier(compiler_t* self, bool can_assign);

static void compiler__init(compiler_t* self, compiler_t* parent);
static token_type compiler__peak(compiler_t* self);
static void compiler__eat(compiler_t* self);
static bool compiler__eat_if(compiler_t* self, token_type type);
static void compiler__eat_err(compiler_t* self, token_type type, const char* err_msg);
static void compiler__error_at(compiler_t* self, token_t* token, const char* err_msg);
// static void       compiler__warn_at(compiler_t* self, token_t* token, const char* warn_msg);
static obj_fun_t* compiler__end_compile(compiler_t* self);
// skips tokens until a statement boundary is reached
static void compiler__synchronize(compiler_t* self);
// parses variable, returns the declaration
static entry_t* compiler__parse_decl(compiler_t* self);
static void compiler__parse_fn(compiler_t* self);
static entry_t* compiler__decl(compiler_t* self, token_t* ident, token_t* ident_type);
static entry_t* compiler__add_decl(compiler_t* self, token_t* ident, token_t* ident_type);
static entry_t* compiler__find_decl(compiler_t* self, token_t* var_name);
static void compiler__emit_named_decl(compiler_t* self, token_t var, bool can_assign);
static void compiler__begin_scope(compiler_t* self);
static void compiler__end_scope(compiler_t* self);
static u32  compiler__push_imm(compiler_t* self, value_t value, token_t token);
static u32 compiler__emit_jump(compiler_t* self, ins_mnemonic_t ins);
static void compiler__patch_jump(compiler_t* self, u32 ip_index);
static u32 compiler__emit_args(compiler_t* self);

// maps token type to its compile rule
static compile_rule compile_rules[] = {
/*   token type              prefix emitter                 infix emitter               precedence  */
    [TOKEN_LEFT_PAREN]    = {compiler__emit_grouping,       compiler__emit_call,        PREC_CALL},
    [TOKEN_RIGHT_PAREN]   = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_LEFT_BRACE]    = {NULL,                          NULL,                       PREC_NONE}, 
    [TOKEN_RIGHT_BRACE]   = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_COMMA]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_DOT]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_MINUS]         = {compiler__emit_unary,          compiler__emit_binary,      PREC_TERM},
    [TOKEN_PLUS]          = {NULL,                          compiler__emit_binary,      PREC_TERM},
    [TOKEN_SEMICOLON]     = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_SLASH]         = {NULL,                          compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_PERCENTAGE]    = {NULL,                          compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_STAR]          = {NULL,                          compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_QUESTION_MARK] = {NULL,                          compiler__emit_ternary,     PREC_TERNARY},
    [TOKEN_EXCLAM]        = {compiler__emit_unary,          NULL,                       PREC_NONE},
    [TOKEN_EXCLAM_EQUAL]  = {NULL,                          compiler__emit_binary,      PREC_EQUALITY},
    [TOKEN_EQUAL]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_EQUAL_EQUAL]   = {NULL,                          compiler__emit_binary,      PREC_EQUALITY},
    [TOKEN_GREATER]       = {NULL,                          compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_GREATER_EQUAL] = {NULL,                          compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_LESS]          = {NULL,                          compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_LESS_EQUAL]    = {NULL,                          compiler__emit_binary,      PREC_COMPARISON},
    [TOKEN_IDENTIFIER]    = {compiler__emit_identifier,     NULL,                       PREC_NONE},
    [TOKEN_STRING]        = {compiler__emit_str,            NULL,                       PREC_NONE},
    [TOKEN_NUMBER]        = {compiler__emit_imm,            NULL,                       PREC_NONE},
    [TOKEN_AND]           = {NULL,                          compiler__emit_and,         PREC_AND},
    [TOKEN_OR]            = {NULL,                          compiler__emit_or,          PREC_OR},
    [TOKEN_CLASS]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_ELSE]          = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_FALSE]         = {compiler__emit_false,          NULL,                       PREC_NONE},
    [TOKEN_FOR]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_FUN]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_IF]            = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_NIL]           = {compiler__emit_nil,            NULL,                       PREC_NONE},
    [TOKEN_PRINT]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_RETURN]        = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_SUPER]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_THIS]          = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_TRUE]          = {compiler__emit_true,           NULL,                       PREC_NONE},
    [TOKEN_VAR]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_WHILE]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_ERROR]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_EOF]           = {NULL,                          NULL,                       PREC_NONE},
};

static compile_rule* compiler__get_rule(token_type type) {
    return &compile_rules[type];
}

static void compiler__emit_prec(compiler_t* self, precedence prec) {
    compiler__eat(self);
    compile_rule* prefix_rule = compiler__get_rule(g_previous.type);
    if (!prefix_rule->prefix) {
        compiler__error_at(self, &g_previous, "Expect expression.");
        return ;
    }

    bool can_assign = prec <= PREC_ASSIGNMENT;
    prefix_rule->prefix(self, can_assign);

    while (prec <= compiler__get_rule(g_current.type)->prec) {
        compiler__eat(self);
        compile_rule* infix_rule = compiler__get_rule(g_previous.type);
        ASSERT(infix_rule);
        ASSERT(infix_rule->infix);
        infix_rule->infix(self, can_assign);
    }

    // if the assignment did not get consumed, nothing else is going to consume it -> error
    if (can_assign && compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__error_at(self, &g_previous, "Invalid assignment target.");
    }
}

static void compiler__emit_expr(compiler_t* self) {
    s32 stack_size = self->fn->chunk.current_stack_size;

    compiler__emit_prec(self, PREC_ASSIGNMENT);

    // expressions always leave at least a value (for calls, it's 2 values) on top of the stack
    ASSERT(g_had_error || self->fn->chunk.current_stack_size >= stack_size + 1);
}

static void compiler__emit_grouping(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after expression.");
}

static void compiler__emit_unary(compiler_t* self, bool can_assign) {
    (void) can_assign;

    token_type type = g_previous.type;
    compiler__emit_prec(self, PREC_UNARY);

    switch (type) {
        case TOKEN_MINUS: {
            compiler__emit_neg(self, can_assign);
        } break ;
        case TOKEN_EXCLAM: {
            compiler__emit_not(self, can_assign);
        } break ;
        default: ASSERT(false);
    }
}

static void compiler__emit_binary(compiler_t* self, bool can_assign) {
    (void) can_assign;
   
    token_type type = g_previous.type;
    compile_rule* rule = compiler__get_rule(type);
    compiler__emit_prec(self, rule->prec + 1);

    switch (type) {
        case TOKEN_PLUS: {
            compiler__emit_add(self, can_assign);
        } break ;
        case TOKEN_MINUS: {
            compiler__emit_sub(self, can_assign);
        } break ;
        case TOKEN_STAR: {
            compiler__emit_mul(self, can_assign);
        } break ;
        case TOKEN_SLASH: {
            compiler__emit_div(self, can_assign);
        } break ;
        case TOKEN_PERCENTAGE: {
            compiler__emit_mod(self, can_assign);
        } break ;
        case TOKEN_EXCLAM_EQUAL: {
            compiler__emit_eq(self, can_assign);
            compiler__emit_not(self, can_assign);
        } break ;
        case TOKEN_EQUAL_EQUAL: {
            compiler__emit_eq(self, can_assign);
        } break ;
        case TOKEN_GREATER: {
            compiler__emit_gt(self, can_assign);
        } break ;
        case TOKEN_GREATER_EQUAL: {
            compiler__emit_lt(self, can_assign);
            compiler__emit_not(self, can_assign);
        } break ;
        case TOKEN_LESS: {
            compiler__emit_lt(self, can_assign);
        } break ;
        case TOKEN_LESS_EQUAL: {
            compiler__emit_gt(self, can_assign);
            compiler__emit_not(self, can_assign);
        } break ;
        default: ASSERT(false);
    }
}

static void compiler__emit_ternary(compiler_t* self, bool can_assign) {
    (void) can_assign;

    u32 then_ip = compiler__emit_jump(self, INS_JUMP_ON_FALSE);
    // pop condition expr
    compiler__emit_pop(self, true);

    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_COLON, "Expect ':' after then branch of ternary operator.");
    u32 exit_ip = compiler__emit_jump(self, INS_JUMP);

    compiler__patch_jump(self, then_ip);
    // pop condition expr
    compiler__emit_pop(self, true);

    compiler__emit_expr(self);

    compiler__patch_jump(self, exit_ip);
}

static void compiler__emit_return(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_nil(self, true);
    compiler__emit_ins(self, INS_RETURN);
}

static void compiler__emit_imm(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    r64 value = libc__strntod(g_previous.lexeme, g_previous.lexeme_len);
    DISCARD_RETURN compiler__push_imm(self, value__num(value), g_previous);
}

static void compiler__emit_nil(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_ins(self, INS_NIL);
}

static void compiler__emit_true(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_TRUE);
}

static void compiler__emit_false(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_FALSE);
}

static void compiler__emit_neg(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_NEG);
}

static void compiler__emit_add(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_ADD);
}

static void compiler__emit_sub(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_SUB);
}

static void compiler__emit_mul(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_MUL);
}

static void compiler__emit_div(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_DIV);
}

static void compiler__emit_mod(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_MOD);
}

static void compiler__emit_not(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_NOT);
}

static void compiler__emit_eq(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_EQ);
}

static void compiler__emit_lt(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_LT);
}

static void compiler__emit_gt(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_GT);
}

static void compiler__emit_print(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_PRINT);
}

static void compiler__emit_pop(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_POP);
}

static void compiler__emit_get_var(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_LOAD);
}

static void compiler__emit_set_var(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_STORE);
}

static void compiler__emit_and(compiler_t* self, bool can_assign) {
    (void) can_assign;

    u32 ip = compiler__emit_jump(self, INS_JUMP_ON_FALSE);

    // pop left expr
    compiler__emit_pop(self, true);

    compiler__emit_prec(self, PREC_AND);

    compiler__patch_jump(self, ip);
}

static void compiler__emit_or(compiler_t* self, bool can_assign) {
    (void) can_assign;

    u32 ip = compiler__emit_jump(self, INS_JUMP_ON_TRUE);

    // pop left expr
    compiler__emit_pop(self, true);

    compiler__emit_prec(self, PREC_OR);

    compiler__patch_jump(self, ip);
}

static void compiler__emit_dup(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_ins(self, INS_DUP);
}

static void compiler__emit_call(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    u32 n_args = compiler__emit_args(self);
    compiler__push_imm(self, value__num(n_args), g_previous);
    compiler__emit_ins(self, INS_CALL);
}

static void compiler__emit_str(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    ASSERT(g_previous.lexeme_len > 1);
    value_t obj_str = obj__copy_str(g_vm, g_previous.lexeme + 1, g_previous.lexeme_len - 2);
    DISCARD_RETURN compiler__push_imm(self, obj_str, g_previous);
}

static void compiler__emit_identifier(compiler_t* self, bool can_assign) {
    compiler__emit_named_decl(self, g_previous, can_assign);
}

static void compiler__init(compiler_t* self, compiler_t* parent) {
    libc__memset(self, 0, sizeof(*self));

    self->parent = parent;
    self->ip_loop_start = -1;
    self->ip_loop_end = -1;
    self->fn = obj__alloc_fun(g_vm);
}

static token_type compiler__peak(compiler_t* self) {
    (void) self;
    return g_current.type;
}

static void compiler__eat(compiler_t* self) {
    g_previous = g_current;

    while (42) {
        g_current = scanner__scan_token(&g_scanner);
        if (compiler__peak(self) != TOKEN_ERROR) {
            break ;
        }

        // assumption: lexeme of error tokens received from the scanner are null-terminated
        compiler__error_at(self, &g_current, g_current.lexeme);
    }
}

static bool compiler__eat_if(compiler_t* self, token_type type) {
    if (compiler__peak(self) == type) {
        compiler__eat(self);
        return true;
    }

    return false;
}

static void compiler__eat_err(compiler_t* self, token_type type, const char* err_msg) {
    if (g_current.type == type) {
        compiler__eat(self);
        return ;
    }

    compiler__error_at(self, &g_current, err_msg);
}

static void compiler__error_at(compiler_t* self, token_t* token, const char* err_msg) {
    (void) self;

    if (g_panic_mode) {
        return ;
    }

    g_had_error = true;
    g_panic_mode = true;

    libc__printf("%u:%u %u:%u | ", token->line_s, token->col_s, token->line_e, token->col_e);
    switch (token->type) {
        case TOKEN_ERROR: {
        } break ;
        case TOKEN_EOF: {
            libc__printf("end of file");
        } break ;
        default: {
            libc__printf("'%.*s'", token->lexeme_len, token->lexeme);
        }
    }
    libc__printf(": %s\n", err_msg);
}

// static void compiler__warn_at(compiler_t* self, token_t* token, const char* warn_msg) {
//     if (self->panic_mode) {
//         return ;
//     }

//     libc__printf("%d | Warning", token->line);
//     switch (token->type) {
//         case TOKEN_ERROR: {
//         } break ;
//         case TOKEN_EOF: {
//             libc__printf(" at end");
//         } break ;
//         default: {
//             libc__printf(" at '%.*s'", token->lexeme_len, token->lexeme);
//         }
//     }
//     libc__printf(": %s\n", warn_msg);
// }

static void compiler__emit_ins(compiler_t* self, ins_mnemonic_t ins) {
    chunk__push_ins(&self->fn->chunk, ins, g_previous);
}

static void compiler__emit_decl_stmt(compiler_t* self) {
    switch (compiler__peak(self)) {
        case TOKEN_VAR:
        case TOKEN_CONST: {
            compiler__emit_var_decl_stmt(self);
        } break ;
        case TOKEN_FUN: {
            compiler__emit_fun_decl_stmt(self);
        } break ;
        default: {
            compiler__emit_stmt(self);
        }
    }

    if (g_panic_mode) {
        compiler__synchronize(self);
    }
}

static void compiler__emit_var_decl_stmt(compiler_t* self) {
    entry_t* decl_entry = compiler__parse_decl(self);
    if (!decl_entry) {
        return ;
    }

    ASSERT(obj__is_decl(decl_entry->value));
    obj_decl_t* decl = obj__as_decl(decl_entry->value);

    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__emit_expr(self);
    } else {
        if (decl->is_const) {
            compiler__error_at(self, &g_previous, "Constant variable requires an initializer.");
            // erase declaration so repl can keep running
            ASSERT(decl->scope_depth - 1 < self->scopes_fill);
            ASSERT(table__erase(&self->scopes[decl->scope_depth - 1], decl_entry->key));
            return ;
        }
        compiler__emit_nil(self, true);
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after variable declaration.");

    // at this point we compiled the initializer, ready to set the state of the declaration to defined
    decl->is_defined = true;
}

static void compiler__emit_fun_decl_stmt(compiler_t* self) {
    entry_t* decl_entry = compiler__parse_decl(self);
    if (!decl_entry) {
        return ;
    }

    ASSERT(obj__is_decl(decl_entry->value));
    obj_decl_t* decl = obj__as_decl(decl_entry->value);

    // allow recursive fn calls
    decl->is_defined = true;

    compiler__parse_fn(self);
}

static void compiler__emit_stmt(compiler_t* self) {
    if (compiler__eat_if(self, TOKEN_PRINT)) {
        compiler__emit_print_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_IF)) {
        compiler__emit_if_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_WHILE)) {
        compiler__emit_while_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_FOR)) {
        compiler__emit_for_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_SWITCH)) {
        compiler__emit_switch_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_LEFT_BRACE)) {
        compiler__begin_scope(self);
        compiler__emit_block_stmt(self);
        compiler__end_scope(self);
    } else if (compiler__eat_if(self, TOKEN_CONTINUE)) {
        compiler__emit_continue_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_BREAK)) {
        compiler__emit_break_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_RETURN)) {
        compiler__emit_return_stmt(self);
    } else {
        compiler__emit_expr_stmt(self);
    }
}

static void compiler__emit_print_stmt(compiler_t* self) {
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after value.");
    compiler__emit_print(self, true);
}

static void compiler__emit_if_stmt(compiler_t* self) {
    compiler__eat_err(self, TOKEN_LEFT_PAREN, "Expect '(' after 'if'.");
    // emit condition expr
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after condition.");

    u32 then_ip = compiler__emit_jump(self, INS_JUMP_ON_FALSE);
    // pop condition expr
    compiler__emit_pop(self, true);
    compiler__emit_stmt(self);

    u32 exit_ip = compiler__emit_jump(self, INS_JUMP);
    compiler__patch_jump(self, then_ip);
    
    // pop condition expr
    compiler__emit_pop(self, true);
    if (compiler__eat_if(self, TOKEN_ELSE)) {
        compiler__emit_stmt(self);
    }

    compiler__patch_jump(self, exit_ip);
}

static void compiler__emit_while_stmt(compiler_t* self) {
    compiler__eat_err(self, TOKEN_LEFT_PAREN, "Expect '(' after 'while'.");

    // jump back before the condition expr at the end of the loop
    u32 loop_start = self->fn->chunk.instructions_fill;
    // emit condition expr
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after condition.");
    u32 exit_ip = compiler__emit_jump(self, INS_JUMP_ON_FALSE);

    // pop condition expr
    compiler__emit_pop(self, true);
    compiler__emit_stmt(self);

    // jump back before condition expr
    compiler__push_imm(self, value__num(loop_start), g_previous);
    compiler__emit_ins(self, INS_JUMP);

    // exit to here if condition evaluates to false
    compiler__patch_jump(self, exit_ip);

    // pop condition expr
    compiler__emit_pop(self, true);
}

static void compiler__emit_for_stmt(compiler_t* self) {
    compiler__begin_scope(self);

    compiler__eat_err(self, TOKEN_LEFT_PAREN, "Expect '(' after 'for'.");

    // Initializer
    switch (compiler__peak(self)) {
        case TOKEN_SEMICOLON: {
            compiler__eat(self);
        } break ;
        case TOKEN_VAR:
        case TOKEN_CONST: {
            compiler__emit_var_decl_stmt(self);
        } break ;
        default: {
            compiler__emit_expr_stmt(self);
        }
    }


    // jump over exit jump ins
    u32 for_begin_ip = compiler__emit_jump(self, INS_JUMP);

    // jump to exit
    u32 exit_ip_start = self->fn->chunk.instructions_fill;
    u32 exit_ip = compiler__emit_jump(self, INS_JUMP);

    compiler__patch_jump(self, for_begin_ip);

    // Condition (start of for loop)
    u32 condition_ip = self->fn->chunk.instructions_fill;

    // save loop start/end and depth, overwrite with current one
    s32 ip_loop_start = self->ip_loop_start;
    s32 ip_loop_end = self->ip_loop_end;
    u32 ip_loop_scope_depth = self->ip_loop_scope_depth;
    bool loop_did_break = self->loop_did_break;
    self->ip_loop_end = exit_ip_start;
    self->ip_loop_start = condition_ip;
    self->ip_loop_scope_depth = self->scopes_fill;

    bool had_condition = false;
    if (!compiler__eat_if(self, TOKEN_SEMICOLON)) {
        had_condition = true;
        compiler__emit_expr(self);
        compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after condition clause.");
        compiler__push_imm(self, value__num(exit_ip_start), g_previous);
        compiler__emit_ins(self, INS_JUMP_ON_FALSE);

        // pop condition expr as it evaluated to true
        compiler__emit_pop(self, true);
    }

    // Increment
    if (!compiler__eat_if(self, TOKEN_RIGHT_PAREN)) {
        // jump to body
        u32 body_ip = compiler__emit_jump(self, INS_JUMP);

        // increment
        u32 increment_ip = self->fn->chunk.instructions_fill;
        self->ip_loop_start = increment_ip;
        compiler__emit_expr(self);
        compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after increment clause.");
        compiler__emit_pop(self, true);

        // jump to condition
        compiler__push_imm(self, value__num(condition_ip), g_previous);
        compiler__emit_ins(self, INS_JUMP);

        // body
        compiler__patch_jump(self, body_ip);
        compiler__emit_stmt(self);

        // jump to increment
        compiler__push_imm(self, value__num(increment_ip), g_previous);
        compiler__emit_ins(self, INS_JUMP);
    } else {
        self->ip_loop_start = condition_ip;

        // body
        compiler__emit_stmt(self);

        // jump to condition
        compiler__push_imm(self, value__num(condition_ip), g_previous);
        compiler__emit_ins(self, INS_JUMP);
    }

    compiler__patch_jump(self, exit_ip);

    if (had_condition && !self->loop_did_break) {
        // pop condition expr if there was one and it is left on the stack (in case we broke out, we don't have it anymore)
        compiler__emit_pop(self, true);
    }

    // restore to previous values
    self->ip_loop_start = ip_loop_start;
    self->ip_loop_end = ip_loop_end;
    self->ip_loop_scope_depth = ip_loop_scope_depth;
    self->loop_did_break = loop_did_break;

    compiler__end_scope(self);
}

static void compiler__emit_switch_stmt(compiler_t* self) {
    /*
        switch_stmt     -> "switch" "(" expression ")"
                        "{" switch_case* default_case? "}" ;
        switch_case     -> "case" expression ":" statement* ;
        default_case    -> "default" ":" statement* ;
    */
    compiler__begin_scope(self);

    compiler__eat_err(self, TOKEN_LEFT_PAREN, "Expect '(' before 'switch' condition.");
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after 'switch' condition.");
    compiler__eat_err(self, TOKEN_LEFT_BRACE, "Expect '{' after 'switch'.");

    // jump over exit jump ins
    u32 switch_ip = compiler__emit_jump(self, INS_JUMP);

    // jump to exit
    u32 exit_ip_start = self->fn->chunk.instructions_fill;
    u32 exit_ip = compiler__emit_jump(self, INS_JUMP);

    compiler__patch_jump(self, switch_ip);

    // parse cases
    while (compiler__eat_if(self, TOKEN_CASE)) {
        // duplicate condition, so that it's not popped off from eq
        compiler__emit_dup(self, true);
        compiler__emit_expr(self);
        compiler__eat_err(self, TOKEN_COLON, "Expect ':' after 'case' in 'switch'.");
        compiler__emit_eq(self, true);
        u32 else_ip = compiler__emit_jump(self, INS_JUMP_ON_FALSE);
        // pop result of eq
        compiler__emit_pop(self, true);

        while (
            compiler__peak(self) != TOKEN_EOF &&
            compiler__peak(self) != TOKEN_RIGHT_BRACE &&
            compiler__peak(self) != TOKEN_CASE &&
            compiler__peak(self) != TOKEN_DEFAULT
        ) {
            compiler__emit_stmt(self);
        }

        compiler__push_imm(self, value__num(exit_ip_start), g_previous);
        compiler__emit_ins(self, INS_JUMP);

        compiler__patch_jump(self, else_ip);
        // pop bool expr from eq
        compiler__emit_pop(self, true);
    }

    // parse default
    if (compiler__eat_if(self, TOKEN_DEFAULT)) {
        compiler__eat_err(self, TOKEN_COLON, "Expect ':' after 'default' in 'switch'.");
        while (
            compiler__peak(self) != TOKEN_EOF &&
            compiler__peak(self) != TOKEN_RIGHT_BRACE
        ) {
            if (compiler__peak(self) == TOKEN_CASE) {
                compiler__error_at(self, &g_current, "Cannot have a case after default case in switch statement.");
            }
            compiler__emit_stmt(self);
        }
    }

    compiler__patch_jump(self, exit_ip);

    // pop condition expr
    compiler__emit_pop(self, true);

    compiler__eat_err(self, TOKEN_RIGHT_BRACE, "Expect '}' after 'switch'.");

    compiler__end_scope(self);
}

static void compiler__emit_expr_stmt(compiler_t* self) {
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after value.");
    compiler__emit_pop(self, true);
}

static void compiler__emit_block_stmt(compiler_t* self) {
    while (
        compiler__peak(self) != TOKEN_RIGHT_BRACE &&
        compiler__peak(self) != TOKEN_EOF
    ) {
        compiler__emit_decl_stmt(self);
    }

    compiler__eat_err(self, TOKEN_RIGHT_BRACE, "Expect '}' after block.");
}

static void compiler__emit_continue_stmt(compiler_t* self) {
    if (self->ip_loop_start == -1) {
        compiler__error_at(self, &g_previous, "Cannot use 'continue' outside of a loop.");
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after 'continue'.");

    // discard loop's scope
    for (s32 scope_depth = self->scopes_fill - 1; scope_depth > self->ip_loop_scope_depth; --scope_depth) {
        ASSERT(self->scopes_fill > 0);
        table_t* scope = &self->scopes[scope_depth];
        u32 n_of_vars_in_scope = scope->fill;
        if (n_of_vars_in_scope == 1) {
            compiler__emit_ins(self, INS_POP);
        } else if (n_of_vars_in_scope > 1) {
            compiler__push_imm(self, value__num(n_of_vars_in_scope), g_previous);
            compiler__emit_ins(self, INS_POPN);
        }
    }

    // jump to top of the current loop
    compiler__push_imm(self, value__num(self->ip_loop_start), g_previous);
    compiler__emit_ins(self, INS_JUMP);
}

static void compiler__emit_break_stmt(compiler_t* self) {
    if (self->ip_loop_end == -1) {
        compiler__error_at(self, &g_previous, "Cannot use 'break' outside of a loop.");
    }
    self->loop_did_break = true;

    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after 'break'.");

    // discard loop's scope
    for (s32 scope_depth = self->scopes_fill - 1; scope_depth > self->ip_loop_scope_depth; --scope_depth) {
        ASSERT(self->scopes_fill > 0);
        table_t* scope = &self->scopes[scope_depth];
        u32 n_of_vars_in_scope = scope->fill;
        if (n_of_vars_in_scope == 1) {
            compiler__emit_ins(self, INS_POP);
        } else if (n_of_vars_in_scope > 1) {
            compiler__push_imm(self, value__num(n_of_vars_in_scope), g_previous);
            compiler__emit_ins(self, INS_POPN);
        }
    }

    // jump to end of the current loop
    compiler__push_imm(self, value__num(self->ip_loop_end), g_previous);
    compiler__emit_ins(self, INS_JUMP);
}

static void compiler__emit_return_stmt(compiler_t* self) {
    if (compiler__eat_if(self, TOKEN_SEMICOLON)) {
        compiler__emit_return(self, true);
    } else {
        compiler__emit_expr(self);
        compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after return value.");
        compiler__emit_ins(self, INS_RETURN);
    }
}

static obj_fun_t* compiler__end_compile(compiler_t* self) {
    compiler__emit_return(self, true);

    // ASSERT(self->had_error || self->fn->chunk->current_stack_size == 0);

#if defined(DEBUG_COMPILER_TRACE)
    ASSERT(self->fn);
    chunk__disasm(&self->fn->chunk, self->fn->name);
#endif

    return self->fn;
}

static void compiler__synchronize(compiler_t* self) {
    g_panic_mode = false;

    while (g_current.type != TOKEN_EOF) {
        if (g_previous.type == TOKEN_SEMICOLON) {
            // we are at the next stmt
            return ;
        }
        switch (g_current.type) {
            case TOKEN_CLASS:
            case TOKEN_FUN:
            case TOKEN_VAR:
            case TOKEN_FOR:
            case TOKEN_IF:
            case TOKEN_WHILE:
            case TOKEN_PRINT:
            case TOKEN_RETURN: {
                return ;
            }
        }

        compiler__eat(self);
    }
}

static entry_t* compiler__parse_decl(compiler_t* self) {
    // check for identifier prefixes that identifies its type (not yet implemented), constness etc
    /* while (!compiler__eat_if(self, identifier)) */

    compiler__eat(self);
    token_t identifier_type = g_previous;

    compiler__eat_err(self, TOKEN_IDENTIFIER, "Expect declaration.");
    token_t ident = g_previous;

    return compiler__decl(self, &ident, &identifier_type);
}

static void compiler__parse_fn(compiler_t* self) {
    compiler_t compiler;
    compiler__init(&compiler, self);
    compiler__begin_scope(&compiler);

    obj_fun_t* fn = compiler.fn;
    ASSERT(fn);
    fn->name = obj__copy_str(g_vm, g_previous.lexeme, g_previous.lexeme_len);
    compiler__eat_err(&compiler, TOKEN_LEFT_PAREN, "Expect '(' after function name.");
    if (compiler__peak(&compiler) != TOKEN_RIGHT_PAREN) {
        do {
            ++fn->arity;
            entry_t* decl_entry = compiler__parse_decl(&compiler);
            if (!decl_entry) {
                continue ;
            }

            ASSERT(obj__is_decl(decl_entry->value));
            obj_decl_t* decl = obj__as_decl(decl_entry->value);
            // define decl so that it can be referred to inside the fn declaration
            decl->is_defined = true;
        } while (
            compiler__peak(&compiler) != TOKEN_EOF &&
            compiler__eat_if(&compiler, TOKEN_COMMA)
        );
    }
    compiler__eat_err(&compiler, TOKEN_RIGHT_PAREN, "Expect ')' after function parameters.");
    compiler__eat_err(&compiler, TOKEN_LEFT_BRACE, "Expect '{' before function body.");
    compiler__emit_block_stmt(&compiler);

    obj_fun_t* compiled_fn = compiler__end_compile(&compiler);
    compiler__destroy(&compiler);

    ASSERT(compiled_fn);
    compiler__push_imm(self, value__obj((obj_t*) compiled_fn), g_previous);
}

static entry_t* compiler__decl(compiler_t* self, token_t* ident, token_t* ident_type) {
    // check if declaration already exists

    ASSERT(self->scopes_fill > 0);
    // if declaration is in an outer scope, allow shadowing
    table_t* current_scope = &self->scopes[self->scopes_fill - 1];
    if (table__find_str(current_scope, ident->lexeme, ident->lexeme_len)) {
        compiler__error_at(self, ident, "Declaration already exists in current scope.");
        return NULL;
    }

    return compiler__add_decl(self, ident, ident_type);
}

static entry_t* compiler__add_decl(compiler_t* self, token_t* ident, token_t* ident_type) {
    ASSERT(self->scopes_fill > 0);
    table_t* scope = &self->scopes[self->scopes_fill - 1];
    value_t ident_value = obj__alloc_decl(g_vm, self->scopes_var_fill, self->scopes_fill, ident_type->type == TOKEN_CONST, false);
    value_t ident_key = obj__copy_str(g_vm, ident->lexeme, ident->lexeme_len);
    table__insert(scope, ident_key, ident_value);
    ++self->scopes_var_fill;

    entry_t* entry = table__find(scope, ident_key);

    return entry;
}

static entry_t* compiler__find_decl(compiler_t* self, token_t* var_name) {
    if (self->scopes_fill == 0) {
        return NULL;
    }

    for (s32 scopes_index = self->scopes_fill - 1; scopes_index >= 0; --scopes_index) {
        table_t* scope = &self->scopes[scopes_index];
        entry_t* entry = table__find_str(scope, var_name->lexeme, var_name->lexeme_len);
        if (entry) {
            ASSERT(obj__is_decl(entry->value));
            obj_decl_t* decl = obj__as_decl(entry->value);
            if (!decl->is_defined) {
                compiler__error_at(self, var_name, "Cannot read variable in its own initializer.");
            }
            return entry;
        }
    }

    return NULL;
}

static void compiler__emit_named_decl(compiler_t* self, token_t var, bool can_assign) {
    entry_t* decl_entry = NULL;
    compiler_t* cur_compiler = self;
    while (cur_compiler && !decl_entry) {
        decl_entry = compiler__find_decl(cur_compiler, &var);
        cur_compiler = cur_compiler->parent;
    }
    if (!decl_entry) {
        // todo: allow emitting undeclared identifiers
        compiler__error_at(self, &var, "Undeclared variable.");
        return ;
    }

    ASSERT(obj__is_decl(decl_entry->value));
    obj_decl_t* decl = obj__as_decl(decl_entry->value);
    ASSERT(decl->is_defined);
    
    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        if (decl->is_const) {
            compiler__error_at(self, &var, "Cannot assign to constant variable.");
            return ;
        } else {
            compiler__emit_expr(self);
            DISCARD_RETURN compiler__push_imm(self, value__num((r64) decl->index), g_previous);
            compiler__emit_set_var(self, can_assign);
        }
    } else {
        DISCARD_RETURN compiler__push_imm(self, value__num((r64) decl->index), g_previous);
        compiler__emit_get_var(self, can_assign);
    }
}

static void compiler__begin_scope(compiler_t* self) {
    if (self->scopes_fill == self->scopes_size) {
        u32 new_scopes_size = self->scopes_size < 8 ? 8 : self->scopes_size * 2;
        self->scopes = allocator__realloc(
            g_vm->allocator, self->scopes,
            self->scopes_size * sizeof(*self->scopes),
            new_scopes_size * sizeof(*self->scopes)
        );
        for (u32 table_index = self->scopes_size; table_index < new_scopes_size; ++table_index) {
            table__create(&self->scopes[table_index], g_vm->allocator);
        }
        self->scopes_size = new_scopes_size;
    }

    ++self->scopes_fill;
}

static void compiler__end_scope(compiler_t* self) {
    ASSERT(self->scopes_fill > 0);
    table_t* scope = &self->scopes[self->scopes_fill - 1];
    u32 n_of_vars_in_scope = scope->fill;
    
    if (n_of_vars_in_scope == 1) {
        compiler__emit_ins(self, INS_POP);
    } else if (n_of_vars_in_scope > 1) {
        compiler__push_imm(self, value__num(n_of_vars_in_scope), g_previous);
        compiler__emit_ins(self, INS_POPN);
    }

    --self->scopes_fill;

    ASSERT(n_of_vars_in_scope <= self->scopes_var_fill);
    self->scopes_var_fill -= n_of_vars_in_scope;
    table__clear(scope);
}

static u32 compiler__push_imm(compiler_t* self, value_t value, token_t token) {
    u32 value_index = chunk__push_imm(&self->fn->chunk, value, token);

    return value_index;
}

static u32 compiler__emit_jump(compiler_t* self, ins_mnemonic_t ins) {
    value_t ip = value__num(self->fn->chunk.instructions_fill);

    u32 ip_index = compiler__push_imm(self, ip, g_previous);
    compiler__emit_ins(self, ins);

    return ip_index;
}

static void compiler__patch_jump(compiler_t* self, u32 ip_index) {
    ASSERT(ip_index < self->fn->chunk.immediates.values_fill);
    self->fn->chunk.immediates.values[ip_index] = value__num(self->fn->chunk.instructions_fill);
}

static u32 compiler__emit_args(compiler_t* self) {
    u32 n_args = 0;

    if (compiler__peak(self) != TOKEN_RIGHT_PAREN) {
        do {
            ++n_args;
            compiler__emit_expr(self);
        } while (compiler__eat_if(self, TOKEN_COMMA));
    }

    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after arguments.");

    return n_args;
}

bool compiler__create(compiler_t* self, vm_t* vm, const char* source) {
    scanner__init(&g_scanner, source);
    g_vm = vm;

    compiler__init(self, NULL);
    ASSERT(self->fn);
    const char* script_fn_name = "main";
    self->fn->name = obj__copy_str(g_vm, script_fn_name, libc__strlen(script_fn_name));

    compiler__begin_scope(self);

    return true;
}

void compiler__destroy(compiler_t* self) {
    if (self->scopes) {
        for (u32 scopes_index = 0; scopes_index < self->scopes_size; ++scopes_index) {
            table__destroy(&self->scopes[scopes_index]);
        }
        allocator__free(g_vm->allocator, self->scopes);
    }
}

obj_fun_t* compiler__compile(compiler_t* self) {
    compiler__eat(self);
    while (!compiler__eat_if(self, TOKEN_EOF)) {
        compiler__emit_decl_stmt(self);
    }
    compiler__eat_err(self, TOKEN_EOF, "Expect end of expression.");
    obj_fun_t* result = compiler__end_compile(self);
    if (g_had_error) {
        return NULL;
    }

    return result;
}
