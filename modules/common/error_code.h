#ifndef ERROR_CODE_H
# define ERROR_CODE_H

# include "compile_defs.h"
# include "data_types.h"

enum ERROR_CODE {
    ERROR_CODE_BASIC_TYPES      = 1,
    ERROR_CODE_CIRCULAR_BUFFER  = 100,
    ERROR_CODE_CLAMP            = 200,
    ERROR_CODE_COLOR            = 300,
    ERROR_CODE_COMPARE          = 400,
    ERROR_CODE_CONSOLE          = 500,
    ERROR_CODE_DATA_STRUCTURES  = 600,
    ERROR_CODE_LERP             = 700,
    ERROR_CODE_LIBC             = 800,
    ERROR_CODE_RANDOM           = 900,
    ERROR_CODE_TEST_FRAMEWORK   = 1000,
    ERROR_CODE_VECTOR_TYPES     = 1100
};

GIL_API void error_code__exit(u32 error_code);

#endif
