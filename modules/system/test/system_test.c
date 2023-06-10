#include "test_framework/test_framework.h"

#include "system/system.h"

#include <stdio.h>
#include <intrin.h>

void test_sleep(u32 n_of_iterations, u32 seconds) {
    printf("system__sleep(%u)\n", seconds);
    u64 total_cycles = 0;
    for (u32 i = 0; i < n_of_iterations; ++i) {
        u64 time_start = __rdtsc();
        system__sleep(seconds);
        u64 time_end = __rdtsc();
        total_cycles += time_end - time_start;
        printf("Cy(G): %lf\n", (time_end - time_start) / 1000000000.0);
    }
    printf("Total Cy(G): %lf\n", total_cycles / 1000000000.0);
    printf("Average Cy(M): %lf\n", total_cycles / 1000000.0 / n_of_iterations);
    printf("\n");
}

void test_usleep(u32 n_of_iterations, u32 useconds) {
    printf("system__usleep(%u)\n", useconds);
    u64 total_cycles = 0;
    for (u32 i = 0; i < n_of_iterations; ++i) {
        u64 time_start = __rdtsc();
        system__usleep(useconds);
        u64 time_end = __rdtsc();
        total_cycles += time_end - time_start;
    }
    printf("Total Cy(G): %lf\n", total_cycles / 1000000000.0);
    printf("Average Cy(M): %lf\n", total_cycles / 1000000.0 / n_of_iterations);
    printf("\n");
}

int main() {
    system__init_module();

    test_sleep(5, 1);
    test_usleep(1, 1000000);
    test_usleep(10, 100000);
    test_usleep(100, 10000);
    test_usleep(1000, 1000);
    test_usleep(10000, 100);
    test_usleep(100000, 10);
    test_usleep(1000000, 1);

    return 0;
}
