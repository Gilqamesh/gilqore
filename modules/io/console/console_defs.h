#ifndef CONSOLE_DEFS_H
# define CONSOLE_DEFS_H

# include "../io_defs.h"

enum console_error_code {
    CONSOLE_ERROR_CODE_START,
    CONSOLE_ERROR_CODE_ATTACH_CONSOLE = 41,
    CONSOLE_ERROR_CODE_GET_STD_HANDLE = 42,
    CONSOLE_ERROR_CODE_VSNPRINTF = 43,
    CONSOLE_ERROR_CODE_WRITE_CONSOLE_A = 44,

};

#endif
