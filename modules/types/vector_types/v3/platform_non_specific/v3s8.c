#include "types/vector_types/v3/v3s8.h"

struct v3s8
v3s8(s8 x, s8 y, s8 z) {
    struct v3s8 v = {x, y, z};

    return v;
}

struct v3s8
v3s8__scale_s8(struct v3s8 v, s8 s) {
    return
    v3s8(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
