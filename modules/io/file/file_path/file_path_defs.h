#ifndef FILE_PATH_DEFS_H
# define FILE_PATH_DEFS_H

# include "../file_defs.h"

enum file_path_error_code {
    FILE_PATH_ERROR_CODE_START,
    FILE_PATH_ERROR_CODE_BASENAME_BUFFER_TOO_SMALL = 27,
    FILE_PATH_ERROR_CODE_DIRECTORY_BUFFER_TOO_SMALL = 28,
};

#endif
