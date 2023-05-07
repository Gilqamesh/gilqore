#ifndef IO_DEFS_H
# define IO_DEFS_H

# include "../defs.h"

enum IO_ERROR_CODE {
    IO_ERROR_CODE_FATAL = ERROR_CODE_IO,

    ERROR_CODE_DIRECTORY,
    ERROR_CODE_FILE = ERROR_CODE_DIRECTORY + 50
};

#endif
