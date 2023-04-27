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

void* libc__memcpy(void* dest, void* src, u64 size) {
    return memcpy(dest, src, size);
}
