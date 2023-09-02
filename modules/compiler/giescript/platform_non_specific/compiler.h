#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "common.h"

# include "scanner.h"
# include "table.h"

struct compiler {
    table_t* scopes;
    u32      scopes_fill;
    u32      scopes_size;
    u32      scopes_var_fill;

    // characteristics for the current loop being compiled, used for break/continue like flow controls
    s32  ip_loop_start;
    s32  ip_loop_end;
    s32  ip_loop_scope_depth;
    bool loop_did_break;

    compiler_t* parent;

    // todo: pass by params, it's a result of compilation and isn't really a state
    obj_fun_t*  fn;
};

bool compiler__create(compiler_t* self, vm_t* vm, const char* source);
void compiler__destroy(compiler_t* self);

obj_fun_t* compiler__compile(compiler_t* self);

#endif // GIES_COMPILER_H
