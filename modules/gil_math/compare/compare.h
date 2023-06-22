#ifndef COMPARE_H
# define COMPARE_H

# include "compare_defs.h"

PUBLIC_API u8  min__u8(u8 a, u8 b);
PUBLIC_API u16 min__u16(u16 a, u16 b);
PUBLIC_API u32 min__u32(u32 a, u32 b);
PUBLIC_API u64 min__u64(u64 a, u64 b);

PUBLIC_API s8  min__s8(s8 a, s8 b);
PUBLIC_API s16 min__s16(s16 a, s16 b);
PUBLIC_API s32 min__s32(s32 a, s32 b);
PUBLIC_API s64 min__s64(s64 a, s64 b);

PUBLIC_API r32 min__r32(r32 a, r32 b);
PUBLIC_API r64 min__r64(r64 a, r64 b);

PUBLIC_API u8  max__u8(u8 a, u8 b);
PUBLIC_API u16 max__u16(u16 a, u16 b);
PUBLIC_API u32 max__u32(u32 a, u32 b);
PUBLIC_API u64 max__u64(u64 a, u64 b);

PUBLIC_API s8  max__s8(s8 a, s8 b);
PUBLIC_API s16 max__s16(s16 a, s16 b);
PUBLIC_API s32 max__s32(s32 a, s32 b);
PUBLIC_API s64 max__s64(s64 a, s64 b);

PUBLIC_API r32 max__r32(r32 a, r32 b);
PUBLIC_API r64 max__r64(r64 a, r64 b);

#endif
