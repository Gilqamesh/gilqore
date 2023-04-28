#include "console/console.h"

#include <stdarg.h>
#include <stdio.h>

#include "libc/libc.h"

struct console {
    u32 place_holder;
};

console console__init_module(u32 max_message_length) {
    (void) max_message_length;
    console self = libc__malloc(sizeof(*self));
    self->place_holder = 42;

    return self;
}

void console__deinit_module(console self) {
    libc__free(self);
}

void console__log(console self, char* msg, ...) {
    if (self->place_holder == 42) {
        va_list ap;
        va_start(ap, msg);

        vprintf(msg, ap);

        va_end(ap);
    }
}
