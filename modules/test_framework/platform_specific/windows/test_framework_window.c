#include "test_framework/test_framework.h"

#include <Windows.h>

#include <stdio.h>

#include "common/error_code.h"
#include "libc/libc.h"
#include "system/process/process.h"
#include "tools/module_compiler/module_compiler.h"

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

    // note: get command line arguments and convert them to ascii
    LPWSTR* wargv = CommandLineToArgvW(
        GetCommandLineW(),
        &g_test_framework.argc
    );
    if (wargv == NULL) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TO_ARGV_W_FAILED);
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

    struct process module_process;
    char command_line[512];
    u32 command_line_index = 0;
    for (u32 cmd_index = 1; cmd_index < (u32) test_framework__argc(); ++cmd_index) {
        char* cur_cmd = test_framework__argv()[cmd_index];
        while (*cur_cmd != '\0' && command_line_index + 1 < ARRAY_SIZE(command_line)) {
            command_line[command_line_index++] = *cur_cmd;
            ++cur_cmd;
        }
        if (cmd_index + 1 < (u32) test_framework__argc()) {
            command_line[command_line_index++] = ' ';
            if (command_line_index >= ARRAY_SIZE(command_line)) {
                error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TOO_LONG);
            }
        }
    }
    command_line[command_line_index] = '\0';
    printf("%s:\n", command_line);
    // note: run the main function of the tester module
    u32 before_test_allocated_memory_size = libc__unfreed_byte_count();
    if (process__create(&module_process, command_line) == false) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_PROCESS_CREATE_FAILED);
    }
    process__wait_execution(&module_process);
    u32 module_process_exit_code = process__destroy(&module_process);
    char error_code_msg[512];
    if (module_process_exit_code > 0) {
        module_compiler__translate_error_code(module_process_exit_code, error_code_msg, ARRAY_SIZE(error_code_msg));
        printf("Error code: %u\nReason: %s\n", module_process_exit_code, error_code_msg);
    } else {
        printf("Success\n");
    }

    u32 after_test_allocated_memory_size = libc__unfreed_byte_count();
    if (after_test_allocated_memory_size != before_test_allocated_memory_size) {
        printf("Before: %u\nAfter: %u\n", before_test_allocated_memory_size, after_test_allocated_memory_size);
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_MEMORY_LEAK_IN_TESTED_MODULE);
    }

    // note: free resources
    for (s32 arg_index = 0; arg_index < argv_size; ++arg_index) {
        libc__free(g_test_framework.argv[arg_index]);
    }
    libc__free(g_test_framework.argv);

    return 0;
}
