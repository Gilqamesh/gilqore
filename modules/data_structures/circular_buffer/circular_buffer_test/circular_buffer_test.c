#include <stdio.h>

#include "data_structures/circular_buffer/circular_buffer.h"
#include "libc/libc.h"
#include "math/random/random.h"
#include "math/mod/mod.h"

void test_filled_circular_buffer(
    circular_buffer_t circular_buffer,
    void* auxiliary_array,
    bool (*confirm_element_at_index)(const void* element, s32 i)) {
    const s32 circular_buffer_total_size = circular_buffer__size_total(circular_buffer);
    const u32 circular_buffer_item_size = circular_buffer__size_item(circular_buffer);
    s32 circular_buffer_cur_size = circular_buffer__size_current(circular_buffer);
    s32 advance_by_total = 0;
    for (s32 i = 0; i < circular_buffer_total_size * 1000; ++i) {
        s32 advance_by = 1;
        circular_buffer__pop(circular_buffer, auxiliary_array);
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        ASSERT(confirm_element_at_index(auxiliary_array, advance_by_total % circular_buffer_total_size));
        ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;

        circular_buffer__advance_head(circular_buffer, 0);
        circular_buffer__advance_tail(circular_buffer, 0);

        advance_by = i % circular_buffer_total_size;
        circular_buffer__pop_multiple(circular_buffer, auxiliary_array, advance_by);
        for (s32 j = 0; j < advance_by; ++j) {
            ASSERT(
                confirm_element_at_index(
                    (void*) ((u8*) auxiliary_array + (u32) j * circular_buffer_item_size),
                    (advance_by_total + j) % circular_buffer_total_size
                )
            );
        }
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;

        advance_by = i;
        circular_buffer__advance_tail(circular_buffer, advance_by);
        circular_buffer_cur_size = mod__u32(circular_buffer_cur_size - advance_by, circular_buffer_total_size);
        ASSERT(circular_buffer__size_current(circular_buffer) == (u32) circular_buffer_cur_size);
        advance_by_total = (advance_by_total + advance_by) % circular_buffer_total_size;
    }
}

bool confirm_element_at_index_s32(const void* element, s32 i) {
    return *(s32*) element == i;
}

bool confirm_element_at_index_r64(const void* element, s32 i) {
    r64 r = 1.3 + (r64) i;
    return *(r64*) element == r;
}

struct test_type {
    s8   a;
    u32  b;
    u16  c;
    struct {
        void*  _;
        s8     __;
    }    d;
    r32  e;
};

bool confirm_element_at_index_test_type(const void* element, s32 i) {
    struct test_type* item = (struct test_type*) element;

    struct test_type v = {
        - (s8) i,
        2 * (u32) i,
        3 * (u16) i, {
            (void*) (u64) i,
            -5 * (s8) i
        },
        2.4f * (r32) i
    };

    return
    item->a == v.a &&
    item->b == v.b &&
    item->c == v.c &&
    item->d._ == v.d._ &&
    item->d.__ == v.d.__ &&
    item->e == v.e;
}

void clear_circular_buffer(circular_buffer_t circular_buffer) {
    circular_buffer__clear(circular_buffer);
    libc__memset(
        circular_buffer__begin(circular_buffer),
        0,
        circular_buffer__size_item(circular_buffer) * circular_buffer__size_total(circular_buffer)
    );
}

#define CIRCULAR_BUFFER_S32_SIZE ((s32) 37)
#define CIRCULAR_BUFFER_R64_SIZE ((s32) 1)
#define CIRCULAR_BUFFER_TEST_TYPE_SIZE ((s32) 117)

int main() {
    s32 auxiliary_array_s32[CIRCULAR_BUFFER_S32_SIZE];
    r64 auxiliary_array_r64[CIRCULAR_BUFFER_R64_SIZE];
    struct test_type auxiliary_array_test_type[CIRCULAR_BUFFER_TEST_TYPE_SIZE];

    circular_buffer_t circular_buffer_s32 = circular_buffer__create(sizeof(s32), CIRCULAR_BUFFER_S32_SIZE);
    ASSERT(circular_buffer__size_current(circular_buffer_s32) == 0);
    ASSERT(circular_buffer__size_total(circular_buffer_s32) == CIRCULAR_BUFFER_S32_SIZE);

    r64* circular_buffer_r64_data = libc__malloc(CIRCULAR_BUFFER_R64_SIZE * sizeof(*circular_buffer_r64_data));
    circular_buffer_t circular_buffer_r64 = circular_buffer__create_from_data(circular_buffer_r64_data, sizeof(*circular_buffer_r64_data), CIRCULAR_BUFFER_R64_SIZE);
    ASSERT(circular_buffer__size_current(circular_buffer_r64) == 0);
    ASSERT(circular_buffer__size_total(circular_buffer_r64) == CIRCULAR_BUFFER_R64_SIZE);

    circular_buffer_t circular_buffer_test_type = circular_buffer__create(sizeof(struct test_type), CIRCULAR_BUFFER_TEST_TYPE_SIZE);
    ASSERT(circular_buffer__size_current(circular_buffer_test_type) == 0);
    ASSERT(circular_buffer__size_total(circular_buffer_test_type) == CIRCULAR_BUFFER_TEST_TYPE_SIZE);

    for (u32 i = 0; i < CIRCULAR_BUFFER_S32_SIZE; ++i) {
        s32 item = i;
        circular_buffer__push(circular_buffer_s32, &item);
        ASSERT(circular_buffer__size_current(circular_buffer_s32) == i + 1);
    }
    for (u32 i = 0; i < CIRCULAR_BUFFER_R64_SIZE; ++i) {
        r64 item = 1.3 + (r64) i;
        circular_buffer__push(circular_buffer_r64, &item);
        ASSERT(circular_buffer__size_current(circular_buffer_r64) == i + 1);
    }
    for (u32 i = 0; i < CIRCULAR_BUFFER_TEST_TYPE_SIZE; ++i) {
        struct test_type item = {
            - (s8) i,
            2 * (u32) i,
            3 * (u16) i, {
                (void*) (u64) i,
                -5 * (s8) i
            },
            2.4f * (r32) i
        };
        circular_buffer__push(circular_buffer_test_type, &item);
        ASSERT(circular_buffer__size_current(circular_buffer_test_type) == i + 1);
    }

    test_filled_circular_buffer(circular_buffer_s32, auxiliary_array_s32, confirm_element_at_index_s32);
    test_filled_circular_buffer(circular_buffer_r64, auxiliary_array_r64, confirm_element_at_index_r64);
    test_filled_circular_buffer(circular_buffer_test_type, auxiliary_array_test_type, confirm_element_at_index_test_type);

    for (u32 i = 0; i < CIRCULAR_BUFFER_S32_SIZE; ++i) {
        s32 item = i;
        auxiliary_array_s32[i] = item;
    }
    for (u32 i = 0; i < CIRCULAR_BUFFER_R64_SIZE; ++i) {
        r64 item = 1.3 + (r64) i;
        auxiliary_array_r64[i] = item;
    }
    for (u32 i = 0; i < CIRCULAR_BUFFER_TEST_TYPE_SIZE; ++i) {
        struct test_type item = {
            - (s8) i,
            2 * (u32) i,
            3 * (u16) i, {
                (void*) (u64) i,
                -5 * (s8) i
            },
            2.4f * (r32) i
        };
        libc__memcpy((u8*) auxiliary_array_test_type + i * sizeof(struct test_type), &item, sizeof(item));
    }

    clear_circular_buffer(circular_buffer_s32);
    clear_circular_buffer(circular_buffer_r64);
    clear_circular_buffer(circular_buffer_test_type);

    circular_buffer__push_multiple(circular_buffer_s32, auxiliary_array_s32, circular_buffer__size_total(circular_buffer_s32));
    circular_buffer__push_multiple(circular_buffer_r64, auxiliary_array_r64, circular_buffer__size_total(circular_buffer_r64));
    circular_buffer__push_multiple(circular_buffer_test_type, auxiliary_array_test_type, circular_buffer__size_total(circular_buffer_test_type));

    test_filled_circular_buffer(circular_buffer_s32, auxiliary_array_s32, confirm_element_at_index_s32);
    test_filled_circular_buffer(circular_buffer_r64, auxiliary_array_r64, confirm_element_at_index_r64);
    test_filled_circular_buffer(circular_buffer_test_type, auxiliary_array_test_type, confirm_element_at_index_test_type);

    libc__free(circular_buffer_r64_data);
    circular_buffer__destroy(circular_buffer_r64);
    circular_buffer__destroy(circular_buffer_s32);
    circular_buffer__destroy(circular_buffer_test_type);

    return 0;
}
