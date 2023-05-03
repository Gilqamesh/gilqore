#ifndef DIRECTORY_PLATFORM_SPECIFIC_DEFS_H
# define DIRECTORY_PLATFORM_SPECIFIC_DEFS_H

# include "../../directory_defs.h"

enum DIRECTORY_ERROR_CODE_WINDOWS {
    DIRECTORY_ERROR_CODE_WINDOWS_FINDCLOSE = DIRECTORY_ERROR_CODE_WINDOWS,
    DIRECTORY_ERROR_CODE_WINDOWS_FIND_NEXT_FILE,
    DIRECTORY_ERROR_CODE_WINDOWS_INVALID_DIRECTORY_READ_INPUT
};

# include <Windows.h>

struct directory {
    HANDLE            handle;
    WIN32_FIND_DATAA  current_file_info;
    bool              no_more_files;
};

#endif
