#include "v2u32.h"

#include "basic_types/basic_types.h"

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

struct v2u32 v2u32__add_v2u32(struct v2u32 v, struct v2u32 w) {
    return
    v2u32(
        v.x + w.x,
        v.y + w.y
    );
}

struct v2u32 v2u32__sub_v2u32(struct v2u32 v, struct v2u32 w) {
    return
    v2u32(
        v.x - w.x,
        v.y - w.y
    );
}

struct v2u32 v2u32__abs_sub(struct v2u32 v, struct v2u32 w) {
    v.x = u32__abs_sub(v.x, w.x);
    v.y = u32__abs_sub(v.y, w.y);

    return v;
}

bool v2u32__is_less(struct v2u32 v, struct v2u32 relative) {
    return
    v.x < relative.x &&
    v.y < relative.y;
}
