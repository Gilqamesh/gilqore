#include "../../system.h"
#include "system_platform_specific_defs.h"

#include <Windows.h>

#include "common/error_code.h"

#define SLEEP_MS_GRANULARITY 100

static LARGE_INTEGER g_performance_frequency;

void system__init_module(void) {
    if (QueryPerformanceFrequency(&g_performance_frequency) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(SYSTEM_ERROR_CODE_SYSTEM_WINDOWS_ERROR_CODE_QUERY_PERFORMANCE_FREQUENCY);
    }
}

static void system__busy_wait(LARGE_INTEGER start_performance_count, s64 mega_ticks_to_wait) {
    s64 epsilon_overhead_tick = 10000;
    LARGE_INTEGER current_performance_count;
    do {
        // note: assume it works to avoid branching
        QueryPerformanceCounter(&current_performance_count);
    } while ((current_performance_count.QuadPart - start_performance_count.QuadPart) * 1000000 + epsilon_overhead_tick < mega_ticks_to_wait);
}

void system__sleep(u32 seconds) {
    system__usleep(seconds * 1000 * 1000);
}

void system__usleep(u32 useconds) {
    LARGE_INTEGER start_performance_count;
    // note: assume it works to avoid branching
    QueryPerformanceCounter(&start_performance_count);
    u32 milliseconds = useconds / 1000;
    if (milliseconds > SLEEP_MS_GRANULARITY) {
        Sleep(milliseconds - SLEEP_MS_GRANULARITY);
    }
    s64 mega_ticks_to_wait = useconds * g_performance_frequency.QuadPart;
    system__busy_wait(start_performance_count, mega_ticks_to_wait);
}
