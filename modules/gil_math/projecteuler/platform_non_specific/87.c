#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/sqrt/sqrt.h"
#include "system/thread/thread.h"
#include "data_structures/hash_set/hash_set.h"

static bool is_prime(u32 a) {
    if (a < 2) {
        return false;
    }

    if (a == 2) {
        return true;
    }
    if (a % 2 == 0) {
        return false;
    }
    for (u32 b = 3; b <= (u32) sqrt__r32(a); b += 2) {
        if (a % b == 0) {
            return false;
        }
    }

    return true;
}

static void generate_primes(u32* primes, u32 primes_size) {
    ASSERT(primes_size > 0);
    u32 cur_prime_index = 0;
    primes[cur_prime_index++] = 2;
    primes[cur_prime_index++] = 3;
    u32 cur_number = 5;
    while (cur_prime_index < primes_size) {
        if (is_prime(cur_number)) {
            primes[cur_prime_index++] = cur_number;
        }
        cur_number += 2;
    }
}

static u32 hash_fn(const hash_set_key_t* key) {
    return *(u32*) key * 1337;
}

static bool eq_fn(const hash_set_key_t* key_a, const hash_set_key_t* key_b) {
    return *(u32*) key_a == *(u32*) key_b;
}

bool test_87(memory_slice_t memory_slice) {
    // P(1)^2 + P(2)^3 + P(3)^4
    if (!seg__init(memory_slice)) {
        return false;
    }

    const u64 max = 50000000;
    const u32 max_prime = (u32) sqrt__r32(max);
    u32 number_of_primes = max_prime;
    seg_t primes_seg = seg__malloc(memory_slice, number_of_primes * sizeof(number_of_primes));
    if (primes_seg == NULL) {
        return false;
    }
    u32* primes = (u32*) seg__seg_to_data(primes_seg);

    generate_primes(primes, number_of_primes);

    const u32 max_number_of_solutions = 10000000;
    seg_t answers_seg = seg__malloc(memory_slice, max_number_of_solutions * sizeof(u32));
    if (answers_seg == NULL) {
        return false;
    }
    u32* answers = (u32*) seg__seg_to_data(answers_seg);

    hash_set_t hash_set;
    ASSERT(hash_set__create(&hash_set, memory_slice__create(answers, max_number_of_solutions), sizeof(u32), &hash_fn, &eq_fn));

    for (u32 a = 0; a < number_of_primes; ++a) {
        if (primes[a] > max_prime) {
            break ;
        }
        const u64 aa = primes[a] * primes[a];
        if (aa >= max) {
            break ;
        }
        for (u32 b = 0; b < number_of_primes; ++b) {
            if (primes[b] > max_prime) {
                break ;
            }
            const u64 bbb = primes[b] * primes[b] * primes[b];
            if (aa + bbb >= max) {
                break ;
            }
            for (u32 c = 0; c < number_of_primes; ++c) {
                if (primes[c] > max_prime) {
                    break ;
                }
                const u64 cccc = primes[c] * primes[c] * primes[c] * primes[c];
                const u32 sum = aa + bbb + cccc;
                if (sum < 50) {
                    libc__printf("Sum: %u\n", sum);
                }
                if (sum >= max) {
                    break ;
                }
                ASSERT(hash_set__insert(&hash_set, &sum));
            }
        }
    }

    const u32 number_of_solutions = hash_set__size(&hash_set);
    libc__printf("Number of solutions: %u\n", number_of_solutions);

    return true;
}
