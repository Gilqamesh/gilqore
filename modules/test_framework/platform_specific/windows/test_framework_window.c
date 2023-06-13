#include "test_framework/test_framework.h"

#include <Windows.h>

#include "common/error_code.h"
#include "libc/libc.h"
#include "system/process/process.h"

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
    s32 argc;
    LPWSTR* wargv = CommandLineToArgvW(
        GetCommandLineW(),
        &argc
    );
    if (wargv == NULL) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TO_ARGV_W_FAILED);
    }
    s32 argv_size = argc + 1;
    char** argv = (char **) libc__malloc(argv_size * sizeof(*argv));
    argv[argc] = NULL;
    for (s32 arg_index = 0; arg_index < argc; ++arg_index) {
        u64 arg_size = wcstombs(NULL, wargv[arg_index], 0);
        argv[arg_index] = (char *) libc__malloc((arg_size + 1) * sizeof(**argv));
        argv[arg_index][arg_size] = '\0';
        u64 copied_arg_size = wcstombs(
            argv[arg_index],
            wargv[arg_index],
            arg_size
        );
        ASSERT(copied_arg_size == arg_size);
    }
    LocalFree(wargv);

    struct process module_process;
    char command_line[512];
    u32 command_line_index = 0;
    for (u32 cmd_index = 1; cmd_index < (u32) argc; ++cmd_index) {
        char* cur_cmd = argv[cmd_index];
        while (*cur_cmd != '\0' && command_line_index + 1 < ARRAY_SIZE(command_line)) {
            command_line[command_line_index++] = *cur_cmd;
            ++cur_cmd;
        }
        if (cmd_index + 1 < (u32) argc) {
            command_line[command_line_index++] = ' ';
            if (command_line_index >= ARRAY_SIZE(command_line)) {
                error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TOO_LONG);
            }
        }
    }
    command_line[command_line_index] = '\0';
    libc__printf("%s:\n", command_line);
    // note: run the main function of the tester module
    u32 before_test_allocated_memory_size = libc__unfreed_byte_count();
    if (process__create(&module_process, command_line) == false) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_PROCESS_CREATE_FAILED);
    }
    process__wait_execution(&module_process);
    u32 module_process_exit_code = process__destroy(&module_process);
    char error_code_msg[512];
    if (module_process_exit_code > 0) {
        test_framework__translate_error_code(module_process_exit_code, error_code_msg, ARRAY_SIZE(error_code_msg));
        libc__printf("Error code: %u\nReason: %s\n", module_process_exit_code, error_code_msg);
    } else {
        libc__printf("Success\n");
    }

    u32 after_test_allocated_memory_size = libc__unfreed_byte_count();
    if (
        after_test_allocated_memory_size != before_test_allocated_memory_size && 
        module_process_exit_code == 0 // only then I care about unfreed memory
    ) {
        libc__printf("Before: %u\nAfter: %u\n", before_test_allocated_memory_size, after_test_allocated_memory_size);
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_MEMORY_LEAK_IN_TESTED_MODULE);
    }

    // note: free resources
    for (s32 arg_index = 0; arg_index < argv_size; ++arg_index) {
        libc__free(argv[arg_index]);
    }
    libc__free(argv);

    TEST_FRAMEWORK_ASSERT(libc__unfreed_byte_count() == 0);

    return 0;
}

s32 test_framework__printf(const char* format, ...) {
    s32      printed_bytes = 0;
#if defined(TEST_FRAMEWORK_SHOULD_PRINT)
    va_list  ap;

    va_start(ap, format);
    printed_bytes = libc__vprintf(format, ap);
    va_end(ap);
#else
    (void) format;
#endif
    return printed_bytes;
}
