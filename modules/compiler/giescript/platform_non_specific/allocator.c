#include "allocator.h"
#include "chunk.h"

#include "memory/segment_allocator/segment_allocator.h"

#include "libc/libc.h"

static void fatal(const char* err, ...) {
    va_list ap;

    libc__printf("Error: ");

    va_start(ap, err);
    libc__vprintf(err, ap);
    va_end(ap);

    libc__printf("\n");

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
        ASSERTF(old_size, "new_size == 0 && old_size == 0 is not allowed in allocator__realloc");
        allocator__free(self, data);
        return NULL;
    }

#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== BEFORE allocator__realloc ==--\n");
    allocator__print(self);
#endif

    seg_t seg = seg__realloc(self->memory, data, new_size);

#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== AFTER allocator__realloc ==--\n");
    allocator__print(self);
#endif

    if (seg == NULL) {
        allocator__print(self);
        fatal("could not allocate %u memory", new_size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void* allocator__alloc(allocator_t* self, size_t size) {
#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== BEFORE allocator__alloc ==--\n");
    allocator__print(self);
#endif

    seg_t seg = seg__malloc(self->memory, size);

#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== AFTER allocator__alloc ==--\n");
    allocator__print(self);
#endif

    if (seg == NULL) {
        fatal("could not allocate %u memory", size);
        return NULL;
    }

    return seg__seg_to_data(seg);
}

void  allocator__free(allocator_t* self, void* data) {
#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== BEFORE allocator__free ==--\n");
    allocator__print(self);
#endif

    seg__free(self->memory, seg__data_to_seg(data));

#if defined(DEBUG_ALLOCATOR_TRACE)
    libc__printf("--== AFTER allocator__free ==--\n");
    allocator__print(self);
#endif
}

void allocator__print(allocator_t* self) {
    libc__printf("--== Segments start ==--\n");
    seg__for_each(self->memory, &seg__print);
    libc__printf("--== Segments end   ==--\n");

    seg__print_aux(self->memory);
}
