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
    // HMODULE test_module = LoadLibrary("test.dll");
    // DWORD err = GetLastError();
    // b_t (*fn)(b_t) = (b_t (*)(b_t)) GetProcAddress(test_module, "fn");
    // err = GetLastError();

    // b_t b = {
    //     ._ = 1,
    //     .__ = 2
    // };
    // b = fn(b);

    // print(b);

    // return 0;
}
