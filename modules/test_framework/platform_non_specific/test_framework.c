#include "test_framework/test_framework.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "libc/libc.h"
#include "system/process/process.h"

#define ERROR_CODES_FILE_NAME "modules/error_codes"

void test_framework__translate_error_code(u32 error_code, char* buffer, u32 buffer_size) {
    char line_buffer[512];
    char enum_buffer[512];
    char message_buffer[512];
    char format_string_buffer[128];
    if ((u32) libc__snprintf(
        format_string_buffer,
        ARRAY_SIZE(format_string_buffer),
        "%%u %%%ds \"%%%d[^\"]\"",
        ARRAY_SIZE(enum_buffer) - 1,
        ARRAY_SIZE(message_buffer) - 1
    ) >= ARRAY_SIZE(format_string_buffer)) {
        // error_code__exit(TEST_FRAMEWORK_ERROR_CODE_FORMAT_STRING_BUFFER_TOO_SMALL);
        error_code__exit(213);
    }

    struct file error_codes_file;
    if (file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false) {
        // error_code__exit(MODULE_COMPILER_ERROR_CODE_ERROR_CODES_FILE_OPEN_FAIL);
        error_code__exit(12121);
    }

    // todo: allocate memory for reader
    struct file_reader reader;
    TEST_FRAMEWORK_ASSERT(
        file_reader__create(
            &reader,
            &error_codes_file,
            memory_slice__create(buffer, buffer_size)
        )
    );
    u32 bytes_read;
    do {
        bytes_read = file_reader__read_while_not(&reader, line_buffer, ARRAY_SIZE(line_buffer), "\r\n");
        if (bytes_read == 0) {
            // error_code__exit(MODULE_COMPILER_ERROR_CODE_UNEXPECTED_EOF_REACHED_ERROR_CODES);
            error_code__exit(224);
        }
        if (bytes_read == ARRAY_SIZE(line_buffer)) {
            // error_code__exit(MODULE_COMPILER_ERROR_CODE_LINE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
            error_code__exit(436);
        }
        line_buffer[bytes_read] = '\0';
        u32 parsed_error_code;
        if (libc__sscanf(
            line_buffer,
            format_string_buffer,
            &parsed_error_code,
            enum_buffer,
            message_buffer
        ) != 3) {
            // error_code__exit(MODULE_COMPILER_ERROR_CODE_VSSCANF_FAILED_TO_PARSE_LINE_ERROR_CODES);
            error_code__exit(9534);
        }
        if (parsed_error_code == error_code) {
            if (libc__snprintf(buffer, buffer_size, "%s", message_buffer) >= (s32) buffer_size) {
                // error_code__exit(MODULE_COMPILER_ERROR_CODE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
                error_code__exit(23835);
            }
            file_reader__destroy(&reader);
            file__close(&error_codes_file);
            return ;
        }
        file_reader__read_while(&reader, NULL, 0, "\r\n");
    } while (bytes_read > 0);

    file_reader__destroy(&reader);
    file__close(&error_codes_file);

    // error_code__exit(MODULE_COMPILER_ERROR_CODE_DID_NOT_FIND_ERROR_CODE);
    error_code__exit(33584);
}

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
