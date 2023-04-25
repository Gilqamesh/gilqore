#include "v2u32.h"

struct v2u32 v2u32(u32 x, u32 y) {
    struct v2u32 v = {x, y};

    return v;
}

struct v2u32 v2u32__scale_u32(struct v2u32 v, u32 s) {
    return
    v2u32(
        v.x * s,
        v.y * s
    );
}

bool v2u32__is_less(struct v2u32 v, struct v2u32 relative) {
    return
    v.x < relative.x &&
    v.y < relative.y;
}
