#include <stdio.h>
#include <stdint.h>
#include <dlfcn.h>

#pragma pack(push, 1)
typedef struct b {
    uint8_t _;
    uint16_t __;
} b_t;
#pragma pack()

void print(b_t b) {
    printf("%u, %u\n", b._, b.__);
}

int main() {
    void *dll_handle = dlopen("./libtest.so", RTLD_LAZY);
    if (!dll_handle) {
        printf("%s\n", dlerror());
        return 1;
    }
    b_t (*fn)(b_t) = dlsym(dll_handle, "fn");
    if (!fn) {
        return 2;
    }

    b_t b = {
        ._ = 1,
        .__ = 2
    };
    b = fn(b);

    print(b);

    return 0;
}
