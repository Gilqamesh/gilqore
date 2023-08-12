#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "types.h"

# include "scanner.h"
# include "table.h"

typedef struct local {
    token_t  identifier;
    s32      scope_depth; // -1
} local_t;

typedef struct scope {
    local_t  locals[256];
    u32      locals_fill;
    s32      scope_depth;
} scope_t;

struct compiler {
    token_t current;
    token_t previous;

    scanner_t scanner;
    bool had_error;
    bool panic_mode;

    scope_t scope;

    vm_t* vm;
    allocator_t* allocator;
    chunk_t* chunk;
};

void compiler__init(compiler_t* self, vm_t* vm, allocator_t* allocator, chunk_t* chunk, const char* source);

bool compiler__compile(compiler_t* self);

#endif // GIES_COMPILER_H
