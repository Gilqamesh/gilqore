#include "console/console.h"

#include <stdio.h>     // vsnprintf

#include "common/error_code.h"
#include "libc/libc.h"

#include <windows.h>

struct console {
    HANDLE out_handle;

    char   *buffer;
    u32    buffer_size;
};

console_t console__init_module(u32 max_message_length) {
    console_t self = libc__malloc(sizeof(*self));
    self->buffer      = NULL;
    self->buffer_size = 0;
    self->out_handle  = INVALID_HANDLE_VALUE;

    // TODO(david): diagnostics
    if (!AttachConsole(ATTACH_PARENT_PROCESS)) {
        error_code__exit(CONSOLE_ERROR_CODE_ATTACH_CONSOLE);
    }

    if ((self->out_handle = GetStdHandle(STD_OUTPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }

    self->buffer_size = max_message_length + 1;
    self->buffer = (char*) libc__malloc(self->buffer_size);

    return self;
}

void console__deinit_module(console_t self) {
    FreeConsole();

    self->out_handle = INVALID_HANDLE_VALUE;

    if (self->buffer) {
        libc__free(self->buffer);
    }
    libc__free(self);
}

u32 console__log(console_t self, const char* msg, ...) {
    DWORD bytes_written;
    if (self->out_handle != INVALID_HANDLE_VALUE) {
        va_list ap;
        va_start(ap, msg);

        s32 number_of_characters_written = vsnprintf(self->buffer, self->buffer_size, msg, ap);
        if (number_of_characters_written < 0) {
            error_code__exit(CONSOLE_ERROR_CODE_VSNPRINTF);
        }
        if (self->buffer_size <= (u32) number_of_characters_written) {
            // todo(david): diagnostic, truncated msg
        }

        if (WriteConsoleA(self->out_handle, self->buffer, strnlen(self->buffer, self->buffer_size), &bytes_written, NULL) == 0) {
            // TODO(david): diagnostic, error
        }

        va_end(ap);
    }
    return (u32) bytes_written;
}

u32 console__size(console_t self) {
    return self->buffer_size - 1;
}
