#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "memory/segment_allocator/segment_allocator.h"

static u64 recs(u32 width, u32 height) {
    u64 sum = 0;
    for (u32 cur_width = 0; cur_width < width; ++cur_width) {
        u32 sub_width = width - cur_width;
        for (u32 cur_height = 0; cur_height < height; ++cur_height) {
            u32 sub_height = height - cur_height;
            u32 sub_sum = sub_width * sub_height;
            sum += sub_sum;
        }
    }

    return sum;
}

bool test_85(memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    const u32 max_width  = 1000;
    const u32 max_height = 1000;
    seg_t recs_table_seg = seg__malloc(memory_slice, max_height * sizeof(u64*));
    ASSERT(recs_table_seg);
    u64** recs_table = seg__seg_to_data(recs_table_seg);
    for (u32 height = 0; height < max_height; ++height) {
        seg_t recs_table_row_seg = seg__malloc(memory_slice, max_width * sizeof(u64));
        ASSERT(recs_table_row_seg);
        recs_table[height] = (u64*)seg__seg_to_data(recs_table_row_seg);
        for (u32 width = 0; width < max_width; ++width) {
            recs_table[height][width] = 0;
        }
    }

    const u32 target_number_of_recs = 2000000;
    u64 target_width = 0;
    u64 target_height = 0;
    u64 current_difference = target_number_of_recs;

    for (u32 height = 1; height <= max_height; ++height) {
        recs_table[height - 1][0] = recs(1, height);
        u64 diff = recs_table[height - 1][0] < target_number_of_recs ? target_number_of_recs - recs_table[height - 1][0] : recs_table[height - 1][0] - target_number_of_recs;
        if (diff < current_difference) {
            current_difference = diff;
            target_width = 1;
            target_height = height;
        }
    }
    for (u32 width = 1; width <= max_width; ++width) {
        recs_table[0][width - 1] = recs(width, 1);
        u64 diff = recs_table[0][width - 1] < target_number_of_recs ? target_number_of_recs - recs_table[0][width - 1] : recs_table[0][width - 1] - target_number_of_recs;
        if (diff < current_difference) {
            current_difference = diff;
            target_width = width;
            target_height = 1;
        }
    }

    for (u32 height = 2; height <= max_height; ++height) {
        for (u32 width = 2; width <= max_width; ++width) {
            recs_table[height - 1][width - 1] =
                width * height +
                recs_table[height - 2][width - 1] +
                recs_table[height - 1][width - 2] -
                recs_table[height - 2][width - 2];
            u64 diff = recs_table[height - 1][width - 1] < target_number_of_recs ? target_number_of_recs - recs_table[height - 1][width - 1] : recs_table[height - 1][width - 1] - target_number_of_recs;
            if (diff < current_difference) {
                current_difference = diff;
                target_width = width;
                target_height = height;
            }
        }
    }

    libc__printf("Target width: %lu, heigh: %lu, area: %lu, diff: %lu, recs: %lu\n", target_width, target_height, target_width * target_height, current_difference, recs(target_width, target_height));

    return true;
}
