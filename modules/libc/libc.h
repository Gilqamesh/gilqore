#ifndef LIBC_H
# define LIBC_H

# include "libc_defs.h"

GIL_API void* libc__malloc(u32 size_bytes);
GIL_API void  libc__free(void* data);

GIL_API void* libc__memcpy(void* dest, void* src, u64 size);

#endif
