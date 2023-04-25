#include "v4s16.h"

struct v4s16
v4s16(s16 a, s16 b, s16 c, s16 d) {
    struct v4s16 v = {a, b, c, d};

    return v;
}


struct v4s16
v4s16__add(struct v4s16 v1, struct v4s16 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4s16
v4s16__sub(struct v4s16 v1, struct v4s16 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4s16
v4s16__scale_s16(struct v4s16 v, s16 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
