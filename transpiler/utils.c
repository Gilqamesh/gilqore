#include "utils.h"

#include <string.h>
#include <stdlib.h>

void fatal_error(const char* format, ...) {
    va_list ap;

    va_start(ap, format);
    vfprintf(stderr, format, ap);
    va_end(ap);

    fprintf(stderr, "\n");

    exit(1);
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
                strncmp(
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

char* string__search_n(const char* str, const char* set, u32 n, bool return_last_occurance) {
    char* result = NULL;

    if (n == 0 || *set == '\0') {
        return result;
    }

    // note: one bit for every byte representation
    u32 boolean_set[256 / (sizeof(u32) * 8)] = { 0 };
    while (*set != '\0') {
        char c = *set++;
        boolean_set[c >> 5] |= 0b1 << (c & 0b11111);
    }

    while (
        *str != '\0' &&
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

u32 file_write_format(FILE* file, struct memory format_memory, const char* format, ...) {
    va_list ap;

    va_start(ap, format);
    u32 written_bytes = (u32) vsnprintf(
        format_memory.data, format_memory.size,
        format, ap
    );
    va_end(ap);

    if (written_bytes >= format_memory.size) {
        fatal_error("format_memory provided to 'file_write_format' is too small");
    }

    if (fwrite(format_memory.data, sizeof(char), written_bytes, file) != written_bytes) {
        fatal_error("unexpected amount of bytes written by 'fwrite' in 'file_write_format'");
    }

    return written_bytes;
}
