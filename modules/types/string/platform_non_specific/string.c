#include "types/string/string.h"

#include <ctype.h>

void string__to_upper(char* str) {
    while (*str != '\0') {
        *str = toupper(*str);
        ++str;
    }
}

char* string__search_n(const char* str, u32 str_len, const char* set, u32 n, bool return_last_occurance) {
    char* result = NULL;

    if (str_len == 0 || n == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        n > 0
    ) {
        char c = *str;
        if (boolean_set[c >> 5] & (0b1 << (c & 0b11111))) {
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

    if (str_len == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        (boolean_set[*str >> 5] & (0b1 << (*str & 0b11111))) > 0 &&
        max-- > 0
    ) {
        ++str;
        result = (char*) str;
    }

    return result;
}

char* string__search_while_not(const char* str, u32 str_len, const char* set, u32 max) {
    char* result = (char*) str;

    if (str_len == 0 || max == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        (boolean_set[*str >> 5] & (0b1 << (*str & 0b11111))) == 0 &&
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
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        n > 0
    ) {
        if (boolean_set[*p >> 5] & (0b1 << (*p & 0b11111))) {
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
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        ((boolean_set[*p >> 5] & (0b1 << (*p & 0b11111)))) > 0 &&
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
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        str_len-- > 0 &&
        max-- > 0
    ) {
        if (boolean_set[*p >> 5] & (0b1 << (*p & 0b11111))) {
            max = 0;
        }
        result = p;
        --p;
    }

    return result;
}
