#include <stdio.h>
#include <stdint.h>

typedef struct a {
    uint8_t  _;
    uint16_t __;
    uint32_t ___;
    uint64_t ____;
} a_t;

void print_arr(unsigned char* arr, uint32_t arr_size) {
    for (uint32_t i = 0; i < arr_size; ++i) {
        printf("%3d ", arr[i]);
    }
    printf("\n");
}

int main() {
    unsigned char arr[32] = { 0 };
    print_arr(arr, sizeof(a_t));

    a_t a = {
        ._ = 1,
        .__ = 0x0201,
        .___ = 0x10101020,
        .____ = 0xf010000102030405
    };
    *(a_t*) arr = a;
    print_arr(arr, sizeof(a_t));

    return 0;
}
