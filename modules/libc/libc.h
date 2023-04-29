#ifndef LIBC_H
# define LIBC_H

# include "libc_defs.h"

GIL_API void* libc__malloc(u32 size_bytes);
GIL_API void  libc__free(void* data);

GIL_API void* libc__memcpy(void* dest, const void* src, u64 size);
GIL_API s32   libc__memcmp(const void *s1, const void *s2, u64 size);
GIL_API void* libc__memset(void *dest, s32 value, u64 size);

#endif
