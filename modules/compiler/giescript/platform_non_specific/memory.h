#ifndef GIES_MEMORY_H
# define GIES_MEMORY_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

# include "memory/memory.h"

# define GROW_CAPACITY(capacity) ((capacity) < 8 ? 8 : (capacity) * 2)
# define GROW_ARRAY(assign, memory, type, data, old_size, new_size) { \
    assign = (type*) memory__realloc(memory, data, old_size * sizeof(type), new_size * sizeof(type)); \
    memory__print(memory); \
}
# define FREE_ARRAY(memory, type, data, size) \
    memory__free(memory, data);

struct memory {
    memory_slice_t   main_memory;
};

bool  memory__create(memory_t* self, memory_slice_t memory);
void  memory__destroy(memory_t* self);

void* memory__realloc(memory_t* self, void* data, size_t old_size, size_t new_size);
void* memory__malloc(memory_t* self, size_t size);
void  memory__free(memory_t* self, void* data);

void  memory__print(memory_t* self);

#endif // GIES_MEMORY_H
