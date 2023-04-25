#include "lerp.h"

u32 lerp__u32(u32 a, r32 normalized_value, u32 b) {
    return
    (u32) ((r32) a + normalized_value * (r32) (b - a));
}

struct color lerp__color(struct color a, r32 normalized_value, struct color b) {
    return
    color__add(
        a,
        color__scale_r32(
            color__sub(b, a),
            normalized_value
        )
    );
}
