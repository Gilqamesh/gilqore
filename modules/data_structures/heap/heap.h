#ifndef HEAP_H
# define HEAP_H

# include "heap_defs.h"

# include "memory/memory.h"

typedef struct heap {
    void* items;
    u32 item_size;
    u32 capacity;
    u32 fill;
    s32 (*comparator)(const void*, const void*);
} heap_t;

PUBLIC_API bool heap__create(
    heap_t* self,
    memory_slice_t memory_slice,
    u32 size_of_one_item,
    u32 initial_number_of_items,
    s32 (*comparator)(const void*, const void*)
);

PUBLIC_API bool heap__push(heap_t* self, void* item);
PUBLIC_API void heap__pop(heap_t* self, void* item);
PUBLIC_API void heap__top(heap_t* self, void* item);

PUBLIC_API u32  heap__size(heap_t* self);
PUBLIC_API u32  heap__capacity(heap_t* self);

#endif // HEAP_H
