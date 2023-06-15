#ifndef BASIC_TYPES_H
# define BASIC_TYPES_H

# include "basic_types_defs.h"

// @returns fractional part of r as well as the integral part
PUBLIC_API r32 r32__modular_fraction(r32 r, r32* integral_part);
// @returns fractional part of r as well as the integral part
PUBLIC_API r64 r64__modular_fraction(r64 r, r64* integral_part);

PUBLIC_API r32 r32__integral_part(r32 r);
PUBLIC_API r64 r64__integral_part(r64 r);

PUBLIC_API r32 r32__fractional_part(r32 r);
PUBLIC_API r64 r64__fractional_part(r64 r);


// @returns number of digits in n + 1 if negative
PUBLIC_API u32 s64__len(s64 n);

#endif
