#ifndef FILE_READER_H
# define FILE_READER_H

# include "file_reader_defs.h"

# include "../file.h"
# include "data_structures/circular_buffer/circular_buffer.h"

struct file_reader {
    struct file* file;
    circular_buffer_t circular_buffer;
    bool eof_reached;
};

GIL_API bool file_reader__create(struct file_reader* self, struct file* file);
GIL_API void file_reader__destroy(struct file_reader* self);

GIL_API u32 file_reader__read(struct file_reader* self, void* out, u32 size);

#endif
