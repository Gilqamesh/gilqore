#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "common.h"

# include "scanner.h"
# include "table.h"

typedef struct local {
    token_t  identifier;
    // -1 - uninitialized state before we compile the initializer
    // 0  - impossible, 0 depth means it's global
    bool     is_const;
    s32      scope_depth;
} local_t;

typedef struct scope {
    table_t locals;

    local_t*  locals_data;
    u32       locals_fill;
    u32       locals_size;
    s32       scope_depth;
} scope_t;

struct compiler {
    token_t current;
    token_t previous;

    scanner_t scanner;
    bool had_error;
    bool panic_mode;

    // scope_t scope;

    table_t* scopes;
    u32      scopes_fill;
    u32      scopes_size;
    u32      scopes_locals_fill;

    vm_t* vm;
    chunk_t* chunk;
};

bool compiler__create(compiler_t* self, vm_t* vm, chunk_t* chunk, const char* source);
void compiler__destroy(compiler_t* self);

bool compiler__compile(compiler_t* self);

#endif // GIES_COMPILER_H
