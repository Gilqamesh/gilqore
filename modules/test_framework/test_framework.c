#include "test_framework.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"

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
    struct file_reader reader;
    file_reader__create(&reader, &error_codes_file);
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
            return ;
        }
        file_reader__read_while(&reader, NULL, 0, "\r\n");
    } while (bytes_read > 0);

    file_reader__destroy(&reader);
    file__close(&error_codes_file);

    // error_code__exit(MODULE_COMPILER_ERROR_CODE_DID_NOT_FIND_ERROR_CODE);
    error_code__exit(33584);
}
