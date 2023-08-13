#ifndef GIES_ALLOCATOR_H
# define GIES_ALLOCATOR_H

# include "compiler/giescript/giescript_defs.h"

# include "common.h"

# include "memory/memory.h"

struct allocator {
    memory_slice_t memory;
};

bool  allocator__create(allocator_t* self, memory_slice_t memory);
void  allocator__destroy(allocator_t* self);

void* allocator__realloc(allocator_t* self, void* data, size_t old_size, size_t new_size);
void* allocator__alloc(allocator_t* self, size_t size);
void  allocator__free(allocator_t* self, void* data);

void  allocator__print(allocator_t* self);

#endif // GIES_ALLOCATOR_H
