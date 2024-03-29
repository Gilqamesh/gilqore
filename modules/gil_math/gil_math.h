#ifndef GIL_MATH_H
# define GIL_MATH_H

# include "gil_math_defs.h"

// @returns the next representable r32 value following a in the direction of b
PUBLIC_API r32 r32__nextafter(r32 a, r32 b);
// @returns the next representable r64 value following a in the direction of b
PUBLIC_API r64 r64__nextafter(r64 a, r64 b);

PUBLIC_API bool is_pow_of_2__u32(u32 n);

PUBLIC_API r64 r64__mod(r64 a, r64 b);

#endif // GIL_MATH_H
