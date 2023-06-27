#include "io/file/file_writer/file_writer.h"
#include "libc/libc.h"
#include "common/error_code.h"
#include "io/file/file.h"
#include <stdarg.h>
bool file_writer__create(struct file_writer* self, struct memory_slice buffer) {
    self->buffer = buffer;
    return true;
}
void file_writer__destroy(struct file_writer* self) {
    (void) self;
}
s32 file_writer__write_format(struct file_writer* self, struct file* file, const char* format, ...) {
    va_list ap;
    va_start(ap, format);
    s32 written_bytes =
    libc__vsnprintf(
        memory_slice__memory(&self->buffer), memory_slice__size(&self->buffer),
        format, ap
    );
    va_end(ap);
    if ((u32) written_bytes >= memory_slice__size(&self->buffer)) {
        // error_code__exit(BUFFER_SIZE_TOO_SMALL);
        error_code__exit(123);
    }
    if (file__write(file, memory_slice__memory(&self->buffer), written_bytes) != (u32) written_bytes) {
        error_code__exit(FILE_WRITER_ERROR_CODE_FILE_WRITE_UNEXPECTED_NUMBER_OF_BYTES_WRITTEN);
    }
    return written_bytes;
}
