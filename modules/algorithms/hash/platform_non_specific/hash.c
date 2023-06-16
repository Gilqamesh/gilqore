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
