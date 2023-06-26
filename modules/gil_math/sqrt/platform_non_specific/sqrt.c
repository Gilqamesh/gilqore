#include "gil_math/sqrt/sqrt.h"

#include <math.h>

r32 sqrt__r32(r32 r) {
    return sqrtf(r);
}

r64 sqrt__r64(r64 r) {
    return sqrt(r);
}
