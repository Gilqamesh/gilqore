#ifndef ERROR_CODE_H
# define ERROR_CODE_H

# include "compile_defs.h"
# include "data_types.h"

// note: start error codes for modules
enum ERROR_CODE {
    ERROR_CODE_ABS              = 1,
    ERROR_CODE_BASIC_TYPES      = 100,
    ERROR_CODE_CIRCULAR_BUFFER  = 200,
    ERROR_CODE_CLAMP            = 300,
    ERROR_CODE_COLOR            = 400,
    ERROR_CODE_COMPARE          = 500,
    ERROR_CODE_CONSOLE          = 600,
    ERROR_CODE_DATA_STRUCTURES  = 700,
    ERROR_CODE_FILE             = 800,
    ERROR_CODE_LERP             = 900,
    ERROR_CODE_LIBC             = 1000,
    ERROR_CODE_MATH             = 1100,
    ERROR_CODE_MOD              = 1200,
    ERROR_CODE_RANDOM           = 1300,
    ERROR_CODE_SQRT             = 1400,
    ERROR_CODE_TEST_FRAMEWORK   = 1500,
    ERROR_CODE_VECTOR_TYPES     = 1600
};

GIL_API void error_code__exit(u32 error_code);

#endif
