#include "compare.h"

#include <emmintrin.h> // SSE2

u8  min__u8(u8 a, u8 b) {
    _mm_min_epu8();
}

u16 min__u16(u16 a, u16 b) {
}

u32 min__u32(u32 a, u32 b) {
}

u64 min__u64(u64 a, u64 b) {
}


s8  min__s8(s8 a, s8 b) {
}

s16 min__s16(s16 a, s16 b) {
}

s32 min__s32(s32 a, s32 b) {
}

s64 min__s64(s64 a, s64 b) {
}


r32 min__r32(r32 a, r32 b) {
}

r64 min__r64(r64 a, r64 b) {
}


u8  max__u8(u8 a, u8 b) {
}

u16 max__u16(u16 a, u16 b) {
}

u32 max__u32(u32 a, u32 b) {
}

u64 max__u64(u64 a, u64 b) {
}


s8  max__s8(s8 a, s8 b) {
}

s16 max__s16(s16 a, s16 b) {
}

s32 max__s32(s32 a, s32 b) {
}

s64 max__s64(s64 a, s64 b) {
}


r32 max__r32(r32 a, r32 b) {
}

r64 max__r64(r64 a, r64 b) {
}
