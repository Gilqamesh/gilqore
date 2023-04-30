#ifndef FILE_PLATFORM_SPECIFIC_DEFS_H
# define FILE_PLATFORM_SPECIFIC_DEFS_H

# include "../file_defs.h"

enum FILE_ERROR_CODE_MAC {
    FILE_ERROR_CODE_MAC_CLOSEHANDLE = FILE_ERROR_CODE_MAC,
    FILE_ERROR_CODE_MAC_READ,
    FILE_ERROR_CODE_MAC_WRITE
};

struct file {
    s32 fd;
};

#endif
