#ifndef FILE_WRITER_DEFS_H
# define FILE_WRITER_DEFS_H

# include "../file_defs.h"

enum file_writer_error_code {
    FILE_WRITER_ERROR_CODE_START,
    FILE_WRITER_ERROR_CODE_FILE_WRITE_UNEXPECTED_NUMBER_OF_BYTES_WRITTEN = 33,
};

#endif
