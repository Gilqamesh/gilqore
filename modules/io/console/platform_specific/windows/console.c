#include "io/console/console.h"

#include "common/error_code.h"
#include "libc/libc.h"
#include "io/file/file_reader/file_reader.h"
#include "gil_math/compare/compare.h"

#include "windows.h"

struct console {
    HANDLE err_handle;
    HANDLE in_handle;
    HANDLE out_handle;

    char   *buffer;
    u32    buffer_size;

    struct memory_slice input_reader_memory;
    struct file_reader input_reader;
};

console_t console__init_module(u32 max_message_length, bool attach_to_parent) {
    console_t self = libc__calloc(sizeof(*self));
    if (self == NULL) {
        return NULL;
    }

    self->err_handle  = INVALID_HANDLE_VALUE;
    self->in_handle  = INVALID_HANDLE_VALUE;
    self->out_handle  = INVALID_HANDLE_VALUE;

    if (attach_to_parent) {
        if (AttachConsole(ATTACH_PARENT_PROCESS) == FALSE) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(CONSOLE_ERROR_CODE_ATTACH_CONSOLE);
            libc__printf("AttachConsole GetLastError() returned %d\n", GetLastError());
            error_code__exit(32465);
        }
    } else {
        HWND console_window_handle = GetConsoleWindow();
        if (console_window_handle == NULL && AllocConsole() == FALSE) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(ALLOC_CONSOLE_FAILED);
            libc__printf("AllocConsole GetLastError() returned %d\n", GetLastError());
            error_code__exit(32466);
        }
    }

    if ((self->err_handle = GetStdHandle(STD_ERROR_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }
    if ((self->in_handle = GetStdHandle(STD_INPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }
    if ((self->out_handle = GetStdHandle(STD_OUTPUT_HANDLE)) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(CONSOLE_ERROR_CODE_GET_STD_HANDLE);
    }

    self->buffer_size = max_message_length + 1;
    self->buffer = (char*) libc__malloc(self->buffer_size);
    if (self->buffer == NULL) {
        libc__free(self);
        return NULL;
    }

    const u32 input_reader_memory_size = KILOBYTES(1);
    self->input_reader_memory = memory_slice__create(
        libc__malloc(input_reader_memory_size),
        input_reader_memory_size
    );
    if (memory_slice__memory(&self->input_reader_memory) == NULL) {
        libc__free(self->buffer);
        libc__free(self);
        return NULL;
    }
    // note: treat the console handle as a file handle
    struct file input_file = {
        .handle = self->in_handle
    };
    if (
        file_reader__create(
            &self->input_reader,
            input_file,
            self->input_reader_memory
        ) == false
    ) {
        libc__free(memory_slice__memory(&self->input_reader_memory));
        libc__free(self->buffer);
        libc__free(self);
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
    libc__free(memory_slice__memory(&self->input_reader_memory));
    file_reader__destroy(&self->input_reader);
    libc__free(self);
}

static DWORD console_write_impl(console_t self, const char* format, HANDLE console_handle, va_list ap) {
    DWORD bytes_written;
    if (console_handle != INVALID_HANDLE_VALUE) {
        s32 number_of_characters_written = libc__vsnprintf(self->buffer, self->buffer_size, format, ap);
        if (number_of_characters_written < 0) {
            // error_code__exit(CONSOLE_ERROR_CODE_VSNPRINTF);
        }
        if (self->buffer_size <= (u32) number_of_characters_written) {
            // todo(david): diagnostic, truncated message
        }

        if (WriteConsoleA(console_handle, self->buffer, (DWORD)libc__strnlen(self->buffer, self->buffer_size), &bytes_written, NULL) == FALSE) {
            // error_code__exit(WRITE_CONSOLE_A);
            // TODO(david): diagnostic, GetLastError()
            error_code__exit(354463);
        }
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
        return 0;
    }

    if (self->in_handle != INVALID_HANDLE_VALUE) {
        // set eof reached to false in case it was true to read new bytes from the input
        self->input_reader.eof_reached = false;
        u32 bytes_read = file_reader__read_while_not(&self->input_reader, buffer, buffer_size - 2, "\r\n");
        buffer[bytes_read] = '\n';
        buffer[bytes_read + 1] = '\0';
        // skip one newline
        (void) file_reader__read_while_not(&self->input_reader, NULL, 0 , "\n");
        (void) file_reader__read_while(&self->input_reader, NULL, 0 , "\n");

        return bytes_read > 0 ? bytes_read - 1 : 0;
    }

    return 0;
}
