#ifndef TEST_FRAMEWORK_H
# define TEST_FRAMEWORK_H

# include "test_framework_defs.h"

// @brief the test module must define this function as its entry point
GIL_API void   test_module_main();

GIL_API s32    test_framework__argc();
GIL_API char** test_framework__argv();

#endif
