#include "basic_types.h"

r32 r32__integer_part(r32 r) {
    return (r32) (u32) r;
}

r64 r64__integer_part(r64 r) {
    return (r64) (u64) r;
}

r32 r32__decimal_part(r32 r) {
    return r - r32__integer_part(r);
}

r64 r64__decimal_part(r64 r) {
    return r - r64__integer_part(r);
}
