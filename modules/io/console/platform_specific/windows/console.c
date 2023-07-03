#include "io/console/console.h"

#include "common/error_code.h"
#include "libc/libc.h"
#include "io/file/file.h"

#include "windows.h"

struct console {
    HANDLE err_handle;
    HANDLE in_handle;
    HANDLE out_handle;

    char   *buffer;
    u32    buffer_size;
};

console_t console__init_module(u32 max_message_length, bool attach_to_parent) {
    console_t self = libc__calloc(sizeof(*self));
    if (self == NULL) {
        return NULL;
    }

    libc__memset(self, 0, sizeof(*self));
    self->err_handle  = INVALID_HANDLE_VALUE;
    self->in_handle  = INVALID_HANDLE_VALUE;
    self->out_handle  = INVALID_HANDLE_VALUE;

    if (attach_to_parent) {
        if (AttachConsole(ATTACH_PARENT_PROCESS) == FALSE) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(CONSOLE_ERROR_CODE_ATTACH_CONSOLE);
            console__deinit_module(self);
            libc__printf("AttachConsole GetLastError() returned %d\n", GetLastError());
            error_code__exit(32465);
        }
    } else {
        HWND console_window_handle = GetConsoleWindow();
        if (console_window_handle == NULL && AllocConsole() == FALSE) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(ALLOC_CONSOLE_FAILED);
            console__deinit_module(self);
            libc__printf("AllocConsole GetLastError() returned %d\n", GetLastError());
            error_code__exit(32466);
        }
    }

    if ((self->err_handle = GetStdHandle(STD_ERROR_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        console__deinit_module(self);
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }
    if (SetConsoleMode(
        self->err_handle,
        ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT 
    ) == FALSE) {
        console__deinit_module(self);
        // todo: diagnostics, GetLastError()
        // error_code__exit(SET_CONSOLE_MODE_FAILED);
        error_code__exit(98484);
    }
    if ((self->in_handle = GetStdHandle(STD_INPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        console__deinit_module(self);
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }

    if (SetConsoleMode(
        self->in_handle,
        ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT | ENABLE_PROCESSED_INPUT | ENABLE_INSERT_MODE
    ) == FALSE) {
        console__deinit_module(self);
        // todo: diagnostics, GetLastError()
        // error_code__exit(SET_CONSOLE_MODE_FAILED);
        error_code__exit(98484);
    }

    if ((self->out_handle = GetStdHandle(STD_OUTPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        console__deinit_module(self);
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }
    if (SetConsoleMode(
        self->out_handle,
        ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT 
    ) == FALSE) {
        console__deinit_module(self);
        // todo: diagnostics, GetLastError()
        // error_code__exit(SET_CONSOLE_MODE_FAILED);
        error_code__exit(98484);
    }

    self->buffer_size = max_message_length + 1;
    self->buffer = (char*) libc__malloc(self->buffer_size);
    if (self->buffer == NULL) {
        console__deinit_module(self);
        return NULL;
    }

    return self;
}

void console__deinit_module(console_t self) {
    FreeConsole();

    self->out_handle = INVALID_HANDLE_VALUE;
    self->in_handle = INVALID_HANDLE_VALUE;
    self->err_handle = INVALID_HANDLE_VALUE;

    if (self->buffer) {
        libc__free(self->buffer);
    }
    libc__free(self);
}

static DWORD console_write_impl(console_t self, const char* format, HANDLE console_handle, va_list ap) {
    u32 bytes_written = 0;
    if (console_handle != INVALID_HANDLE_VALUE) {
        u32 number_of_characters_written = (u32) libc__vsnprintf(self->buffer, self->buffer_size, format, ap);
        if (self->buffer_size <= number_of_characters_written) {
            ASSERT(self->buffer_size > 0);
            number_of_characters_written = self->buffer_size - 1;
            // todo(david): diagnostic, truncated message
        }
        ASSERT(self->buffer[number_of_characters_written] == '\0');

        struct file out_file = {
            .handle = console_handle
        };
        bytes_written = file__write(&out_file, self->buffer, number_of_characters_written);
    }

    return bytes_written;
}

u32 console__write(console_t self, const char* format, ...) {
    if (self->out_handle != INVALID_HANDLE_VALUE) {
        va_list ap;
        va_start(ap, format);
        return (u32) console_write_impl(self, format, self->out_handle, ap);
        va_end(ap);
    }

    return 0;
}

u32 console__write_error(console_t self, const char* format, ...) {
    if (self->err_handle != INVALID_HANDLE_VALUE) {
        va_list ap;
        va_start(ap, format);
        return (u32) console_write_impl(self, format, self->err_handle, ap);
        va_end(ap);
    }

    return 0;
}

u32 console__read_line(console_t self, char* buffer, u32 buffer_size) {
    if (buffer_size < 2) {
        if (buffer_size == 1) {
            buffer[0] = '\0';
        }
        return 0;
    }

    u32 bytes_read = 0;
    if (self->in_handle != INVALID_HANDLE_VALUE) {
        struct file input_file = {
            .handle = self->in_handle
        };
        bytes_read = file__read(&input_file, buffer, buffer_size);
        if (buffer[bytes_read - 2] == '\r') {
            bytes_read -= 2;
        } else {
            --bytes_read;
        }
        buffer[bytes_read] = '\0';
    }

    return bytes_read;
}
