#ifndef FILE_PATH_H
# define FILE_PATH_H

# include "file_path_defs.h"

// from module compiler, story:
//  want parent dir's basename
//  want basename
//  want to append path to path

GIL_API bool file_path__directory_part(const char* path, char* buffer, u32 buffer_size);
GIL_API bool file_path__basename_part(const char* path, char* buffer, u32 buffer_size);
// @returns basename 
// @param n number of subdirectories from the back
// for example: n == 0 is the same as the basename, n == 1 is the path where the parent dir is also included
GIL_API bool file_path__basename_relative_part(const char* path, char* buffer, u32 buffer_size, u32 n);

GIL_API bool file_path__append(const char* path, char* buffer, u32 buffer_size, const char* append_str);

#endif
