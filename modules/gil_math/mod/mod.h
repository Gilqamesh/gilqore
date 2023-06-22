#ifndef MOD_H
# define MOD_H

# include "mod_defs.h"

PUBLIC_API s8  mod__s8(s8 a, s8 b);
PUBLIC_API s16 mod__s16(s16 a, s16 b);
PUBLIC_API s32 mod__s32(s32 a, s32 b);
PUBLIC_API s64 mod__s64(s64 a, s64 b);

PUBLIC_API u8  mod__u8(s8 a, s8 b);
PUBLIC_API u16 mod__u16(s16 a, s16 b);
PUBLIC_API u32 mod__u32(s32 a, s32 b);
PUBLIC_API u64 mod__u64(s64 a, s64 b);

#endif
