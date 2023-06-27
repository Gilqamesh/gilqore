#include "gil_math/mod/mod.h"
s8  mod__s8(s8 a, s8 b) {
    return a % b;
}
s16 mod__s16(s16 a, s16 b) {
    return a % b;
}
s32 mod__s32(s32 a, s32 b) {
    return a % b;
}
s64 mod__s64(s64 a, s64 b) {
    return a % b;
}
u8  mod__u8(s8 a, s8 b) {
    s8 r = a % b;
    return r < 0 ? r + b : r;
}
u16 mod__u16(s16 a, s16 b) {
    s16 r = a % b;
    return r < 0 ? r + b : r;
}
u32 mod__u32(s32 a, s32 b) {
    s32 r = a % b;
    return r < 0 ? r + b : r;
}
u64 mod__u64(s64 a, s64 b) {
    s64 r = a % b;
    return r < 0 ? r + b : r;
}
