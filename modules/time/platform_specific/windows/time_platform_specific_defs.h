#ifndef TIME_PLATFORM_SPECIFIC_DEFS_H
# define TIME_PLATFORM_SPECIFIC_DEFS_H

# include "../../time_defs.h"

enum time_windows_error_code {
    WINDOWS_TIME_ERROR_CODE_START,
    TIME_ERROR_CODE_SYSTEM_TIME_TO_FILE_TIME = 41,
};

# include "windows.h"

struct time {
    FILETIME val;
};

#endif
