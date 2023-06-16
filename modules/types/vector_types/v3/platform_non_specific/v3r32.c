#include "types/vector_types/v3/v3r32.h"

struct v3r32 v3r32(r32 x, r32 y, r32 z) {
    struct v3r32 v = {x, y, z};

    return v;
}

struct v3r32 v3r32__scale_r32(struct v3r32 v, r32 s) {
    return
    v3r32(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
