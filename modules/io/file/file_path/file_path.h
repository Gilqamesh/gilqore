#ifndef FILE_PATH_H
# define FILE_PATH_H

# include "file_path_defs.h"

// @param path cannot be "." or ".."
// @param basename_buffer optional
// @param basename_len optional
// @param directory_buffer optional
// @param directory_len optional
// @returns basename + directory part, directory part is empty if there wasn't a separator in 'path'
GIL_API bool file_path__decompose(
    const char* path, u32 path_len,
    char* basename_buffer, u32 basename_buffer_size, u32* basename_len,
    char* directory_buffer, u32 directory_buffer_size, u32* directory_len
);

#endif
