#include "types/vector_types/v4/v4s32.h"
struct v4s32
v4s32(s32 a, s32 b, s32 c, s32 d) {
    struct v4s32 v = {a, b, c, d};
    return v;
}
struct v4s32
v4s32__add(struct v4s32 v1, struct v4s32 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;
    return v1;
}
struct v4s32
v4s32__sub(struct v4s32 v1, struct v4s32 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;
    return v1;
}
struct v4s32
v4s32__scale_s32(struct v4s32 v, s32 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;
    return v;
}
