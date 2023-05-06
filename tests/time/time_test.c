#include "test_framework/test_framework.h"

#include "time/time.h"
#include "system/system.h"

#include <stdio.h>

void time_interval_test(u32 interval_useconds) {
    struct time time_prev = time__get();

    system__usleep(interval_useconds);

    struct time time_cur = time__get();

    ASSERT(time__cmp(time_prev, time_cur) < 0);
}

void test_module_main() {
    time_interval_test(1000000);
    time_interval_test(100000);
    time_interval_test(10000);
    time_interval_test(1000);
    time_interval_test(100);
    time_interval_test(10);
    time_interval_test(1);
}
