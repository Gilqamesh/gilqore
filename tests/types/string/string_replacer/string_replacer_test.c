#include "test_framework/test_framework.h"

#include "types/string/string_replacer/string_replacer.h"

#include "libc/libc.h"
#include "math/clamp/clamp.h"
#include "types/vector_types/v2/v2u32.h"

#include <stdio.h>

#define SHOULD_PRINT_TEST

static void test_offset(
    struct string_replacer* string_replacer,
    char* buffer,
    u32 buffer_size,
    const char* expected,
    u32 expected_len,
    s32 offset
) {
    u32 expected_new_strlen = clamp__s32(0, expected_len - offset, expected_len);
    TEST_FRAMEWORK_ASSERT(string_replacer__read(string_replacer, buffer, buffer_size, offset) == expected_new_strlen);
    TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, expected + clamp__s32(0, offset, expected_len)) == 0);
    printf("At offset %2d: \"%s\"\n", offset, buffer);
}

static void test_replace(
    struct string_replacer* string_replacer,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    u32 what_position,
    u32 what_length,
    const char* with,
    u32 with_len,
    const char* expected
) {
    u32 expected_what_length = what_length;
    if (what_position + expected_what_length > string_replacer->original_str_len) {
        expected_what_length = string_replacer->original_str_len - what_position;
    }
    u32 expected_str_len = string_replacer->current_str_len + with_len - expected_what_length;
    TEST_FRAMEWORK_ASSERT(string_replacer__replace(
        string_replacer,
        what_position,
        what_length,
        with,
        with_len
    ) == expected_str_len);
    for (u32 offset = offset_interval.x; offset <= offset_interval.y; ++offset) {
        test_offset(string_replacer, buffer, buffer_size, expected, expected_str_len, offset);
    }
}

int main() {
    struct string_replacer string_replacer;

    const char* original = "hey bro wadap";
    u32 original_len = libc__strlen(original);

    printf("Original string: \"%s\"\n", original);

    TEST_FRAMEWORK_ASSERT(string_replacer__create(&string_replacer, original) == true);

    char buffer[1024];

    printf("Original with offset:\n");
    for (u32 offset = 0; offset < 20; ++offset) {
        test_offset(&string_replacer, buffer, ARRAY_SIZE(buffer), original, original_len, offset);
    }

    const char* with = "AAA";
    test_replace(
        &string_replacer,
        buffer,
        ARRAY_SIZE(buffer),
        v2u32(0, 20),
        0, 1,
        with, libc__strlen(with),
        "AAAey bro wadap"
    );

    const char* with2 = "BBB";
    test_replace(
        &string_replacer,
        buffer,
        ARRAY_SIZE(buffer),
        v2u32(0, 20),
        3, 2,
        with2, libc__strlen(with2),
        "AAAeyBBBro wadap"
    );

    const char* with3 = "[some longass string lollllllllllllllllllllllllllllllllllllll]";
    test_replace(
        &string_replacer,
        buffer,
        ARRAY_SIZE(buffer),
        v2u32(0, 20),
        1, 1,
        with3, libc__strlen(with3),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll]yBBBro wadap"
    );

    const char* with4 = "[trolololololol]";
    test_replace(
        &string_replacer,
        buffer,
        ARRAY_SIZE(buffer),
        v2u32(0, 20),
        2, 1,
        with4, libc__strlen(with4),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro wadap"
    );

    const char* with5 = "[sdfh0a7sdf023uib4jhb dfs]";
    test_replace(
        &string_replacer,
        buffer,
        ARRAY_SIZE(buffer),
        v2u32(0, 20),
        7, 10 ,
        with5, libc__strlen(with5),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro[sdfh0a7sdf023uib4jhb dfs]"
    );

    return 0;
}
