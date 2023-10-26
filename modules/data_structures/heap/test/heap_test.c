#include "test_framework/test_framework.h"

#include "data_structures/heap/heap.h"

s32 items_comparator(const void* item_a, const void* item_b) {
    return *(const int*)item_a < *(const int*)item_b ? -1 : (*(const int*)item_a == *(const int*)item_b ? 0 : 1);
}

static void print_items(int* items, u32 items_size) {
    for (u32 i = 0; i < items_size; ++i) {
        libc__printf("%d ", items[i]);
    }
    libc__printf("\n");
}

int main() {
    int items[] = {
        5, 4, -3, 16, 33, 2, 9, 6, 7, 78, 92, -98
    };
    int items2[] = {
        -65, 73, -8, 0, 7, -35
    };

    heap_t heap;
    TEST_FRAMEWORK_ASSERT(heap__create(&heap, memory_slice__create(items, sizeof(items)), sizeof(items[0]), ARRAY_SIZE(items), &items_comparator));

    print_items(items, ARRAY_SIZE(items));
    while (heap__size(&heap) > 0) {
        int item;
        heap__pop(&heap, &item);
        print_items(items, heap__size(&heap));
        libc__printf("Popped item: %d\n", item);
    }
    for (u32 i = 0; i < ARRAY_SIZE(items2); ++i) {
        heap__push(&heap, &items2[i]);
        print_items(items, heap__size(&heap));
    }
    while (heap__size(&heap) > 0) {
        int item;
        heap__pop(&heap, &item);
        print_items(items, heap__size(&heap));
        libc__printf("Popped item: %d\n", item);
    }

    return 0;
}
