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

// todo: conceptionally this is wrong as it assumes the file is readable
// also the file pointer can be messed with etc.
GIL_API bool file_reader__create(struct file_reader* self, struct file* file);
GIL_API void file_reader__destroy(struct file_reader* self);

// @brief sets file pointer to the beginning of the file
GIL_API void file_reader__clear(struct file_reader* self);

// @brief reads size bytes into out or until eof hasn't been met
// @param out optional
// @returns amount of bytes read
GIL_API u32 file_reader__read_one(struct file_reader* self, void* out, u32 size);
// @brief reads size bytes while neither byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
GIL_API u32 file_reader__read_while_not(struct file_reader* self, void* out, u32 size, const char* set);
// @brief reads size bytes while either byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
GIL_API u32 file_reader__read_while(struct file_reader* self, void* out, u32 size, const char* set);

#endif
