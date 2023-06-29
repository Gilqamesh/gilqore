#include "test_framework/test_framework.h"

#include "types/string/string.h"
#include "libc/libc.h"

#include <stdarg.h>

#define TERMINATING_PTR ((void*) 0x12345678)

struct test_string_params {
    char* str;
    u32 str_len;
    char* set;
    u32 n;
    bool return_last_occurance;
};

static void test_fn(
    const char* expected,
    char* (*fn_to_apply_on_str_buffer)(struct test_string_params*),
    struct test_string_params* test_params
) {
    char* result = fn_to_apply_on_str_buffer(test_params);
    if (result == NULL) {
        TEST_FRAMEWORK_ASSERT(expected == NULL);
    } else {
        TEST_FRAMEWORK_ASSERT(
            libc__strcmp(
                result,
                expected
            ) == 0
        );
    }
}

static void test_v(
    char* (*fn_to_apply_on_str_buffer)(struct test_string_params*),
    const char* test_str,
    char* str_buffer,
    u32 str_buffer_size,
    ...
) {
    u32 test_str_len = libc__strlen(test_str);
    TEST_FRAMEWORK_ASSERT(test_str_len + 1 <= str_buffer_size);
    libc__strncpy(str_buffer, test_str, str_buffer_size);

    va_list ap;

    va_start(ap, str_buffer_size);

    struct test_string_params test_params;
    test_params.str = str_buffer;
    test_params.str_len = libc__strlen(str_buffer);
    while (1) {
        char* set = va_arg(ap, char*);
        if (set == TERMINATING_PTR) {
            break ;
        }
        u32 n = va_arg(ap, u32);
        bool return_last_occurance = va_arg(ap, s32);
        char* expected = va_arg(ap, char*);
        test_params.n = n;
        test_params.set = set;
        test_params.return_last_occurance = return_last_occurance;
        // libc__printf("%s\n", expected);
        test_fn(
            expected,
            fn_to_apply_on_str_buffer,
            &test_params
        );
    }

    va_end(ap);
}

char* test_to_upper(struct test_string_params* params) {
    string__to_upper(params->str);

    return params->str;
}

char* test_search_n(struct test_string_params* params) {
    return string__search_n(params->str, params->str_len, params->set, params->n, params->return_last_occurance);
}
char* test_rsearch_n(struct test_string_params* params) {
    return string__rsearch_n(params->str, params->str_len, params->set, params->n, params->return_last_occurance);
}
char* test_search_while(struct test_string_params* params) {
    return string__search_while(params->str, params->str_len, params->set, params->n);
}
char* test_search_while_not(struct test_string_params* params) {
    return string__search_while_not(params->str, params->str_len, params->set, params->n);
}
char* test_rsearch_while(struct test_string_params* params) {
    return string__rsearch_while(params->str, params->str_len, params->set, params->n);
}
char* test_rsearch_while_not(struct test_string_params* params) {
    return string__rsearch_while_not(params->str, params->str_len, params->set, params->n);
}

int main() {
    u32 str_buffer_size = 1024;
    char* str_buffer = libc__malloc(str_buffer_size);

    const char* test_str = "hey Bro Whadap";

    test_v(
        &test_to_upper,
        test_str,
        str_buffer,
        str_buffer_size,
        "h", 0, false, "HEY BRO WHADAP",
        TERMINATING_PTR
    );

    test_v(
        &test_search_n,
        test_str,
        str_buffer,
        str_buffer_size,
        "h",       0, false, NULL,
        "h",       1, false, "hey Bro Whadap",
        "h",       2, false, "hadap",
        "b",       1, false, NULL,
        "o",       1, false, "o Whadap",
        "o",       2, false, NULL,
        "a",       2, false, "ap",
        "apo",     1, false, "o Whadap",
        "apo",     2, false, "adap",
        "apo",     3, false, "ap",
        "apo",     4, false, "p",
        "apo",     5, false, NULL,
        "apoopa",  1, false, "o Whadap",
        "apoopa",  2, false, "adap",
        "apoopa",  3, false, "ap",
        "apoopa",  4, false, "p",
        "apoopa",  5, false, NULL,
        "   ",     1, false, " Bro Whadap",
        "   ",     2, false, " Whadap",
        "   ",     3, false, NULL,
        "lmtvlmv", 1, false, NULL,
        "lmtvlmv", 3, false, NULL,
        "h",       0, true,  NULL,
        "h",       1, true,  "hey Bro Whadap",
        "h",       2, true,  "hadap",
        "h",       3, true,  "hadap",
        "b",       1, true,  NULL,
        "o",       1, true,  "o Whadap",
        "o",       2, true,  "o Whadap",
        "a",       2, true,  "ap",
        "apo",     1, true,  "o Whadap",
        "apo",     2, true,  "adap",
        "apo",     3, true,  "ap",
        "apo",     4, true,  "p",
        "apo",     5, true,  "p",
        "apoopa",  1, true,  "o Whadap",
        "apoopa",  2, true,  "adap",
        "apoopa",  3, true,  "ap",
        "apoopa",  4, true,  "p",
        "apoopa",  5, true,  "p",
        "   ",     1, true,  " Bro Whadap",
        "   ",     2, true,  " Whadap",
        "   ",     3, true,  " Whadap",
        "lmtvlmv", 1, true,  NULL,
        "lmtvlmv", 3, true,  NULL,
        TERMINATING_PTR
    );

    test_v(
        &test_rsearch_n,
        test_str,
        str_buffer,
        str_buffer_size,
        "h",       0, false, NULL,
        "h",       1, false, "hadap",
        "h",       2, false, "hey Bro Whadap",
        "b",       1, false, NULL,
        "o",       1, false, "o Whadap",
        "o",       2, false, NULL,
        "a",       2, false, "adap",
        "x",       0, false, NULL,
        "apo",     0, false, NULL,
        "apo",     1, false, "p",
        "apo",     2, false, "ap",
        "apo",     3, false, "adap",
        "apo",     4, false, "o Whadap",
        "apo",     5, false, NULL,
        "apoopa",  1, false, "p",
        "apoopa",  2, false, "ap",
        "apoopa",  3, false, "adap",
        "apoopa",  4, false, "o Whadap",
        "apoopa",  5, false, NULL,
        "   ",     1, false, " Whadap",
        "   ",     2, false, " Bro Whadap",
        "   ",     3, false, NULL,
        "lmtvlmv", 1, false, NULL,
        "lmtvlmv", 3, false, NULL,
        "h",       0, true,  NULL,
        "h",       1, true,  "hadap",
        "h",       2, true,  "hey Bro Whadap",
        "h",       3, true,  "hey Bro Whadap",
        "b",       1, true,  NULL,
        "o",       1, true,  "o Whadap",
        "o",       2, true,  "o Whadap",
        "a",       2, true,  "adap",
        "a",       3, true,  "adap",
        "apo",     0, true,  NULL,
        "apo",     1, true,  "p",
        "apo",     2, true,  "ap",
        "apo",     3, true,  "adap",
        "apo",     4, true,  "o Whadap",
        "apo",     5, true,  "o Whadap",
        "apoopa",  1, true,  "p",
        "apoopa",  2, true,  "ap",
        "apoopa",  3, true,  "adap",
        "apoopa",  4, true,  "o Whadap",
        "apoopa",  5, true,  "o Whadap",
        "   ",     1, true,  " Whadap",
        "   ",     2, true,  " Bro Whadap",
        "   ",     3, true,  " Bro Whadap",
        "lmtvlmv", 1, true,  NULL,
        "lmtvlmv", 3, true,  NULL,
        TERMINATING_PTR
    );

    // set, n, bool, expected
    const char* test_str2 = "hhhhey Bro Whadap";
    test_v(
        &test_search_while,
        test_str2,
        str_buffer,
        str_buffer_size,
        "h",           0,   false, test_str2,
        "h",           1,   false, "hhhey Bro Whadap",
        "h",           2,   false, "hhey Bro Whadap",
        "h",           3,   false, "hey Bro Whadap",
        "h",           4,   false, "ey Bro Whadap",
        "h",           50,  false, "ey Bro Whadap",
        "yhh e",       0,   false, test_str2,
        "yhh e",       1,   false, "hhhey Bro Whadap",
        "yhh e",       2,   false, "hhey Bro Whadap",
        "yhh e",       3,   false, "hey Bro Whadap",
        "yhh e",       4,   false, "ey Bro Whadap",
        "yhh e",       5,   false, "y Bro Whadap",
        "yhh e",       6,   false, " Bro Whadap",
        "yhh e",       7,   false, "Bro Whadap",
        "yhh e",       50,  false, "Bro Whadap",
        "a",           0,   false, test_str2,
        "a",           1,   false, test_str2,
        "hBorp ayeWd", 50,  false, "",
        TERMINATING_PTR
    );

    test_v(
        &test_search_while_not,
        test_str2,
        str_buffer,
        str_buffer_size,
        "h",  0,  false, test_str2,
        "h",  1,  false, test_str2,
        "h",  50, false, test_str2,
        "e",  0,  false, test_str2,
        "e",  1,  false, "hhhey Bro Whadap",
        "e",  2,  false, "hhey Bro Whadap",
        "e",  3,  false, "hey Bro Whadap",
        "e",  4,  false, "ey Bro Whadap",
        "e",  50, false, "ey Bro Whadap",
        "",   0,  false, test_str2,
        "",   1,  false, test_str2,
        "B",  50, false, "Bro Whadap",
        "Wx", 50, false, "Whadap",
        "x",  50, false, "",
        TERMINATING_PTR
    );

    test_v(
        &test_rsearch_while,
        test_str2,
        str_buffer,
        str_buffer_size,
        "p",            0,  false, "",
        "p",            1,  false, "p",
        "p",            3,  false, "p",
        "pad",          1,  false, "p",
        "pad",          2,  false, "ap",
        "pad",          3,  false, "dap",
        "pad",          4,  false, "adap",
        "pad",          50, false, "adap",
        " WhpadBorhey", 50, false, test_str2,
        TERMINATING_PTR
    );

    // "hhhhey Bro Whadap"
    test_v(
        &test_rsearch_while_not,
        test_str2,
        str_buffer,
        str_buffer_size,
        "x", 0,  false, "",
        "x", 1,  false, "p",
        "x", 2,  false, "ap",
        "x", 3,  false, "dap",
        "x", 50, false, test_str2,
        "W", 50, false, "Whadap",
        TERMINATING_PTR
    );

    libc__free(str_buffer);

    const char* str = "lajos";
    const char* prefix = "laf";
    TEST_FRAMEWORK_ASSERT(string__starts_with(str, prefix) == NULL);

    const char* prefix2 = "laj";
    TEST_FRAMEWORK_ASSERT(string__starts_with(str, prefix2) == str + 3 && *(str + 3) == 'o');

    const char* prefix3 = "";
    TEST_FRAMEWORK_ASSERT(string__starts_with(str, prefix3) == str + 0 && *(str + 0) == 'l');

    const char* haystack = "aaasndiu32apple8yfdsbllsbd";
    u32 haystack_len = libc__strlen(haystack);
    const char* needle = "apple";
    u32 needle_len = libc__strlen(needle);
    char* after_needle = string__search(
        haystack, haystack_len,
        needle, needle_len
    );
    TEST_FRAMEWORK_ASSERT(libc__strcmp(after_needle, "8yfdsbllsbd") == 0);

    after_needle = string__search(
        haystack, haystack_len,
        haystack, haystack_len
    );
    TEST_FRAMEWORK_ASSERT(libc__strcmp(after_needle, "") == 0);

    after_needle = string__search(
        haystack, haystack_len,
        "", 0
    );
    TEST_FRAMEWORK_ASSERT(libc__strcmp(after_needle, haystack) == 0);

    return 0;
}
