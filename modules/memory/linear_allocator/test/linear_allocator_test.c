#include "test_framework/test_framework.h"

#include "memory/linear_allocator/linear_allocator.h"
#include "libc/libc.h"

struct test_struct_64 {
    char _[64];
};

int main() {
    u64 memory_size = KILOBYTES(2);
    void* memory = libc__malloc(memory_size);

    struct linear_allocator allocator;
    TEST_FRAMEWORK_ASSERT(linear_allocator__create(&allocator, memory, memory_size));
    u64 available_size = memory_size;
    TEST_FRAMEWORK_ASSERT(linear_allocator__available(&allocator) == available_size);

    TEST_FRAMEWORK_ASSERT(memory_size % sizeof(struct test_struct_64) == 0);
    u32 test_struct_64_container_size = memory_size / sizeof(struct test_struct_64);
    struct test_struct_64** test_struct_64_container = libc__malloc(test_struct_64_container_size * sizeof(*test_struct_64_container));
    struct linear_allocator_memory_slice* memory_slices = libc__malloc(test_struct_64_container_size * sizeof(*memory_slices));
    for (u32 push_index = 0; push_index < test_struct_64_container_size; ++push_index) {
        u64 size_to_push = sizeof(*(test_struct_64_container[push_index]));
        memory_slices[push_index] = linear_allocator__push(&allocator, size_to_push);
        test_struct_64_container[push_index] = (struct test_struct_64*) memory_slices[push_index].memory;
        libc__memset(test_struct_64_container[push_index]->_, push_index, ARRAY_SIZE(test_struct_64_container[push_index]->_));

        TEST_FRAMEWORK_ASSERT(size_to_push <= available_size);
        available_size -= size_to_push;
        TEST_FRAMEWORK_ASSERT(linear_allocator__available(&allocator) == available_size);
    }

    struct test_struct_64 expected;
    for (u32 push_index = 0; push_index < test_struct_64_container_size; ++push_index) {
        libc__memset(expected._, push_index, ARRAY_SIZE(expected._));
        TEST_FRAMEWORK_ASSERT(libc__strncmp(expected._, test_struct_64_container[push_index]->_, ARRAY_SIZE(expected._)) == 0);
    }

    for (s32 push_index = test_struct_64_container_size - 1; push_index >= 0; --push_index) {
        u32 size_to_pop = memory_slices[push_index].size;
        linear_allocator__pop(&allocator, memory_slices[push_index]);
        available_size += size_to_pop;
        TEST_FRAMEWORK_ASSERT(linear_allocator__available(&allocator) == available_size);
    }

    // ALIGNMENT
    u32 alignment = 1;
    TEST_FRAMEWORK_ASSERT(linear_allocator__available_aligned(&allocator, alignment) == available_size);
    for (u32 push_index = 0; push_index < test_struct_64_container_size; ++push_index) {
        u64 size_to_push = sizeof(*(test_struct_64_container[push_index]));
        memory_slices[push_index] = linear_allocator__push_aligned(&allocator, size_to_push, alignment);
        test_struct_64_container[push_index] = (struct test_struct_64*) memory_slices[push_index].memory;
        TEST_FRAMEWORK_ASSERT((u64) test_struct_64_container[push_index] % alignment == 0);
        libc__memset(test_struct_64_container[push_index]->_, push_index, ARRAY_SIZE(test_struct_64_container[push_index]->_));

        TEST_FRAMEWORK_ASSERT(size_to_push <= available_size);
        available_size -= size_to_push;
        TEST_FRAMEWORK_ASSERT(linear_allocator__available_aligned(&allocator, alignment) == available_size);
    }

    libc__free(test_struct_64_container);
    libc__free(memory_slices);

    linear_allocator__destroy(&allocator);

    libc__free(memory);

    return 0;
}
