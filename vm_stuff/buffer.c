#include "buffer.h"

#include <stdlib.h>

bool buffer__create(buffer_t* self, uint32_t size) {
    self->start = malloc(size);
    if (!self->start) {
        return false;
    }

    self->cur = self->start;
    self->end = self->start + size;

    return true;
}

void buffer__destroy(buffer_t* self) {
    free(self->start);
}

bool aligned_buffer__create(aligned_buffer_t* self, uint32_t size, uint32_t max_number_of_elements) {
    if (!buffer__create(&self->buffer, size)) {
        return false;
    }

    self->offset_start = malloc(max_number_of_elements * sizeof(*self->offset_start));
    self->offset_cur = self->offset_start;
    self->offset_end = self->offset_start + max_number_of_elements;

    self->addr_start = malloc(max_number_of_elements * sizeof(*self->addr_start));
    self->addr_cur = self->addr_start;
    self->addr_end = self->addr_start + max_number_of_elements;

    return true;
}

void aligned_buffer__destroy(aligned_buffer_t* self) {
    buffer__destroy(&self->buffer);
}
