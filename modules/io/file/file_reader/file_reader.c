#include "file_reader.h"

#include "math/compare/compare.h"
#include "libc/libc.h"

#define FILE_READER_CIRCULAR_BUFFER_SIZE 16384

bool file_reader__create(struct file_reader* self, struct file* file) {
    self->file = file;
    self->circular_buffer = circular_buffer__create(sizeof(char), FILE_READER_CIRCULAR_BUFFER_SIZE);
    self->eof_reached = false;

    return true;
}

void file_reader__destroy(struct file_reader* self) {
    self->file = NULL;
    circular_buffer__destroy(self->circular_buffer);
}

void file_reader__clear(struct file_reader* self) {
    circular_buffer__clear(self->circular_buffer);
    self->eof_reached = false;
}

static void file_reader__ensure_fill(struct file_reader* self) {
    if (
        self->eof_reached == false &&
        circular_buffer__size_current(self->circular_buffer) < circular_buffer__size_total(self->circular_buffer)
    ) {
        void* head = circular_buffer__head(self->circular_buffer);
        void* end  = circular_buffer__end(self->circular_buffer);
        u32 till_buffer_end = (u8*) end - (u8*) head;
        u32 bytes_to_read = min__u32(FILE_READER_CIRCULAR_BUFFER_SIZE, till_buffer_end);
        u32 bytes_read = file__read(self->file, head, bytes_to_read);
        circular_buffer__advance_head(self->circular_buffer, bytes_read);
        if (bytes_read < bytes_to_read) {
            self->eof_reached = true;
        } else if (bytes_read < FILE_READER_CIRCULAR_BUFFER_SIZE) {
            bytes_to_read = FILE_READER_CIRCULAR_BUFFER_SIZE - bytes_read;
            bytes_read = file__read(self->file, head, bytes_to_read);
            circular_buffer__advance_head(self->circular_buffer, bytes_read);
            if (bytes_read < bytes_to_read) {
                self->eof_reached = true;
            }
        }
    }
}

char file_reader__peek(struct file_reader* self) {
    file_reader__ensure_fill(self);
    if (circular_buffer__size_current(self->circular_buffer) == 0) {
        // error_code__exit(FILE_READER_ERROR_NOTHING_TO_PEEK);
    }
    return *(char*) circular_buffer__tail(self->circular_buffer);
}

u32 file_reader__read_one(struct file_reader* self, void* out, u32 size) {
    u32 total_bytes_read = 0;

    u32 circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    while (size > 0 && (self->eof_reached == false || circular_buffer_cur_size > 0)) {
        file_reader__ensure_fill(self);
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
        u32 bytes_to_write = min__u32(circular_buffer_cur_size, size);
        if (out != NULL) {
            circular_buffer__pop_multiple(
                self->circular_buffer,
                out,
                bytes_to_write
            );
            out = (u8*) out + bytes_to_write;
        } else {
            circular_buffer__advance_tail(self->circular_buffer, bytes_to_write);
        }
        size -= bytes_to_write;
        total_bytes_read += bytes_to_write;
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    }

    return total_bytes_read;
}

u32 file_reader__read_while_not(struct file_reader* self, void* out, u32 size, const char* set) {
    u32 total_bytes_read = 0;

    char boolean_set[256];
    libc__memset(boolean_set, 0, ARRAY_SIZE(boolean_set));
    while (*set != '\0') {
        boolean_set[(unsigned char)*set++] = (char) 1;
    }

    u32 circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    while (
        (out == NULL || size > 0) &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        if (circular_buffer_cur_size == 0) {
            file_reader__ensure_fill(self);
        }
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            unsigned char c = *(u8*) circular_buffer__tail(self->circular_buffer);
            if (boolean_set[c] == (char) 1) {
                return total_bytes_read;
            }
            if (out != NULL) {
                circular_buffer__pop(self->circular_buffer, out);
                out = (u8*) out + 1;
                --size;
            } else {
                circular_buffer__advance_tail(self->circular_buffer, 1);
            }
            ++total_bytes_read;
        }
    }

    return total_bytes_read;
}

u32 file_reader__read_while(struct file_reader* self, void* out, u32 size, const char* set) {
    u32 total_bytes_read = 0;

    char boolean_set[256];
    libc__memset(boolean_set, 0, ARRAY_SIZE(boolean_set));
    while (*set != '\0') {
        boolean_set[(unsigned char)*set++] = (char) 1;
    }

    u32 circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    while (
        (out == NULL || size > 0) &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        if (circular_buffer_cur_size == 0) {
            file_reader__ensure_fill(self);
        }
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            unsigned char c = *(u8*) circular_buffer__tail(self->circular_buffer);
            if (boolean_set[c] == (char) 0) {
                return total_bytes_read;
            }
            if (out != NULL) {
                circular_buffer__pop(self->circular_buffer, out);
                out = (u8*) out + 1;
                --size;
            } else {
                circular_buffer__advance_tail(self->circular_buffer, 1);
            }
            ++total_bytes_read;
        }
    }

    return total_bytes_read;
}
