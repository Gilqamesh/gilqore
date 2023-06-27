#include "types/vector_types/v3/v3s64.h"
struct v3s64 v3s64(s64 x, s64 y, s64 z) {
    struct v3s64 v = {x, y, z};
    return v;
}
struct v3s64 v3s64__scale_s64(struct v3s64 v, s64 s) {
    return
    v3s64(
        v.x * s,
        v.y * s,
        v.z * s
    );
}
