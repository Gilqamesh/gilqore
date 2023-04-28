#ifndef FILE_H
# define FILE_H

# include "file_defs.h"

typedef struct file *file;

GIL_API file file__open(const char* path);
GIL_API void file__close(file self);

GIL_API u32 file__read(file self, void* out, u32 size);

#endif
