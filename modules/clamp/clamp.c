#include "clamp.h"

u8 clamp__u8(u8 min, u8 value, u8 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

u16 clamp__u16(u16 min, u16 value, u16 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

u32 clamp__u32(u32 min, u32 value, u32 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

u64 clamp__u64(u64 min, u64 value, u64 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

s64 clamp__s64(s64 min, s64 value, s64 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

s32 clamp__s32(s32 min, s32 value, s32 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

s16 clamp__s16(s16 min, s16 value, s16 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

r32 clamp__r32(r32 min, r32 value, r32 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

r64 clamp__r64(r64 min, r64 value, r64 max) {
    if (value < min) {
        return min;
    }
    if (value > max) {
        return max;
    }
    return value;
}

struct v3u64 clamp__v3u64(struct v3u64 min, struct v3u64 value, struct v3u64 max) {
    return v3u64(clamp__u64(min.x, value.x, max.x), clamp__u64(min.y, value.y, max.y), clamp__u64(min.z, value.z, max.z));
}

struct v3u32 clamp__v3u32(struct v3u32 min, struct v3u32 value, struct v3u32 max) {
    return v3u32(clamp__u32(min.x, value.x, max.x), clamp__u32(min.y, value.y, max.y), clamp__u32(min.z, value.z, max.z));
}

struct v3u16 clamp__v3u16(struct v3u16 min, struct v3u16 value, struct v3u16 max) {
    return v3u16(clamp__u16(min.x, value.x, max.x), clamp__u16(min.y, value.y, max.y), clamp__u16(min.z, value.z, max.z));
}

struct v2u64 clamp__v2u64(struct v2u64 min, struct v2u64 value, struct v2u64 max) {
    return v2u64(clamp__u64(min.x, value.x, max.x), clamp__u64(min.y, value.y, max.y));
}

struct v2u32 clamp__v2u32(struct v2u32 min, struct v2u32 value, struct v2u32 max) {
    return v2u32(clamp__u32(min.x, value.x, max.x), clamp__u32(min.y, value.y, max.y));
}

struct v2u16 clamp__v2u16(struct v2u16 min, struct v2u16 value, struct v2u16 max) {
    return v2u16(clamp__u16(min.x, value.x, max.x), clamp__u16(min.y, value.y, max.y));
}

struct v3s64 clamp__v3s64(struct v3s64 min, struct v3s64 value, struct v3s64 max) {
    return v3s64(clamp__s64(min.x, value.x, max.x), clamp__s64(min.y, value.y, max.y), clamp__s64(min.y, value.y, max.y));
}

struct v3s32 clamp__v3s32(struct v3s32 min, struct v3s32 value, struct v3s32 max) {
    return v3s32(clamp__s32(min.x, value.x, max.x), clamp__s32(min.y, value.y, max.y), clamp__s32(min.z, value.z, max.z));
}

struct v3s16 clamp__v3s16(struct v3s16 min, struct v3s16 value, struct v3s16 max) {
    return v3s16(clamp__s16(min.x, value.x, max.x), clamp__s16(min.y, value.y, max.y), clamp__s16(min.z, value.z, max.z));
}

struct v2s64 clamp__v2s64(struct v2s64 min, struct v2s64 value, struct v2s64 max) {
    return v2s64(clamp__s64(min.x, value.x, max.x), clamp__s64(min.y, value.y, max.y));
}

struct v2s32 clamp__v2s32(struct v2s32 min, struct v2s32 value, struct v2s32 max) {
    return v2s32(clamp__s32(min.x, value.x, max.x), clamp__s32(min.y, value.y, max.y));
}

struct v2s16 clamp__v2s16(struct v2s16 min, struct v2s16 value, struct v2s16 max) {
    return v2s16(clamp__s16(min.x, value.x, max.x), clamp__s16(min.y, value.y, max.y));
}

struct v3r64 clamp__v3r64(struct v3r64 min, struct v3r64 value, struct v3r64 max) {
    return v3r64(clamp__r64(min.x, value.x, max.x), clamp__r64(min.y, value.y, max.y), clamp__r64(min.z, value.z, max.z));
}

struct v3r32 clamp__v3r32(struct v3r32 min, struct v3r32 value, struct v3r32 max) {
    return v3r32(clamp__r32(min.x, value.x, max.x), clamp__r32(min.y, value.y, max.y), clamp__r32(min.z, value.z, max.z));
}

struct v2r64 clamp__v2r64(struct v2r64 min, struct v2r64 value, struct v2r64 max) {
    return v2r64(clamp__r64(min.x, value.x, max.x), clamp__r64(min.y, value.y, max.y));
}

struct v2r32 clamp__v2r32(struct v2r32 min, struct v2r32 value, struct v2r32 max) {
    return v2r32(clamp__r32(min.x, value.x, max.x), clamp__r32(min.y, value.y, max.y));
}
