#ifndef GIES_ALLOCATOR_H
# define GIES_ALLOCATOR_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

# include "memory/memory.h"

# define GROW_CAPACITY(capacity) ((capacity) < 8 ? 8 : (capacity) * 2)
# define GROW_ARRAY(assign, allocator, type, data, old_size, new_size) { \
    assign = (type*) allocator__realloc(allocator, data, old_size * sizeof(type), new_size * sizeof(type)); \
    allocator__print(allocator); \
}
# define FREE_ARRAY(allocator, type, data, size) \
    allocator__free(allocator, data);

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
