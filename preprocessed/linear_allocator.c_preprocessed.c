#include "memory/linear_allocator/linear_allocator.h"
#include "libc/libc.h"
#include "gil_math/gil_math.h"
#include "gil_math/compare/compare.h"
bool linear_allocator__create(struct linear_allocator* self, struct memory_slice memory_slice) {
    self->memory_slice = memory_slice;
    self->fill = 0;
    return true;
}
void linear_allocator__destroy(struct linear_allocator* self) {
    libc__memset(self, 0, sizeof(*self));
}
struct memory_slice linear_allocator__push(struct linear_allocator* self, u64 size) {
    if (size > linear_allocator__available(self)) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_OVERFLOW_IN_PUSH);
    }
    struct memory_slice result;
    result.memory = memory_slice__memory(&self->memory_slice);
    result.size = size;
    result.offset = 0;
    self->fill += size;
    self->memory_slice =
    memory_slice__create(
        (char*) memory_slice__memory(&self->memory_slice) + size,
        memory_slice__size(&self->memory_slice)
    );
    return result;
}
struct memory_slice linear_allocator__push_aligned(struct linear_allocator* self, u64 size, u32 alignment) {
    if (is_pow_of_2__u32(alignment) == false) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_ALIGNMENT_NOT_POW_OF_2);
    }
    u64 modulo = ((u64) memory_slice__memory(&self->memory_slice)) & ((u64) (alignment - 1));
    u64 offset = modulo != 0 ? (u64) alignment - modulo : 0;
    if (size + offset > linear_allocator__available(self)) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_OVERFLOW_IN_PUSH_ALIGNED);
    }
    struct memory_slice result = 
    memory_slice__create(
        (char*) memory_slice__memory(&self->memory_slice) + offset,
        size
    );
    result.offset = offset;
    self->fill += size + offset;
    self->memory_slice =
    memory_slice__create(
        (char*) memory_slice__memory(&self->memory_slice) + size + offset,
        memory_slice__size(&self->memory_slice)
    );
    return result;
}
void linear_allocator__pop(struct linear_allocator* self, struct memory_slice memory_slice) {
    u64 memory_slice_size = memory_slice__size(&memory_slice);
    if (memory_slice_size + memory_slice.offset > self->fill) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_UNDERFLOW_IN_POP);
    }
    self->fill -= memory_slice_size + memory_slice.offset;
    self->memory_slice =
    memory_slice__create(
        (char*) memory_slice__memory(&self->memory_slice) - memory_slice_size,
        memory_slice__size(&self->memory_slice)
    );
    if (memory_slice__memory(&memory_slice) != memory_slice__memory(&self->memory_slice)) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_UNEXPECTED_MEMORY_ADDRESS_IN_POP);
    }
    self->memory_slice =
    memory_slice__create(
        (char*) memory_slice__memory(&self->memory_slice) - memory_slice.offset,
        memory_slice__size(&self->memory_slice)
    );
}
u64 linear_allocator__available(struct linear_allocator* self) {
    ASSERT(self->fill <= memory_slice__size(&self->memory_slice));
    return memory_slice__size(&self->memory_slice) - self->fill;
}
u64 linear_allocator__available_aligned(struct linear_allocator* self, u32 alignment) {
    if (is_pow_of_2__u32(alignment) == false) {
        error_code__exit(LINEAR_ALLOCATOR_ERROR_CODE_ALIGNMENT_NOT_POW_OF_2);
    }
    u64 modulo = ((u64) memory_slice__memory(&self->memory_slice)) & ((u64) alignment - 1);
    u64 offset = modulo != 0 ? (u64) alignment - modulo : 0;
    u64 total_size_left = linear_allocator__available(self);
    return total_size_left < offset ? 0 : total_size_left - offset;
}
