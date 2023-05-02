#include "v3u8.h"

struct v3u8 v3u8(u8 x, u8 y, u8 z) {
    struct v3u8 v = {x, y, z};

    return v;
}

struct v3u8 v3u8__scale_u8(struct v3u8 v, u8 s) {
    return
    v3u8(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
