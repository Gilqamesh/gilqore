#ifndef FILE_WRITER_H
# define FILE_WRITER_H

# include "file_writer_defs.h"

struct file;

struct file_writer {
    char*  buffer;
    u32    buffer_size;
};

GIL_API bool file_writer__create(struct file_writer* self);
GIL_API void file_writer__destroy(struct file_writer* self);

// @returns the number of bytes written to the file
GIL_API s32 file_writer__write_format(struct file_writer* self, struct file* file, const char* format, ...);

#endif
