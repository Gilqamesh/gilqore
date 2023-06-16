#include "types/vector_types/v2/v2r32.h"

#include "math/sqrt/sqrt.h"
#include "math/abs/abs.h"

struct v2r32 v2r32(r32 x, r32 y) {
    struct v2r32 v = {x, y};

    return v;
}

struct v2r32 v2r32__scale_r32(struct v2r32 v, r32 s) {
    return
    v2r32(
        v.x * s,
        v.y * s
    );
}

struct v2r32 v2r32__scale_v2r32(struct v2r32 v, struct v2r32 s) {
    return
    v2r32(
        v.x * s.x,
        v.y * s.y
    );
}

struct v2r32 v2r32__add_v2r32(struct v2r32 v, struct v2r32 w) {
    return
    v2r32(
        v.x + w.x,
        v.y + w.y
    );
}

struct v2r32 v2r32__sub_v2r32(struct v2r32 v, struct v2r32 w) {
    return
    v2r32(
        v.x - w.x,
        v.y - w.y
    );
}

struct v2r32 v2r32__abs(struct v2r32 v) {
    v.x = r32__abs(v.x);
    v.y = r32__abs(v.y);

    return v;
}

struct v2r32 v2r32__abs_dist(struct v2r32 v, struct v2r32 w) {
    v.x = r32__abs_dist(v.x, w.x);
    v.y = r32__abs_dist(v.y, w.y);

    return v;
}

r32 v2r32__dot_v2r32(struct v2r32 v, struct v2r32 w) {
    return
    v.x * w.x +
    v.y * w.y;
}

r32 v2r32__length(struct v2r32 v) {
    return
    sqrt__r32(
        v2r32__dot_v2r32(
            v,
            v
        )
    );
}

struct v2r32 v2r32__normalize(struct v2r32 v) {
    return
    v2r32__scale_r32(
        v,
        1.0f / v2r32__length(v)
    );
}

bool v2r32__is_in_half_dims(struct v2r32 v, struct v2r32 half_dims) {
    return 
    v.x > -half_dims.x &&
    v.x < half_dims.x &&
    v.y > -half_dims.y &&
    v.y < half_dims.y;
}

