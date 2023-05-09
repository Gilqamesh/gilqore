#include "math.h"

#include <math.h>

r32 r32__nextafter(r32 a, r32 b) {
    return nextafterf(a, b);
}

r64 r64__nextafter(r64 a, r64 b) {
    return nextafter(a, b);
}
