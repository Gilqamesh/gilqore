#ifndef LIBC_DEFS_H
# define LIBC_DEFS_H

# include "defs.h"

enum LIBC_ERROR_CODE {
    LIBC_ERROR_CODE_FATAL = ERROR_CODE_LIBC,
    LIBC_ERROR_CODE_MALLOC_FAILED
};

#endif
