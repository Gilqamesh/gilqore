#ifndef GIES_TYPES_H
# define GIES_TYPES_H

# include "compiler/giescript/giescript_defs.h"

# define DEBUG_VM_TRACE
// # undef DEBUG_VM_TRACE

# define DEBUG_COMPILER_TRACE
# undef DEBUG_COMPILER_TRACE

# define DEBUG_ALLOCATOR_TRACE
# undef DEBUG_ALLOCATOR_TRACE

# define DEBUG_TOKEN_TRACE
# undef DEBUG_TOKEN_TRACE

typedef struct chunk chunk_t;
typedef struct allocator allocator_t;
typedef struct value value_t;
typedef struct value_arr value_arr_t;
typedef struct vm vm_t;
typedef struct scanner scanner_t;
typedef struct token token_t;
typedef struct compiler compiler_t;
typedef struct obj obj_t;
typedef struct obj_str obj_str_t;
typedef struct obj_var_info obj_var_info_t;

typedef struct table table_t;
typedef struct entry entry_t;

#endif // GIES_TYPES_H
