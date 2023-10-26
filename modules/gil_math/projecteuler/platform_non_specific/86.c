#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/sqrt/sqrt.h"
#include "system/thread/thread.h"

#include <x86intrin.h>

bool is_square(u32 n) {
    r64 a = sqrt__r64(n);
    return a == (u32) a;
}

bool has_integer_shortest_dist(u32 a, u32 b, u32 c) {
    /*
    1. a^2 + b^2 + c^2 + 2bc
    2. a^2 + b^2 + c^2 + 2ab
    3. a^2 + b^2 + c^2 + 2ac
    */
    /*
    1. a < b & a < c
    2. b < a & b < c
    3. c < a & c < b
    !1. a >= b | a >= c
    !2. b >= a | b >= c
    */
    const u32 ab = a * b;
    const u32 ac = a * c;
    const u32 bc = b * c;
    const u32 aa_bb_cc = a * a + b * b + c * c;
    if (ab < ac) {
        if (ab < bc) {
            return is_square(aa_bb_cc + 2 * ab);
        } else {
            return is_square(aa_bb_cc + 2 * bc);
        }
    } else {
        if (ac < bc) {
            return is_square(aa_bb_cc + 2 * ac);
        } else {
            return is_square(aa_bb_cc + 2 * bc);
        }
    }
}

u32 gcd(u32 a, u32 b) {
    if (a < b) {
        u32 t = a;
        a = b;
        b = t;
    }

    while (b != 0) {
        u32 t = b;
        b = a % b;
        a = t;
    }

    return a;
}

bool coprime(u32 a, u32 b) {
    return gcd(a, b) == 1;
}

typedef struct test_range {
    u32 id;
    u32 low;
    u32 high;
    u32 M;
    u32 n_of_solutions;
    mutex_t* mutex;
} test_range_t;

u32 worker_fn(void* user_data) {
    test_range_t* test_range = (test_range_t*)user_data;
    u64 time_start = __rdtsc();
    for (u32 a = test_range->low; a <= test_range->high; ++a) {
        for (u32 b = a; b <= test_range->M; ++b) {
            for (u32 c = b; c <= test_range->M; ++c) {
                if (has_integer_shortest_dist(a, b, c)) {
                    ++test_range->n_of_solutions;
                }
            }
        }
    }
    u64 time_end = __rdtsc();
    mutex__lock(test_range->mutex);
    libc__printf("Thread id: %u, time taken (kCy): %.3lfkCy\n", test_range->id, (r64)(time_end - time_start) / 1000.0);
    mutex__unlock(test_range->mutex);
    return 0;
}

bool test_86(memory_slice_t memory_slice) {
    (void) memory_slice;

    // // m > n
    // // m, n, k elements of positive integers
    // // a = k * (m^2 - n^2)
    // // b + c = k * 2mn
    // // x = k * (m^2 + n^2)
    // const u32 M = 100;
    // const u32 max_m = 1000;
    // const u32 max_k = 1000;
    // u32 n_of_sols = 0;
    // for (u32 m = 2; m < max_m; ++m) {
    //     for (u32 n = 1; n < m; ++n) {
    //         if (n % 2 == 1 && m % 2 == 1) {
    //             continue ;
    //         }
    //         if (!coprime(m, n)) {
    //             continue ;
    //         }
    //         for (u32 k = 1; k < max_k; ++k) {
    //             u32 a = k * (m * m - n * n);
    //             if (a > M) {
    //                 break ;
    //             }
    //             u32 b_c = k * 2 * m * n;
    //             if (b_c > M) {
    //                 break ;
    //             }
    //             for (u32 b = b_c - 1; b >= b_c / 2; --b) {
    //                 u32 c = b_c - b;
    //                 if (has_integer_shortest_dist(a, b, c)) {
    //                     ++n_of_sols;
    //                 }
    //             }
    //             for (u32 b = a - 1; b > a / 2; --b) {
    //                 u32 c = a - b;
    //                 if (has_integer_shortest_dist(b_c, b, c)) {
    //                     ++n_of_sols;
    //                 }
    //             }
    //         }
    //     }
    // }
    // libc__printf("Number of solutions: %u\n", n_of_sols);

    // 1850 -> 1.046.725, 120 556 545.151 kCy   1 thread(s)
    // 1850 -> 1.046.725,  21 987 945.499 kCy, 10 thread(s)
    // 1850 -> 1.046.725,   9 529 681.150 kCy, 25 thread(s)
    // 1840 -> 1.031.554,  11 607 529.325 kCy, 20 thread(s)
    // 1820 -> 1.006.727,  11 280 357.302 kCy, 20 thread(s)
    // 1815 ->   998.665,   7 028 195.374 kCy, 33 thread(s)
    // 1816 ->   999.460,  25 400 351.599 kCy,  8 thread(s)
    // 1817 ->   999.850,   9 833 051.550 kCy, 23 thread(s)
    // 1818 -> 1.000.457,  12 425 274.078 kCy, 18 thread(s)
    const u32 M = 1818;
    const u32 number_of_threads = 18;
    ASSERT(M % number_of_threads == 0);
    const u32 stride = M / number_of_threads;
    test_range_t ranges[number_of_threads];
    thread_t threads[number_of_threads];
    u32 number_of_sols = 0;
    mutex_t mutex;
    ASSERT(mutex__create(&mutex));
    mutex__lock(&mutex);
    for (u32 thread_index = 0; thread_index < ARRAY_SIZE(threads); ++thread_index) {
        ranges[thread_index].id = thread_index;
        ranges[thread_index].low = thread_index * stride + 1;
        ranges[thread_index].high = (thread_index + 1) * stride;
        ranges[thread_index].M = M;
        ranges[thread_index].mutex = &mutex;
        libc__printf("Low: %u, high: %u, thread id: %u\n", ranges[thread_index].low, ranges[thread_index].high, thread_index);
        ranges[thread_index].n_of_solutions = 0;
        thread__create(&threads[thread_index], &worker_fn, &ranges[thread_index]);
    }
    mutex__unlock(&mutex);
    for (u32 thread_index = 0; thread_index < ARRAY_SIZE(threads); ++thread_index) {
        thread__wait_execution(&threads[thread_index]);
        ASSERT(thread__destroy(&threads[thread_index]) == 0);
        number_of_sols += ranges[thread_index].n_of_solutions;
    }
    libc__printf("Number of solutions: %u\n", number_of_sols);

    mutex__destroy(&mutex);

    // u32 n_of_sols_2 = 0;
    // for (u32 a = 1; a <= M; ++a) {
    //     for (u32 b = a; b <= M; ++b) {
    //         for (u32 c = b; c <= M; ++c) {
    //             if (has_integer_shortest_dist(a, b, c)) {
    //                 ++n_of_sols_2;
    //             }
    //         }
    //     }
    // }
    // libc__printf("Number of solutions: %u\n", n_of_sols_2);

    return true;
}
