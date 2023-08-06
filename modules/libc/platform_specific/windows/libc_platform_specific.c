#include "libc/libc.h"

#include <Windows.h>

void* libc__mmalloc(void* addr, size_t size) {
    void* result = VirtualAlloc(addr, size, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);

    if (result == NULL) {
        // todo: diagnostics, GetLastError()
        error_code__exit(32543);
    }

    ASSERT(result == addr);

    return result;
}
