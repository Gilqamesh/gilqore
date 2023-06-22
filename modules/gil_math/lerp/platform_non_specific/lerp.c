#include "math/lerp/lerp.h"

u32 lerp__u32(u32 a, r32 t, u32 b) {
    return
    (u32) ((r32) a + t * (r32) (b - a));
}

struct color lerp__color(struct color a, r32 t, struct color b) {
    return
    color__add(
        b,
        color__scale_r32(
            a,
            1.0f - t
        )
    );
}
