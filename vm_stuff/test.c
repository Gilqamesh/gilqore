#include <stdint.h>

typedef struct a {
    uint8_t  _;
    uint16_t __;
    int32_t  ___;
    int8_t   ____;
} a_t;

typedef struct b {
    a_t      _;
    uint32_t __;
    a_t      ___;
} b_t;

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

b_t fn3() {
    a_t a = {
        ._ = 3,
        .__ = 3443,
        .___ = -89283,
        .____ = -93
    };
    return (b_t) {
        ._   = fn(a),
        .__  = 42424242,
        .___ = fn(fn(fn(a)))
    };
}

int32_t fact(uint64_t a) {
    if (a == 0) {
        return 1;
    }

    return a * fact(a - 1);
}
