#include "math.h"

#include <math.h>

r32 r32__nextafter(r32 a, r32 b) {
    return nextafterf(a, b);
}

r64 r64__nextafter(r64 a, r64 b) {
    return nextafter(a, b);
}

bool is_pow_of_2__u32(u32 n) {
    return n > 0 && (n & (n - 1)) == 0;
}
