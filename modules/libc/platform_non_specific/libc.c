#include "libc/libc.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <ctype.h>

#include "common/error_code.h"

#if defined(GIL_DEBUG)
struct debug_memory_entry {
    void* addr;
    u32   size;
};

# define MAX_NUMBER_OF_MEMORY_ENTRIES 4096
static s32 g_unfreed_memory_bytes_count;
static struct debug_memory_entry memory_entries[MAX_NUMBER_OF_MEMORY_ENTRIES];
#endif

static void debug__bookkeep_memory_add(void* addr, u32 size_bytes) {
#if defined(GIL_DEBUG)
    u64 memory_hash = ((u64) addr * 17) % ARRAY_SIZE(memory_entries);
    bool found = false;
    for (u64 i = memory_hash; i < ARRAY_SIZE(memory_entries) && found == false; ++i) {
        if (memory_entries[i].addr == NULL) {
            memory_entries[i].addr = addr;
            memory_entries[i].size = size_bytes;
            found = true;
        }
    }
    for (u64 i = 0; i < memory_hash && found == false; ++i) {
        if (memory_entries[i].addr == NULL) {
            memory_entries[i].addr = addr;
            memory_entries[i].size = size_bytes;
            found = true;
        }
    }
    ASSERT(found == true && "reached MAX_NUMBER_OF_MEMORY_ENTRIES in debug__bookkeep_memory_add");
    g_unfreed_memory_bytes_count += size_bytes;
#else
    (void) addr;
    (void) size_bytes;
#endif
}

static void debug__bookkeep_memory_remove(void* addr) {
#if defined(GIL_DEBUG)
    u64 memory_hash = ((u64) addr * 1773217) % ARRAY_SIZE(memory_entries);
    bool found = false;
    for (u64 i = memory_hash; i < ARRAY_SIZE(memory_entries) && found == false; ++i) {
        if (memory_entries[i].addr == addr) {
            memory_entries[i].addr = NULL;
            g_unfreed_memory_bytes_count -= memory_entries[i].size;
            memory_entries[i].size = 0;
            found = true;
        }
    }
    for (u64 i = 0; i < memory_hash && found == false; ++i) {
        if (memory_entries[i].addr == addr) {
            memory_entries[i].addr = NULL;
            g_unfreed_memory_bytes_count -= memory_entries[i].size;
            memory_entries[i].size = 0;
            found = true;
        }
    }
    ASSERT(found == true && "memory address is not found in debug__bookkeep_memory_remove");
#else
    (void) addr;
#endif
}

void* libc__malloc(u64 size_bytes) {
    void* result = malloc(size_bytes);
    if (result == NULL) {
        error_code__exit(LIBC_ERROR_CODE_MALLOC_FAILED);
    }
    debug__bookkeep_memory_add(result, size_bytes);

    return result;
}

void* libc__calloc(u64 size_bytes) {
    void* result = calloc(1, size_bytes);
    if (result == NULL) {
        // error_code__exit(LIBC_ERROR_CODE_CALLOC_FAILED);
        error_code__exit(847);
    }
    debug__bookkeep_memory_add(result, size_bytes);
    
    return result;
}

void libc__free(void* data) {
    if (data != NULL) {
        debug__bookkeep_memory_remove(data);

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

s32 libc__strncmp(const char* str1, const char* str2, u64 size) {
    return strncmp(str1, str2, size);
}

void* libc__strcat(char* dest, const char* src) {
    return strcat(dest, src);
}

char* libc__strcpy(char* dest, const char* src) {
    return strcpy(dest, src);
}

char* libc__strncpy(char* dest, const char* src, u64 size) {
    return strncpy(dest, src, size);
}

char* libc__strchr(const char* str, char c) {
    while (*str != '\0') {
        if (*str == c) {
            return (char*) str;
        }
        ++str;
    }

    return NULL;
}

char* libc__strrchr(const char* str, char c) {
    char* last = NULL;

    while (*str != '\0') {
        if (*str == c) {
            last = (char*) str;
        }
        ++str;
    }

    return (char*) last;
}

s32 libc__printf(const char* format, ...) {
    va_list  ap;
    s32      printed_bytes;

    va_start(ap, format);
    printed_bytes = libc__vprintf(format, ap);
    va_end(ap);

    return printed_bytes;
}

s32 libc__vprintf(const char* format, va_list ap) {
    return vprintf(format, ap);
}

s32 libc__snprintf(char *buffer, u64 size, const char* format, ...) {
    va_list  ap;
    s32      written_bytes;

    va_start(ap, format);
    written_bytes = libc__vsnprintf(buffer, size, format, ap);
    va_end(ap);

    return written_bytes;
}

s32 libc__vsnprintf(char* buffer, u64 buffer_size, const char* format, va_list ap) {
    s32 written_bytes = vsnprintf(buffer, buffer_size, format, ap);

    if (written_bytes < 0) {
        error_code__exit(LIBC_ERROR_CODE_VSNPRINTF);
    }

    return written_bytes;
}

// @note buffer overflow can occur
s32 libc__sscanf(const char* str, const char* format, ...) {
    va_list  ap;
    s32      parsed_fields;

    va_start(ap, format);
    parsed_fields = libc__vsscanf(str, format, ap);
    va_end(ap);

    return parsed_fields;
}

s32 libc__vsscanf(const char* str, const char* format, va_list ap) {
    s32 parsed_fields = vsscanf(str, format, ap);

    if (parsed_fields < 0) {
        // error_code__exit(VSSCANF);
    }

    return parsed_fields;
}

bool libc__isspace(char c) {
    return isspace(c);
}

bool libc__isdigit(char c) {
    return isdigit(c);
}

s64 libc__atoi(const char* str, u32 radix) {
    (void) radix;
    return atoi(str);
}

void libc__itoa(s64 n, char* buffer, u32 buffer_size)
{
    if (n == S64_MIN) {
        libc__snprintf(buffer, buffer_size, "-9223372036854775808");
        return ;
    }
    if (n < 0) {
        n *= -1;
        *buffer++ = '-';
    }
    if (n == 0) {
        *buffer++ = '0';
    }
    while (n != 0) {
		*buffer++ = n % 10 + '0';
		n /= 10;
	}
    *buffer = '\0';
}

void libc__qsort(
    void* base,
    u32 n_of_items,
    u32 size_of_item,
    s32 (*compare_fn)(const void*, const void*)
) {
    qsort(base, n_of_items, size_of_item, compare_fn);
}

