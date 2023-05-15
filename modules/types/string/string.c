#include "string.h"

#include "libc/libc.h"

#include <ctype.h>

void string__to_upper(char* str) {
    while (*str != '\0') {
        *str = toupper(*str);
        ++str;
    }
}

char* string__strchr_n(const char* str, char c, u32 n) {
    char *result = NULL;

    if (n == 0) {
        return result;
    }

    while (*str != '\0' && n > 0) {
        if (*str == c && --n == 0) {
            result = (char*) str;
        }
        ++str;
    }

    return result;
}

char* string__strchr_set(const char* str, const char* set) {
    char* result = NULL;

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (*str != '\0' && result == NULL) {
        char c = *str;
        if (boolean_set[c >> 5] & (0b1 << (c & 0b11111))) {
            result = (char*) str;
        }
        ++str;
    }

    return result;
}

char* string__strchr_set_n(const char* str, const char* set, u32 n) {
    char* result = NULL;

    if (n == 0) {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (*str != '\0' && result == NULL && n > 0) {
        char c = *str;
        if (boolean_set[c >> 5] & (0b1 << (c & 0b11111)) &&
            --n == 0
        ) {
            result = (char*) str;
        }
        ++str;
    }

    return result;
}

char* string__strrchr_n(const char* str, char c, u32 n) {
    char* result = NULL;
    if (n == 0) {
        return result;
    }
    u32 str_len = libc__strlen(str);
    if (str_len == 0) {
        return result;
    }
    char* p = (char*) str + str_len - 1;

    while (p >= str && n > 0) {
        if (*p == c && --n == 0) {
            result = p;
        }
        --p;
    }

    return result;
}

char* string__strrchr_set(const char* str, const char* set) {
    char* result = NULL;

    u32 str_len = libc__strlen(str);
    if (str_len == 0) {
        return result;
    }
    char* p = (char*) str + str_len - 1;

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (p >= str && result == NULL) {
        if (boolean_set[*p >> 5] & (0b1 << (*p & 0b11111))) {
            result = (char*) p;
        }
        --p;
    }

    return result;
}

char* string__strrchr_set_n(const char* str, const char* set, u32 n) {
    char* result = NULL;

    if (n == 0) {
        return result;
    }

    u32 str_len = libc__strlen(str);
    if (str_len == 0) {
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
        p >= str &&
        n > 0
    ) {
        if (
            boolean_set[*p >> 5] & (0b1 << (*p & 0b11111)) &&
            --n == 0
        ) {
            result = (char*) p;
        }
        --p;
    }

    return result;
}
