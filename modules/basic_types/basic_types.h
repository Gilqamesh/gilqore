#ifndef BASIC_TYPES_H
# define BASIC_TYPES_H

# include "basic_types_defs.h"

GIL_API r32 r32__integer_part(r32 r);
GIL_API r64 r64__integer_part(r64 r);

GIL_API r32 r32__decimal_part(r32 r);
GIL_API r64 r64__decimal_part(r64 r);

GIL_API u8  u8__abs_sub(u8 a, u8 b);
GIL_API u16 u16__abs_sub(u16 a, u16 b);
GIL_API u32 u32__abs_sub(u32 a, u32 b);
GIL_API u64 u64__abs_sub(u64 a, u64 b);

GIL_API s8  s8__abs(s8 a);
GIL_API s16 s16__abs(s16 a);
GIL_API s32 s32__abs(s32 a);
GIL_API s64 s64__abs(s64 a);

GIL_API s8  s8__abs_sub(s8 a, s8 b);
GIL_API s16 s16__abs_sub(s16 a, s16 b);
GIL_API s32 s32__abs_sub(s32 a, s32 b);
GIL_API s64 s64__abs_sub(s64 a, s64 b);

GIL_API r32 r32__abs(r32 a);
GIL_API r64 r64__abs(r64 a);

GIL_API r32 r32__abs_sub(r32 a, r32 b);
GIL_API r64 r64__abs_sub(r64 a, r64 b);

#endif
