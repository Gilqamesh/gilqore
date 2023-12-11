#ifndef COMPILER_H
# define COMPILER_H

# include <stdint.h>
# include <stdarg.h>
# include <stdbool.h>

# include "types.h"
# include "scanner.h"
# include "hash_map.h"
# include "compiler/compiler_alignment.h"

bool compiler__module_init();

typedef struct compiler_flags {
    uint32_t    error_limit;
    bool        show_warnings;

    FILE*       out_stream;
    FILE*       warn_stream;
    FILE*       err_stream;
} compiler_flags_t;
void compiler_flags__create(compiler_flags_t* self);

typedef struct compiler_flag compiler_flag_t;
// @returns false if 'arg' usage for flag is wrong
typedef bool (*compiler_flag_fn_t)(const char* arg, compiler_flags_t*, compiler_flag_t* compiler_flag);
typedef struct compiler_flag {
    compiler_flag_fn_t  fn;
    const char*         option_usage;
    const char*         option_description;
} compiler_flag_t;

compiler_flag_t* compiler__flag_find(const char* flag);
extern hash_map_t* compiler_flag_fns;

typedef struct local {
    token_t     token;
    type_t*     type;
    uint32_t    offset_from_bp;
    bool        is_const;

    struct {
        uint32_t stack_index; // changes depending on where we are in the stack
        bool     is_defined;
    } transient_data;
} local_t;

typedef struct scope {
    local_t*       locals;
    uint32_t       locals_top;
    uint32_t       locals_size;
} scope_t;

typedef struct compiler {
    scanner_t                 scanner; // todo: move to compilation unit shared place
    types_t                   types;

    token_t                   token_cur;
    token_t                   token_prev;

    scope_t*                  scopes;
    uint32_t                  scopes_top;
    uint32_t                  scopes_size;

    type_internal_function_t* compiled_fn;

    bool                      panic_mode;
    bool                      had_error;

    compiler_flags_t*         flags; // todo: move to compilation unit shared place

    struct compiler*          parent;
} compiler_t;

type_internal_function_t* compiler__create_and_compile(
    compiler_t* self,
    compiler_flags_t* compiler_flags,
    const char* fn_source, uint64_t fn_source_len, bool source_is_mutable,
    const char* fn_name
);

#endif // COMPILER_H
