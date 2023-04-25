#ifndef BASIC_TYPES_H
# define BASIC_TYPES_H

# include "basic_types_defs.h"

typedef uint64_t u64;
typedef uint32_t u32;
typedef uint16_t u16;
typedef uint8_t  u8;

typedef int64_t  s64;
typedef int32_t  s32;
typedef int16_t  s16;
typedef int8_t   s8;

typedef float  r32;
typedef double r64;

GIL_API r32 r32__integer_part(r32 r);
GIL_API r32 r32__fractional_part(r32 r);

#endif
