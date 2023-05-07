#ifndef MODULE_COMPILER_DEFS_H
# define MODULE_COMPILER_DEFS_H

# include "../tools_defs.h"

enum MODULE_COMPILER_ERROR_CODE {
    MODULE_COMPILER_ERROR_CODE_PATH_TOO_LONG = ERROR_CODE_MODULE_COMPILER,
    MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_TOO_LONG,
    MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_UNKNOWN,
    MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_KEY_TOO_LONG,
    MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_VALUE_TOO_LONG,
    MODULE_COMPILER_ERROR_CODE_CONFIG_MODULE_DEPENDENCY_NOT_FOUND
};

#endif
