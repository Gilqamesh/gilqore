#include "allocator.h"
#include "chunk.h"

#include "memory/segment_allocator/segment_allocator.h"

#include "libc/libc.h"

static void fatal(const char* err, ...) {
    va_list ap;

    va_start(ap, err);
    libc__vprintf(err, ap);
    va_end(ap);

    error_code__exit(12345);
}

bool allocator__create(allocator_t* self, memory_slice_t memory) {
    self->memory = memory;

    if (!seg__init(self->memory)) {
        return false;
    }

    return true;
}

void allocator__destroy(allocator_t* self) {
    libc__memset(self, 0, sizeof(*self));
}

void* allocator__realloc(allocator_t* self, void* data, size_t old_size, size_t new_size) {
    if (new_size == 0) {
        ASSERT(old_size);
        seg__free(self->memory, seg__data_to_seg(data));

        // for now do not support this
        allocator__print(self);
        fatal("Error: could not allocate %u memory\n", new_size);

        return NULL;
    }
    
    seg_t seg = seg__realloc(self->memory, data, new_size);
    if (seg == NULL) {
        allocator__print(self);
        fatal("Error: could not allocate %u memory\n", new_size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void* allocator__alloc(allocator_t* self, size_t size) {
    seg_t seg = seg__malloc(self->memory, size);

    if (seg == NULL) {
        allocator__print(self);
        fatal("Error: could not allocate %u memory\n", size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void  allocator__free(allocator_t* self, void* data) {
    seg__free(self->memory, seg__data_to_seg(data));
}

void allocator__print(allocator_t* self) {
    libc__printf("--== Segments start ==--\n");
    seg__for_each(self->memory, &seg__print);
    libc__printf("--== Segments end   ==--\n");

    seg__print_aux(self->memory);
}
