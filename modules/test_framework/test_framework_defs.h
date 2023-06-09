#ifndef TEST_FRAMEWORK_DEFS_H
# define TEST_FRAMEWORK_DEFS_H

# include "../modules_defs.h"

enum test_framework_error_code {
    TEST_FRAMEWORK_ERROR_CODE_START,
    TEST_FRAMEWORK_ERROR_CODE_GET_PROC_ADDRESS_FAILED = 46,
    TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TO_ARGV_W_FAILED = 47,
    TEST_FRAMEWORK_ERROR_CODE_MEMORY_LEAK_IN_TESTED_MODULE = 48,
    TEST_FRAMEWORK_ERROR_CODE_PROCESS_CREATE_FAILED = 49,
    TEST_FRAMEWORK_ERROR_CODE_COMMAND_LINE_TOO_LONG = 50,
    TEST_FRAMEWORK_ERROR_CODE_ASSERT = 51,
};

#endif
