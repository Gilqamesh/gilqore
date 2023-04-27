#ifndef CLAMP_H
# define CLAMP_H

# include "clamp_defs.h"

struct v2u8;
struct v2u16;
struct v2u32;
struct v2u64;

struct v2s8;
struct v2s16;
struct v2s32;
struct v2s64;

struct v2r32;
struct v2r64;

GIL_API u8  clamp__u8(u8 min, u8 value, u8 max);
GIL_API u16 clamp__u16(u16 min, u16 value, u16 max);
GIL_API u32 clamp__u32(u32 min, u32 value, u32 max);
GIL_API u64 clamp__u64(u64 min, u64 value, u64 max);

GIL_API s8  clamp__s8(s8 min, s8 value, s8 max);
GIL_API s16 clamp__s16(s16 min, s16 value, s16 max);
GIL_API s32 clamp__s32(s32 min, s32 value, s32 max);
GIL_API s64 clamp__s64(s64 min, s64 value, s64 max);

GIL_API r32 clamp__r32(r32 min, r32 value, r32 max);
GIL_API r64 clamp__r64(r64 min, r64 value, r64 max);

GIL_API struct v2u8  clamp__v2u8(struct v2u8 min, struct v2u8 value, struct v2u8 max);
GIL_API struct v2u16 clamp__v2u16(struct v2u16 min, struct v2u16 value, struct v2u16 max);
GIL_API struct v2u32 clamp__v2u32(struct v2u32 min, struct v2u32 value, struct v2u32 max);
GIL_API struct v2u64 clamp__v2u64(struct v2u64 min, struct v2u64 value, struct v2u64 max);

GIL_API struct v2s8  clamp__v2s8(struct v2s8 min, struct v2s8 value, struct v2s8 max);
GIL_API struct v2s16 clamp__v2s16(struct v2s16 min, struct v2s16 value, struct v2s16 max);
GIL_API struct v2s32 clamp__v2s32(struct v2s32 min, struct v2s32 value, struct v2s32 max);
GIL_API struct v2s64 clamp__v2s64(struct v2s64 min, struct v2s64 value, struct v2s64 max);

GIL_API struct v2r32 clamp__v2r32(struct v2r32 min, struct v2r32 value, struct v2r32 max);
GIL_API struct v2r64 clamp__v2r64(struct v2r64 min, struct v2r64 value, struct v2r64 max);

GIL_API struct v3s8  clamp__v3s8(struct v3s8 min, struct v3s8 value, struct v3s8 max);
GIL_API struct v3s16 clamp__v3s16(struct v3s16 min, struct v3s16 value, struct v3s16 max);
GIL_API struct v3s32 clamp__v3s32(struct v3s32 min, struct v3s32 value, struct v3s32 max);
GIL_API struct v3s64 clamp__v3s64(struct v3s64 min, struct v3s64 value, struct v3s64 max);

GIL_API struct v3u8  clamp__v3u8(struct v3u8 min, struct v3u8 value, struct v3u8 max);
GIL_API struct v3u16 clamp__v3u16(struct v3u16 min, struct v3u16 value, struct v3u16 max);
GIL_API struct v3u32 clamp__v3u32(struct v3u32 min, struct v3u32 value, struct v3u32 max);
GIL_API struct v3u64 clamp__v3u64(struct v3u64 min, struct v3u64 value, struct v3u64 max);

GIL_API struct v3r32 clamp__v3r32(struct v3r32 min, struct v3r32 value, struct v3r32 max);
GIL_API struct v3r64 clamp__v3r64(struct v3r64 min, struct v3r64 value, struct v3r64 max);

GIL_API struct v4u8  clamp__v4u8(struct v4u8 min, struct v4u8 value, struct v4u8 max);
GIL_API struct v4u16 clamp__v4u16(struct v4u16 min, struct v4u16 value, struct v4u16 max);
GIL_API struct v4u32 clamp__v4u32(struct v4u32 min, struct v4u32 value, struct v4u32 max);
GIL_API struct v4u64 clamp__v4u64(struct v4u64 min, struct v4u64 value, struct v4u64 max);

GIL_API struct v4s8  clamp__v4s8(struct v4s8 min, struct v4s8 value, struct v4s8 max);
GIL_API struct v4s16 clamp__v4s16(struct v4s16 min, struct v4s16 value, struct v4s16 max);
GIL_API struct v4s32 clamp__v4s32(struct v4s32 min, struct v4s32 value, struct v4s32 max);
GIL_API struct v4s64 clamp__v4s64(struct v4s64 min, struct v4s64 value, struct v4s64 max);

GIL_API struct v4r32 clamp__v4r32(struct v4r32 min, struct v4r32 value, struct v4r32 max);
GIL_API struct v4r64 clamp__v4r64(struct v4r64 min, struct v4r64 value, struct v4r64 max);


#endif
