#include "test_framework/test_framework.h"

#include "system/thread/thread.h"

#include "libc/libc.h"
#include "math/random/random.h"

u32 worker_fn(void* user_data) {
    (void) user_data;
    libc__printf("Start working...\n");

    struct random randomizer;
    random__init(&randomizer, 42);

    r64 sum = 0.0;
    const r64 min_r64 = -10000.0;
    const r64 max_r64 = 1000000.0;
    for (u32 i = 0; i < 10000000; ++i) {
        sum += random__r64_closed(&randomizer, min_r64, max_r64);
    }
    libc__printf("Result of work: %lf\n", sum);

    return 42;
}

int main() {
    struct thread thread;

    thread__create(&thread, &worker_fn, NULL);

    thread__wait_execution(&thread);
    TEST_FRAMEWORK_ASSERT(thread__destroy(&thread) == 42);

    return 0;
}
