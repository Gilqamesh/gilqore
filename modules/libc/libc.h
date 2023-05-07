#ifndef LIBC_H
# define LIBC_H

# include "libc_defs.h"

GIL_API void* libc__malloc(u32 size_bytes);
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

GIL_API s32 libc__snprintf(char *buffer, u64 size, const char* format, ...);

GIL_API bool libc__isspace(char c);

#endif
