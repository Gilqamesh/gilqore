#ifndef TEST_FRAMEWORK_H
# define TEST_FRAMEWORK_H

# include "test_framework_defs.h"

# include "common/error_code.h"
# include "libc/libc.h"

# define TEST_FRAMEWORK_ASSERT(condition) { \
    if((condition) == false) { \
        libc__printf("Assertion failed: %s, file %s, line %d\n", #condition, __FILE__, __LINE__); \
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_ASSERT); \
    } \
}

GIL_API s32 test_framework__printf(const char* format, ...);

GIL_API void test_framework__translate_error_code(u32 error_code, char* buffer, u32 buffer_size);

#endif
