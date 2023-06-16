#include "types/vector_types/v4/v4u32.h"

struct v4u32 v4u32(u32 a, u32 b, u32 c, u32 d) {
    struct v4u32 v = {a, b, c, d};

    return v;
}

struct v4u32 v4u32__scale_u32(struct v4u32 v, u32 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
