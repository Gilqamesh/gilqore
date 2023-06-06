#include "types/basic_types/basic_types.h"

#include "math/math.h"

#define EPSILON_R32 0.00001f
#define EPSILON_R64 0.0000000000001

int main() {
    r32 tested_r32 = 2.3f;
    r32 integral_r32;
    r32 fractional_r32 = r32__modular_fraction(tested_r32, &integral_r32);
    r32 expected_integral_r32 = 2.0f;
    r32 expected_fractional_r32 = 0.3f;

    r64 tested_r64 = 2.43766;
    r64 integral_r64;
    r64 fractional_r64 = r64__modular_fraction(tested_r64, &integral_r64);
    r64 expected_integral_r64 = 2.0;
    r64 expected_fractional_r64 = 0.43766;

    ASSERT(
        integral_r32 < r32__nextafter(integral_r32, integral_r32 + 1.0f) &&
        integral_r32 > r32__nextafter(integral_r32, integral_r32 - 1.0f)
    );
    ASSERT(
        fractional_r32 < r32__nextafter(fractional_r32, fractional_r32 + 1.0f) &&
        fractional_r32 > r32__nextafter(fractional_r32, fractional_r32 - 1.0f)
    );
    ASSERT(
        integral_r32 < expected_integral_r32 + EPSILON_R32 &&
        integral_r32 > expected_integral_r32 - EPSILON_R32
    );
    ASSERT(
        fractional_r32 < expected_fractional_r32 + EPSILON_R32 &&
        fractional_r32 > expected_fractional_r32 - EPSILON_R32
    );

    ASSERT(
        integral_r64 < r64__nextafter(integral_r64, integral_r64 + 1.0) &&
        integral_r64 > r64__nextafter(integral_r64, integral_r64 - 1.0)
    );
    ASSERT(
        fractional_r64 < r64__nextafter(fractional_r64, fractional_r64 + 1.0) &&
        fractional_r64 > r64__nextafter(fractional_r64, fractional_r64 - 1.0)
    );
    ASSERT(
        integral_r64 < expected_integral_r64 + EPSILON_R64 &&
        integral_r64 > expected_integral_r64 - EPSILON_R64
    );
    ASSERT(
        fractional_r64 < expected_fractional_r64 + EPSILON_R64 &&
        fractional_r64 > expected_fractional_r64 - EPSILON_R64
    );
    
    ASSERT(s64__len(0) == 1);
    ASSERT(s64__len(1) == 1);
    ASSERT(s64__len(-1) == 2);
    ASSERT(s64__len(12) == 2);
    ASSERT(s64__len(-12) == 3);
    ASSERT(s64__len(12345) == 5);
    ASSERT(s64__len(-12345) == 6);

    return 0;
}
