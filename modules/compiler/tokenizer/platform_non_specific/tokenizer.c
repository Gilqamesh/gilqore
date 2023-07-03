#include "compiler/tokenizer/tokenizer.h"

#include "memory/memory.h"
#include "libc/libc.h"

const char* token__type_name_lox(struct token* token) {
    switch (token->type) {
        case LOX_TOKEN_COMMENT: return "comment";
        case LOX_TOKEN_LEFT_PAREN: return "left paren";
        case LOX_TOKEN_RIGHT_PAREN: return "right parent";
        case LOX_TOKEN_LEFT_BRACE: return "left brace";
        case LOX_TOKEN_RIGHT_BRACE: return "right brace";
        case LOX_TOKEN_COMMA: return "comma";
        case LOX_TOKEN_DOT: return "dot";
        case LOX_TOKEN_MINUS: return "minus";
        case LOX_TOKEN_PLUS: return "plus";
        case LOX_TOKEN_SEMICOLON: return "semicolon";
        case LOX_TOKEN_SLASH: return "slash";
        case LOX_TOKEN_STAR: return "star";
        case LOX_TOKEN_BANG: return "bang";
        case LOX_TOKEN_BANG_EQUAL: return "bang equal";
        case LOX_TOKEN_EQUAL: return "equal";
        case LOX_TOKEN_EQUAL_EQUAL: return "double equal";
        case LOX_TOKEN_GREATER: return "greater";
        case LOX_TOKEN_GREATER_EQUAL: return "greater equal";
        case LOX_TOKEN_LESS: return "less";
        case LOX_TOKEN_LESS_EQUAL: return "less equal";
        case LOX_TOKEN_IDENTIFIER: return "identifier";
        case LOX_TOKEN_STRING: return "string";
        case LOX_TOKEN_NUMBER: return "number";
        case LOX_TOKEN_AND: return "and";
        case LOX_TOKEN_CLASS: return "class";
        case LOX_TOKEN_ELSE: return "else";
        case LOX_TOKEN_FALSE: return "false";
        case LOX_TOKEN_FUN: return "function";
        case LOX_TOKEN_FOR: return "for";
        case LOX_TOKEN_IF: return "if";
        case LOX_TOKEN_NIL: return "nil";
        case LOX_TOKEN_OR: return "or";
        case LOX_TOKEN_PRINT: return "print";
        case LOX_TOKEN_RETURN: return "return";
        case LOX_TOKEN_SUPER: return "super";
        case LOX_TOKEN_THIS: return "this";
        case LOX_TOKEN_TRUE: return "true";
        case LOX_TOKEN_VAR: return "variable";
        case LOX_TOKEN_WHILE: return "while";
        case LOX_TOKEN_EOF: return "eof";
        default: return "unknown";
    }
}

const char* token__type_name_c(struct token* token) {
    (void) token;
    return "";
}

const char* token__type_name_comment(struct token* token) {
    switch (token->type) {
        case COMMENT_TOKEN_TYPE_TOKEN: return "comment";
        default: return "unknown";
    }
}

void tokenizer__error(
    struct tokenizer* self,
    u32 line,
    const char* message, ...
) {
    self->had_error = true;

    va_list ap;

    libc__printf("%u | Error: ", line);

    va_start(ap, message);
    libc__vprintf(message, ap);
    va_end(ap);

    libc__printf("\n");
}

bool tokenizer__create(
    struct tokenizer* self,
    struct memory_slice tokens_memory
) {
    self->had_error = false;
    self->tokens_fill = 0;
    self->tokens_size = memory_slice__size(&tokens_memory) / sizeof(*self->tokens);
    if (self->tokens_size == 0) {
        return false;
    }

    self->tokens = (struct token*) memory_slice__memory(&tokens_memory);

    return true;
}

void tokenizer__destroy(struct tokenizer* self) {
    (void) self;
}

bool tokenizer__add(
    struct tokenizer* self,
    const char* lexeme,
    u32 lexeme_len,
    u32 token_type,
    u32 line
) {
    if (self->tokens_fill == self->tokens_size) {
        // error_code__exit(CAPACITY_REACHED_IN_ADD);
        error_code__exit(3492);
    }

    self->tokens[self->tokens_fill].lexeme = lexeme;
    self->tokens[self->tokens_fill].lexeme_len = lexeme_len;
    self->tokens[self->tokens_fill].type = token_type;
    self->tokens[self->tokens_fill].line = line;
    ++self->tokens_fill;

    return true;
}

void tokenizer__clear_error(struct tokenizer* self) {
    self->had_error = false;
}

bool tokenizer__had_error(struct tokenizer* self) {
    return self->had_error;
}

u32 tokenizer__fill(struct tokenizer* self) {
    return self->tokens_fill;
}

u32 tokenizer__size(struct tokenizer* self) {
    return self->tokens_size;
}

void tokenizer__clear(struct tokenizer* self) {
    self->tokens_fill = 0;
    self->had_error = false;
}
