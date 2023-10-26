#include "data_structures/heap/heap.h"

#include "libc/libc.h"

static u32 heap__item_index(heap_t* self, void* item);
static void* heap__left_child(heap_t* self, void* item);
static void* heap__right_child(heap_t* self, void* item);
static void* heap__parent(heap_t* self, void* item);
static void* heap__item_at(heap_t* self, u32 index);
static void heap__swap_item(heap_t* self, void* item_a, void* item_b);
static void heap__sift_up(heap_t* self, void* item);
static void heap__sift_down(heap_t* self, void* item);

static u32 heap__item_index(heap_t* self, void* item) {
    ASSERT((char*)item >= (char*)self->items);
    const size_t item_diff = (char*)item - (char*)self->items;
    ASSERT(item_diff % self->item_size == 0);
    return (u32) (item_diff / self->item_size);
}

static void* heap__left_child(heap_t* self, void* item) {
    u32 index = (heap__item_index(self, item) << 1) + 1;
    if (index >= self->fill) {
        return NULL;
    }
    return heap__item_at(self, index);
}

static void* heap__right_child(heap_t* self, void* item) {
    u32 index = (heap__item_index(self, item) << 1) + 2;
    if (index >= self->fill) {
        return NULL;
    }
    return heap__item_at(self, index);
}

static void* heap__parent(heap_t* self, void* item) {
    u32 item_index = heap__item_index(self, item);
    if (item_index == 0) {
        return NULL;
    }
    return heap__item_at(self, (item_index - 1) >> 1);
}

static void* heap__item_at(heap_t* self, u32 index) {
    return (void*) ((char*)self->items + self->item_size * index);
}

static void heap__swap_item(heap_t* self, void* item_a, void* item_b) {
    u64 tmp = 0;
    u64 remaining_bytes = self->item_size;
    u64 offset = 0;
    while (remaining_bytes > 0) {
        u32 bytes_to_write = remaining_bytes < sizeof(tmp) ? remaining_bytes : sizeof(tmp);
        libc__memcpy(&tmp, (char*)item_a + offset, bytes_to_write);
        libc__memcpy((char*)item_a + offset, (char*)item_b + offset, bytes_to_write);
        libc__memcpy((char*)item_b + offset, &tmp, bytes_to_write);
        remaining_bytes -= bytes_to_write;
        offset += bytes_to_write;
    }
}

static void heap__sift_up(heap_t* self, void* item) {
    void* item_to_swap = item;
    void* parent_of_item = heap__parent(self, item_to_swap);
    while (parent_of_item && self->comparator(item_to_swap, parent_of_item) < 0) {
        heap__swap_item(self, item_to_swap, parent_of_item);
        item_to_swap = parent_of_item;
        parent_of_item = heap__parent(self, item_to_swap);
    }
}

static void heap__sift_down(heap_t* self, void* item) {
    while (true) {
        void* left_child = heap__left_child(self, item);
        void* right_child = heap__right_child(self, item);
        void* smallest = item;
        if (left_child && self->comparator(left_child, smallest) < 0) {
            smallest = left_child;
        }
        if (right_child && self->comparator(right_child, smallest) < 0) {
            smallest = right_child;
        }
        if (smallest != item) {
            heap__swap_item(self, item, smallest);
            item = smallest;
        } else {
            break ;
        }
    }
}

bool heap__create(
    heap_t* self,
    memory_slice_t memory_slice,
    u32 size_of_one_item,
    u32 initial_number_of_items,
    s32 (*comparator)(const void*, const void*)
) {
    self->items = memory_slice__memory(&memory_slice);
    self->item_size = size_of_one_item;
    self->comparator = comparator;
    if (size_of_one_item == 0) {
        // error_code__exit(HEAP_ERROR_CODE_SIZE_OF_ONE_ITEM_IS_ZERO_IN_CREATE);
        error_code__exit(423);
    }
    self->capacity = memory_slice__size(&memory_slice) / size_of_one_item;
    if (self->capacity < initial_number_of_items) {
        error_code__exit(424);
    }
    self->fill = initial_number_of_items;

    // heapify array
    for (u32 i = 0; i < self->fill; ++i) {
        heap__sift_up(self, heap__item_at(self, i));
    }

    return true;
}

bool heap__push(heap_t* self, void* item) {
    if (self->fill >= self->capacity) {
        // error_code__exit(HEAP_ERROR_CODE_OVERFLOW_IN_PUSH);
        error_code__exit(678);
    }

    // add to end -> then sift up while heap property isnt established
    void* dst = heap__item_at(self, self->fill);
    libc__memcpy(dst, item, self->item_size);
    ++self->fill;
    heap__sift_up(self, dst);

    return true;
}

void heap__pop(heap_t* self, void* item) {
    heap__top(self, item);

    if (--self->fill > 0) {
        libc__memcpy(self->items, heap__item_at(self, self->fill), self->item_size);
        heap__sift_down(self, self->items);
    }
}

void heap__top(heap_t* self, void* item) {
    if (self->fill == 0) {
        error_code__exit(978);
    }

    libc__memcpy(item, self->items, self->item_size);
}

u32 heap__size(heap_t* self) {
    return self->fill;
}

u32 heap__capacity(heap_t* self) {
    return self->capacity;
}
