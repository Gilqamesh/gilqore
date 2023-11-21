#include <stdint.h>

typedef struct a {
    uint8_t  _;
    uint16_t __;
    int32_t  ___;
    int8_t   ____;
} a_t;

a_t fn (a_t a) {
    return (a_t) {
        ._ = a._ + 1,
        .__ = a.__ + 1,
        .___ = a.___ + 1,
        .____ = a.____ + 1
    };
}

int32_t fn2(int32_t a) {
    return a + 1;
}

uint64_t fact(uint64_t a) {
    if (a == 0) {
        return 1;
    }

    return a * fact(a - 1);
}
