#ifndef DIRECTORY_PLATFORM_SPECIFIC_DEFS_H
# define DIRECTORY_PLATFORM_SPECIFIC_DEFS_H

# include "../../directory_defs.h"

// todo: error code

enum DIRECTORY_ERROR_CODE_WINDOWS {
    DIRECTORY_ERROR_CODE_WINDOWS_FINDCLOSE = DIRECTORY_ERROR_CODE_WINDOWS
};

# include <Windows.h>

struct directory {
    HANDLE            handle;
    WIN32_FIND_DATAA  current_file_info;
};

struct directory_entry {
    const char* file_name;
}

#endif
