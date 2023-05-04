#ifndef PROCESS_PLATFORM_SPECIFIC_DEFS_H
# define PROCESS_PLATFORM_SPECIFIC_DEFS_H

# include "../../process_defs.h"

enum PROCESS_ERROR_CODE_LINUX {
    PROCESS_ERROR_CODE_LINUX_WIFSIGNALED = PROCESS_ERROR_CODE_LINUX,
    PROCESS_ERROR_CODE_LINUX_ARBITRARY_MAX_ARGC
};

#include <unistd.h>

struct process {
    pid_t pid;
    s32 exit_code;
};

#endif
