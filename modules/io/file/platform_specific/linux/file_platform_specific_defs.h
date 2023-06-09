#ifndef FILE_PLATFORM_SPECIFIC_DEFS_H
# define FILE_PLATFORM_SPECIFIC_DEFS_H

# include "../file_defs.h"

enum FILE_ERROR_CODE_LINUX {
    FILE_ERROR_CODE_LINUX_CLOSE = FILE_ERROR_CODE_LINUX,
    FILE_ERROR_CODE_LINUX_READ,
    FILE_ERROR_CODE_LINUX_WRITE,
    FILE_ERROR_CODE_LINUX_SEEK
};

struct file {
    s32 fd;
};

#endif
