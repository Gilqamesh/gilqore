#ifndef LIBC_H
# define LIBC_H

# include "libc_defs.h"

# if defined(WINDOWS)
#  include "platform_specific/windows/libc_platform_specific.h"
# elif defined(LINUX)
#  include "platform_specific/linux/libc_platform_specific.h"
# elif defined(MAC)
#  include "platform_specific/mac/libc_platform_specific.h"
# endif

# include <stdarg.h>

PUBLIC_API void* libc__malloc(u64 size_bytes);
PUBLIC_API void* libc__calloc(u64 size_bytes);
PUBLIC_API void* libc__realloc(void* data, u64 new_size_bytes);
PUBLIC_API void  libc__free(void* data);
# if defined(GIL_DEBUG)
PUBLIC_API u32   libc__unfreed_byte_count(void);
# endif

PUBLIC_API void* libc__memcpy(void* dest, const void* src, u64 size);
PUBLIC_API s32   libc__memcmp(const void *s1, const void *s2, u64 size);
PUBLIC_API void* libc__memset(void *dest, s32 value, u64 size);
PUBLIC_API void* libc__memmove(void* dst, void* src, size_t size);

PUBLIC_API u32 libc__strlen(const char* str);
PUBLIC_API u32 libc__strnlen(const char* str,  u32 max_len);
PUBLIC_API s32 libc__strcmp(const char* str1, const char* str2);
PUBLIC_API s32 libc__strncmp(const char* str1, const char* str2, u64 size);
PUBLIC_API void* libc__strcat(char* dest, const char* src);
PUBLIC_API char* libc__strcpy(char* dest, const char* src);
PUBLIC_API char* libc__strncpy(char* dest, const char* src, u64 size);
PUBLIC_API char* libc__strchr(const char* str, char c);
PUBLIC_API char* libc__strrchr(const char* str, char c);

// @returns number of bytes written
PUBLIC_API s32 libc__printf(const char* format, ...);
// @returns number of bytes written
PUBLIC_API s32 libc__vprintf(const char* format, va_list ap);
// @brief writes format into the buffer and null-terminates it
// @returns number of bytes that would have been written not counting the null-terminating character
PUBLIC_API s32 libc__snprintf(char* buffer, u64 size, const char* format, ...);
// @brief writes format into the buffer and null-terminates it
// @returns number of bytes that would have been written not counting the null-terminating character
// @note if return equals to the buffer size, it means the format was truncated
PUBLIC_API s32 libc__vsnprintf(char* buffer, u64 buffer_size, const char* format, va_list ap);
// @note buffer overflow can occur
PUBLIC_API s32 libc__sscanf(const char* str, const char* format, ...);
// @note buffer overflow can occur
PUBLIC_API s32 libc__vsscanf(const char* str, const char* format, va_list ap);

PUBLIC_API bool libc__isspace(char c);
PUBLIC_API bool libc__isdigit(char c);
PUBLIC_API bool libc__isalpha(char c);
PUBLIC_API bool libc__isalnum(char c);

PUBLIC_API s64 libc__atoi(const char* str, u32 radix);
PUBLIC_API void libc__itoa(s64 n, char* buffer, u32 buffer_size);

PUBLIC_API r64 libc__strtod(const char* str);
PUBLIC_API r64 libc__strntod(const char* str, u32 str_len);

PUBLIC_API void libc__qsort(
    void* base,
    u32 n_of_items,
    u32 size_of_item,
    s32 (*compare_fn)(const void*, const void*)
);

#endif
