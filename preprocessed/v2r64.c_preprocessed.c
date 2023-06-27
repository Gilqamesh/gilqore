#include "types/vector_types/v2/v2r64.h"
struct v2r64 v2r64(r64 x, r64 y) {
    struct v2r64 v = {x, y};
    return v;
}
struct v2r64 v2r64__scale_r64(struct v2r64 v, r64 s) {
    return
    v2r64(
        v.x * s,
        v.y * s
    );
}
