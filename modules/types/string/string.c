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

    while (p != str && n > 0) {
        if (*p == c && --n == 0) {
            result = p;
        }
        --p;
    }

    return result;
}
