#include "types/vector_types/v4/v4s64.h"

struct v4s64 v4s64(s64 a, s64 b, s64 c, s64 d) {
    struct v4s64 v = {a, b, c, d};

    return v;
}

struct v4s64 v4s64__add(struct v4s64 v1, struct v4s64 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4s64 v4s64__sub(struct v4s64 v1, struct v4s64 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4s64 v4s64__scale_s64(struct v4s64 v, s64 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
