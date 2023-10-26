#ifndef RANDOM_H
# define RANDOM_H

# include "random_defs.h"

typedef struct random {
    u64 random_vector[624];
    u32 random_vector_index;
    u32 _reserved;
} random_t;

PUBLIC_API void random__init(struct random* self, u64 seed);

// @brief generates a random u64 on [0, 2^64-1]-interval
PUBLIC_API u64 random__u64(struct random* self);
// @brief generates a random u32 on [0, 2^32-1]-interval
PUBLIC_API u32 random__u32(struct random* self);
// @brief generates a random u32 on [0, 2^16-1]-interval
PUBLIC_API u16 random__u16(struct random* self);
// @brief generates a random s64 on [-2^63, 2^63-1]-interval
PUBLIC_API s64 random__s64(struct random* self);
// @brief generates a random s32 on [-2^31, 2^31-1]-interval
PUBLIC_API s32 random__s32(struct random* self);
// @brief generates a random s32 on [-2^15, 2^15-1]-interval
PUBLIC_API s16 random__s16(struct random* self);

// @brief generates a random r64 on [0,1]-real-interval
PUBLIC_API r64 random__r64(struct random* self);

// @brief generates a random s64 on a [left,right] interval
PUBLIC_API s64 random__s64_closed(struct random* self, s64 left, s64 right);
// @brief generates a random s32 on a [left,right] interval
PUBLIC_API s32 random__s32_closed(struct random* self, s32 left, s32 right);
// @brief generates a random s16 on a [left,right] interval
PUBLIC_API s16 random__s16_closed(struct random* self, s16 left, s16 right);
// @brief generates a random u64 on a [left,right] interval
PUBLIC_API u64 random__u64_closed(struct random* self, u64 left, u64 right);
// @brief generates a random u32 on a [left,right] interval
PUBLIC_API u32 random__u32_closed(struct random* self, u32 left, u32 right);
// @brief generates a random u16 on a [left,right] interval
PUBLIC_API u16 random__u16_closed(struct random* self, u16 left, u16 right);

// @brief generates a random r64 on [left,right]-real-interval
PUBLIC_API r64 random__r64_closed(struct random* self, r64 left, r64 right);
// @brief generates a random r32 on [left,right]-real-interval
PUBLIC_API r32 random__r32_closed(struct random* self, r32 left, r32 right);

// @brief generates a random r64 on [left,right)-real-interval
PUBLIC_API r64 random__r64_left_closed(struct random* self, r64 left, r64 right);
// @brief generates a random r32 on [left,right)-real-interval
PUBLIC_API r32 random__r32_left_closed(struct random* self, r32 left, r32 right);

// @brief generates a random r64 on (left,right)-real-interval
PUBLIC_API r64 random__r64_open(struct random* self, r64 left, r64 right);
// @brief generates a random r32 on (left,right)-real-interval
PUBLIC_API r32 random__r32_open(struct random* self, r32 left, r32 right);

#endif
