#include "v3u32.h"

struct v3u32 v3u32(u32 x, u32 y, u32 z) {
    struct v3u32 v = {x, y, z};

    return v;
}

struct v3u32 v3u32__scale_u32(struct v3u32 v, u32 s) {
    return
    v3u32(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
