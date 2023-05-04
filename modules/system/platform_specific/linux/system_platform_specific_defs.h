#ifndef SYSTEM_PLATFORM_SPECIFIC_DEFS_H
# define SYSTEM_PLATFORM_SPECIFIC_DEFS_H

# include "../../system_defs.h"

enum SYSTEM_LINUX_ERROR_CODE {
    SYSTEM_LINUX_ERROR_CODE_OPEN = ERROR_CODE_SYSTEM_LINUX,
    SYSTEM_LINUX_ERROR_CODE_CLOSE,
    SYSTEM_LINUX_ERROR_CODE_FORK,
    SYSTEM_LINUX_ERROR_CODE_WAITPID,
    SYSTEM_LINUX_ERROR_CODE_PIPE,
    SYSTEM_LINUX_ERROR_CODE_PIPE2,
    SYSTEM_LINUX_ERROR_CODE_WRITE,
    SYSTEM_LINUX_ERROR_CODE_READ,
    SYSTEM_LINUX_ERROR_CODE_USLEEP
}

#endif