#ifndef TEST_FRAMEWORK_H
# define TEST_FRAMEWORK_H

# include "test_framework_defs.h"

# define TEST_FRAMEWORK_ASSERT(condition) ASSERT(condition)

GIL_API s32 test_framework__printf(const char* format, ...);

#endif
