#include "types/vector_types/v3/v3s16.h"
struct v3s16
v3s16(s16 x, s16 y, s16 z) {
    struct v3s16 v = {x, y, z};
    return v;
}
struct v3s16
v3s16__scale_s16(struct v3s16 v, s16 s) {
    return
    v3s16(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
