#include "memory.h"
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

bool memory__create(memory_t* self, memory_slice_t memory) {
    self->main_memory = memory;

    if (!seg__init(self->main_memory)) {
        return false;
    }

    return true;
}

void memory__destroy(memory_t* self) {
    libc__memset(self, 0, sizeof(*self));
}

void* memory__realloc(memory_t* self, void* data, size_t old_size, size_t new_size) {
    if (new_size == 0) {
        ASSERT(old_size);
        seg__free(self->main_memory, seg__data_to_seg(data));

        // for now do not support this
        memory__print(self);
        fatal("Error: could not allocate %u memory\n", new_size);

        return NULL;
    }
    
    seg_t seg = seg__realloc(self->main_memory, data, new_size);
    if (seg == NULL) {
        memory__print(self);
        fatal("Error: could not allocate %u memory\n", new_size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void* memory__malloc(memory_t* self, size_t size) {
    seg_t seg = seg__malloc(self->main_memory, size);

    if (seg == NULL) {
        memory__print(self);
        fatal("Error: could not allocate %u memory\n", size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void  memory__free(memory_t* self, void* data) {
    seg__free(self->main_memory, seg__data_to_seg(data));
}

void memory__print(memory_t* self) {
    libc__printf("--== Segments start ==--\n");
    seg__for_each(self->main_memory, &seg__print);
    libc__printf("--== Segments end   ==--\n");

    seg__print_aux(self->main_memory);
}
