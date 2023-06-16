#include "types/vector_types/v3/v3u64.h"

struct v3u64 v3u64(u64 x, u64 y, u64 z) {
    struct v3u64 v = {x, y, z};

    return v;
}

struct v3u64 v3u64__scale_u64(struct v3u64 v, u64 s) {
    return
    v3u64(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
