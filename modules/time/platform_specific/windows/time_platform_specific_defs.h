#ifndef TIME_PLATFORM_SPECIFIC_DEFS_H
# define TIME_PLATFORM_SPECIFIC_DEFS_H

# include "../../time_defs.h"

enum TIME_ERROR_CODE_WINDOWS {
    TIME_ERROR_CODE_WINDOWS_SYSTEM_TIME_TO_FILE_TIME = TIME_ERROR_CODE_WINDOWS
};

# include <Windows.h>

struct time {
    FILETIME val;
};

#endif
