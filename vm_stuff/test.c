#include <stdint.h>

typedef struct a {
    uint8_t _;
    uint16_t __;
} a_t;

a_t fn (a_t a) {
    return (a_t) {
        ._ = a._ + 1,
        .__ = a.__ + 1
    };
}
