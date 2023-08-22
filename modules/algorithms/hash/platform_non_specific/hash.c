#include "algorithms/hash/hash.h"

u64 hash__sum(const char* str) {
    u64 hash_result = 0;

    while (*str != '\0') {
        hash_result += *str++;
    }

    return hash_result;
}

u64 hash__sum_n(const char* str, u32 str_len) {
    u64 hash_result = 0;

    while (
        *str != '\0' &&
        str_len-- != 0
    ) {
        hash_result += *str++;
    }

    return hash_result;
}

/*
((((a * C) ^ b * C) ^ c * C) ^ d * C) ^ e * C
((a * C) ^ b * C) ^ c * C
(d * C) ^ e * C

(C * C * (a * C) ^ b ^ c ^ e ^ (d * C) * C
*/

u32 hash__fnv_1a(const char* str, u32 len, u32 prev_hash) {
    // FNV offset basis
    u32 hash_result = prev_hash ? prev_hash : 2166136261U;

    while (len > 0) {
        hash_result ^= *str++;
        // FNV prime
        hash_result *= 16777619;
        --len;
    }

    return hash_result;
}
