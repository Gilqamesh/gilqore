#include "data_structures/stack/stack.h"
#include "libc/libc.h"
#include "memory/memory.h"
bool stack__create(
    struct stack* self,
    struct memory_slice memory_slice,
    u32 size_of_one_item
) {
    self->items = memory_slice__memory(&memory_slice);
    self->item_size = size_of_one_item;
    self->fill = 0;
    if (size_of_one_item == 0) {
        error_code__exit(STACK_ERROR_CODE_SIZE_OF_ONE_ITEM_IS_ZERO_IN_CREATE);
    }
    self->capacity = memory_slice__size(&memory_slice) / size_of_one_item;
    return true;
}
void stack__destroy(struct stack* self) {
    libc__memset(self, 0, sizeof(*self));
}
void* stack__push(struct stack* self) {
    if (self->fill >= self->capacity) {
        error_code__exit(STACK_ERROR_CODE_OVERFLOW_IN_PUSH);
    }
    return (void*) ((char*) self->items + self->item_size * self->fill++);
}
void* stack__pop(struct stack* self) {
    if (self->fill == 0) {
        error_code__exit(STACK_ERROR_CODE_UNDERFLOW_IN_POP);
    }
    return (void*) ((char*) self->items + self->item_size * --self->fill);
}
void* stack__at(struct stack* self, u32 index) {
    if (self->capacity <= index) {
        error_code__exit(STACK_ERROR_CODE_INDEX_OUT_OF_RANGE_IN_AT);
    }
    return (void*) ((char*) self->items + self->item_size * index);
}
u32 stack__available(struct stack* self) {
    ASSERT(self->fill <= self->capacity);
    return self->capacity - self->fill;
}
u32 stack__size(struct stack* self) {
    return self->fill;
}
u32 stack__capacity(struct stack* self) {
    return self->capacity;
}
