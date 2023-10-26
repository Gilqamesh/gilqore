#ifndef FILE_READER_H
# define FILE_READER_H

# include "file_reader_defs.h"

# include "data_structures/circular_buffer/circular_buffer.h"
# include "io/file/file.h"

#include <stdarg.h>

typedef struct file_reader {
    struct circular_buffer circular_buffer;
    struct file file;
    bool eof_reached;
} file_reader_t;

PUBLIC_API bool file_reader__create(
    file_reader_t* self,
    struct file file,
    struct memory_slice internal_buffer
);
PUBLIC_API void file_reader__destroy(file_reader_t* self);

// @brief clear internal state and replace the file to read from
PUBLIC_API void file_reader__clear(file_reader_t* self, struct file file);

PUBLIC_API bool file_reader__has_reached_eof(file_reader_t* self);
// @returns the top most byte without advancing the file stream
PUBLIC_API char file_reader__peek(file_reader_t* self);
// @brief reads size bytes into out or until eof hasn't been met
// @param out optional
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_one(file_reader_t* self, void* out, u32 size);
// @brief reads size bytes while neither byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_while_not(file_reader_t* self, void* out, u32 size, const char* set);
// @brief reads size bytes while either byte from the set is matched or until eof is reached
// @param out optional, if not provided size is ignored as well
// @returns amount of bytes read
PUBLIC_API u32 file_reader__read_while(file_reader_t* self, void* out, u32 size, const char* set);
// @brief reads max size bytes to out while word hasn't been matched, so if word is matched, out will contain it at its end
// @param out must be provided
// @returns whether or not word has been read as well as the amount of bytes read
PUBLIC_API bool file_reader__read_while_not_word(
    file_reader_t* self,
    void* out,
    u32 size,
    const char* word,
    u32 word_length,
    u32* bytes_read
);
// @brief regex: -?[0-9]+
// @param out optional
PUBLIC_API bool file_reader__read_s32(file_reader_t* self, s32* out);
// @brief reads from stream while format matches
//        %p: 0x[0-9a-fA-F]+
// @param out optional
// @returns number of bytes read
PUBLIC_API u32 file_reader__read_format(file_reader_t* self, const char* format, ...);
PUBLIC_API u32 file_reader__read_formatv(file_reader_t* self, const char* format, va_list ap);

#endif
