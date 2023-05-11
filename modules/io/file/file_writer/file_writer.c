#include "file_writer.h"

#include "libc/libc.h"
#include "common/error_code.h"
#include "io/file/file.h"

#include <stdarg.h>

bool file_writer__create(struct file_writer* self) {
    self->buffer_size = 1024;
    self->buffer = libc__malloc(1024);

    return true;
}

void file_writer__destroy(struct file_writer* self) {
    libc__free(self->buffer);
}

s32 file_writer__write_format(struct file_writer* self, struct file* file, const char* format, ...) {
    va_list ap;

    va_start(ap, format);
    s32 written_bytes = libc__vsnprintf(self->buffer, self->buffer_size, format, ap);
    va_end(ap);

    if ((u32) written_bytes >= self->buffer_size) {
        // error_code__exit(BUFFER_SIZE_TOO_SMALL);
        error_code__exit(123);
    }

    if (file__write(file, self->buffer, written_bytes) != (u32) written_bytes) {
        error_code__exit(FILE_WRITER_ERROR_CODE_FILE_WRITE_UNEXPECTED_NUMBER_OF_BYTES_WRITTEN);
    }

    return written_bytes;
}
