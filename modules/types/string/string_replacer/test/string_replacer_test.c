#include "test_framework/test_framework.h"

#include "types/string/string_replacer/string_replacer.h"

#include "libc/libc.h"
#include "math/clamp/clamp.h"
#include "types/vector_types/v2/v2u32.h"
#include "io/file/file.h"

#include <stdio.h>

#if 0
#define SHOULD_PRINT
#endif

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
#if defined(SHOULD_PRINT)
    printf("At offset %2d: \"%s\"\n", offset, buffer);
#endif
}

static void test_replace_at_position(
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
    u32 expected_str_len = libc__strlen(expected);
    TEST_FRAMEWORK_ASSERT(string_replacer__replace_at_position(
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

static void test_replace_at_position_vformatted(
    struct string_replacer* string_replacer,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    u32 what_position,
    u32 what_length,
    const char* expected,
    const char* with_format,
    va_list ap
) {
    u32 expected_str_len = libc__strlen(expected);
    TEST_FRAMEWORK_ASSERT(string_replacer__replace_at_position_vf(
        string_replacer,
        what_position,
        what_length,
        with_format,
        ap
    ) == expected_str_len);
    for (u32 offset = offset_interval.x; offset <= offset_interval.y; ++offset) {
        test_offset(string_replacer, buffer, buffer_size, expected, expected_str_len, offset);
    }
}

static void test_replace_at_position_formatted(
    struct string_replacer* string_replacer,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    u32 what_position,
    u32 what_length,
    const char* expected,
    const char* with_format,
    ...
) {
    va_list ap;
    va_start(ap, with_format);
    test_replace_at_position_vformatted(
        string_replacer,
        buffer,
        buffer_size,
        offset_interval,
        what_position,
        what_length,
        expected,
        with_format,
        ap
    );
    va_end(ap);
}

static void test_replace_word(
    struct string_replacer* string_replacer,
    u32 number_of_what_occurances,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    const char* what,
    u32 what_length,
    const char* with,
    u32 with_len,
    const char* expected
) {
    u32 expected_str_len = libc__strlen(expected);
    TEST_FRAMEWORK_ASSERT(string_replacer__replace_word(
        string_replacer,
        number_of_what_occurances,
        what,
        what_length,
        with,
        with_len
    ) == expected_str_len);
    for (u32 offset = offset_interval.x; offset <= offset_interval.y; ++offset) {
        test_offset(string_replacer, buffer, buffer_size, expected, expected_str_len, offset);
    }
}

static void test_replace_word_vformatted(
    struct string_replacer* string_replacer,
    u32 max_number_of_what_occurances,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    const char* what,
    u32 what_length,
    const char* expected,
    const char* with_format,
    va_list ap
) {
    u32 expected_str_len = libc__strlen(expected);
    TEST_FRAMEWORK_ASSERT(string_replacer__replace_word_vf(
        string_replacer,
        max_number_of_what_occurances,
        what,
        what_length,
        with_format,
        ap
    ) == expected_str_len);
    for (u32 offset = offset_interval.x; offset <= offset_interval.y; ++offset) {
        test_offset(string_replacer, buffer, buffer_size, expected, expected_str_len, offset);
    }
}

static void test_replace_word_formatted(
    struct string_replacer* string_replacer,
    u32 max_number_of_what_occurances,
    char* buffer,
    u32 buffer_size,
    struct v2u32 offset_interval,
    const char* what,
    u32 what_length,
    const char* expected,
    const char* with_format,
    ...
) {
    va_list ap;
    va_start(ap, with_format);
    test_replace_word_vformatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer,
        buffer_size,
        offset_interval,
        what,
        what_length,
        expected,
        with_format,
        ap
    );
    va_end(ap);
}

static void test_replaces_at_position(
    struct string_replacer* string_replacer,
    const char* original,
    u32 original_size,
    char* buffer,
    u32 buffer_size
) {
    string_replacer__clear(string_replacer, original, original_size);

    const char* with = "AAA";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        0, 1,
        with, libc__strlen(with),
        "AAAey bro wadap"
    );

    const char* with2 = "BBB";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        3, 2,
        with2, libc__strlen(with2),
        "AAAeyBBBro wadap"
    );

    const char* with3 = "[some longass string lollllllllllllllllllllllllllllllllllllll]";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        1, 1,
        with3, libc__strlen(with3),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll]yBBBro wadap"
    );

    const char* with4 = "[trolololololol]";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        2, 1,
        with4, libc__strlen(with4),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro wadap"
    );

    const char* with5 = "[sdfh0a7sdf023uib4jhb dfs]";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        7, 10,
        with5, libc__strlen(with5),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro[sdfh0a7sdf023uib4jhb dfs]"
    );

    const char* with6 = "";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        5, 1,
        with6, libc__strlen(with6),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBo[sdfh0a7sdf023uib4jhb dfs]"
    );

    const char* with7 = "[inserted str]";
    test_replace_at_position(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        6, 0,
        with7, libc__strlen(with7),
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBB[inserted str]o[sdfh0a7sdf023uib4jhb dfs]"
    );
}

static void test_replaces_at_position_formatted(
    struct string_replacer* string_replacer,
    const char* original,
    u32 original_size,
    char* buffer,
    u32 buffer_size
) {
    string_replacer__clear(string_replacer, original, original_size);

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        0, 1,
        "AAAey bro wadap",
        "%s", "AAA"
    );

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        3, 2,
        "AAAeyBBBro wadap",
        "%s", "BBB"
    );

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        1, 1,
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll]yBBBro wadap",
        "%s", "[some longass string lollllllllllllllllllllllllllllllllllllll]"
    );

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        2, 1,
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro wadap",
        "%s", "[trolololololol]"
    );

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        7, 10,
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBro[sdfh0a7sdf023uib4jhb dfs]",
        "%s", "[sdfh0a7sdf023uib4jhb dfs]"
    );

    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        5, 1,
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBBo[sdfh0a7sdf023uib4jhb dfs]",
        "%s", ""
    );
 
    test_replace_at_position_formatted(
        string_replacer,
        buffer,
        buffer_size,
        v2u32(0, 20),
        6, 0,
        "AAA[some longass string lollllllllllllllllllllllllllllllllllllll][trolololololol]BBB[formatted_sting]o[sdfh0a7sdf023uib4jhb dfs]",
        "%s", "[formatted_sting]"
    );
}

static void test_replaces_word(
    struct string_replacer* string_replacer,
    const char* original,
    u32 original_size,
    char* buffer,
    u32 buffer_size
) {
    string_replacer__clear(string_replacer, original, original_size);
    const char* what = "bro";
    const char* with = "breh";
    u32 number_of_what_occurances = 1;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what, libc__strlen(what),
        with, libc__strlen(with),
        "hey breh "
    );

    string_replacer__clear(string_replacer, original, original_size);
    const char* what2 = "hey bro ";
    const char* with2 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    number_of_what_occurances = 1;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what2, libc__strlen(what2),
        with2, libc__strlen(with2),
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    );

    string_replacer__clear(string_replacer, original, original_size);
    const char* what3 = " ";
    const char* with3 = "-";
    number_of_what_occurances = 1;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        with3, libc__strlen(with3),
        "hey-bro "
    );

    string_replacer__clear(string_replacer, original, original_size);
    number_of_what_occurances = 2;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        with3, libc__strlen(with3),
        "hey-bro-"
    );

    string_replacer__clear(string_replacer, original, original_size);
    number_of_what_occurances = 3;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        with3, libc__strlen(with3),
        "hey-bro-"
    );

    string_replacer__clear(string_replacer, original, original_size);
    const char* what4 = "wada";
    const char* with4 = " ";
    number_of_what_occurances = 1;
    test_replace_word(
        string_replacer,
        number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what4, libc__strlen(what4),
        with4, libc__strlen(with4),
        "hey bro "
    );
}

static void test_replaces_word_formatted(
    struct string_replacer* string_replacer,
    const char* original,
    u32 original_size,
    char* buffer,
    u32 buffer_size
) {
    string_replacer__clear(string_replacer, original, original_size);
    const char* what = "bro";
    u32 max_number_of_what_occurances = 1;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what, libc__strlen(what),
        "hey breh ",
        "%s", "breh"
    );

    string_replacer__clear(string_replacer, original, original_size);
    const char* what2 = "hey bro ";
    max_number_of_what_occurances = 1;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what2, libc__strlen(what2),
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "%s", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    );

    string_replacer__clear(string_replacer, original, original_size);
    const char* what3 = " ";
    max_number_of_what_occurances = 1;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        "hey-bro ",
        "%s", "-"
    );

    string_replacer__clear(string_replacer, original, original_size);
    max_number_of_what_occurances = 2;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        "hey-bro-",
        "%s", "-"
    );

    string_replacer__clear(string_replacer, original, original_size);
    max_number_of_what_occurances = 3;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what3, libc__strlen(what3),
        "hey-bro-",
        "%s", "-"
    );

    const char* what4 = "wada";
    string_replacer__clear(string_replacer, original, original_size);
    max_number_of_what_occurances = 1;
    test_replace_word_formatted(
        string_replacer,
        max_number_of_what_occurances,
        buffer, buffer_size,
        v2u32(0, 20),
        what4, libc__strlen(what4),
        "hey bro ",
        "%s", "-"
    );
}

int main() {
    struct string_replacer string_replacer;

    const char* original = "hey bro wadap";
    char original_buffer[256];
    u32 original_len = libc__strlen(original);
    TEST_FRAMEWORK_ASSERT(original_len < ARRAY_SIZE(original_buffer));
    libc__memcpy(original_buffer, original, original_len);
    original_buffer[original_len] = '\0';

#if defined(SHOULD_PRINT)
    printf("Original string: \"%s\"\n", original);
#endif

    u32 buffer_size = 131072;
    char* buffer = libc__malloc(buffer_size);

    u32 total_number_of_replacements = 16;
    u32 average_replacement_size = 1024;
    u32 total_size_of_replacements_in_bytes = total_number_of_replacements * average_replacement_size;
    TEST_FRAMEWORK_ASSERT(
        string_replacer__create(
            &string_replacer,
            original,
            original_len,
            total_number_of_replacements,
            total_size_of_replacements_in_bytes
        ) == true
    );

#if defined(SHOULD_PRINT)
    printf("Original with offset:\n");
#endif
    for (u32 offset = 0; offset < 20; ++offset) {
        test_offset(&string_replacer, buffer, buffer_size, original_buffer, original_len, offset);
    }

    test_replaces_at_position(&string_replacer, original_buffer, original_len, buffer, buffer_size);
    test_replaces_at_position(&string_replacer, original_buffer, original_len, buffer, buffer_size);
    test_replaces_at_position(&string_replacer, original_buffer, original_len, buffer, buffer_size);

    test_replaces_at_position_formatted(&string_replacer, original_buffer, original_len, buffer, buffer_size);
    test_replaces_at_position_formatted(&string_replacer, original_buffer, original_len, buffer, buffer_size);
    test_replaces_at_position_formatted(&string_replacer, original_buffer, original_len, buffer, buffer_size);

    const char* original2 = "hey bro ";
    u32 original2_len = libc__strlen(original2);
    TEST_FRAMEWORK_ASSERT(original2_len < ARRAY_SIZE(original_buffer));
    libc__memcpy(original_buffer, original2, original2_len);
    // note: not null-terminating on purpose, the string replacer should only check up to original2_len anyway
    // original_buffer[original2_len] = '\0';
    test_replaces_word(&string_replacer, original_buffer, original2_len, buffer, buffer_size);
    test_replaces_word(&string_replacer, original_buffer, original2_len, buffer, buffer_size);
    test_replaces_word(&string_replacer, original_buffer, original2_len, buffer, buffer_size);

    test_replaces_word_formatted(&string_replacer, original_buffer, original2_len, buffer, buffer_size);
    test_replaces_word_formatted(&string_replacer, original_buffer, original2_len, buffer, buffer_size);
    test_replaces_word_formatted(&string_replacer, original_buffer, original2_len, buffer, buffer_size);

    struct file file;
    const char* filename = "asid8y0837y2h4rjsdf";
    if (file__exists(filename) == true) {
        TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);
    }
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);

    const char* filecontent =
    "#ifndef FILE_H\n"
    "# define FILE_H\n"
    "\n"
    "#include \"<something.h>\"\n"
    "\n"
    "enum file_error_code {\n"
    "    FILE_ERROR_CODE_PATH_TOO_LONG = 2,\n"
    "    FILE_ERROR_CODE_IDK_BREH = 3,\n"
    "};\n"
    "\n"
    "struct file {\n"
    "    HANDLE handle;\n"
    "};\n"
    "\n"
    "GIL_API bool file__create(struct file* self);\n"
    "GIL_API void file__destroy(struct file* self);\n"
    "\n"
    "#endif\n";
    u32 filecontent_size = libc__strlen(filecontent);
    TEST_FRAMEWORK_ASSERT(file__write(&file, filecontent, filecontent_size) == filecontent_size);

    string_replacer__clear(&string_replacer, filecontent, filecontent_size);
    const char* what =
    "enum file_error_code {\n"
    "    FILE_ERROR_CODE_PATH_TOO_LONG = 2,\n"
    "    FILE_ERROR_CODE_IDK_BREH = 3,\n"
    "};";
    const char* with =
    "enum file_error_code {\n"
    "    FILE_ERROR_CODE_START\n"
    "};";

    u32 max_number_of_what_occurances = 1;
    string_replacer__replace_word(
        &string_replacer,
        max_number_of_what_occurances,
        what, libc__strlen(what),
        with, libc__strlen(with)
    );
    u32 new_string_len = string_replacer__read(
        &string_replacer,
        buffer,
        buffer_size,
        0
    );

    file__close(&file);
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    TEST_FRAMEWORK_ASSERT(file__write(&file, buffer, new_string_len) == new_string_len);
    file__close(&file);

    TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);
    libc__free(buffer);

    return 0;
}
