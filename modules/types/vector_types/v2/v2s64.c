#include "v2s64.h"

struct v2s64 v2s64(s64 x, s64 y) {
    struct v2s64 v = {x, y};

    return v;
}

struct v2s64 v2s64__scale_s64(struct v2s64 v, s64 s) {
    return
    v2s64(
        v.x * s,
        v.y * s
    );
}

