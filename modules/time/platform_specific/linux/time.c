#include "../../time.h"
#include "time_platform_specific_defs.h"

#include "common/error_code.h"

struct time time__get(void) {
    struct time result;

    if ((result.val = time(NULL)) == (time_t) -1) {
        // todo: diagnostics, errno
        error_code__exit(TIME_ERROR_CODE_LINUX_TIME);
    }

    return result;
}

s64 time__cmp(struct time t1, struct time t2) {
    return t1.val - t2.val;
}
