#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "common.h"

# include "scanner.h"
# include "table.h"

struct compiler {
    token_t current;
    token_t previous;

    scanner_t scanner;
    bool had_error;
    bool panic_mode;

    table_t* scopes;
    u32      scopes_fill;
    u32      scopes_size;
    u32      scopes_var_fill;

    // characteristics for the current loop being compiled, used for break/continue like flow controls
    s32 ip_loop_start;
    s32 ip_loop_end;
    s32 ip_loop_scope_depth;
    bool loop_did_break;

    vm_t*    vm;
    obj_fun_t* current_fn;

    chunk_t* chunk;
};

bool compiler__create(compiler_t* self, vm_t* vm, chunk_t* chunk, const char* source);
void compiler__destroy(compiler_t* self);

bool compiler__compile(compiler_t* self);

#endif // GIES_COMPILER_H
