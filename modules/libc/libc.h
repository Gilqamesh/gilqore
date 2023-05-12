#ifndef LIBC_H
# define LIBC_H

# include "libc_defs.h"

# include <stdarg.h>

GIL_API void* libc__malloc(u32 size_bytes);
GIL_API void* libc__calloc(u32 size_bytes);
GIL_API void  libc__free(void* data);
# if defined(GIL_DEBUG)
GIL_API u32   libc__unfreed_byte_count(void);
# endif

GIL_API void* libc__memcpy(void* dest, const void* src, u64 size);
GIL_API s32   libc__memcmp(const void *s1, const void *s2, u64 size);
GIL_API void* libc__memset(void *dest, s32 value, u64 size);

GIL_API u64 libc__strlen(const char* str);
GIL_API s32 libc__strcmp(const char* str1, const char* str2);
GIL_API s32 libc__strncmp(const char* str1, const char* str2, u64 size);
GIL_API void* libc__strcat(char* dest, const char* src);
GIL_API char* libc__strcpy(char* dest, const char* src);
GIL_API char* libc__strncpy(char* dest, const char* src, u64 size);
GIL_API char* libc__strchr(const char* str, char c);
GIL_API char* libc__strrchr(const char* str, char c);

// @returns number of bytes written
GIL_API s32 libc__printf(const char* format, ...);
// @returns number of bytes written
GIL_API s32 libc__vprintf(const char* format, va_list ap);
// @brief writes format into the buffer and null-terminates it
// @returns number of bytes that would have been written not counting the null-terminating character
GIL_API s32 libc__snprintf(char* buffer, u64 size, const char* format, ...);
// @brief writes format into the buffer and null-terminates it
// @returns number of bytes that would have been written not counting the null-terminating character
// @note if return equals to the buffer size, it means the format was truncated
GIL_API s32 libc__vsnprintf(char* buffer, u64 buffer_size, const char* format, va_list ap);
// @note buffer overflow can occur
GIL_API s32 libc__sscanf(const char* str, const char* format, ...);
// @note buffer overflow can occur
GIL_API s32 libc__vsscanf(const char* str, const char* format, va_list ap);

GIL_API bool libc__isspace(char c);
GIL_API bool libc__isdigit(char c);

GIL_API char* libc__itoa(s64 n, char* buffer, u32 radix);
GIL_API s64 libc__atoi(const char* str, u32 radix);

GIL_API void libc__qsort(
    void* base,
    u32 n_of_items,
    u32 size_of_item,
    s32 (*compare_fn)(const void*, const void*)
);

#endif
