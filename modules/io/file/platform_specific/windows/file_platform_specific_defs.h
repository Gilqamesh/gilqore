#ifndef FILE_PLATFORM_SPECIFIC_DEFS_H
# define FILE_PLATFORM_SPECIFIC_DEFS_H

# include "../../file_defs.h"

enum file_windows_error_code {
    WINDOWS_FILE_ERROR_CODE_START,
    FILE_ERROR_CODE_WINDOWS_READ = 22,
    FILE_ERROR_CODE_WINDOWS_WRITE = 23,
    FILE_ERROR_CODE_WINDOWS_SEEK = 24,
    FILE_ERROR_CODE_WINDOWS_CLOSE = 25,
};

#include "windows.h"

struct file {
    HANDLE handle;
};

#endif
