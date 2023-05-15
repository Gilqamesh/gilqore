#include "test_framework/test_framework.h"

#include "types/string/string.h"
#include "libc/libc.h"

int main() {
    u32 buffer_size = 1024;
    char* buffer = libc__malloc(buffer_size);

    ASSERT(false && "implement tests");

    libc__free(buffer);
}
