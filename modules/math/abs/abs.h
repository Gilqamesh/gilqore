#ifndef ABS_H
# define ABS_H

# include "abs_defs.h"

PUBLIC_API u8  u8__abs_dist(u8 a, u8 b);
PUBLIC_API u16 u16__abs_dist(u16 a, u16 b);
PUBLIC_API u32 u32__abs_dist(u32 a, u32 b);
PUBLIC_API u64 u64__abs_dist(u64 a, u64 b);

PUBLIC_API s8  s8__abs(s8 a);
PUBLIC_API s16 s16__abs(s16 a);
PUBLIC_API s32 s32__abs(s32 a);
PUBLIC_API s64 s64__abs(s64 a);

PUBLIC_API u8  s8__abs_dist(s8 a, s8 b);
PUBLIC_API u16 s16__abs_dist(s16 a, s16 b);
PUBLIC_API u32 s32__abs_dist(s32 a, s32 b);
PUBLIC_API u64 s64__abs_dist(s64 a, s64 b);

PUBLIC_API r32 r32__abs(r32 a);
PUBLIC_API r64 r64__abs(r64 a);

PUBLIC_API r32 r32__abs_dist(r32 a, r32 b);
PUBLIC_API r64 r64__abs_dist(r64 a, r64 b);

#endif
