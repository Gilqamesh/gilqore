#ifndef DIRECTORY_PLATFORM_SPECIFIC_DEFS_H
# define DIRECTORY_PLATFORM_SPECIFIC_DEFS_H

# include "../../directory_defs.h"

enum DIRECTORY_ERROR_CODE_LINUX {
    DIRECTORY_ERROR_CODE_LINUX_CLOSEDIR = DIRECTORY_ERROR_CODE_LINUX,
    DIRECTORY_ERROR_CODE_LINUX_INVALID_DIRECTORY_READ_INPUT
};

# include <dirent.h>

struct directory {
    DIR* handle;
};

#endif