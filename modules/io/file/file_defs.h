#ifndef FILE_DEFS_H
# define FILE_DEFS_H

# include "../io_defs.h"

enum file_error_code {
    FILE_ERROR_CODE_START,
    FILE_ERROR_CODE_ACCESS_MODE_INVALID = 26,
    FILE_ERROR_CODE_CREATION_MODE_INVALID = 27,
};

#endif
