#include "types/vector_types/v2/v2s16.h"

struct v2s16 v2s16(s16 x, s16 y) {
    struct v2s16 v = {x, y};

    return v;
}

struct v2s16 v2s16__scale_s16(struct v2s16 v, s16 s) {
    return
    v2s16(
        v.x * s,
        v.y * s
    );
}
