#include "time/time.h"
#include "time_platform_specific_defs.h"

#include "libc/libc.h"

struct time time__get(void) {
    struct time result;

    SYSTEMTIME system_time;
    GetSystemTime(&system_time);
    if (SystemTimeToFileTime(&system_time, &result.val) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(TIME_ERROR_CODE_SYSTEM_TIME_TO_FILE_TIME);
    }

    return result;
}

s64 time__cmp(struct time t1, struct time t2) {
    ULARGE_INTEGER t1_large_int;
    ULARGE_INTEGER t2_large_int;

    t1_large_int.LowPart = t1.val.dwLowDateTime;
    t1_large_int.HighPart = t1.val.dwHighDateTime;
    t2_large_int.LowPart = t2.val.dwLowDateTime;
    t2_large_int.HighPart = t2.val.dwHighDateTime;

    return (s64) t1_large_int.QuadPart - (s64) t2_large_int.QuadPart;
}

void time__to_str(struct time time, struct memory_slice memory_slice) {
    SYSTEMTIME system_time;
    if (FileTimeToSystemTime(&time.val, &system_time) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(TIME_ERROR_CODE_SYSTEM_TIME_TO_FILE_TIME);
    }

    libc__snprintf(
        memory_slice__memory(&memory_slice), memory_slice__size(&memory_slice),
        "%u-%02u-%02u %u:%02u:%02u",
        system_time.wYear, system_time.wMonth, system_time.wDay,
        system_time.wHour, system_time.wMinute, system_time.wSecond
    );
}
