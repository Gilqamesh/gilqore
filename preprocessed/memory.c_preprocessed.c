#include "memory/memory.h"
struct memory_slice memory_slice__create(void* memory, u64 size) {
    struct memory_slice result;
    result.memory = memory;
    result.size = size;
    result.offset = 0;
    return result;
}
void* memory_slice__memory(struct memory_slice* self) {
    return self->memory;
}
u64 memory_slice__size(struct memory_slice* self) {
    return self->size;
}
