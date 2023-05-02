#include "v2u64.h"

struct v2u64 v2u64(u64 x, u64 y) {
    struct v2u64 v = {x, y};

    return v;
}

struct v2u64 v2u64__scale_u64(struct v2u64 v, u64 s) {
    return
    v2u64(
        v.x * s,
        v.y * s
    );
}
