#include "memory/linear_allocator/linear_allocator.h"

#include "libc/libc.h"
#include "math/math.h"
#include "math/compare/compare.h"

bool linear_allocator__create(struct linear_allocator* self, void* memory, u64 size) {
    self->memory = memory;
    self->size = size;
    self->fill = 0;

    return true;
}

void linear_allocator__destroy(struct linear_allocator* self) {
    libc__memset(self, 0, sizeof(*self));
}

struct linear_allocator_memory_slice linear_allocator__push(struct linear_allocator* self, u64 size) {
    if (size > linear_allocator__available(self)) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_OVERFLOW_IN_PUSH);
    }

    struct linear_allocator_memory_slice result;
    result.memory = self->memory;
    result.size = size;
    result.offset = 0;

    self->fill += size;
    self->memory = (char*) self->memory + size;

    return result;
}

struct linear_allocator_memory_slice linear_allocator__push_aligned(struct linear_allocator* self, u64 size, u32 alignment) {
    if (is_pow_of_2__u32(alignment) == false) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_ALIGNMENT_NOT_POW_OF_2);
    }

    u64 modulo = ((u64) self->memory) & ((u64) (alignment - 1));
    u64 offset = modulo != 0 ? (u64) alignment - modulo : 0;

    if (size + offset > linear_allocator__available(self)) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_OVERFLOW_IN_PUSH_ALIGNED);
    }

    struct linear_allocator_memory_slice result;
    result.memory = (char*) self->memory + offset;
    result.size = size;
    result.offset = offset;

    self->fill += size + offset;
    self->memory = (char*) self->memory + size + offset;

    return result;
}

void linear_allocator__pop(struct linear_allocator* self, struct linear_allocator_memory_slice memory_slice) {
    if (memory_slice.size + memory_slice.offset > self->fill) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_UNDERFLOW_IN_POP);
    }

    self->fill -= memory_slice.size + memory_slice.offset;
    self->memory = (char*) self->memory - memory_slice.size;
    if (memory_slice.memory != self->memory) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_UNEXPECTED_MEMORY_ADDRESS_IN_POP);
    }
    self->memory = (char*) self->memory - memory_slice.offset;
}

u64 linear_allocator__available(struct linear_allocator* self) {
    ASSERT(self->fill <= self->size);
    return self->size - self->fill;
}

u64 linear_allocator__available_aligned(struct linear_allocator* self, u32 alignment) {
    if (is_pow_of_2__u32(alignment) == false) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_ALIGNMENT_NOT_POW_OF_2);
    }

    u64 modulo = ((u64) self->memory) & ((u64) alignment - 1);
    u64 offset = modulo != 0 ? (u64) alignment - modulo : 0;
    u64 total_size_left = linear_allocator__available(self);

    return total_size_left < offset ? 0 : total_size_left - offset;
}
