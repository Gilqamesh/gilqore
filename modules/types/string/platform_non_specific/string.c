#include "types/string/string.h"

#include "algorithms/hash/hash.h"
#include "libc/libc.h"

void string__to_upper(char* str) {
    while (*str != '\0') {
        *str = libc__toupper(*str);
        ++str;
    }
}

char* string__search_n(const char* str, u32 str_len, const char* set, u32 n, bool return_last_occurance) {
    char* result = NULL;

    if (n == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        *str != '\0' &&
        str_len-- > 0 &&
        n > 0
    ) {
        char c = *str;
        if (boolean_set[c >> 5] & (1 << (c & 0x1f))) {
            --n;
            if ((return_last_occurance == true ||
                (return_last_occurance == false && n == 0))
            ) {
                result = (char*) str;
            }
        }
        ++str;
    }

    return result;
}

char* string__search_while(const char* str, u32 str_len, const char* set, u32 max) {
    char* result = (char*) str;

    if (*set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        *str != '\0' &&
        str_len-- > 0 &&
        (boolean_set[*str >> 5] & (1 << (*str & 0x1f))) > 0 &&
        max-- > 0
    ) {
        ++str;
        result = (char*) str;
    }

    return result;
}

char* string__search_while_not(const char* str, u32 str_len, const char* set, u32 max) {
    char* result = (char*) str;

    if (max == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        *str != '\0' &&
        str_len-- > 0 &&
        (boolean_set[*str >> 5] & (1 << (*str & 0x1f))) == 0 &&
        max-- > 0
    ) {
        ++str;
        result = (char*) str;
    }

    return result;
}

char* string__rsearch_n(const char* str, u32 str_len, const char* set, u32 n, bool return_last_occurance) {
    char* result = NULL;

    if (n == 0 || str_len == 0 || *set == '\0') {
        return result;
    }

    char* p = (char*) str + str_len - 1;

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        str_len-- > 0 &&
        n > 0
    ) {
        if (boolean_set[*p >> 5] & (1 << (*p & 0x1f))) {
            --n;
            if ((return_last_occurance == true ||
                (return_last_occurance == false && n == 0))
            ) {
                result = (char*) p;
            }
        }
        --p;
    }

    return result;
}

char* string__rsearch_while(const char* str, u32 str_len, const char* set, u32 max) {
    char* p = (char*) str + str_len - 1;
    char* result = (char*) p + 1;

    if (max == 0 || str_len == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        str_len-- > 0 &&
        ((boolean_set[*p >> 5] & (1 << (*p & 0x1f)))) > 0 &&
        max-- > 0
    ) {
        result = p;
        --p;
    }

    return result;
}

char* string__rsearch_while_not(const char* str, u32 str_len, const char* set, u32 max) {
    char* p = (char*) str + str_len - 1;
    char* result = p + 1;

    if (max == 0 || str_len == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 1 << (c & 0x1f);
    }

    while (
        str_len-- > 0 &&
        max-- > 0
    ) {
        if (boolean_set[*p >> 5] & (1 << (*p & 0x1f))) {
            max = 0;
        }
        result = p;
        --p;
    }

    return result;
}

char* string__starts_with(const char* str, const char* prefix) {
    while (*str && *prefix) {
        if (*str++ != *prefix++) {
            return NULL;
        }
    }

    if (*prefix) {
        return NULL;
    }

    return (char*) str;
}

char* string__search(
    const char* str, u32 str_len,
    const char* what, u32 what_len
) {
    if (str_len < what_len) {
        return NULL;
    }

    if (what_len == 0) {
        return (char*) str;
    }

    u64 hash_value = hash__sum_n(what, what_len);
    u32 rolling_hash_value = 0;
    u32 str_index = 0;
    while (
        str_index < str_len
    ) {
        rolling_hash_value += str[str_index];
        if (str_index + 1 >= what_len) {
            if (str_index >= what_len) {
                rolling_hash_value -= str[str_index - what_len];
            }
            if (
                rolling_hash_value == hash_value &&
                libc__strncmp(
                    str + str_index + 1 - what_len,
                    what,
                    what_len
                ) == 0
            ) {
                return (char*) str + str_index + 1;
            }
        }

        ++str_index;
    }

    return NULL;
}
