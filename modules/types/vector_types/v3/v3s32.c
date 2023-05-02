#include "v3s32.h"

struct v3s32
v3s32(s32 x, s32 y, s32 z) {
    struct v3s32 v = {x, y, z};

    return v;
}

struct v3s32
v3s32__scale_s32(struct v3s32 v, s32 s) {
    return
    v3s32(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
