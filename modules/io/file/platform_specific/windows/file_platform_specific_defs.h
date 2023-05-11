#ifndef FILE_PLATFORM_SPECIFIC_DEFS_H
# define FILE_PLATFORM_SPECIFIC_DEFS_H

# include "../../file_defs.h"

enum FILE_ERROR_CODE_WINDOWS {
    FILE_ERROR_CODE_WINDOWS_START = 999
};

#include <Windows.h>

struct file {
    HANDLE handle;
};

#endif
