#include "test_framework/test_framework.h"

#include "time/time.h"
#include "system/system.h"

#include <stdio.h>

void time_interval_test(u32 interval_useconds) {
    struct time time_prev = time__get();

    system__usleep(interval_useconds);

    struct time time_cur = time__get();

    TEST_FRAMEWORK_ASSERT(time__cmp(time_prev, time_cur) < 0);
}

int main() {
    system__init_module();

    const r64 min_wait_time_s = 1.0;
    const r64 min_wait_time_us = min_wait_time_s * 1000000.0;
    for (s32 i = 0; i < 3; ++i) {
        time_interval_test((u32) min_wait_time_us);
    }

    return 0;
}
