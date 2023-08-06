#include "libc/libc.h"

#include <Windows.h>

void* libc__mmap(void* addr, size_t size) {
    void* result = VirtualAlloc(addr, size, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);

    if (result == NULL) {
        // todo: diagnostics, GetLastError()
        error_code__exit(32543);
    }

    ASSERT(result == addr);

    return result;
}

void  libc__munmap(void* data) {
    if (VirtualFree(data, 0, MEM_RELEASE) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(32543);
    }
}
