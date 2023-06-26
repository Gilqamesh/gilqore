#include "test_framework/test_framework.h"

#include "gil_math/lerp/lerp.h"

#include "libc/libc.h"

int main() {
    TEST_FRAMEWORK_ASSERT(lerp__u32(2, 1.0f, 30) == 30);

    struct color result_color = lerp__color(
        color__pack(0, 0, 0, 255),
        0.5f,
        color__pack(255, 255, 255, 0)
    );
    libc__printf("%u\n", color__channel_red(result_color));
    libc__printf("%u\n", color__channel_green(result_color));
    libc__printf("%u\n", color__channel_blue(result_color));
    libc__printf("%u\n", color__channel_alpha(result_color));
    TEST_FRAMEWORK_ASSERT(
        color__channel_red(result_color) == 127 &&
        color__channel_green(result_color) == 127 &&
        color__channel_blue(result_color) == 127 &&
        color__channel_alpha(result_color) == 127
    );

    return 0;
}
