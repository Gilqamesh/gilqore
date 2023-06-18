#ifndef FILE_READER_H
# define FILE_READER_H

# include "file_reader_defs.h"

struct file;
struct memory_slice;

# include "data_structures/circular_buffer/circular_buffer.h"

struct file_reader {
    struct circular_buffer circular_buffer;
    struct file* file;
    bool eof_reached;
};

PUBLIC_API bool file_reader__create(
    struct file_reader* self,
    struct file* file,
    struct memory_slice internal_buffer
);
PUBLIC_API void file_reader__destroy(struct file_reader* self);

// @brief clear internal state and replace the file to read from
PUBLIC_API void file_reader__clear(struct file_reader* self, struct file* file);

// @returns the top most byte without advancing the file stream
PUBLIC_API char file_reader__peek(struct file_reader* self);
// @brief reads size bytes into out or until eof hasn't been met
// @param out optional
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_one(struct file_reader* self, void* out, u32 size);
// @brief reads size bytes while neither byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_while_not(struct file_reader* self, void* out, u32 size, const char* set);
// @brief reads size bytes while either byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_while(struct file_reader* self, void* out, u32 size, const char* set);
// @brief reads max size bytes to out while word hasn't been matched, so if word is matched, out will contain it at its end
// @param out must be provided
// @returns whether or not word has been read as well as the amount of bytes read
PUBLIC_API bool file_reader__read_while_not_word(
    struct file_reader* self,
    void* out,
    u32 size,
    const char* word,
    u32 word_length,
    u32* bytes_read
);
// @brief out must be provided
// @returns amount of bytes_read
PUBLIC_API u32 file_reader__read_format(struct file_reader* self, void* out, u32 size, const char* format, ...);

#endif
