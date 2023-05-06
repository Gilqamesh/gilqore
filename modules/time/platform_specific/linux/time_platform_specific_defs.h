#ifndef TIME_PLATFORM_SPECIFIC_DEFS_H
# define TIME_PLATFORM_SPECIFIC_DEFS_H

# include "../../time_defs.h"

enum TIME_ERROR_CODE_LINUX {
    TIME_ERROR_CODE_LINUX_TIME = TIME_ERROR_CODE_LINUX
};

# include <time.h>

struct time {
    time_t val;
};

#endif
