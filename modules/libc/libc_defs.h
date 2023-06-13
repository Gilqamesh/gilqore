#ifndef LIBC_DEFS_H
# define LIBC_DEFS_H

# include "../modules_defs.h"

enum libc_error_code {
    LIBC_ERROR_CODE_START,
    LIBC_ERROR_CODE_MALLOC_FAILED = 32,
    LIBC_ERROR_CODE_VSNPRINTF = 33,
};

#endif
