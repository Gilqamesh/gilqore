#include "basic_types.h"

r32 r32__integer_part(r32 r) {
    return (s32) r;
}

r32 r32__fractional_part(r32 r) {
    return r - r32__integer_part(r);
}
