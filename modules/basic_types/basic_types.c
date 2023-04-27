#include "basic_types.h"

r32 r32__integer_part(r32 r) {
    return (r32) (u32) r;
}

r64 r64__integer_part(r64 r) {
    return (r64) (u64) r;
}

r32 r32__decimal_part(r32 r) {
    return r - r32__integer_part(r);
}

r64 r64__decimal_part(r64 r) {
    return r - r64__integer_part(r);
}

u8  u8__abs_sub(u8 a, u8 b) {
    return a < b ? b - a : a - b;
}

u16 u16__abs_sub(u16 a, u16 b) {
    return a < b ? b - a : a - b;
}

u32 u32__abs_sub(u32 a, u32 b) {
    return a < b ? b - a : a - b;
}

u64 u64__abs_sub(u64 a, u64 b) {
    return a < b ? b - a : a - b;
}

s8  s8__abs(s8 a) {
    return a < 0 ? -a : a;
}

s16 s16__abs(s16 a) {
    return a < 0 ? -a : a;
}

s32 s32__abs(s32 a) {
    return a < 0 ? -a : a;
}

s64 s64__abs(s64 a) {
    return a < 0 ? -a : a;
}

s8  s8__abs_sub(s8 a, s8 b) {
    return a < b ? b - a : a - b;
}

s16 s16__abs_sub(s16 a, s16 b) {
    return a < b ? b - a : a - b;
}

s32 s32__abs_sub(s32 a, s32 b) {
    return a < b ? b - a : a - b;
}

s64 s64__abs_sub(s64 a, s64 b) {
    return a < b ? b - a : a - b;
}

r32 r32__abs(r32 a) {
    return a < 0 ? -a : a;
}

r64 r64__abs(r64 a) {
    return a < 0 ? -a : a;
}

r32 r32__abs_sub(r32 a, r32 b) {
    return a < b ? b - a : a - b;
}

r64 r64__abs_sub(r64 a, r64 b) {
    return a < b ? b - a : a - b;
}
