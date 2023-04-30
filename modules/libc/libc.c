#include "libc.h"

#include <stdlib.h>
#include <string.h>

void* libc__malloc(u32 size_bytes) {
    void* result = malloc(size_bytes);
    if (result == NULL) {
        error_code__exit(LIBC_ERROR_CODE_MALLOC_FAILED);
    }

    return result;
}

void libc__free(void* data) {
    if (data != NULL) {
        free(data);
    }
}

void* libc__memcpy(void* dest, const void* src, u64 size) {
    return memcpy(dest, src, size);
}

s32 libc__memcmp(const void *s1, const void *s2, u64 size) {
    return memcmp(s1, s2, size);
}

void* libc__memset(void *dest, s32 value, u64 size) {
    return memset(dest, value, size);
}

u64 libc__strlen(const char* str) {
    return (u64) strlen(str);
}

s32 libc__strcmp(const char* str1, const char* str2) {
    return strcmp(str1, str2);
}
