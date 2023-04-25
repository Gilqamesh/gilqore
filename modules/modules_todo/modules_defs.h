#ifndef MODULES_DEFS_H
# define MODULES_DEFS_H

#include "../common/common_defs.h"

enum ERROR_START_CODE {
    ERROR_START_CODE_APP = 1,
    ERROR_START_CODE_FILE_READER = 100
};

enum APP_ERROR {
    APP_ERROR_WINDOW_CALLBACK = ERROR_START_CODE_APP,
    APP_ERROR_CONSOLE_UNINITIALIZED,
    APP_ERROR_WM_CREATE,
    APP_ERROR_INVALID_CODE_PATH,
    APP_ERROR_ALLOC_FAIL,
    APP_ERROR_RAN_OUT_OF_MEMORY,
    APP_CONSOLE_FATAL
};

#endif
