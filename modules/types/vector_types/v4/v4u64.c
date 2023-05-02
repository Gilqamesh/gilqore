#include "v4u64.h"

struct v4u64 v4u64(u64 a, u64 b, u64 c, u64 d) {
    struct v4u64 v = {a, b, c, d};

    return v;
}

struct v4u64 v4u64__add(struct v4u64 v1, struct v4u64 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;

    return v1;
}

struct v4u64 v4u64__sub(struct v4u64 v1, struct v4u64 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;

    return v1;
}

struct v4u64 v4u64__scale_u64(struct v4u64 v, u64 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;

    return v;
}
