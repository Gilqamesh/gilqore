#include "compiler.h"
#include "scanner.h"
#include "chunk.h"
#include "obj.h"

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
    void (*prefix)(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
    void (*infix)(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
    precedence prec;
} compile_rule;

static compile_rule* compiler__get_rule(token_type type);

// compiles from the specified precedence till the highest precedence
static void compiler__emit_prec(compiler_t* self, allocator_t* allocator, chunk_t* chunk, precedence prec);

static void compiler__emit_ins(compiler_t* self, allocator_t* allocator, chunk_t* chunk, ins_mnemonic_t ins);
static void compiler__emit_expression(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_grouping(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_unary(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_binary(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_conditional(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_imm(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_nil(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_true(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_false(compiler_t* self, allocator_t* allocator, chunk_t* chunk);
static void compiler__emit_str(compiler_t* self, allocator_t* allocator, chunk_t* chunk);

static void compiler__eat(compiler_t* self);
static void compiler__eat_if(compiler_t* self, token_type type, const char* err_msg);
static void compiler__error_at(compiler_t* self, token_t* token, const char* err_msg);
static void compiler__end_compile(compiler_t* self, allocator_t* allocator, chunk_t* chunk);

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
    [TOKEN_IDENTIFIER]    = {NULL,                          NULL,                       PREC_NONE},
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

static void compiler__emit_prec(compiler_t* self, allocator_t* allocator, chunk_t* chunk, precedence prec) {
    compiler__eat(self);
    compile_rule* prefix_rule = compiler__get_rule(self->previous.type);
    if (!prefix_rule->prefix) {
        compiler__error_at(self, &self->previous, "Expect expression.");
        return ;
    }

    prefix_rule->prefix(self, allocator, chunk);

    while (prec <= compiler__get_rule(self->current.type)->prec) {
        compiler__eat(self);
        compile_rule* infix_rule = compiler__get_rule(self->previous.type);
        ASSERT(infix_rule);
        infix_rule->infix(self, allocator, chunk);
    }
}

static void compiler__emit_expression(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_prec(self, allocator, chunk, PREC_ASSIGNMENT);
}

static void compiler__emit_grouping(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_expression(self, allocator, chunk);
    compiler__eat_if(self, TOKEN_RIGHT_PAREN, "Expect ')' after expression.");
}

static void compiler__emit_unary(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    token_type type = self->previous.type;
    compiler__emit_prec(self, allocator, chunk, PREC_UNARY);

    switch (type) {
        case TOKEN_MINUS: {
            compiler__emit_ins(self, allocator, chunk, INS_NEG);
        } break ;
        case TOKEN_EXCLAM: {
            compiler__emit_ins(self, allocator, chunk, INS_NOT);
        } break ;
        default: ASSERT(false);
    }
}

static void compiler__emit_binary(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    token_type type = self->previous.type;
    compile_rule* rule = compiler__get_rule(type);
    compiler__emit_prec(self, allocator, chunk, rule->prec + 1);

    switch (type) {
        case TOKEN_PLUS: {
            compiler__emit_ins(self, allocator, chunk, INS_ADD);
        } break ;
        case TOKEN_MINUS: {
            compiler__emit_ins(self, allocator, chunk, INS_SUB);
        } break ;
        case TOKEN_STAR: {
            compiler__emit_ins(self, allocator, chunk, INS_MUL);
        } break ;
        case TOKEN_SLASH: {
            compiler__emit_ins(self, allocator, chunk, INS_DIV);
        } break ;
        case TOKEN_EXCLAM_EQUAL: {
            compiler__emit_ins(self, allocator, chunk, INS_EQ);
            compiler__emit_ins(self, allocator, chunk, INS_NOT);
        } break ;
        case TOKEN_EQUAL_EQUAL: {
            compiler__emit_ins(self, allocator, chunk, INS_EQ);
        } break ;
        case TOKEN_GREATER: {
            compiler__emit_ins(self, allocator, chunk, INS_GT);
        } break ;
        case TOKEN_GREATER_EQUAL: {
            compiler__emit_ins(self, allocator, chunk, INS_LT);
            compiler__emit_ins(self, allocator, chunk, INS_NOT);
        } break ;
        case TOKEN_LESS: {
            compiler__emit_ins(self, allocator, chunk, INS_LT);
        } break ;
        case TOKEN_LESS_EQUAL: {
            compiler__emit_ins(self, allocator, chunk, INS_GT);
            compiler__emit_ins(self, allocator, chunk, INS_EQ);
        } break ;
        default: ASSERT(false);
    }
}

static void compiler__emit_conditional(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    ASSERT(false && "todo: implement emitting the bytecode");

    compiler__emit_prec(self, allocator, chunk, PREC_TERNARY);

    compiler__eat_if(self, TOKEN_COLON, "Expect ':' after then branch of conditional operator.");

    compiler__emit_prec(self, allocator, chunk, PREC_ASSIGNMENT);
}

static void compiler__emit_imm(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    r64 value = libc__strntod(self->previous.lexeme, self->previous.lexeme_len);
    DISCARD_RETURN chunk__push_imm(chunk, allocator, value__num(value), self->previous.line);
}

static void compiler__emit_nil(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_ins(self, allocator, chunk, INS_NIL);
}

static void compiler__emit_true(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_ins(self, allocator, chunk, INS_TRUE);
}

static void compiler__emit_false(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_ins(self, allocator, chunk, INS_FALSE);
}

static void compiler__emit_str(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    ASSERT(self->previous.lexeme_len > 1);
    obj_str_t* obj_str = obj__copy_str(self->vm, allocator, self->previous.lexeme + 1, self->previous.lexeme_len - 2);
    DISCARD_RETURN chunk__push_imm(chunk, allocator, value__obj((obj_t*) obj_str),self->previous.line);
}

static void compiler__eat(compiler_t* self) {
    self->previous = self->current;

    while (42) {
        self->current = scanner__scan_token(&self->scanner);
        if (self->current.type != TOKEN_ERROR) {
            break ;
        }

        // assumption: lexeme of error tokens received from the scanner are null-terminated
        compiler__error_at(self, &self->current, self->current.lexeme);
    }
}

static void compiler__eat_if(compiler_t* self, token_type type, const char* err_msg) {
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

static void compiler__emit_ins(compiler_t* self, allocator_t* allocator, chunk_t* chunk, ins_mnemonic_t ins) {
    chunk__push_ins(chunk, allocator, ins, self->previous.line);
}

static void compiler__end_compile(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__emit_ins(self, allocator, chunk, INS_RETURN);
}

void compiler__init(compiler_t* self, vm_t* vm, const char* source) {
    scanner__init(&self->scanner, source);

    self->had_error = false;
    self->panic_mode = false;

    self->vm = vm;
}

bool compiler__compile(compiler_t* self, allocator_t* allocator, chunk_t* chunk) {
    compiler__eat(self);
    compiler__emit_expression(self, allocator, chunk);
    compiler__eat_if(self, TOKEN_EOF, "Expect end of expression.");
    compiler__end_compile(self, allocator, chunk);

#if defined(DEBUG_COMPILER_TRACE)
    if (!self->had_error) {
        chunk__disasm(chunk, "code");
    }
#endif

    return !self->had_error;
}
