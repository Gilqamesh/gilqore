#include "libc.h"

#include <stdlib.h>
#include <string.h>

#if defined(GIL_DEBUG)
struct debug_memory_entry {
    void* addr;
    u32   size;
};

static s32 g_unfreed_memory_bytes_count;
static struct debug_memory_entry memory_entries[4096];
#endif

void* libc__malloc(u32 size_bytes) {
    void* result = malloc(size_bytes);
    if (result == NULL) {
        error_code__exit(LIBC_ERROR_CODE_MALLOC_FAILED);
    }
#if defined(GIL_DEBUG)
    u64 memory_hash = ((u64) result * 17) % ARRAY_SIZE(memory_entries);
    bool found = false;
    for (u64 i = memory_hash; i < ARRAY_SIZE(memory_entries) && found == false; ++i) {
        if (memory_entries[i].addr == NULL) {
            memory_entries[i].addr = result;
            memory_entries[i].size = size_bytes;
            found = true;
        }
    }
    for (u64 i = 0; i < memory_hash && found == false; ++i) {
        if (memory_entries[i].addr == NULL) {
            memory_entries[i].addr = result;
            memory_entries[i].size = size_bytes;
            found = true;
        }
    }
    ASSERT(found == true);
    g_unfreed_memory_bytes_count += size_bytes;
#endif

    return result;
}

void libc__free(void* data) {
    if (data != NULL) {
#if defined(GIL_DEBUG)
        u64 memory_hash = ((u64) data * 1773217) % ARRAY_SIZE(memory_entries);
        bool found = false;
        for (u64 i = memory_hash; i < ARRAY_SIZE(memory_entries) && found == false; ++i) {
            if (memory_entries[i].addr == data) {
                memory_entries[i].addr = NULL;
                g_unfreed_memory_bytes_count -= memory_entries[i].size;
                memory_entries[i].size = 0;
                found = true;
            }
        }
        for (u64 i = 0; i < memory_hash && found == false; ++i) {
            if (memory_entries[i].addr == data) {
                memory_entries[i].addr = NULL;
                g_unfreed_memory_bytes_count -= memory_entries[i].size;
                memory_entries[i].size = 0;
                found = true;
            }
        }
        ASSERT(g_unfreed_memory_bytes_count >= 0);
        ASSERT(found == true);
#endif
        free(data);
    }
}

u32 libc__unfreed_byte_count(void) {
    return (u32) g_unfreed_memory_bytes_count;
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
