#include "data_structures/generic_array/generic_array.h"

#include "libc/libc.h"

bool generic_array__create(
    struct generic_array* self,
    void* memory,
    u64 memory_size,
    u32 size_of_one_item
) {
    self->items = memory;
    self->item_size = size_of_one_item;
    self->fill = 0;
    if (size_of_one_item == 0) {
        error_code__exit(GENERIC_ARRAY_ERROR_CODE_SIZE_OF_ONE_ITEM_IS_ZERO_IN_CREATE);
    }
    self->capacity = memory_size / size_of_one_item;

    return true;
}

void generic_array__destroy(struct generic_array* self) {
    libc__memset(self, 0, sizeof(*self));
}

void* generic_array__push(struct generic_array* self) {
    if (self->fill >= self->capacity) {
        error_code__exit(GENERIC_ARRAY_ERROR_CODE_OVERFLOW_IN_PUSH);
    }

    return (void*) ((char*) self->items + self->item_size * self->fill++);
}

void* generic_array__pop(struct generic_array* self) {
    if (self->fill == 0) {
        error_code__exit(GENERIC_ARRAY_ERROR_CODE_UNDERFLOW_IN_POP);
    }

    return (void*) ((char*) self->items + self->item_size * --self->fill);
}

void* generic_array__at(struct generic_array* self, u32 index) {
    if (self->capacity <= index) {
        error_code__exit(GENERIC_ARRAY_ERROR_CODE_INDEX_OUT_OF_RANGE_IN_AT);
    }

    return (void*) ((char*) self->items + self->item_size * index);
}

u32 generic_array__available(struct generic_array* self) {
    ASSERT(self->fill <= self->capacity);
    return self->capacity - self->fill;
}

u32 generic_array__size(struct generic_array* self) {
    return self->fill;
}

u32 generic_array__capacity(struct generic_array* self) {
    return self->capacity;
}
