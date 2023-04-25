#include "v2u8.h"

struct v2u8 v2u8(u8 x, u8 y) {
    struct v2u8 v = {x, y};

    return v;
}

struct v2u8 v2u8__scale_u8(struct v2u8 v, u8 s) {
    return
    v2u8(
        v.x * s,
        v.y * s
    );
}
