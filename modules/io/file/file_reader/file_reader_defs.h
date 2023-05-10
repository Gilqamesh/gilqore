#ifndef FILE_READER_DEFS_H
# define FILE_READER_DEFS_H

# include "../file_defs.h"

enum file_reader_error_code {
    FILE_READER_ERROR_CODE_START,
    FILE_READER_ERROR_CODE_NOTHING_TO_PEEK = 34,
    FILE_READER_ERROR_CODE_WRONG_FORMAT_SPECIFIER = 35,
};

#endif
