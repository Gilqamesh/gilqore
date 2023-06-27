#include "types/basic_types/basic_types.h"

#include "gil_math/gil_math.h"

r32 r32__modular_fraction(r32 r, r32* integral_part) {
    return modff(r, integral_part);
}

r64 r64__modular_fraction(r64 r, r64* integral_part) {
    return modf(r, integral_part);
}

r32 r32__integral_part(r32 r) {
    r32 integral_part;
    r32__modular_fraction(r, &integral_part);
    return integral_part;
}

r64 r64__integral_part(r64 r) {
    r64 integral_part;
    r64__modular_fraction(r, &integral_part);
    return integral_part;
}

r32 r32__fractional_part(r32 r) {
    r32 integral_part;
    r32 fractional_part = r32__modular_fraction(r, &integral_part);
    return fractional_part;
}

r64 r64__fractional_part(r64 r) {
    r64 integral_part;
    r64 fractional_part = r64__modular_fraction(r, &integral_part);
    return fractional_part;
}

u32 s64__len(s64 n) {
    u32 number_of_digits =
    n == 0 ? 1 :
    n < 0 ? 1 : 0;

    while (n != 0) {
        n /= 10;
        ++number_of_digits;
    }

    return number_of_digits;
}
