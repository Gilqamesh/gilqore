#include "v4s8.h"

struct v4s8
v4s8(s8 a, s8 b, s8 c, s8 d) {
    struct v4s8 v = {a, b, c, d};

    return v;
}


struct v4s8
v4s8__add(struct v4s8 v1, struct v4s8 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4s8
v4s8__sub(struct v4s8 v1, struct v4s8 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4s8
v4s8__scale_s8(struct v4s8 v, s8 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}

struct v4s8 v4s8__scale_r32(struct v4s8 v, r32 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}

bool v4s8__eq(struct v4s8 v, struct v4s8 w) {
    return
    v.a == w.a &&
    v.b == w.b &&
    v.c == w.c &&
    v.d == w.d;
}
