#include "compiler/parser/parser.h"

#include "compiler/tokenizer/tokenizer.h"

#include "libc/libc.h"

bool parser__is_program_valid(struct parser_program program) {
    return program.statement != NULL;
}

bool parser__create(
    struct parser* self,
    struct tokenizer* tokenizer,
    struct memory_slice internal_buffer
) {
    self->tokenizer = tokenizer;
    self->internal_buffer = internal_buffer;
    self->had_syntax_error = false;
    self->had_runtime_error = false;
    self->token_index = 0;
    self->env_parse_id = 0;
    self->env_stack_ids = NULL;
    self->env_stack_ids_fill = 0;
    self->env_stack_ids_size = 0;

    return true;
}

void parser__destroy(struct parser* self) {
    (void) self;
}

void parser__syntax_error(
    struct parser* self,
    const char* format, ...
) {
    va_list ap;

    va_start(ap, format);
    parser__syntax_verror(self, format, ap);
    va_end(ap);
}

void parser__syntax_verror(
    struct parser* self,
    const char* format, va_list ap
) {
    self->had_syntax_error = true;

    libc__printf("Syntax Error: ");

    libc__vprintf(format, ap);
    
    libc__printf("\n");
}

void parser__warn_error(
    struct parser* self,
    const char* format, ...
) {
    va_list ap;

    va_start(ap, format);
    parser__warn_verror(self, format, ap);
    va_end(ap);
}

void parser__warn_verror(
    struct parser* self,
    const char* format, va_list ap
) {
    (void) self;
    
    libc__printf("Warning: ");

    libc__vprintf(format, ap);

    libc__printf("\n");
}
