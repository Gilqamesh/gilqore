#include "compiler.h"
#include "scanner.h"
#include "chunk.h"
#include "obj.h"
#include "vm.h"
#include "debug.h"

#include "libc/libc.h"

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
static void compiler__emit_decl(compiler_t* self);
static void compiler__emit_var_decl(compiler_t* self);
static void compiler__emit_stmt(compiler_t* self);
static void compiler__emit_print_stmt(compiler_t* self);
static void compiler__emit_expr_stmt(compiler_t* self);
static void compiler__emit_block_stmt(compiler_t* self);
static void compiler__emit_expr(compiler_t* self);

static void compiler__emit_grouping(compiler_t* self, bool can_assign);
static void compiler__emit_unary(compiler_t* self, bool can_assign);
static void compiler__emit_binary(compiler_t* self, bool can_assign);
static void compiler__emit_conditional(compiler_t* self, bool can_assign);

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
static void compiler__emit_not(compiler_t* self, bool can_assign);
static void compiler__emit_eq(compiler_t* self, bool can_assign);
static void compiler__emit_lt(compiler_t* self, bool can_assign);
static void compiler__emit_gt(compiler_t* self, bool can_assign);
static void compiler__emit_print(compiler_t* self, bool can_assign);
static void compiler__emit_pop(compiler_t* self, bool can_assign);
static void compiler__emit_define_global(compiler_t* self, bool can_assign);
static void compiler__emit_get_global(compiler_t* self, bool can_assign);
static void compiler__emit_set_global(compiler_t* self, bool can_assign);
static void compiler__emit_get_local(compiler_t* self, bool can_assign);
static void compiler__emit_set_local(compiler_t* self, bool can_assign);

static void compiler__emit_str(compiler_t* self, bool can_assign);
static void compiler__emit_identifier(compiler_t* self, bool can_assign);

// returns current token type being compiled
static token_type compiler__peak(compiler_t* self);
static void compiler__eat(compiler_t* self);
static bool compiler__eat_if(compiler_t* self, token_type type);
static void compiler__eat_err(compiler_t* self, token_type type, const char* err_msg);
static void compiler__error_at(compiler_t* self, token_t* token, const char* err_msg);
// static void       compiler__warn_at(compiler_t* self, token_t* token, const char* warn_msg);
static void compiler__end_compile(compiler_t* self);
// skips tokens until a statement boundary is reached
static void compiler__synchronize(compiler_t* self);
// parses variable, returns the declaration
static obj_var_info_t compiler__parse_variable(compiler_t* self);
// registers the global to the name -> var infos table, returns the var info
static obj_var_info_t* compiler__declare_global(compiler_t* self, token_t* global, token_t* global_type);
static void compiler__define_variable(compiler_t* self, obj_var_info_t* var_info);
static void compiler__declare_local(compiler_t* self, token_t* ident, token_t* ident_type);
// add local variable
static void compiler__add_local(compiler_t* self, token_t* ident, token_t* ident_type);
// returns local index or -1 if not found, which means it's a global variable
static obj_var_info_t compiler__find_local(compiler_t* self, token_t* local_name);
static void compiler__emit_named_var(compiler_t* self, token_t var, bool can_assign);
static void compiler__begin_scope(compiler_t* self);
static void compiler__end_scope(compiler_t* self);
static u32  compiler__push_imm(compiler_t* self, value_t value, u32 line);

// maps token type to its compile rule
static compile_rule compile_rules[] = {
/*   token type              prefix emitter                 infix emitter               precedence  */
    [TOKEN_LEFT_PAREN]    = {compiler__emit_grouping,       NULL,                       PREC_NONE},
    [TOKEN_RIGHT_PAREN]   = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_LEFT_BRACE]    = {NULL,                          NULL,                       PREC_NONE}, 
    [TOKEN_RIGHT_BRACE]   = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_COMMA]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_DOT]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_MINUS]         = {compiler__emit_unary,          compiler__emit_binary,      PREC_TERM},
    [TOKEN_PLUS]          = {NULL,                          compiler__emit_binary,      PREC_TERM},
    [TOKEN_SEMICOLON]     = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_SLASH]         = {NULL,                          compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_STAR]          = {NULL,                          compiler__emit_binary,      PREC_FACTOR},
    [TOKEN_QUESTION_MARK] = {compiler__emit_conditional,    NULL,                       PREC_NONE},
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
    [TOKEN_AND]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_CLASS]         = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_ELSE]          = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_FALSE]         = {compiler__emit_false,          NULL,                       PREC_NONE},
    [TOKEN_FOR]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_FUN]           = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_IF]            = {NULL,                          NULL,                       PREC_NONE},
    [TOKEN_NIL]           = {compiler__emit_nil,            NULL,                       PREC_NONE},
    [TOKEN_OR]            = {NULL,                          NULL,                       PREC_NONE},
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
    compile_rule* prefix_rule = compiler__get_rule(self->previous.type);
    if (!prefix_rule->prefix) {
        compiler__error_at(self, &self->previous, "Expect expression.");
        return ;
    }

    bool can_assign = prec <= PREC_ASSIGNMENT;
    prefix_rule->prefix(self, can_assign);

    while (prec <= compiler__get_rule(self->current.type)->prec) {
        compiler__eat(self);
        compile_rule* infix_rule = compiler__get_rule(self->previous.type);
        ASSERT(infix_rule);
        infix_rule->infix(self, can_assign);
    }

    // if the assignment did not get consumed, nothing else is going to consume it -> error
    if (can_assign && compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__error_at(self, &self->previous, "Invalid assignment target.");
    }
}

static void compiler__emit_expr(compiler_t* self) {
    // s32 stack_size = self->chunk->current_stack_size;

    compiler__emit_prec(self, PREC_ASSIGNMENT);

    // expressions always leave a value on top of the stack
    // ASSERT(self->had_error || (!self->had_error && self->chunk->current_stack_size == stack_size + 1));
}

static void compiler__emit_grouping(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_RIGHT_PAREN, "Expect ')' after expression.");
}

static void compiler__emit_unary(compiler_t* self, bool can_assign) {
    (void) can_assign;

    token_type type = self->previous.type;
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
   
    token_type type = self->previous.type;
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
        } break ;
        case TOKEN_LESS_EQUAL: {
            compiler__emit_gt(self, can_assign);
            compiler__emit_not(self, can_assign);
        } break ;
        default: ASSERT(false);
    }
}

static void compiler__emit_conditional(compiler_t* self, bool can_assign) {
    (void) can_assign;

    ASSERT(false && "todo: implement emitting the bytecode");

    compiler__emit_prec(self, PREC_TERNARY);

    compiler__eat_err(self, TOKEN_COLON, "Expect ':' after then branch of conditional operator.");

    compiler__emit_prec(self, PREC_ASSIGNMENT);
}

static void compiler__emit_return(compiler_t* self, bool can_assign) {
    (void) can_assign;

    compiler__emit_ins(self, INS_RETURN);
}

static void compiler__emit_imm(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    r64 value = libc__strntod(self->previous.lexeme, self->previous.lexeme_len);
    DISCARD_RETURN compiler__push_imm(self, value__num(value), self->previous.line);
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

static void compiler__emit_define_global(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_DEFINE_GLOBAL);
}

static void compiler__emit_get_global(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_GET_GLOBAL);
}

static void compiler__emit_set_global(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_SET_GLOBAL);
}

static void compiler__emit_get_local(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_GET_LOCAL);
}

static void compiler__emit_set_local(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    compiler__emit_ins(self, INS_SET_LOCAL);
}

static void compiler__emit_str(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    ASSERT(self->previous.lexeme_len > 1);
    value_t obj_str = obj__copy_str(self->vm, self->previous.lexeme + 1, self->previous.lexeme_len - 2);
    DISCARD_RETURN compiler__push_imm(self, obj_str, self->previous.line);
}

static void compiler__emit_identifier(compiler_t* self, bool can_assign) {
    compiler__emit_named_var(self, self->previous, can_assign);
}

static token_type compiler__peak(compiler_t* self) {
    return self->current.type;
}

static void compiler__eat(compiler_t* self) {
    self->previous = self->current;

    while (42) {
        self->current = scanner__scan_token(&self->scanner);
        if (compiler__peak(self) != TOKEN_ERROR) {
            break ;
        }

        // assumption: lexeme of error tokens received from the scanner are null-terminated
        compiler__error_at(self, &self->current, self->current.lexeme);
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
    if (self->current.type == type) {
        compiler__eat(self);
        return ;
    }

    compiler__error_at(self, &self->current, err_msg);
}

static void compiler__error_at(compiler_t* self, token_t* token, const char* err_msg) {
    if (self->panic_mode) {
        return ;
    }

    self->had_error = true;
    self->panic_mode = true;

    libc__printf("%d | Error", token->line);
    switch (token->type) {
        case TOKEN_ERROR: {
        } break ;
        case TOKEN_EOF: {
            libc__printf(" at end");
        } break ;
        default: {
            libc__printf(" at '%.*s'", token->lexeme_len, token->lexeme);
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
    chunk__push_ins(self->chunk, ins, self->previous.line);
}

static void compiler__emit_decl(compiler_t* self) {
    switch (compiler__peak(self)) {
        case TOKEN_VAR:
        case TOKEN_CONST: {
            compiler__emit_var_decl(self);
        } break ;
        default: {
            compiler__emit_stmt(self);
        }
    }

    if (self->panic_mode) {
        compiler__synchronize(self);
    }
}

// local:  [expr ins (if initializer exists) | ins_nil]
// global: [expr ins (if initializer exists) | ins_nil]
//         [ins_define_global] [imm/imm_long]
static void compiler__emit_var_decl(compiler_t* self) {
    obj_var_info_t var_info = compiler__parse_variable(self);

    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__emit_expr(self);
    } else {
        if (var_info.is_const) {
            compiler__error_at(self, &self->previous, "Constant variable requires an initializer.");
            // table__erase(&self->vm->global_names_to_var_infos);
            return ;
        }
        compiler__emit_nil(self, true);
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after variable declaration.");

    // do not store variables that are in local scopes
    if (var_info.var_index == -1) {
        // at this point we compiled the initializer, ready to set the state of the local to initialized
        ASSERT(self->scope.scope_depth > 0);
        local_t* local = &self->scope.locals_data[self->scope.locals_fill - 1];
        local->scope_depth = self->scope.scope_depth;
        return ;
    }

    compiler__define_variable(self, &var_info);
}

static void compiler__emit_stmt(compiler_t* self) {
    if (compiler__eat_if(self, TOKEN_PRINT)) {
        compiler__emit_print_stmt(self);
    } else if (compiler__eat_if(self, TOKEN_LEFT_BRACE)) {
        compiler__begin_scope(self);
        compiler__emit_block_stmt(self);
        compiler__end_scope(self);
    } else {
        compiler__emit_expr_stmt(self);
    }
}

static void compiler__emit_print_stmt(compiler_t* self) {
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after value.");
    compiler__emit_print(self, true);
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
        compiler__emit_decl(self);
    }

    compiler__eat_err(self, TOKEN_RIGHT_BRACE, "Expect '}' after block.");
}

static void compiler__end_compile(compiler_t* self) {
    compiler__emit_return(self, true);

    // ASSERT(self->had_error || (!self->had_error && self->chunk->current_stack_size == 0));
}

static void compiler__synchronize(compiler_t* self) {
    self->panic_mode = false;

    while (self->current.type != TOKEN_EOF) {
        if (self->previous.type == TOKEN_SEMICOLON) {
            // we are at the next stmt
            return ;
        }
        switch (self->current.type) {
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

static obj_var_info_t compiler__parse_variable(compiler_t* self) {
    obj_var_info_t result = obj__var_info(-1, false);

    // check for identifier prefixes that identifies its type (not yet implemented), constness etc
    /* while (!compiler__eat_if(self, identifier)) */
    compiler__eat(self);
    token_t identifier_type = self->previous;

    compiler__eat_err(self, TOKEN_IDENTIFIER, "Expect variable name.");
    token_t ident = self->previous;

    if (self->scope.scope_depth == 0) {
        obj_var_info_t* var_info = compiler__declare_global(self, &ident, &identifier_type);
        if (!var_info) {
            return result;
        }

        result = *var_info;
    } else {
        compiler__declare_local(self, &ident, &identifier_type);
        // declare but not initialize yet
        result.var_index = -1;
    }

    return result;
}

static obj_var_info_t* compiler__declare_global(compiler_t* self, token_t* ident, token_t* ident_type) {
    value_t obj_str = obj__copy_str(self->vm, ident->lexeme, ident->lexeme_len);

    // check if name -> var info for the ident already exists, which saves us having to do this check during runtime
    vm_t* vm = self->vm;
    value_t var_info;
    if (table__get(&vm->global_names_to_var_infos, obj_str, &var_info)) {
        // already declared variable
        compiler__error_at(self, ident, "Already declared identifier");
        // if it does, no need to create an index, just return with it
        return NULL;
    }

    // store name -> index
    u32 index = value_arr__push(&vm->global_values, self->vm->allocator, value__undefined());
    var_info = obj__get_var_info(self->vm, index, ident_type->type == TOKEN_CONST);
    table__insert(&vm->global_names_to_var_infos, obj_str, var_info);

    return obj__as_var_info(var_info);
}

// local:  -
// global: [ins_define_global] [imm/imm_long (index of global)]
static void compiler__define_variable(compiler_t* self, obj_var_info_t* var_info) {
    DISCARD_RETURN compiler__push_imm(self, value__num(var_info->var_index), self->previous.line);
    compiler__emit_define_global(self, true);
}

static void compiler__declare_local(compiler_t* self, token_t* ident, token_t* ident_type) {
    // check if local is already stored
    for (s32 local_index = self->scope.locals_fill - 1; local_index >= 0; --local_index) {
        local_t* local = &self->scope.locals_data[local_index];
        if (local->scope_depth != -1 && local->scope_depth < self->scope.scope_depth) {
            // if local is in an outer scope, allow shadowing
            break ;
        }

        if (
            local->identifier.lexeme_len == ident->lexeme_len &&
            libc__memcmp(local->identifier.lexeme, ident->lexeme, ident->lexeme_len) == 0
        ) {
            compiler__error_at(self, ident, "Variable already declared in this scope.");
            return ;
        }
    }

    compiler__add_local(self, ident, ident_type);
}

static void compiler__add_local(compiler_t* self, token_t* ident, token_t* ident_type) {
    if (self->scope.locals_fill == self->scope.locals_size) {
        u32 new_locals_size = self->scope.locals_fill < 8 ? 8 : self->scope.locals_fill * 2;
        self->scope.locals_data = allocator__realloc(
            self->vm->allocator, self->scope.locals_data,
            self->scope.locals_size * sizeof(*self->scope.locals_data),
            new_locals_size         * sizeof(*self->scope.locals_data)
        );
        self->scope.locals_size = new_locals_size;
    }

    local_t* local = &self->scope.locals_data[self->scope.locals_fill++];
    local->identifier  = *ident;
    // we have not yet ran the initializer for the local, indicate this by setting it to a temporary state
    local->scope_depth = -1;
    local->is_const = ident_type->type == TOKEN_CONST;
}

static obj_var_info_t compiler__find_local(compiler_t* self, token_t* local_name) {
    obj_var_info_t result = obj__var_info(-1, false);

    for (s32 local_index = self->scope.locals_fill - 1; local_index >= 0; --local_index) {
        local_t* local = &self->scope.locals_data[local_index];
        if (
            local->identifier.lexeme_len == local_name->lexeme_len &&
            libc__memcmp(local->identifier.lexeme, local_name->lexeme, local_name->lexeme_len) == 0
        ) {
            if (local->scope_depth == -1) {
                compiler__error_at(self, local_name, "Cannot read local variable in its own initializer.");
            }

            result.is_const = local->is_const;
            result.var_index = local_index;
            break ;
        }
    }

    return result;
}

// local:  [expr ins (if assignment)]
//         [ins_set_local/ins_get_local] [imm/imm_long (index of local)]
// global: [expr ins (if assignment)]
//         [ins_set_global/ins_get_global] [imm/imm_long (index of global)]
static void compiler__emit_named_var(compiler_t* self, token_t var, bool can_assign) {
    (void) can_assign;

    obj_var_info_t local_result = compiler__find_local(self, &var);
    if (local_result.var_index != -1) {
        if (compiler__eat_if(self, TOKEN_EQUAL)) {
            if (local_result.is_const) {
                compiler__error_at(self, &var, "Cannot assign to constant variable.");
                return ;
            } else {
                compiler__emit_expr(self);
                DISCARD_RETURN compiler__push_imm(self, value__num((r64) local_result.var_index), self->previous.line);
                compiler__emit_set_local(self, can_assign);
            }
        } else {
            DISCARD_RETURN compiler__push_imm(self, value__num((r64) local_result.var_index), self->previous.line);
            compiler__emit_get_local(self, can_assign);
        }
    } else {
        value_t obj_str = obj__copy_str(self->vm, var.lexeme, var.lexeme_len);
        // get the global
        value_t global_info;
        bool found_global_decl = table__get(&self->vm->global_names_to_var_infos, obj_str, &global_info);
        if (!found_global_decl) {
            compiler__error_at(self, &var, "Variable is not declared.");
            return ;
        }

        ASSERT(obj__is_var_info(global_info));
        obj_var_info_t* var_info = obj__as_var_info(global_info);

        if (compiler__eat_if(self, TOKEN_EQUAL)) {
            if (var_info->is_const) {
                compiler__error_at(self, &var, "Cannot assign to constant variable.");
                return ;
            } else {
                compiler__emit_expr(self);
                DISCARD_RETURN compiler__push_imm(self, value__num((r64) var_info->var_index), self->previous.line);
                compiler__emit_set_global(self, can_assign);
            }
        } else {
            DISCARD_RETURN compiler__push_imm(self, value__num((r64) var_info->var_index), self->previous.line);
            compiler__emit_get_global(self, can_assign);
        }
    }
}

static void compiler__begin_scope(compiler_t* self) {
    ++self->scope.scope_depth;
}

static void compiler__end_scope(compiler_t* self) {
    ASSERT(self->scope.scope_depth > 0);

    --self->scope.scope_depth;

    // pop locals from the scope
    while (
        self->scope.locals_fill > 0 &&
        self->scope.locals_data[self->scope.locals_fill - 1].scope_depth > self->scope.scope_depth
    ) {
        compiler__emit_ins(self, INS_POP);
        --self->scope.locals_fill;
    }
}

static u32 compiler__push_imm(compiler_t* self, value_t value, u32 line) {
    u32 value_index = chunk__push_imm(self->chunk, value, line);

    return value_index;
}

bool compiler__create(compiler_t* self, vm_t* vm, chunk_t* chunk, const char* source) {
    scanner__init(&self->scanner, source);

    self->had_error = false;
    self->panic_mode = false;

    self->scope.locals_data = 0;
    self->scope.locals_fill = 0;
    self->scope.locals_size = 0;
    self->scope.scope_depth = 0;

    self->vm = vm;
    self->chunk = chunk;

    return true;
}

void compiler__destroy(compiler_t* self) {
    if (self->scope.locals_data) {
        allocator__free(self->vm->allocator, self->scope.locals_data);
    }
}

bool compiler__compile(compiler_t* self) {
    compiler__eat(self);
    while (!compiler__eat_if(self, TOKEN_EOF)) {
        compiler__emit_decl(self);
    }
    compiler__eat_err(self, TOKEN_EOF, "Expect end of expression.");
    compiler__end_compile(self);

#if defined(DEBUG_COMPILER_TRACE)
    if (!self->had_error) {
        chunk__disasm(self->chunk, "code");
    }
#endif

    return !self->had_error;
}
