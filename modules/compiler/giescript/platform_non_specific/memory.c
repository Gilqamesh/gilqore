#include "memory.h"
#include "chunk.h"
#include "segment.h"

#include "libc/libc.h"

bool memory__create(memory_t* self, memory_slice_t memory) {
    self->main_memory = memory;

    self->first_free_segment = seg__init(memory_slice__memory(&self->main_memory), memory_slice__size(&self->main_memory));

    return true;
}

void memory__destroy(memory_t* self) {
    libc__memset(self, 0, sizeof(*self));
}

void* memory__realloc(memory_t* self, void* data, u64 old_size, u64 new_size) {
    if (new_size == 0) {
        ASSERT(old_size);
        seg__free(self->main_memory, &self->first_free_segment, seg__data_to_seg(data));
        return NULL;
    }
    seg_t seg = seg__realloc(self->main_memory, &self->first_free_segment, data, new_size);
    void* result = seg__seg_to_data(seg);
    if (result == NULL) {
        error_code__exit(21432);
    }

    return result;
}
