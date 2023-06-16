#include "types/vector_types/v4/v4r64.h"

struct v4r64 v4r64(r64 a, r64 b, r64 c, r64 d) {
    struct v4r64 v = {a, b, c, d};

    return v;
}

struct v4r64
v4r64__add(struct v4r64 v1, struct v4r64 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4r64
v4r64__sub(struct v4r64 v1, struct v4r64 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4r64 v4r64__scale_r64(struct v4r64 v, r64 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
