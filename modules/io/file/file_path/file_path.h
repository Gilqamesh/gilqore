#ifndef FILE_PATH_H
# define FILE_PATH_H

# include "file_path_defs.h"

GIL_API bool file_path__decompose(
    const char* path, u32 path_len,
    char* basename_buffer, u32 basename_buffer_size,
    char* directory_buffer, u32 directory_buffer_size
);

#endif
