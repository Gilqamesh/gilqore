#ifndef DIRECTORY_PLATFORM_SPECIFIC_DEFS_H
# define DIRECTORY_PLATFORM_SPECIFIC_DEFS_H

# include "../../directory_defs.h"

enum directory_windows_error_code {
    WINDOWS_DIRECTORY_ERROR_CODE_START,
};


enum DIRECTORY_ERROR_CODE_WINDOWS {
    DIRECTORY_ERROR_CODE_WINDOWS_FINDCLOSE,
    DIRECTORY_ERROR_CODE_WINDOWS_PATH_TRUNCATED,
    DIRECTORY_ERROR_CODE_WINDOWS_FIND_NEXT_FILE,
    DIRECTORY_ERROR_CODE_WINDOWS_INVALID_DIRECTORY_READ_INPUT
};

# include "windows.h"

struct directory {
    HANDLE            handle;
    WIN32_FIND_DATAA  current_file_info;
    bool              no_more_files;
};

#endif
