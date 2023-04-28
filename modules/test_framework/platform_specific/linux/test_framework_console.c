#include "test_framework/test_framework.h"

#include "common/error_code.h"
#include "libc/libc.h"

struct test_framework_console {
    s32    argc;
    char** argv;
};

static struct test_framework_console g_test_framework;

GIL_API int main(int argc, char** argv) {
    g_test_framework.argc = argc;
    g_test_framework.argv = argv;
}

s32    test_framework__argc() {
    return g_test_framework.argc;
}

char** test_framework__argv() {
    return g_test_framework.argv;
}
