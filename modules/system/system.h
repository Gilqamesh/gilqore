#ifndef SYSTEM_H
# define SYSTEM_H

# include "system_defs.h"

// @brief incur some initialization overhead, must use this fn before any system calls here
GIL_API void system__init_module(void);

GIL_API void system__sleep(u32 seconds);
GIL_API void system__usleep(u32 useconds);

#endif
