#ifndef GIES_TYPES_H
# define GIES_TYPES_H

# include "compiler/giescript/giescript_defs.h"

# define DEBUG_VM_TRACE
# undef DEBUG_VM_TRACE

# define DEBUG_COMPILER_TRACE
// # undef DEBUG_COMPILER_TRACE

# define DEBUG_ALLOCATOR_TRACE
# undef DEBUG_ALLOCATOR_TRACE

# define DEBUG_TOKEN_TRACE
# undef DEBUG_TOKEN_TRACE

typedef enum ins_mnemonic { // compiled/interpreted in the following way
    INS_RETURN,             // [ins]
    INS_IMM,                // [ins] [u8]
    INS_IMM_LONG,           // [ins] [u24 high] [u24 mid] [u24 low]
    INS_NIL,                // [ins]
    INS_TRUE,               // [ins]
    INS_FALSE,              // [ins]
    INS_NEG,                // [ins]
    INS_ADD,                // [ins]
    INS_SUB,                // [ins]
    INS_MUL,                // [ins]
    INS_DIV,                // [ins]
    INS_NOT,                // [ins]
    INS_EQ,                 // [ins]
    INS_GT,                 // [ins]
    INS_LT,                 // [ins]
    INS_PRINT,              // [ins]
    INS_POP,                // [ins]
    INS_POPN,               // [ins] [imm/imm_long (pop n times)]
    INS_DEFINE_GLOBAL,      // [ins] [imm/imm_long (index of global)]
    INS_GET_GLOBAL,         // [ins] [imm/imm_long (index of global)]
    INS_SET_GLOBAL,         // [ins] [imm/imm_long (index of global)]
    INS_GET_LOCAL,          // [ins] [imm/imm_long (index of local)]
    INS_SET_LOCAL,          // [ins] [imm/imm_long (index of local)]

    _INS_MNEMONIC_SIZE
} ins_mnemonic_t;

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
typedef struct ins_info ins_info_t;
typedef struct table table_t;
typedef struct entry entry_t;

#endif // GIES_TYPES_H
