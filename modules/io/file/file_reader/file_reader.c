#include "file_reader.h"

#include "math/compare/compare.h"

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

u32 file_reader__read(struct file_reader* self, void* out, u32 size) {
    u32 total_bytes_read = 0;

    u32 circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    while (size > 0 && (self->eof_reached == false || circular_buffer_cur_size > 0)) {
        if (
            self->eof_reached == false &&
            circular_buffer_cur_size == 0
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
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
        u32 bytes_to_write = min__u32(circular_buffer_cur_size, size);
        circular_buffer__pop_multiple(
            self->circular_buffer,
            out,
            bytes_to_write
        );
        out = (u8*) out + bytes_to_write;
        size -= bytes_to_write;
        total_bytes_read += bytes_to_write;
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
    }

    return total_bytes_read;
}
