#include "types/vector_types/v2/v2s32.h"
struct v2s32 v2s32(s32 x, s32 y) {
    struct v2s32 v = {x, y};
    return v;
}
struct v2s32 v2s32__scale_s32(struct v2s32 v, s32 s) {
    return
    v2s32(
        v.x * s,
        v.y * s
    );
}
bool v2s32__is_equal(struct v2s32 v1, struct v2s32 v2) {
    return
    v1.x == v2.x &&
    v1.y == v2.y;
}
struct v2s32 v2s32__sub_v2s32(struct v2s32 v, struct v2s32 w) {
    return
    v2s32(
        v.x - w.x,
        v.y - w.y
    );
}
