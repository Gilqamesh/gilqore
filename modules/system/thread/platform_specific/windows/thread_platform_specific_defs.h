#ifndef THREAD_WINDOWS_DEFS_H
# define THREAD_WINDOWS_DEFS_H

# include "../../thread_defs.h"

enum thread_windows_error_code {
    WINDOWS_THREAD_ERROR_CODE_START,

};

# include "windows.h"

typedef struct thread {
    HANDLE handle;
} thread_t;

typedef struct mutex {
    HANDLE mutex;
} mutex_t;

#endif
