#include "test_framework/test_framework.h"

#include "data_structures/generic_array/generic_array.h"
#include "libc/libc.h"

struct item {
    char _[16];
};

int main() {
    u32 main_memory_size = KILOBYTES(2);
    void* main_memory = libc__malloc(main_memory_size);

    struct generic_array generic_array;
    TEST_FRAMEWORK_ASSERT(
        generic_array__create(
            &generic_array,
            main_memory,
            main_memory_size,
            sizeof(struct item)
        )
    );
    u32 expected_available = main_memory_size / sizeof(struct item);
    u32 expected_size = 0;
    u32 expected_capacity = expected_available;
    TEST_FRAMEWORK_ASSERT(generic_array__available(&generic_array) == expected_available);
    TEST_FRAMEWORK_ASSERT(generic_array__size(&generic_array) == expected_size);
    TEST_FRAMEWORK_ASSERT(generic_array__capacity(&generic_array) == expected_capacity);

    u32 number_of_pushes = expected_capacity;
    for (u32 push_index = 0; push_index < number_of_pushes; ++push_index) {
        struct item item;
        libc__memset(&item, push_index, sizeof(item));
        generic_array__push(&generic_array, &item);
        --expected_available;
        ++expected_size;

        TEST_FRAMEWORK_ASSERT(generic_array__available(&generic_array) == expected_available);
        TEST_FRAMEWORK_ASSERT(generic_array__size(&generic_array) == expected_size);
    }

    for (u32 at_index = 0; at_index < number_of_pushes; ++at_index) {
        struct item* item = generic_array__at(&generic_array, at_index);
        struct item expected;
        libc__memset(&expected, at_index, sizeof(expected));
        TEST_FRAMEWORK_ASSERT(libc__memcmp(&expected, item, sizeof(expected)) == 0);
    }

    for (s32 pop_index = number_of_pushes - 1; pop_index >= 0; --pop_index) {
        struct item* item = generic_array__pop(&generic_array);
        ++expected_available;
        --expected_size;

        TEST_FRAMEWORK_ASSERT(generic_array__available(&generic_array) == expected_available);
        TEST_FRAMEWORK_ASSERT(generic_array__size(&generic_array) == expected_size);

        struct item expected;
        libc__memset(&expected, pop_index, sizeof(expected));
        TEST_FRAMEWORK_ASSERT(libc__memcmp(&expected, item, sizeof(expected)) == 0);
    }

    generic_array__destroy(&generic_array);
    libc__free(main_memory);

    return 0;
}
