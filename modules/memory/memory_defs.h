#ifndef MEMORY_DEFS_H
# define MEMORY_DEFS_H

# include "../modules_defs.h"

enum memory_error_code {
    MEMORY_ERROR_CODE_START,
};

typedef struct memory_slice {
    void* memory;
    u64 size;
    u64 offset; // implementation specific, for now it's just offset
} memory_slice_t;

#endif
