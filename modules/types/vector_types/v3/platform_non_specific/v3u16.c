#include "types/vector_types/v3/v3u16.h"

struct v3u16 v3u16(u16 x, u16 y, u16 z) {
    struct v3u16 v = {x, y, z};

    return v;
}

struct v3u16 v3u16__scale_u16(struct v3u16 v, u16 s) {
    return
    v3u16(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
