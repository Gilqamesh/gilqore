#include "libc_platform_specific.h"

#include <stdlib.h>

char* libc__itoa(s64 n, char* buffer, u32 radix)
{
#if defined(COMPILER_MSVC)
    return _itoa((s32)n, buffer, radix);
#else
    return itoa((s32)n, buffer, radix);
#endif
}
