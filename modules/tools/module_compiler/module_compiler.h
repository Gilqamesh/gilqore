#ifndef MODULE_COMPILER_H
# define MODULE_COMPILER_H

# include "module_compiler_defs.h"

// @brief builds and updates the modules hierarchy, sanitize checks dependencies etc.
GIL_API void module_compiler__compile(void);

#endif
