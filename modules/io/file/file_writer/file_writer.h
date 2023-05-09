#ifndef FILE_WRITER_H
# define FILE_WRITER_H

# include "file_writer_defs.h"

# include "../file.h"

struct file_writer {
    struct file*  file;
    char*         buffer;
    u32           buffer_size;
};

// todo: conceptionally this is wrong as it assumes the file is writeable
// also the file pointer can be messed with etc.
GIL_API bool file_writer__create(struct file_writer* self, struct file* file);
GIL_API void file_writer__destroy(struct file_writer* self);

// @returns the number of bytes written to the file
GIL_API s32 file_reader__write_format(struct file_writer* self, const char* format, ...);

#endif
