#include "clamp.h"

#include "types/vector_types/v2/v2u8.h"
#include "types/vector_types/v2/v2u16.h"
#include "types/vector_types/v2/v2u32.h"
#include "types/vector_types/v2/v2u64.h"

#include "types/vector_types/v3/v3u8.h"
#include "types/vector_types/v3/v3u16.h"
#include "types/vector_types/v3/v3u32.h"
#include "types/vector_types/v3/v3u64.h"

#include "types/vector_types/v4/v4u8.h"
#include "types/vector_types/v4/v4u16.h"
#include "types/vector_types/v4/v4u32.h"
#include "types/vector_types/v4/v4u64.h"

#include "types/vector_types/v2/v2s8.h"
#include "types/vector_types/v2/v2s16.h"
#include "types/vector_types/v2/v2s32.h"
#include "types/vector_types/v2/v2s64.h"

#include "types/vector_types/v3/v3s8.h"
#include "types/vector_types/v3/v3s16.h"
#include "types/vector_types/v3/v3s32.h"
#include "types/vector_types/v3/v3s64.h"

#include "types/vector_types/v4/v4s8.h"
#include "types/vector_types/v4/v4s16.h"
#include "types/vector_types/v4/v4s32.h"
#include "types/vector_types/v4/v4s64.h"

#include "types/vector_types/v2/v2r32.h"
#include "types/vector_types/v2/v2r64.h"

#include "types/vector_types/v3/v3r32.h"
#include "types/vector_types/v3/v3r64.h"

#include "types/vector_types/v4/v4r32.h"
#include "types/vector_types/v4/v4r64.h"

#include "math/compare/compare.h"

u8 clamp__u8(u8 min, u8 value, u8 max) {
    return
    max__u8(
        min,
        min__u8(
            value,
            max
        )
    );
}

u16 clamp__u16(u16 min, u16 value, u16 max) {
    return
    max__u16(
        min,
        min__u16(
            value,
            max
        )
    );
}

u32 clamp__u32(u32 min, u32 value, u32 max) {
    return
    max__u32(
        min,
        min__u32(
            value,
            max
        )
    );
}

u64 clamp__u64(u64 min, u64 value, u64 max) {
    return
    max__u64(
        min,
        min__u64(
            value,
            max
        )
    );
}

s8  clamp__s8(s8 min, s8 value, s8 max) {
    return
    max__s8(
        min,
        min__s8(
            value,
            max
        )
    );
}

s16 clamp__s16(s16 min, s16 value, s16 max) {
    return
    max__s16(
        min,
        min__s16(
            value,
            max
        )
    );
}

s32 clamp__s32(s32 min, s32 value, s32 max) {
    return
    max__s32(
        min,
        min__s32(
            value,
            max
        )
    );
}

s64 clamp__s64(s64 min, s64 value, s64 max) {
    return
    max__s64(
        min,
        min__s64(
            value,
            max
        )
    );
}

r32 clamp__r32(r32 min, r32 value, r32 max) {
    return
    max__r32(
        min,
        min__r32(
            value,
            max
        )
    );
}

r64 clamp__r64(r64 min, r64 value, r64 max) {
    return
    max__r64(
        min,
        min__r64(
            value,
            max
        )
    );
}

struct v2u8  clamp__v2u8(struct v2u8 min, struct v2u8 value, struct v2u8 max) {
    return
    v2u8(
        clamp__u8(
            min.x,
            value.x,
            max.x
        ),
        clamp__u8(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2u16 clamp__v2u16(struct v2u16 min, struct v2u16 value, struct v2u16 max) {
    return
    v2u16(
        clamp__u16(
            min.x,
            value.x,
            max.x
        ),
        clamp__u16(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2u32 clamp__v2u32(struct v2u32 min, struct v2u32 value, struct v2u32 max) {
    return
    v2u32(
        clamp__u32(
            min.x,
            value.x,
            max.x
        ),
        clamp__u32(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2u64 clamp__v2u64(struct v2u64 min, struct v2u64 value, struct v2u64 max) {
    return
    v2u64(
        clamp__u64(
            min.x,
            value.x,
            max.x
        ),
        clamp__u64(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2s8  clamp__v2s8(struct v2s8 min, struct v2s8 value, struct v2s8 max) {
    return
    v2s8(
        clamp__s8(
            min.x,
            value.x,
            max.x
        ),
        clamp__s8(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2s16 clamp__v2s16(struct v2s16 min, struct v2s16 value, struct v2s16 max) {
    return
    v2s16(
        clamp__s16(
            min.x,
            value.x,
            max.x
        ),
        clamp__s16(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2s32 clamp__v2s32(struct v2s32 min, struct v2s32 value, struct v2s32 max) {
    return
    v2s32(
        clamp__s32(
            min.x,
            value.x,
            max.x
        ),
        clamp__s32(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2s64 clamp__v2s64(struct v2s64 min, struct v2s64 value, struct v2s64 max) {
    return
    v2s64(
        clamp__s64(
            min.x,
            value.x,
            max.x
        ),
        clamp__s64(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2r32 clamp__v2r32(struct v2r32 min, struct v2r32 value, struct v2r32 max) {
    return
    v2r32(
        clamp__r32(
            min.x,
            value.x,
            max.x
        ),
        clamp__r32(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v2r64 clamp__v2r64(struct v2r64 min, struct v2r64 value, struct v2r64 max) {
    return
    v2r64(
        clamp__r64(
            min.x,
            value.x,
            max.x
        ),
        clamp__r64(
            min.y,
            value.y,
            max.y
        )
    );
}

struct v3s8  clamp__v3s8(struct v3s8 min, struct v3s8 value, struct v3s8 max) {
    return
    v3s8(
        clamp__s8(
            min.x,
            value.x,
            max.x
        ),
        clamp__s8(
            min.y,
            value.y,
            max.y
        ),
        clamp__s8(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3u16 clamp__v3u16(struct v3u16 min, struct v3u16 value, struct v3u16 max) {
    return
    v3u16(
        clamp__u16(
            min.x,
            value.x,
            max.x
        ),
        clamp__u16(
            min.y,
            value.y,
            max.y
        ),
        clamp__u16(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3u32 clamp__v3u32(struct v3u32 min, struct v3u32 value, struct v3u32 max) {
    return
    v3u32(
        clamp__u32(
            min.x,
            value.x,
            max.x
        ),
        clamp__u32(
            min.y,
            value.y,
            max.y
        ),
        clamp__u32(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3u64 clamp__v3u64(struct v3u64 min, struct v3u64 value, struct v3u64 max) {
    return
    v3u64(
        clamp__u64(
            min.x,
            value.x,
            max.x
        ),
        clamp__u64(
            min.y,
            value.y,
            max.y
        ),
        clamp__u64(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3u8  clamp__v3u8(struct v3u8 min, struct v3u8 value, struct v3u8 max) {
    return
    v3u8(
        clamp__u8(
            min.x,
            value.x,
            max.x
        ),
        clamp__u8(
            min.y,
            value.y,
            max.y
        ),
        clamp__u8(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3s16 clamp__v3s16(struct v3s16 min, struct v3s16 value, struct v3s16 max) {
    return
    v3s16(
        clamp__s16(
            min.x,
            value.x,
            max.x
        ),
        clamp__s16(
            min.y,
            value.y,
            max.y
        ),
        clamp__s16(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3s32 clamp__v3s32(struct v3s32 min, struct v3s32 value, struct v3s32 max) {
    return
    v3s32(
        clamp__s32(
            min.x,
            value.x,
            max.x
        ),
        clamp__s32(
            min.y,
            value.y,
            max.y
        ),
        clamp__s32(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3s64 clamp__v3s64(struct v3s64 min, struct v3s64 value, struct v3s64 max) {
    return
    v3s64(
        clamp__s64(
            min.x,
            value.x,
            max.x
        ),
        clamp__s64(
            min.y,
            value.y,
            max.y
        ),
        clamp__s64(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3r32 clamp__v3r32(struct v3r32 min, struct v3r32 value, struct v3r32 max) {
    return
    v3r32(
        clamp__r32(
            min.x,
            value.x,
            max.x
        ),
        clamp__r32(
            min.y,
            value.y,
            max.y
        ),
        clamp__r32(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v3r64 clamp__v3r64(struct v3r64 min, struct v3r64 value, struct v3r64 max) {
    return
    v3r64(
        clamp__r64(
            min.x,
            value.x,
            max.x
        ),
        clamp__r64(
            min.y,
            value.y,
            max.y
        ),
        clamp__r64(
            min.z,
            value.z,
            max.z
        )
    );
}

struct v4u8  clamp__v4u8(struct v4u8 min, struct v4u8 value, struct v4u8 max) {
    return
    v4u8(
        clamp__u8(
            min.a,
            value.a,
            max.a
        ),
        clamp__u8(
            min.b,
            value.b,
            max.b
        ),
        clamp__u8(
            min.c,
            value.c,
            max.c
        ),
        clamp__u8(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4u16 clamp__v4u16(struct v4u16 min, struct v4u16 value, struct v4u16 max) {
    return
    v4u16(
        clamp__u16(
            min.a,
            value.a,
            max.a
        ),
        clamp__u16(
            min.b,
            value.b,
            max.b
        ),
        clamp__u16(
            min.c,
            value.c,
            max.c
        ),
        clamp__u16(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4u32 clamp__v4u32(struct v4u32 min, struct v4u32 value, struct v4u32 max) {
    return
    v4u32(
        clamp__u32(
            min.a,
            value.a,
            max.a
        ),
        clamp__u32(
            min.b,
            value.b,
            max.b
        ),
        clamp__u32(
            min.c,
            value.c,
            max.c
        ),
        clamp__u32(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4u64 clamp__v4u64(struct v4u64 min, struct v4u64 value, struct v4u64 max) {
    return
    v4u64(
        clamp__u64(
            min.a,
            value.a,
            max.a
        ),
        clamp__u64(
            min.b,
            value.b,
            max.b
        ),
        clamp__u64(
            min.c,
            value.c,
            max.c
        ),
        clamp__u64(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4s8  clamp__v4s8(struct v4s8 min, struct v4s8 value, struct v4s8 max) {
    return
    v4s8(
        clamp__s8(
            min.a,
            value.a,
            max.a
        ),
        clamp__s8(
            min.b,
            value.b,
            max.b
        ),
        clamp__s8(
            min.c,
            value.c,
            max.c
        ),
        clamp__s8(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4s16 clamp__v4s16(struct v4s16 min, struct v4s16 value, struct v4s16 max) {
    return
    v4s16(
        clamp__s16(
            min.a,
            value.a,
            max.a
        ),
        clamp__s16(
            min.b,
            value.b,
            max.b
        ),
        clamp__s16(
            min.c,
            value.c,
            max.c
        ),
        clamp__s16(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4s32 clamp__v4s32(struct v4s32 min, struct v4s32 value, struct v4s32 max) {
    return
    v4s32(
        clamp__s32(
            min.a,
            value.a,
            max.a
        ),
        clamp__s32(
            min.b,
            value.b,
            max.b
        ),
        clamp__s32(
            min.c,
            value.c,
            max.c
        ),
        clamp__s32(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4s64 clamp__v4s64(struct v4s64 min, struct v4s64 value, struct v4s64 max) {
    return
    v4s64(
        clamp__s64(
            min.a,
            value.a,
            max.a
        ),
        clamp__s64(
            min.b,
            value.b,
            max.b
        ),
        clamp__s64(
            min.c,
            value.c,
            max.c
        ),
        clamp__s64(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4r32 clamp__v4r32(struct v4r32 min, struct v4r32 value, struct v4r32 max) {
    return
    v4r32(
        clamp__r32(
            min.a,
            value.a,
            max.a
        ),
        clamp__r32(
            min.b,
            value.b,
            max.b
        ),
        clamp__r32(
            min.c,
            value.c,
            max.c
        ),
        clamp__r32(
            min.d,
            value.d,
            max.d
        )
    );
}

struct v4r64 clamp__v4r64(struct v4r64 min, struct v4r64 value, struct v4r64 max) {
    return
    v4r64(
        clamp__r64(
            min.a,
            value.a,
            max.a
        ),
        clamp__r64(
            min.b,
            value.b,
            max.b
        ),
        clamp__r64(
            min.c,
            value.c,
            max.c
        ),
        clamp__r64(
            min.d,
            value.d,
            max.d
        )
    );
}
