#ifndef LINEAR_ALLOCATOR_H
# define LINEAR_ALLOCATOR_H

# include "linear_allocator_defs.h"

# include "memory/memory.h"

struct linear_allocator {
    struct memory_slice memory_slice;
    u64 fill;
};

PUBLIC_API bool linear_allocator__create(struct linear_allocator* self, struct memory_slice memory_slice);
PUBLIC_API void linear_allocator__destroy(struct linear_allocator* self);

// @returns uninitialized memory address
PUBLIC_API struct memory_slice linear_allocator__push(struct linear_allocator* self, u64 size);
// @param alignment must be power of 2
PUBLIC_API struct memory_slice linear_allocator__push_aligned(struct linear_allocator* self, u64 size, u32 alignment);
PUBLIC_API void linear_allocator__pop(struct linear_allocator* self, struct memory_slice memory_slice);

PUBLIC_API u64 linear_allocator__available(struct linear_allocator* self);
// @returns available bytes to allocate with alignment
PUBLIC_API u64 linear_allocator__available_aligned(struct linear_allocator* self, u32 alignment);

#endif // LINEAR_ALLOCATOR_H
