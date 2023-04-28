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

console console__init_module(u32 max_message_length) {
    console self = libc__malloc(sizeof(*self));
    self->buffer      = NULL;
    self->buffer_size = 0;
    self->out_handle  = INVALID_HANDLE_VALUE;

    // TODO(david): diagnostics
    if (!AttachConsole(ATTACH_PARENT_PROCESS)) {
        error_code__exit(CONSOLE_ERROR_CODE_ATTACH_CONSOLE);
        UNREACHABLE_CODE;
    }

    if ((self->out_handle = GetStdHandle(STD_OUTPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
        UNREACHABLE_CODE;
    }

    self->buffer_size = max_message_length;
    self->buffer = (char*) libc__malloc(self->buffer_size);

    return self;
}

void console__deinit_module(console self) {
    FreeConsole();

    self->out_handle = INVALID_HANDLE_VALUE;

    if (self->buffer) {
        libc__free(self->buffer);
    }
}

void console__log(console self, char* msg, ...) {
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

        DWORD bytes_written;
        if (WriteConsoleA(self->out_handle, self->buffer, strnlen(self->buffer, self->buffer_size), &bytes_written, NULL) == 0) {
            // TODO(david): diagnostic, error
        }

        va_end(ap);
    }
}
