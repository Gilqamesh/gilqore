#include "test_framework/test_framework.h"

#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"

#include <x86intrin.h>

static void run_tests(memory_slice_t memory_slice) {
    (void) memory_slice;

    u64 time_start;
    u64 time_end;

#define _RUN_TIMED_TEST(id_of_test, expr) \
    do { \
        time_start = __rdtsc(); \
        TEST_FRAMEWORK_ASSERT(expr); \
        time_end = __rdtsc(); \
        libc__printf(#id_of_test ". time taken (kCy): %.3lf\n", (r64)(time_end - time_start) / 1000.0); \
    } while (false);

    // _RUN_TIMED_TEST(
    //     82,
    //     test_82(
    //         "modules/gil_math/projecteuler/test/resources/82matrix.txt",
    //         "modules/gil_math/projecteuler/test/resources/82solution.txt",
    //         memory_slice
    //     )
    // );
    // _RUN_TIMED_TEST(
    //     83,
    //     test_83(
    //         "modules/gil_math/projecteuler/test/resources/83matrix.txt",
    //         "modules/gil_math/projecteuler/test/resources/83solution.txt",
    //         memory_slice
    //     )
    // );
    // _RUN_TIMED_TEST(84, test_84(memory_slice));
    // _RUN_TIMED_TEST(85, test_85(memory_slice));
    // _RUN_TIMED_TEST(86, test_86(memory_slice));
    // _RUN_TIMED_TEST(87, test_87(memory_slice));
    // _RUN_TIMED_TEST(88, test_88(memory_slice));
    _RUN_TIMED_TEST(89, test_89("modules/gil_math/projecteuler/test/resources/89romans.txt", memory_slice));

#undef _RUN_TIMED_TEST
}

int main() {
    // allocate main memory
    size_t main_memory_size = MEGABYTES(256);
    void* main_memory = libc__malloc(main_memory_size);

    // run tests
    run_tests(memory_slice__create(main_memory, main_memory_size));

    // free up main memory
    libc__free(main_memory);

    return 0;
}
