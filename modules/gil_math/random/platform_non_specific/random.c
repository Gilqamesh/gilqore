#include "gil_math/random/random.h"

/*
    Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura,
    All rights reserved.                          

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

        1. Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.

        2. Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.

        3. The names of its contributors may not be used to endorse or promote 
            products derived from this software without specific prior written 
            permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


    source: http://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/emt.html
*/

#define RANDOM__M 397
#define RANDOM__MATRIX_A 0xB5026F5AA96619E9ULL
#define RANDOM__UM 0xFFFFFFFF80000000ULL /* Most significant 33 bits */
#define RANDOM__LM 0x7FFFFFFFULL /* Least significant 31 bits */

void random__init(struct random* self, u64 seed) {
    self->random_vector[0] = seed;
    for (self->random_vector_index = 1; self->random_vector_index < ARRAY_SIZE(self->random_vector); ++self->random_vector_index) {
        self->random_vector[self->random_vector_index] = (
            6364136223846793005ULL *
            (
                self->random_vector[self->random_vector_index - 1] ^
                (self->random_vector[self->random_vector_index - 1] >> 62)
            ) +
            self->random_vector_index
        );
    }
}

u64 random__u64(struct random* self) {
    u32 i;
    u64 x;
    const u64 mag01[2] = { 0ULL, RANDOM__MATRIX_A };

    if (self->random_vector_index >= ARRAY_SIZE(self->random_vector)) { /* generate ARRAY_SIZE(self->random_vector) words at one time */

        for (i = 0; i < ARRAY_SIZE(self->random_vector) - RANDOM__M; ++i) {
            x = (self->random_vector[i]     & RANDOM__UM) |
                (self->random_vector[i + 1] & RANDOM__LM);
            self->random_vector[i] = self->random_vector[i + RANDOM__M] ^ (x >> 1) ^ mag01[x & 1ULL];
        }

        for (; i < ARRAY_SIZE(self->random_vector) - 1; ++i) {
            x = (self->random_vector[i] & RANDOM__UM) | (self->random_vector[i + 1] & RANDOM__LM);
            self->random_vector[i] = self->random_vector[i + (RANDOM__M - ARRAY_SIZE(self->random_vector))] ^ (x >> 1) ^ mag01[x & 1ULL];
        }

        x = (self->random_vector[ARRAY_SIZE(self->random_vector) - 1] & RANDOM__UM) | (self->random_vector[0] & RANDOM__LM);
        self->random_vector[ARRAY_SIZE(self->random_vector) - 1] = self->random_vector[RANDOM__M - 1] ^ (x >> 1) ^ mag01[x & 1ULL];

        self->random_vector_index = 0;
    }

    x = self->random_vector[self->random_vector_index++];

    x ^= (x >> 29) & 0x5555555555555555ULL;
    x ^= (x << 17) & 0x71D67FFFEDA60000ULL;
    x ^= (x << 37) & 0xFFF7EEE000000000ULL;
    x ^= (x >> 43);

    return x;
}

u32 random__u32(struct random* self) {
    return (u32) random__u64(self);
}

u16 random__u16(struct random* self) {
    return (u16) random__u64(self);
}

s64 random__s64(struct random* self) {
    return (s64) random__u64(self);
}

s32 random__s32(struct random* self) {
    return (s32) random__u64(self);
}

s16 random__s16(struct random* self) {
    return (s16) random__u64(self);
}

r64 random__r64(struct random* self) {
    return (r64) ((random__u64(self) >> 11) * (1.0/9007199254740991.0));
}

s64 random__s64_closed(struct random* self, s64 left, s64 right) {
    r64 p = random__r64(self);

    return (s64) ((r64)left + p * ((r64)right - (r64)left + 1.0));
}

s32 random__s32_closed(struct random* self, s32 left, s32 right) {
    return (s32) random__s64_closed(self, (s64)left, (s64)right);
}

s16 random__s16_closed(struct random* self, s16 left, s16 right) {
    return (s16) random__s64_closed(self, (s64)left, (s64)right);
}

u64 random__u64_closed(struct random* self, u64 left, u64 right) {
    r64 p = random__r64(self);

    return (u64) ((r64)left + p * ((r64)right - (r64)left + 1.0));
}

u32 random__u32_closed(struct random* self, u32 left, u32 right) {
    return (u32) random__u64_closed(self, (u64)left, (u64)right);
}

u16 random__u16_closed(struct random* self, u16 left, u16 right) {
    return (u16) random__u64_closed(self, (u64)left, (u64)right);
}

r64 random__r64_closed(struct random* self, r64 left, r64 right) {
    r64 p = random__r64(self);

    return left + p * (right - left);
}

r32 random__r32_closed(struct random* self, r32 left, r32 right) {
    return (r32) random__r64_closed(self, (r64)left, (r64)right);
}

r64 random__r64_left_closed(struct random* self, r64 left, r64 right) {
    r64 p = (r64) ((random__u64(self) >> 11) * (1.0/9007199254740992.0));

    return left + p * (right - left);
}

r32 random__r32_left_closed(struct random* self, r32 left, r32 right) {
    return (r32) random__r64_left_closed(self, (r64)left, (r64)right);
}

r64 random__r64_open(struct random* self, r64 left, r64 right) {
    r64 p = (r64) (((r64)(random__u64(self) >> 12) + 0.5) * (1.0/4503599627370496.0));

    return left + p * (right - left);
}

r32 random__r32_open(struct random* self, r32 left, r32 right) {
    return (r32) random__r64_open(self, (r64)left, (r64)right);
}
