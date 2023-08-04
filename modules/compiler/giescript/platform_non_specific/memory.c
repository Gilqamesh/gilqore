#include "memory.h"
#include "chunk.h"

#include "libc/libc.h"

void memory__create(memory_t* self, memory_slice_t memory) {
    self->memory = memory;
}

void memory__destroy(memory_t* self) {
    self->memory = memory_slice__create(0, 0);
}

void* memory__realloc(memory_t* self, void* data, u64 old_size, u64 new_size) {
    (void) self;
    (void) old_size;

    if (new_size == 0) {
        libc__free(data);
        return NULL;
    }

    void* result = libc__realloc(data, new_size);
    if (result == 0) {
        error_code__exit(21432);
    }
    
    return result;
}
