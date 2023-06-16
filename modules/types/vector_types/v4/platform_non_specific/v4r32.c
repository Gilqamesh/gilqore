#include "types/vector_types/v4/v4r32.h"

struct v4r32 v4r32(r32 a, r32 b, r32 c, r32 d) {
    struct v4r32 v = {a, b, c, d};

    return v;
}

struct v4r32
v4r32__add(struct v4r32 v1, struct v4r32 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4r32
v4r32__sub(struct v4r32 v1, struct v4r32 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4r32 v4r32__scale_r32(struct v4r32 v, r32 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
