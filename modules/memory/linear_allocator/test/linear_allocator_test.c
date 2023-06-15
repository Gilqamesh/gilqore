#include "test_framework/test_framework.h"

#include "memory/linear_allocator/linear_allocator.h"
#include "libc/libc.h"
#include "math/random/random.h"

#if defined(TEST_FRAMEWORK_SHOULD_PRINT)
# undef TEST_FRAMEWORK_SHOULD_PRINT
#endif

void test_push(
    struct linear_allocator *allocator,
    void **item_container,
    void *expected_item,
    struct linear_allocator_memory_slice *memory_slices,
    u32 item_container_size,
    u32 item_size,
    u32 memory_slices_size,
    u64 available_size,
    u32 alignment,
    bool is_aligned
) {
    if (is_aligned) {
#if defined(TEST_FRAMEWORK_SHOULD_PRINT)
        libc__printf("Alignment: %u\n", alignment);
#endif
    }
    u32 number_of_pushes = 0;
    for (u32 push_index = 0; push_index < item_container_size; ++push_index) {
        u64 size_to_push = item_size;
        if (is_aligned) {
            u64 available_aligned = linear_allocator__available_aligned(allocator, alignment);
            if (size_to_push > available_aligned) {
                break ;
            }
        }
        TEST_FRAMEWORK_ASSERT(push_index < memory_slices_size);
        if (is_aligned) {
            memory_slices[push_index] = linear_allocator__push_aligned(allocator, size_to_push, alignment);
        } else {
            memory_slices[push_index] = linear_allocator__push(allocator, size_to_push);
        }
        ++number_of_pushes;
        item_container[push_index] = memory_slices[push_index].memory;
        if (is_aligned) {
            TEST_FRAMEWORK_ASSERT((u64) ((char*) item_container[push_index]) % alignment == 0);
        }
        libc__memset(item_container[push_index], push_index, 1);
        libc__memset((char*) item_container[push_index] + item_size - 1, push_index, 1);

        if (is_aligned) {
#if defined(TEST_FRAMEWORK_SHOULD_PRINT)
            libc__printf(
                "Memory slice's address: %lu, size: %lu, offset to align: %lu\n",
                (u64) memory_slices[push_index].memory, memory_slices[push_index].size, memory_slices[push_index].offset
            );
#endif
        }

        TEST_FRAMEWORK_ASSERT(memory_slices[push_index].size + memory_slices[push_index].offset <= available_size);
        available_size -= memory_slices[push_index].size + memory_slices[push_index].offset;
        TEST_FRAMEWORK_ASSERT(linear_allocator__available(allocator) == available_size);
    }
    if (is_aligned) {
#if defined(TEST_FRAMEWORK_SHOULD_PRINT)
        libc__printf("Number of pushes: %u\n", number_of_pushes);
#endif
    }

    for (u32 push_index = 0; push_index < number_of_pushes; ++push_index) {
        libc__memset(expected_item, push_index, 1);
        libc__memset((char*) expected_item + item_size - 1, push_index, 1);
        TEST_FRAMEWORK_ASSERT(*(char*) expected_item == *(char*) item_container[push_index]);
        TEST_FRAMEWORK_ASSERT(*((char*) expected_item + item_size - 1) == *((char*) item_container[push_index] + item_size - 1));
        // TEST_FRAMEWORK_ASSERT(libc__strncmp(expected_item, item_container[push_index], item_size) == 0);
    }

    for (s32 push_index = number_of_pushes - 1; push_index >= 0; --push_index) {
        TEST_FRAMEWORK_ASSERT((u32) push_index < memory_slices_size);
        u32 size_to_pop = memory_slices[push_index].size + memory_slices[push_index].offset;
        linear_allocator__pop(allocator, memory_slices[push_index]);
        available_size += size_to_pop;
        TEST_FRAMEWORK_ASSERT(linear_allocator__available(allocator) == available_size);
    }
}

struct test_data {
    struct linear_allocator allocator;
    struct linear_allocator_memory_slice* memory_slices;
    struct linear_allocator_memory_slice memory_slices_memory_slice;
    u32 memory_slices_size;
    void** item_container;
    struct linear_allocator_memory_slice item_container_memory_slice;
    u32 item_container_size;
    void* aux_item;
    struct linear_allocator_memory_slice aux_item_memory_slice;
    u32 item_size;

    void* memory;
    struct linear_allocator_memory_slice memory_memory_slice;
};

struct test_data test_data__create(
    u64 memory_size,
    u32 item_size,
    struct linear_allocator* main_allocator
) {
    struct test_data test_data;

    test_data.memory_memory_slice = linear_allocator__push(main_allocator, memory_size);
    TEST_FRAMEWORK_ASSERT(test_data.memory_memory_slice.size == memory_size);
    test_data.memory = test_data.memory_memory_slice.memory;

    TEST_FRAMEWORK_ASSERT(linear_allocator__create(&test_data.allocator, test_data.memory, memory_size));
    TEST_FRAMEWORK_ASSERT(linear_allocator__available(&test_data.allocator) == memory_size);

    test_data.aux_item_memory_slice = linear_allocator__push(main_allocator, item_size);
    TEST_FRAMEWORK_ASSERT(test_data.aux_item_memory_slice.size == item_size);
    test_data.aux_item = test_data.aux_item_memory_slice.memory;
    test_data.item_size = item_size;

    test_data.item_container_size = memory_size / test_data.item_size;
    // u64 item_container__total_size = test_data.item_container_size * test_data.item_size;
    u64 item_container__total_size = test_data.item_container_size * sizeof(*test_data.item_container);
    test_data.item_container_memory_slice = linear_allocator__push(main_allocator, item_container__total_size);
    TEST_FRAMEWORK_ASSERT(test_data.item_container_memory_slice.size == item_container__total_size);
    test_data.item_container = test_data.item_container_memory_slice.memory;

    test_data.memory_slices_size = test_data.item_container_size;
    u64 memory_slices_total_size = test_data.memory_slices_size * sizeof(*test_data.memory_slices);
    test_data.memory_slices_memory_slice = linear_allocator__push(main_allocator, memory_slices_total_size);
    TEST_FRAMEWORK_ASSERT(test_data.memory_slices_memory_slice.size == memory_slices_total_size);
    test_data.memory_slices = test_data.memory_slices_memory_slice.memory;

    return test_data;
}

void test_data__destroy(
    struct test_data* self,
    struct linear_allocator* main_allocator
) {
    linear_allocator__pop(main_allocator, self->memory_slices_memory_slice);
    linear_allocator__pop(main_allocator, self->item_container_memory_slice);
    linear_allocator__pop(main_allocator, self->aux_item_memory_slice);
    linear_allocator__pop(main_allocator, self->memory_memory_slice);

    linear_allocator__destroy(&self->allocator);
}

void test_data__params(
    u64 memory_size,
    u32 item_size,
    struct linear_allocator* main_allocator
) {
    struct test_data test_data = test_data__create(memory_size, item_size, main_allocator);

    test_push(
        &test_data.allocator,
        (void**) test_data.item_container,
        test_data.aux_item,
        test_data.memory_slices,
        test_data.item_container_size,
        test_data.item_size,
        test_data.memory_slices_size,
        linear_allocator__available(&test_data.allocator),
        0,
        false
    );

    for (u32 two_exponent = 0; two_exponent <= 10; ++two_exponent) {
        u32 alignment = 1 << two_exponent;
        if (alignment == 0) {
            break ;
        }
        test_push(
            &test_data.allocator,
            (void**) test_data.item_container,
            test_data.aux_item,
            test_data.memory_slices,
            test_data.item_container_size,
            test_data.item_size,
            test_data.memory_slices_size,
            linear_allocator__available(&test_data.allocator),
            alignment,
            true
        );
    }

    test_data__destroy(&test_data, main_allocator);
}

u32 test_data__main(
    u64 seed,
    u64 max_memory_size,
    u32 max_item_size,
    struct linear_allocator* main_allocator
) {
    u32 test_runs = 0;

    struct random randomizer;
    random__init(&randomizer, seed);

    u32 item_size = 1;
    while (item_size <= max_item_size) {
        u64 memory_size = 1;
        while (memory_size <= max_memory_size) {
            test_data__params(memory_size, item_size, main_allocator);
            ++test_runs;

            const u64 min_memory_size_delta = 150;
            const u64 max_memory_size_delta = KILOBYTES(1);
            u64 memory_size_delta = random__u64_closed(&randomizer, min_memory_size_delta, max_memory_size_delta);
            memory_size += memory_size_delta;
        }

        const u32 min_item_size_delta = 1;
        const u64 max_item_size_delta = 10;
        u32 item_size_delta = random__u32_closed(&randomizer, min_item_size_delta, max_item_size_delta);
        item_size += item_size_delta;
    }

    return test_runs;
}

u32 test_evaluate_subresult(
    u64 seed,
    u64 max_memory_size,
    u32 max_item_size,
    struct linear_allocator* main_allocator
) {
    // libc__printf("seed: %-10u\tmax memory size: %-6lu\tmax item size: %-3u\n", seed, max_memory_size, max_item_size);
    u32 test_runs = test_data__main(seed, max_memory_size, max_item_size, main_allocator);
    // libc__printf("number of test runs: %u\n", test_runs);

    return test_runs;
}

int main() {
    struct random randomizer;
    random__init(&randomizer, 42);

    const u64 min_memory_size = 1;
    const u64 max_memory_size = KILOBYTES(23);
    const u32 min_item_size = 1;
    const u32 max_item_size = BYTES(178);

    u64 aux_memory = MEGABYTES(256);
    u64 main_memory_size = aux_memory + max_memory_size;
    void* main_memory = libc__malloc(main_memory_size);
    struct linear_allocator main_allocator;
    linear_allocator__create(&main_allocator,  main_memory, main_memory_size);

    u32 total_test_runs = 0;

    const u32 number_of_min_tests = 10;
    for (u32 test_batch_index = 0; test_batch_index < number_of_min_tests; ++test_batch_index) {
        u64 random_seed = random__u64(&randomizer);

        total_test_runs += test_evaluate_subresult(random_seed, 1, 1, &main_allocator);
    }

    // todo: revisit with thread api
    const u32 number_of_test_batches = 10;
    for (u32 test_batch_index = 0; test_batch_index < number_of_test_batches; ++test_batch_index) {
        u64 random_seed = random__u64(&randomizer);
        u64 memory_size = random__u64_closed(&randomizer, min_memory_size, max_memory_size);
        u32 item_size = random__u32_closed(&randomizer, min_item_size, max_item_size);

        total_test_runs += test_evaluate_subresult(random_seed, memory_size, item_size, &main_allocator);
    }

    libc__printf("total test runs: %u\n", total_test_runs);

    linear_allocator__destroy(&main_allocator);
    libc__free(main_memory);

    return 0;
}
