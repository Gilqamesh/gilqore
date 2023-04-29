#include "test_framework/test_framework.h"

#include <Windows.h>

#include "common/error_code.h"
#include "libc/libc.h"

struct test_framework_window {
    s32    argc;
    char** argv;
};

static struct test_framework_window g_test_framework;

GIL_API int WinMain(
    HINSTANCE instance,
    HINSTANCE prev_instance,
    LPSTR     cmd_line,
    int       show_cmd
) {
    (void) instance;
    (void) prev_instance;
    (void) cmd_line;
    (void) show_cmd;

    HMODULE module_handle = GetModuleHandleA(NULL);
    if (module_handle == NULL) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_MODULE_MAIN_UNDEFINED);
        UNREACHABLE_CODE;
    }
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
#pragma GCC diagnostic ignored "-Wpragmas"
#endif
    void (*module_main)() = (void *) GetProcAddress(module_handle, "test_module_main");
#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif
    if (module_main == NULL) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_MODULE_MAIN_UNDEFINED);
        UNREACHABLE_CODE;
    }

    // note: get command line arguments and convert them to ascii
    LPWSTR* wargv = CommandLineToArgvW(
        GetCommandLineW(),
        &g_test_framework.argc
    );
    if (wargv == NULL) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TO_ARGVW);
        UNREACHABLE_CODE;
    }
    s32 argv_size = g_test_framework.argc + 1;
    g_test_framework.argv = (char **) libc__malloc(argv_size * sizeof(*g_test_framework.argv));
    g_test_framework.argv[g_test_framework.argc] = NULL;
    for (s32 arg_index = 0; arg_index < g_test_framework.argc; ++arg_index) {
        u64 arg_size = wcstombs(NULL, wargv[arg_index], 0);
        g_test_framework.argv[arg_index] = (char *) libc__malloc((arg_size + 1) * sizeof(**g_test_framework.argv));
        g_test_framework.argv[arg_index][arg_size] = '\0';
        u64 copied_arg_size = wcstombs(
            g_test_framework.argv[arg_index],
            wargv[arg_index],
            arg_size
        );
        ASSERT(copied_arg_size == arg_size);
    }
    LocalFree(wargv);

    // note: run the main function of the tester module
    module_main();

    // note: free resources
    for (s32 arg_index = 0; arg_index < argv_size; ++arg_index) {
        libc__free(g_test_framework.argv[arg_index]);
    }
    libc__free(g_test_framework.argv);

    return 0;
}

s32    test_framework__argc() {
    return g_test_framework.argc;
}

char** test_framework__argv() {
    return g_test_framework.argv;
}
