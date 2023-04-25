#include "v2u16.h"

struct v2u16 v2u16(u16 x, u16 y) {
    struct v2u16 v = {x, y};

    return v;
}

struct v2u16 v2u16__scale_u16(struct v2u16 v, u16 s) {
    return
    v2u16(
        v.x * s,
        v.y * s
    );
}
