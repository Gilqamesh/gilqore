#include "test_framework/test_framework.h"

#include "graphics/color/color.h"

#include "gil_math/clamp/clamp.h"
#include "gil_math/random/random.h"
#include "libc/libc.h"

#define COLOR_CHANNEL_VALUE_MIN 0
#define COLOR_CHANNEL_VALUE_MAX 255

struct color_op_result {
    struct color color;
    u32 red;
    u32 green;
    u32 blue;
    u32 alpha;
};

static struct color_op_result test_color_add(
    s32 red_a, s32 green_a, s32 blue_a, s32 alpha_a,
    s32 red_b, s32 green_b, s32 blue_b, s32 alpha_b,
    struct color color_a,
    struct color color_b
) {
    struct color_op_result result;

    struct color result_color = color__add(color_a, color_b);
    result.color = result_color;

    result.red = clamp__s32(COLOR_CHANNEL_VALUE_MIN, red_a + red_b, COLOR_CHANNEL_VALUE_MAX);
    result.green = clamp__s32(COLOR_CHANNEL_VALUE_MIN, green_a + green_b, COLOR_CHANNEL_VALUE_MAX);
    result.blue = clamp__s32(COLOR_CHANNEL_VALUE_MIN, blue_a + blue_b, COLOR_CHANNEL_VALUE_MAX);
    result.alpha = clamp__s32(COLOR_CHANNEL_VALUE_MIN, alpha_a + alpha_b, COLOR_CHANNEL_VALUE_MAX);

    return result;
}

static struct color_op_result test_color_sub(
    s32 red_a, s32 green_a, s32 blue_a, s32 alpha_a,
    s32 red_b, s32 green_b, s32 blue_b, s32 alpha_b,
    struct color color_a,
    struct color color_b
) {
    struct color_op_result result;

    struct color result_color = color__sub(color_a, color_b);
    result.color = result_color;

    result.red = clamp__s32(COLOR_CHANNEL_VALUE_MIN, red_a - red_b, COLOR_CHANNEL_VALUE_MAX);
    result.green = clamp__s32(COLOR_CHANNEL_VALUE_MIN, green_a - green_b, COLOR_CHANNEL_VALUE_MAX);
    result.blue = clamp__s32(COLOR_CHANNEL_VALUE_MIN, blue_a - blue_b, COLOR_CHANNEL_VALUE_MAX);
    result.alpha = clamp__s32(COLOR_CHANNEL_VALUE_MIN, alpha_a - alpha_b, COLOR_CHANNEL_VALUE_MAX);

    return result;
}

static struct color_op_result test_color_scale(
    s32 red, s32 green, s32 blue, s32 alpha,
    r32 scale,
    struct color color
) {
    struct color_op_result result;

    struct color result_color = color__scale_r32(color, scale);
    result.color = result_color;

    result.red = clamp__s32(COLOR_CHANNEL_VALUE_MIN, red * scale, COLOR_CHANNEL_VALUE_MAX);
    result.green = clamp__s32(COLOR_CHANNEL_VALUE_MIN, green * scale, COLOR_CHANNEL_VALUE_MAX);
    result.blue = clamp__s32(COLOR_CHANNEL_VALUE_MIN, blue * scale, COLOR_CHANNEL_VALUE_MAX);
    result.alpha = clamp__s32(COLOR_CHANNEL_VALUE_MIN, alpha * scale, COLOR_CHANNEL_VALUE_MAX);

    return result;
}

static void test_validate_op_result(
    struct color_op_result op_result
) {
    struct color expected = color(
        op_result.red,
        op_result.green,
        op_result.blue,
        op_result.alpha
    );
    TEST_FRAMEWORK_ASSERT(color__channel_red(expected) == op_result.red);
    TEST_FRAMEWORK_ASSERT(color__channel_green(expected) == op_result.green);
    TEST_FRAMEWORK_ASSERT(color__channel_blue(expected) == op_result.blue);
    TEST_FRAMEWORK_ASSERT(color__channel_alpha(expected) == op_result.alpha);
    TEST_FRAMEWORK_ASSERT(color__eq(op_result.color, expected));
}

static void test_color_ops(
    u32 red_a, u32 green_a, u32 blue_a, u32 alpha_a,
    u32 red_b, u32 green_b, u32 blue_b, u32 alpha_b,
    r32 scale
) {
    struct color color_a = color(
        red_a,
        green_a,
        blue_a,
        alpha_a
    );
    TEST_FRAMEWORK_ASSERT(color__channel_red(color_a) == red_a);
    TEST_FRAMEWORK_ASSERT(color__channel_green(color_a) == green_a);
    TEST_FRAMEWORK_ASSERT(color__channel_blue(color_a) == blue_a);
    TEST_FRAMEWORK_ASSERT(color__channel_alpha(color_a) == alpha_a);
    u32 color_a_unpacked = color__unpack(color_a);
    TEST_FRAMEWORK_ASSERT(
        color__eq(
            color__pack(color_a_unpacked),
            color_a
        )
    );
    struct color color_b = color(
        red_b,
        green_b,
        blue_b,
        alpha_b
    );
    TEST_FRAMEWORK_ASSERT(color__channel_red(color_b) == red_b);
    TEST_FRAMEWORK_ASSERT(color__channel_green(color_b) == green_b);
    TEST_FRAMEWORK_ASSERT(color__channel_blue(color_b) == blue_b);
    TEST_FRAMEWORK_ASSERT(color__channel_alpha(color_b) == alpha_b);
    u32 color_b_unpacked = color__unpack(color_b);
    TEST_FRAMEWORK_ASSERT(
        color__eq(
            color__pack(color_b_unpacked),
            color_b
        )
    );

    struct color_op_result op_result = test_color_add(
        red_a, green_a, blue_a, alpha_a,
        red_b, green_b, blue_b, alpha_b,
        color_a, color_b
    );
    test_validate_op_result(op_result);

    op_result = test_color_sub(
        red_a, green_a, blue_a, alpha_a,
        red_b, green_b, blue_b, alpha_b,
        color_a, color_b
    );
    test_validate_op_result(op_result);

    op_result = test_color_scale(
        red_a, green_a, blue_a, alpha_a,
        scale,
        color_a
    );
    test_validate_op_result(op_result);
}

int main() {
    struct random randomizer;
    random__init(&randomizer, 42);

    for (u32 i = 0; i < 10000; ++i) {
        u32 red_a   = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 green_a = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 blue_a  = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 alpha_a = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 red_b   = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 green_b = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 blue_b  = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        u32 alpha_b = random__u32_closed(&randomizer, COLOR_CHANNEL_VALUE_MIN, COLOR_CHANNEL_VALUE_MAX);
        r32 scale   = random__r32_closed(&randomizer, -2.0f, 3.0f);
        test_color_ops(
            red_a, green_a, blue_a, alpha_a,
            red_b, green_b, blue_b, alpha_b,
            scale
        );
    }

    return 0;
}
