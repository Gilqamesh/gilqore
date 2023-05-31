#ifndef PROCESS_DEFS_H
# define PROCESS_DEFS_H

# include "../system_defs.h"

enum process_error_code {
    PROCESS_ERROR_CODE_START,
    PROCESS_ERROR_CODE_FORCED_TO_TERMINATE = 19,
    PROCESS_ERROR_CODE_WAIT_FOR_SINGLE_OBJECT_FAILED = 20,
};

#endif
