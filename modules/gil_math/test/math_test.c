#include "test_framework/test_framework.h"

#include "gil_math/gil_math.h"

int main() {
    for (u32 n = 1, i = 0; i < 32; ++i, n <<= 1) {
        TEST_FRAMEWORK_ASSERT(is_pow_of_2__u32(n));
    }

    u32 known_not_powers_of_2[] = {
        3, 7, 9, 10, 11, 12, 13, 14, 15, 1237, 392, 99, 9987783, 1235678
    };
    for (u32 i = 0; i < ARRAY_SIZE(known_not_powers_of_2); ++i) {
        TEST_FRAMEWORK_ASSERT(is_pow_of_2__u32(known_not_powers_of_2[i]) == false);
    }

    return 0;
}
