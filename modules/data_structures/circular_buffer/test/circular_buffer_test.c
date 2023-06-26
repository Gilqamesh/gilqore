#include "test_framework/test_framework.h"

#include "data_structures/circular_buffer/circular_buffer.h"
#include "libc/libc.h"
#include "gil_math/random/random.h"
#include "gil_math/mod/mod.h"

struct circular_buffer_context {
    struct memory_slice circular_buffer_memory;
    struct memory_slice auxiliary_memory;
    struct memory_slice expected_memory;
    struct circular_buffer circular_buffer;
};

void test_filled_circular_buffer(struct circular_buffer_context* circular_buffer_context) {
    void* expected_array = memory_slice__memory(&circular_buffer_context->expected_memory);
    void* auxiliary_array = memory_slice__memory(&circular_buffer_context->auxiliary_memory);
    struct circular_buffer* circular_buffer = &circular_buffer_context->circular_buffer;
    const s32 circular_buffer_total_size = circular_buffer__size_total(circular_buffer);
    const u32 circular_buffer_item_size = circular_buffer__size_item(circular_buffer);
    s32 circular_buffer_cur_size = circular_buffer__size_current(circular_buffer);
    s32 advance_by_total = 0;
    for (s32 i = 0; i < circular_buffer_total_size * 1000; ++i) {
        s32 advance_by = 1;
        circular_buffer__pop(circular_buffer, auxiliary_array);
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        u32 item_index = advance_by_total % circular_buffer_total_size;
        TEST_FRAMEWORK_ASSERT(
            libc__memcmp(
                (char*) expected_array + item_index * circular_buffer_item_size,
                auxiliary_array,
                circular_buffer_item_size
            ) == 0
        );
        TEST_FRAMEWORK_ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;

        circular_buffer__advance_head(circular_buffer, 0);
        circular_buffer__advance_tail(circular_buffer, 0);

        advance_by = i % circular_buffer_total_size;
        circular_buffer__pop_multiple(circular_buffer, auxiliary_array, advance_by);
        for (s32 j = 0; j < advance_by; ++j) {
            TEST_FRAMEWORK_ASSERT(
                libc__memcmp(
                    (char*) expected_array + ((advance_by_total + j) % circular_buffer_total_size) * circular_buffer_item_size,
                    (char*) auxiliary_array + j * circular_buffer_item_size,
                    circular_buffer_item_size
                ) == 0
            );
        }
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        TEST_FRAMEWORK_ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;

        advance_by = i;
        circular_buffer__advance_tail(circular_buffer, advance_by);
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        TEST_FRAMEWORK_ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;
    }
}

void clear_circular_buffer(struct circular_buffer* circular_buffer) {
    circular_buffer__clear(circular_buffer);
    libc__memset(
        circular_buffer__begin(circular_buffer),
        0,
        circular_buffer__size_item(circular_buffer) * circular_buffer__size_total(circular_buffer)
    );
}

static struct circular_buffer_context create_circular_buffer_context(
    u32 item_size,
    u32 number_of_items
) {
    struct circular_buffer_context result;

    u32 circular_buffer_memory_size = item_size * number_of_items;
    void* circular_buffer_memory = libc__malloc(circular_buffer_memory_size);
    result.circular_buffer_memory = memory_slice__create(circular_buffer_memory, circular_buffer_memory_size);

    void* auxiliary_memory = libc__malloc(circular_buffer_memory_size);
    result.auxiliary_memory = memory_slice__create(auxiliary_memory, circular_buffer_memory_size);
    
    void* expected_memory = libc__malloc(circular_buffer_memory_size);
    result.expected_memory = memory_slice__create(expected_memory, circular_buffer_memory_size);

    TEST_FRAMEWORK_ASSERT(
        circular_buffer__create(
            &result.circular_buffer,
            result.circular_buffer_memory,
            item_size, number_of_items
        )
    );
    TEST_FRAMEWORK_ASSERT(circular_buffer__size_current(&result.circular_buffer) == 0);
    TEST_FRAMEWORK_ASSERT(circular_buffer__size_item(&result.circular_buffer) == item_size);
    TEST_FRAMEWORK_ASSERT(circular_buffer__size_total(&result.circular_buffer) == number_of_items);

    return result;
}

static void destroy_circular_buffer_context(struct circular_buffer_context* context) {
    circular_buffer__destroy(&context->circular_buffer);
    libc__free(memory_slice__memory(&context->circular_buffer_memory));
    libc__free(memory_slice__memory(&context->auxiliary_memory));
    libc__free(memory_slice__memory(&context->expected_memory));
}

static void test_main(
    u32 item_size,
    u32 number_of_items,
    u64 seed
) {

    struct random randomizer;
    random__init(&randomizer, seed);

    struct circular_buffer_context circular_buffer_context = create_circular_buffer_context(item_size, number_of_items);

    for (u32 i = 0; i < circular_buffer__size_total(&circular_buffer_context.circular_buffer); ++i) {
        void* item = (char*) memory_slice__memory(&circular_buffer_context.expected_memory) + i * item_size;
        libc__memset(item, i, item_size);
        for (u32 byte_offset = 0; byte_offset < item_size; ++byte_offset) {
            u64 random_number = random__u64(&randomizer);
            *((char*) item + byte_offset) = (char) random_number;
        }

        circular_buffer__push(&circular_buffer_context.circular_buffer, item);
        TEST_FRAMEWORK_ASSERT(circular_buffer__size_current(&circular_buffer_context.circular_buffer) == i + 1);
    }

    test_filled_circular_buffer(&circular_buffer_context);

    ASSERT(memory_slice__size(&circular_buffer_context.auxiliary_memory) == memory_slice__size(&circular_buffer_context.expected_memory));
    libc__memcpy(
        memory_slice__memory(&circular_buffer_context.auxiliary_memory),
        memory_slice__memory(&circular_buffer_context.expected_memory),
        memory_slice__size(&circular_buffer_context.auxiliary_memory)
    );

    clear_circular_buffer(&circular_buffer_context.circular_buffer);

    circular_buffer__push_multiple(
        &circular_buffer_context.circular_buffer,
        memory_slice__memory(&circular_buffer_context.auxiliary_memory),
        circular_buffer__size_total(&circular_buffer_context.circular_buffer)
    );

    test_filled_circular_buffer(&circular_buffer_context);

    destroy_circular_buffer_context(&circular_buffer_context);
}

int main() {
    struct random randomizer;
    random__init(&randomizer, 42);

    const u32 max_number_of_tests = 16;
    const u32 min_number_of_items = 1;
    const u32 max_number_of_items = 128;
    const u32 min_item_size = 1;
    const u32 max_item_size = 65;
    for (u32 test_counter = 0; test_counter < max_number_of_tests; ++test_counter) {
        u32 item_size = random__u32_closed(&randomizer, min_item_size, max_item_size);
        u32 number_of_items = random__u32_closed(&randomizer, min_number_of_items, max_number_of_items);
        u64 random_seed = random__u64(&randomizer);
        test_main(item_size, number_of_items, random_seed);
    }

    return 0;
}
