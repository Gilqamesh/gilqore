#include "console/console.h"

#include <stdarg.h>
#include <stdio.h>

#include "libc/libc.h"

struct console {
    u32 place_holder;
};

console_t console__init_module(u32 max_message_length) {
    (void) max_message_length;
    console_t self = libc__malloc(sizeof(*self));
    self->place_holder = 42;

    return self;
}

void console__deinit_module(console_t self) {
    libc__free(self);
}

u32 console__log(console_t self, const char* msg, ...) {
    if (self->place_holder == 42) {
        va_list ap;
        va_start(ap, msg);

        vprintf(msg, ap);

        va_end(ap);
    }
}

u32 console__size(console_t self) {
    (void) self;

    return 0;
}
