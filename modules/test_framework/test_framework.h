#ifndef TEST_FRAMEWORK_H
# define TEST_FRAMEWORK_H

# include "test_framework_defs.h"

# include "common/error_code.h"

# include <stdio.h>

# define TEST_FRAMEWORK_ASSERT(condition) { \
    if((condition) == false) { \
        printf("Assertion failed: %s, file %s, line %d\n", #condition, __FILE__, __LINE__); \
        error_code__exit(TEST_FRAMEWORK_ERROR_CODE_ASSERT); \
    } \
}

// todo: can't use this yet, because module_compiler is not ready
GIL_API s32 test_framework__printf(const char* format, ...);

#endif
