#ifndef FILE_WRITER_H
# define FILE_WRITER_H

# include "file_writer_defs.h"

# include "memory/memory.h"

struct file;

typedef struct file_writer {
    struct memory_slice buffer;
} file_writer_t;

PUBLIC_API bool file_writer__create(struct file_writer* self, struct memory_slice buffer);
PUBLIC_API void file_writer__destroy(struct file_writer* self);

// @returns the number of bytes written to the file
PUBLIC_API s32 file_writer__write_format(struct file_writer* self, struct file* file, const char* format, ...);

#endif
