#ifndef LIBC_WINDOWS_H
# define LIBC_WINDOWS_H

# include "libc_platform_specific_defs.h"

PUBLIC_API char* libc__itoa(s64 n, char* buffer, u32 radix);

#endif
