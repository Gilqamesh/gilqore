#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/sqrt/sqrt.h"
#include "system/thread/thread.h"
#include "data_structures/hash_set/hash_set.h"

static u32 unique_number_of_partitioning_helper(u32* set, u32 set_size, u32 n, u32 index, bool* has_product_sum_number, u64 sum, u64* product) {
    if (n == 0) {
        if (*product == sum) {
            *has_product_sum_number = true;
        }
        return 1;
    }
    if (set_size == 0 || index == set_size) {
        return 0;
    }

    u32 result = 0;

    for (s32 i = (s32)n; i > 0; --i) {
        if (index > 0 && set[index] + i > set[index - 1]) {
            continue ;
        }

        set[index] += i;
        *product *= set[index];
        // if product is already too big, stop looking for product sum numbers as there won't be one
        if (*product <= sum) {
            result += unique_number_of_partitioning_helper(set, set_size, n - i, index + 1, has_product_sum_number, sum, product);
        }
        *product /= set[index];
        set[index] -= i;
    }

    // ASSERT(hash_map__insert(solutions, &solution_key, &result));

    return result;
}

static u32 unique_number_of_partitioning(u32* set, u32 set_size, u32 n, bool* has_product_sum_number) {
    if (n < set_size) {
        return 0;
    }

    for (u32 set_index = 0; set_index < set_size; ++set_index) {
        set[set_index] = 1;
    }

    u64 sum = n;
    u64 product = 1;
    return unique_number_of_partitioning_helper(set, set_size, n - set_size, 0, has_product_sum_number, sum, &product);
}

/*
    a1 + a2 + a3 + a4 + a5 = a1 * a2 * a3 * a4 * a5
    -> - a5 + a6           = / a5 * a6
    a1 + a2 + a3 + a4 + a6 = a1 * a2 * a3 * a4 * a6
*/

static u32 minimal_product_sum_number(memory_slice_t memory_slice, u32 k) {
    // N = a1 + a2 + ... + ak = a1 * a2 * ... * ak
    // N is elements of natural numbers
    seg_t set_seg = seg__malloc(memory_slice, k * sizeof(u32));
    ASSERT(set_seg);
    u32* set = (u32*) seg__seg_to_data(set_seg);

    u32 result = 0;

    for (u32 n = k; ; ++n) {
        if (k == 4354) {
            if (n % 100 == 0) {
                libc__printf("k: %u, n: %u\n", k, n);
            }
        }
        bool has_product_sum_number = false;
        DISCARD_RETURN unique_number_of_partitioning(set, k, n, &has_product_sum_number);
        if (has_product_sum_number) {
            result = n;
            break ;
        }
    }

    seg__free(memory_slice, set_seg);

    return result;
}

static u32 hash_set_hash_fn(const hash_set_key_t* key) {
    return *(u32*)key * 1337;
}

static bool hash_set_eq_fn(const hash_set_key_t* key_a, const hash_set_key_t* key_b) {
    return *(u32*)key_a == *(u32*)key_b;
}

bool test_88(memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    const u32 max_k = 12000;

    const u32 hash_set_memory_size = max_k * 10 * sizeof(u32);
    seg_t hash_set_memory_seg = seg__malloc(memory_slice, hash_set_memory_size);
    if (hash_set_memory_seg == NULL) {
        return false;
    }
    void* hash_set_memory = seg__seg_to_data(hash_set_memory_seg);
    hash_set_t hash_set;
    ASSERT(hash_set__create(&hash_set, memory_slice__create(hash_set_memory, hash_set_memory_size), sizeof(u32), &hash_set_hash_fn, &hash_set_eq_fn));

    for (u32 k = 2; k <= max_k; ++k) {
        if (k == 4354) {
            s32 debug = 0;
            ++debug;
        }
        u32 min_product_sum_number = minimal_product_sum_number(memory_slice, k);
        ASSERT(hash_set__insert(&hash_set, &min_product_sum_number));
        libc__printf("k: %u, n: %u\n", k, min_product_sum_number);
    }

    libc__printf("Number of minimal product sum numbers: %u\n", hash_set__capacity(&hash_set));

    u32 sum = 0;
    hash_set_key_t* begin = hash_set__begin(&hash_set);
    hash_set_key_t* end = hash_set__end(&hash_set);
    while (begin != end) {
        sum += *(u32*)begin;
        begin = hash_set__next(&hash_set, begin);
    }

    libc__printf("Sum of all unique minimal product sums: %u\n", sum);

    return true;
}
