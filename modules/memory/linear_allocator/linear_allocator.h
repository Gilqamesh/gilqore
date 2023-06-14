#ifndef LINEAR_ALLOCATOR_H
# define LINEAR_ALLOCATOR_H

# include "linear_allocator_defs.h"

struct linear_allocator {
    void* memory;
    u64   size;
    u64   fill;
};

struct linear_allocator_memory_slice {
    void* memory;
    u64 size;
    u64 offset;
};

GIL_API bool linear_allocator__create(struct linear_allocator* self, void* memory, u64 size);
GIL_API void linear_allocator__destroy(struct linear_allocator* self);

// @returns uninitialized memory address
GIL_API struct linear_allocator_memory_slice linear_allocator__push(struct linear_allocator* self, u64 size);
// @param alignment must be power of 2
GIL_API struct linear_allocator_memory_slice linear_allocator__push_aligned(struct linear_allocator* self, u64 size, u32 alignment);
GIL_API void linear_allocator__pop(struct linear_allocator* self, struct linear_allocator_memory_slice memory_slice);

GIL_API u64 linear_allocator__available(struct linear_allocator* self);
// @returns available bytes to allocate with alignment
GIL_API u64 linear_allocator__available_aligned(struct linear_allocator* self, u32 alignment);

#endif // LINEAR_ALLOCATOR_H
