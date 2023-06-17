#ifndef MEMORY_H
# define MEMORY_H

# include "memory_defs.h"

PUBLIC_API struct memory_slice memory_slice__create(void* memory, u64 size);

PUBLIC_API void* memory_slice__memory(struct memory_slice* self);
PUBLIC_API u64 memory_slice__size(struct memory_slice* self);

#endif // MEMORY_H
