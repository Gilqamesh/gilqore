#include "types/vector_types/v2/v2s8.h"
struct v2s8 v2s8(s8 x, s8 y) {
    struct v2s8 v = {x, y};
    return v;
}
struct v2s8 v2s8__scale_s8(struct v2s8 v, s8 s) {
    return
    v2s8(
        v.x * s,
        v.y * s
    );
}
