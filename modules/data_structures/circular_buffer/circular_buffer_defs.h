#ifndef CIRCULAR_BUFFER_DEFS_H
# define CIRCULAR_BUFFER_DEFS_H

# include "../data_structures_defs.h"

enum CIRCULAR_BUFFER_ERROR_CODE {
    CIRCULAR_BUFFER_ERROR_CODE_FATAL = ERROR_CODE_CIRCULAR_BUFFER,
    CIRCULAR_BUFFER_ERROR_CODE_INVALID_PARAMETERS_DURING_CREATION
};

#endif
