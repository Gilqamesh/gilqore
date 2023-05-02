#include "v4u16.h"

struct v4u16 v4u16(u16 a, u16 b, u16 c, u16 d) {
    struct v4u16 v = {a, b, c, d};

    return v;
}

struct v4u16 v4u16__add(struct v4u16 v1, struct v4u16 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4u16 v4u16__sub(struct v4u16 v1, struct v4u16 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4u16 v4u16__scale_u16(struct v4u16 v, u16 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
