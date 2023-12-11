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

#include <stdio.h>

static uint32_t debug__push_hex(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* bytes, uint32_t bytes_size) {
    bytes = bytes + bytes_size;
    uint8_t* buffer_top_start = buffer_top;

    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }

    for (uint32_t bytes_index = 0; bytes_index < bytes_size; ++bytes_index) {
        int32_t bytes_written = snprintf(
            buffer_top, buffer_end - buffer_top,
            "%02x", (int32_t) *--bytes
        );
        buffer_top += bytes_written;
    }

    return buffer_top - buffer_top_start;
}

static uint32_t debug__push_pointer(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* pointer) {
    uint8_t* buffer_top_start = buffer_top;

    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }

    uint64_t val = (uint64_t) pointer;
    uint8_t* p = (uint8_t*) &val;
    p += sizeof(uint8_t*);
    for (uint32_t bytes_index = 0; bytes_index < sizeof(uint8_t*); ++bytes_index) {
        int32_t bytes_written = snprintf(
            buffer_top, buffer_end - buffer_top,
            "%02x", (int32_t) *--p
        );
        buffer_top += bytes_written;
    }

    return buffer_top - buffer_top_start;
}

typedef struct sa {
    int a;
    int b;
    double c;
    float d;
    uint32_t e;
} ta;

typedef struct sb {
    int a;
    int b;
    double c;
    float d;
    uint32_t e;
} tb;

int main() {
    uint64_t a = (uint64_t)(-2+0.2);
    uint64_t b = a + 1;
    double c = 2;
    float c;

    // ta a;
    // tb* b = (tb*) &a;

    // float b = 2;
    // ta c = (ta) b;

    return 0;
}
