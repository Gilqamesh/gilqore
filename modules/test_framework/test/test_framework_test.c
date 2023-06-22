#include "test_framework/test_framework.h"

#include "libc/libc.h"
#include "system/process/process.h"

int main(int argc, char** argv) {
    u32 command_line_size = 512;
    char* command_line = libc__malloc(command_line_size);
    u32 command_line_index = 0;
    for (s32 cmd_index = 1; cmd_index < argc; ++cmd_index) {
        char* cur_cmd = argv[cmd_index];
        while (*cur_cmd != '\0' && command_line_index + 1 < command_line_size) {
            command_line[command_line_index++] = *cur_cmd;
            ++cur_cmd;
        }
        if (cmd_index + 1 < argc) {
            command_line[command_line_index++] = ' ';
            if (command_line_index >= command_line_size) {
                error_code__exit(TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TOO_LONG);
            }
        }
    }
    command_line[command_line_index] = '\0';
    libc__printf("%s:\n", command_line);

    // note: run the main function of the tester module
    u32 before_test_allocated_memory_size = libc__unfreed_byte_count();

    struct process module_process;
    if (process__create(&module_process, command_line) == false) {
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_PROCESS_CREATE_FAILED);
    }
    process__wait_execution(&module_process);
    u32 module_process_exit_code = process__destroy(&module_process);
    char error_code_msg[512];
    if (module_process_exit_code > 0) {
        test_framework__translate_error_code(module_process_exit_code, error_code_msg, ARRAY_SIZE(error_code_msg));
        libc__printf("Error code: %u\nReason: %s\n", module_process_exit_code, error_code_msg);
        // todo: free leaked memory from process
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

    libc__free(command_line);

    TEST_FRAMEWORK_ASSERT(libc__unfreed_byte_count() == 0);

    return 0;
}
