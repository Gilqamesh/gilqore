#include "compiler.h"
#include "scanner.h"
#include "chunk.h"
#include "obj.h"
#include "vm.h"

#define DEBUG_COMPILER_TRACE
#if defined(DEBUG_COMPILER_TRACE)
# include "debug.h"
#endif

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
static void compiler__emit_expr(compiler_t* self);

static void compiler__emit_grouping(compiler_t* self, bool can_assign);
static void compiler__emit_unary(compiler_t* self, bool can_assign);
static void compiler__emit_binary(compiler_t* self, bool can_assign);
static void compiler__emit_conditional(compiler_t* self, bool can_assign);
static void compiler__emit_imm(compiler_t* self, bool can_assign);
static void compiler__emit_nil(compiler_t* self, bool can_assign);
static void compiler__emit_true(compiler_t* self, bool can_assign);
static void compiler__emit_false(compiler_t* self, bool can_assign);
static void compiler__emit_str(compiler_t* self, bool can_assign);
static void compiler__emit_identifier(compiler_t* self, bool can_assign);

// returns current token type being compiled
static token_type compiler__peak(compiler_t* self);
static void       compiler__eat(compiler_t* self);
static bool       compiler__eat_if(compiler_t* self, token_type type);
static void       compiler__eat_err(compiler_t* self, token_type type, const char* err_msg);
static void       compiler__error_at(compiler_t* self, token_t* token, const char* err_msg);
static void       compiler__end_compile(compiler_t* self);
// skips tokens until a statement boundary is reached
static void       compiler__synchronize(compiler_t* self);
// if parses identifier, emits the identifier as a value to the chunk and returns its index, otherwise sets panic mode
static u32        compiler__parse_variable(compiler_t* self);
static u32        compiler__get_value_index(compiler_t* self, token_t* identifier);
static void       compiler__define_variable(compiler_t* self, u32 identifier_index);
static void       compiler__emit_named_var(compiler_t* self, token_t* token, bool can_assign);

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

    if (can_assign && compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__error_at(self, &self->previous, "Invalid assignment target.");
    }
}

static void compiler__emit_expr(compiler_t* self) {
    compiler__emit_prec(self, PREC_ASSIGNMENT);
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
            compiler__emit_ins(self, INS_NEG);
        } break ;
        case TOKEN_EXCLAM: {
            compiler__emit_ins(self, INS_NOT);
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
            compiler__emit_ins(self, INS_ADD);
        } break ;
        case TOKEN_MINUS: {
            compiler__emit_ins(self, INS_SUB);
        } break ;
        case TOKEN_STAR: {
            compiler__emit_ins(self, INS_MUL);
        } break ;
        case TOKEN_SLASH: {
            compiler__emit_ins(self, INS_DIV);
        } break ;
        case TOKEN_EXCLAM_EQUAL: {
            compiler__emit_ins(self, INS_EQ);
            compiler__emit_ins(self, INS_NOT);
        } break ;
        case TOKEN_EQUAL_EQUAL: {
            compiler__emit_ins(self, INS_EQ);
        } break ;
        case TOKEN_GREATER: {
            compiler__emit_ins(self, INS_GT);
        } break ;
        case TOKEN_GREATER_EQUAL: {
            compiler__emit_ins(self, INS_LT);
            compiler__emit_ins(self, INS_NOT);
        } break ;
        case TOKEN_LESS: {
            compiler__emit_ins(self, INS_LT);
        } break ;
        case TOKEN_LESS_EQUAL: {
            compiler__emit_ins(self, INS_GT);
            compiler__emit_ins(self, INS_EQ);
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

static void compiler__emit_imm(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    r64 value = libc__strntod(self->previous.lexeme, self->previous.lexeme_len);
    DISCARD_RETURN chunk__push_imm(self->chunk, self->allocator, value__num(value), self->previous.line);
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

static void compiler__emit_str(compiler_t* self, bool can_assign) {
    (void) can_assign;
    
    ASSERT(self->previous.lexeme_len > 1);
    obj_str_t* obj_str = obj__copy_str(self->vm, self->allocator, self->previous.lexeme + 1, self->previous.lexeme_len - 2);
    DISCARD_RETURN chunk__push_imm(self->chunk, self->allocator, value__obj((obj_t*) obj_str), self->previous.line);
}

static void compiler__emit_identifier(compiler_t* self, bool can_assign) {
    compiler__emit_named_var(self, &self->previous, can_assign);
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
        return;
    }

    self->had_error = true;
    self->panic_mode = true;

    libc__printf("[line %d] Error", token->line);
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

static void compiler__emit_ins(compiler_t* self, ins_mnemonic_t ins) {
    chunk__push_ins(self->chunk, self->allocator, ins, self->previous.line);
}

static void compiler__emit_decl(compiler_t* self) {
    if (compiler__eat_if(self, TOKEN_VAR)) {
        compiler__emit_var_decl(self);
    } else {
        compiler__emit_stmt(self);
    }

    if (self->panic_mode) {
        compiler__synchronize(self);
    }
}

// [initializer expr INS / INS_NIL]
// [INS_DEFINE_GLOBAL]
// [INS_IMM/INS_IMM_LONG]
// [1 to 3 INS for index of identifier name]
static void compiler__emit_var_decl(compiler_t* self) {
    u32 global_var_index = compiler__parse_variable(self);

    if (compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__emit_expr(self);
    } else {
        compiler__emit_ins(self, INS_NIL);
    }

    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after variable declaration.");

    compiler__define_variable(self, global_var_index);
}

static void compiler__emit_stmt(compiler_t* self) {
    if (compiler__eat_if(self, TOKEN_PRINT)) {
        compiler__emit_print_stmt(self);
    } else {
        compiler__emit_expr_stmt(self);
    }
}

static void compiler__emit_print_stmt(compiler_t* self) {
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after value.");
    compiler__emit_ins(self, INS_PRINT);
}

static void compiler__emit_expr_stmt(compiler_t* self) {
    compiler__emit_expr(self);
    compiler__eat_err(self, TOKEN_SEMICOLON, "Expect ';' after value.");
    compiler__emit_ins(self, INS_POP);
}

static void compiler__end_compile(compiler_t* self) {
    compiler__emit_ins(self, INS_RETURN);
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

static u32 compiler__parse_variable(compiler_t* self) {
    compiler__eat_err(self, TOKEN_IDENTIFIER, "Expect variable name.");

    return compiler__get_value_index(self, &self->previous);
}

static u32 compiler__get_value_index(compiler_t* self, token_t* identifier) {
    obj_str_t* obj_str = obj__copy_str(self->vm, self->allocator, identifier->lexeme, identifier->lexeme_len);

    // check if name -> index for the token already exists, which saves us having to do this check during runtime
    vm_t* vm = self->vm;
    value_t index_value;
    if (table__get(&vm->global_names_to_index, value__obj((obj_t*) obj_str), &index_value)) {
        // if it does, no need to create an index, just return with it
        return (u32) value__as_num(index_value);
    }

    // store name -> index
    u32 index = value_arr__push(&vm->global_values, self->allocator, value__undefined());
    table__insert(&vm->global_names_to_index, value__obj((obj_t*) obj_str), value__num((r64) index));

    return index;
}

static void compiler__define_variable(compiler_t* self, u32 identifier_index) {
    compiler__emit_ins(self, INS_DEFINE_GLOBAL);
    DISCARD_RETURN chunk__push_imm(self->chunk, self->allocator, value__num(identifier_index), self->previous.line);
}

static void compiler__emit_named_var(compiler_t* self, token_t* token, bool can_assign) {
    u32 var_index = compiler__get_value_index(self, token);

    if (can_assign && compiler__eat_if(self, TOKEN_EQUAL)) {
        compiler__emit_expr(self);
        compiler__emit_ins(self, INS_SET_GLOBAL);
    } else {
        compiler__emit_ins(self, INS_GET_GLOBAL);
    }

    DISCARD_RETURN chunk__push_imm(self->chunk, self->allocator, value__num(var_index), self->previous.line);
}

void compiler__init(compiler_t* self, vm_t* vm, allocator_t* allocator, chunk_t* chunk, const char* source) {
    scanner__init(&self->scanner, source);

    self->had_error = false;
    self->panic_mode = false;

    self->vm = vm;
    self->allocator = allocator;
    self->chunk = chunk;
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
