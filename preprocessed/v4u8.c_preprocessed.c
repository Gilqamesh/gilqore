#include "types/vector_types/v4/v4u8.h"
struct v4u8
v4u8(u8 a, u8 b, u8 c, u8 d) {
    struct v4u8 v = {a, b, c, d};
    return v;
}
struct v4u8
v4u8__add(struct v4u8 v1, struct v4u8 v2) {
    v1.a += v2.a;
    v1.b += v2.b;
    v1.c += v2.c;
    v1.d += v2.d;
    return v1;
}
struct v4u8
v4u8__sub(struct v4u8 v1, struct v4u8 v2) {
    v1.a -= v2.a;
    v1.b -= v2.b;
    v1.c -= v2.c;
    v1.d -= v2.d;
    return v1;
}
struct v4u8
v4u8__scale_u8(struct v4u8 v, u8 s) {
    v.a *= s;
    v.b *= s;
    v.c *= s;
    v.d *= s;
    return v;
}
struct v4u8
v4u8__scale_r32(struct v4u8 v, r32 s) {
    v.a = (u8) ((r32) v.a * s);
    v.b = (u8) ((r32) v.b * s);
    v.c = (u8) ((r32) v.c * s);
    v.d = (u8) ((r32) v.d * s);
    return v;
}
bool v4u8__eq(struct v4u8 v, struct v4u8 w) {
    return
    v.a == w.a &&
    v.b == w.b &&
    v.c == w.c &&
    v.d == w.d;
}
