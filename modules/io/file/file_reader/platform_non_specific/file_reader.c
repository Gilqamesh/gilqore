#include "io/file/file_reader/file_reader.h"

#include "gil_math/compare/compare.h"
#include "libc/libc.h"
#include "algorithms/hash/hash.h"
#include "io/file/file.h"
#include "memory/memory.h"

#include <stdarg.h>

bool file_reader__create(
    struct file_reader* self,
    struct file* file,
    struct memory_slice internal_buffer
) {
    self->file = file;
    if (circular_buffer__create(
        &self->circular_buffer,
        internal_buffer,
        sizeof(char), memory_slice__size(&internal_buffer)
    ) == false) {
        return false;
    }
    self->eof_reached = false;

    return true;
}

void file_reader__destroy(struct file_reader* self) {
    self->file = NULL;
    circular_buffer__destroy(&self->circular_buffer);
}

void file_reader__clear(struct file_reader* self, struct file* file) {
    circular_buffer__clear(&self->circular_buffer);
    self->file = file;
    self->eof_reached = false;
}

static void file_reader__ensure_fill(struct file_reader* self) {
    if (
        self->eof_reached == false &&
        circular_buffer__size_current(&self->circular_buffer) == 0
    ) {
        void* head = circular_buffer__head(&self->circular_buffer);
        void* end  = circular_buffer__end(&self->circular_buffer);
        u32 till_buffer_end = (u32)((char*) end - (char*) head);
        u32 circular_buffer_total_size = circular_buffer__size_item(&self->circular_buffer) * circular_buffer__size_total(&self->circular_buffer);
        u32 bytes_to_read = min__u32(circular_buffer_total_size, till_buffer_end);
        u32 bytes_read = file__read(self->file, head, bytes_to_read);
        circular_buffer__advance_head(&self->circular_buffer, bytes_read);
        if (bytes_read < bytes_to_read) {
            self->eof_reached = true;
        } else if (bytes_read < circular_buffer_total_size) {
            bytes_to_read = circular_buffer_total_size - bytes_read;
            bytes_read = file__read(self->file, head, bytes_to_read);
            circular_buffer__advance_head(&self->circular_buffer, bytes_read);
            if (bytes_read < bytes_to_read) {
                self->eof_reached = true;
            }
        }
    }
}

char file_reader__peek(struct file_reader* self) {
    file_reader__ensure_fill(self);
    if (circular_buffer__size_current(&self->circular_buffer) == 0) {
        // error_code__exit(FILE_READER_ERROR_NOTHING_TO_PEEK);
    }
    return *(char*) circular_buffer__tail(&self->circular_buffer);
}

u32 file_reader__read_one(struct file_reader* self, void* out, u32 size) {
    u32 total_bytes_read = 0;

    u32 circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
    while (
        size > 0 &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        file_reader__ensure_fill(self);
        circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            u32 bytes_to_write = min__u32(circular_buffer_cur_size, size);
            if (out != NULL) {
                circular_buffer__pop_multiple(
                    &self->circular_buffer,
                    out,
                    bytes_to_write
                );
                out = (u8*) out + bytes_to_write;
            } else {
                circular_buffer__advance_tail(&self->circular_buffer, bytes_to_write);
            }
            size -= bytes_to_write;
            total_bytes_read += bytes_to_write;
            circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        }
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

    u32 circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
    while (
        (out == NULL || size > 0) &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        if (circular_buffer_cur_size == 0) {
            file_reader__ensure_fill(self);
        }
        circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            unsigned char c = *(u8*) circular_buffer__tail(&self->circular_buffer);
            if (boolean_set[c] == (char) 1) {
                return total_bytes_read;
            }
            if (out != NULL) {
                circular_buffer__pop(&self->circular_buffer, out);
                out = (u8*) out + 1;
                --size;
            } else {
                circular_buffer__advance_tail(&self->circular_buffer, 1);
            }
            ++total_bytes_read;
            circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
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

    u8* cur_out = out;

    u32 circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
    while (
        (cur_out == NULL || size > 0) &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        if (circular_buffer_cur_size == 0) {
            file_reader__ensure_fill(self);
        }
        circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            unsigned char c = *(u8*) circular_buffer__tail(&self->circular_buffer);
            if (boolean_set[c] == (char) 0) {
                return total_bytes_read;
            }
            if (cur_out != NULL) {
                *cur_out++ = c;
                --size;
            }
            circular_buffer__advance_tail(&self->circular_buffer, 1);
            ++total_bytes_read;
            circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        }
    }

    return total_bytes_read;
}

bool file_reader__read_while_not_word(
    struct file_reader* self,
    void* out,
    u32 size,
    const char* word,
    u32 word_length,
    u32* bytes_read
) {
    if (word_length == 0) {
        return 0;
    }

    u32 total_bytes_read = 0;

    u64 hash_value = hash__sum_n(word, word_length);
    u64 rolling_hash_value = 0;
    u32 circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
    while (
        total_bytes_read < size &&
        (self->eof_reached == false || circular_buffer_cur_size > 0)
    ) {
        if (circular_buffer_cur_size == 0) {
            file_reader__ensure_fill(self);
        }
        circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        if (circular_buffer_cur_size > 0) {
            circular_buffer__pop(&self->circular_buffer, (u8*) out + total_bytes_read);

            rolling_hash_value += *((u8*) out + total_bytes_read);
            if (total_bytes_read + 1 >= word_length) {
                if (total_bytes_read >= word_length) {
                    rolling_hash_value -= *((u8*) out + total_bytes_read - word_length);
                }
                u32 word_position = total_bytes_read + 1 - word_length;
                if (
                    rolling_hash_value == hash_value &&
                    libc__strncmp(
                        (const char*) out + word_position,
                        word,
                        word_length
                    ) == 0
                ) {
                    *bytes_read = total_bytes_read + 1;
                    return true;
                }
            }

            ++total_bytes_read;
            circular_buffer_cur_size = circular_buffer__size_current(&self->circular_buffer);
        }
    }

    *bytes_read = total_bytes_read;
    return false;
}

#if 0
struct conversion_flags {
    bool  is_left_justified;  // '-'
    bool  is_zero_padded;     // '0'
    bool  is_there_precision; // '.'
    s32   amount_of_precision;
    bool  is_alternate_form;  // '#'
    bool  is_space_prefixed;  // ' '
    bool  is_sign_prefixed;   // '+'
    s32   minimum_field_width;
};

// @returns number of bytes moved in format
static u32 parse_conversion_flags(const char* format, struct conversion_flags* flags) {
    u32 bytes_parsed = 0;

    libc__memset(flags, 0, sizeof(flags));
    bool found_flag = true;
    while (found_flag) {
        found_flag = false;
        switch (*format) {
            case '-': {
                flags->is_left_justified = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            case '0': {
                flags->is_zero_padded = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            case '.': {
                flags->is_there_precision = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            case '#': {
                flags->is_alternate_form = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            case ' ': {
                flags->is_space_prefixed = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            case '+': {
                flags->is_sign_prefixed = true;
                ++bytes_parsed;
                found_flag = true;
            } break ;
            default: break ;
        }
    }
    if (libc__isdigit(*(format + bytes_parsed)) == true) {
        flags->minimum_field_width = libc__atoi(format + bytes_parsed, 10);
        bytes_parsed += s64__len(flags->minimum_field_width);
    }
    if (*(format + bytes_parsed) == '.') {
        ++bytes_parsed;
        flags->is_there_precision = true;
        while (*(format + bytes_parsed) == '0') {
            ++bytes_parsed;
        }
        if (libc__isdigit(*(format + bytes_parsed)) == true) {
            flags->amount_of_precision = libc__atoi(format + bytes_parsed, 10);
            bytes_parsed += s64__len(flags->amount_of_precision);
        }
    }
}

// @returns bytes written out
static u32 dispatch_by_conversion(
    struct file_reader* self,
    char conversion_specifier,
    struct conversion_flags* flags,
    u8* out,
    u32 out_size,
    va_list ap
) {
    u32 bytes_written_out = 0;

    switch (conversion_specifier) {
        case 's': {
        } break ;
        case 'S': {
        } break ;
    }

    return bytes_written_out;
}

u32 file_reader__read_format(struct file_reader* self, void* out, u32 size, const char* format, ...) {
    u32 bytes_matched = 0;

    va_list ap;

    va_start(ap, format);

    char* cur_format = (char*) format;
    u8* cur_out = out;

    u32 cur_bytes_matched = 1;
    u32 circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);

    while (
        cur_bytes_matched > 0 &&
        size > 0 &&
        (self->eof_reached == false || circular_buffer_cur_size > 0) &&
        *cur_format != '\0'
    ) {
        file_reader__ensure_fill(self);
        cur_bytes_matched = 0;
        circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);

        if (circular_buffer_cur_size > 0) {
            if (*cur_format == '%') {
                ++cur_format;
                if (*cur_format == '\0') {
                    // error_code__exit(WRONG_FORMAT_SPECIFIER);
                    error_code__exit(999);
                }
                struct conversion_flags flags;
                u32 bytes_parsed = parse_conversion_flags(cur_format, &flags);
                cur_format += bytes_parsed;
                if (*cur_format == '\0') {
                    // error_code__exit(WRONG_FORMAT_SPECIFIER);
                    error_code__exit(999);
                }
                u32 max_bytes_to_match = min__u32(circular_buffer_cur_size, size);
                cur_bytes_matched = dispatch_by_conversion(self, *cur_format, &flags, cur_out, max_bytes_to_match, ap);

                cur_out += cur_bytes_matched;
                size -= cur_bytes_matched;
                bytes_matched += cur_bytes_matched;
            } else {
                s8* p_c = circular_buffer__tail(self->circular_buffer);
                if (*p_c != *cur_format) {
                    // note: byte is not matched from the format, go to postamble of the routine
                    cur_bytes_matched = 0;
                } else {
                    *cur_out++ = *p_c;
                    --size;
                    circular_buffer__advance_tail(self->circular_buffer, 1);
                    ++bytes_matched;

                    cur_bytes_matched = 1;
                }
            }
            ++cur_format;

            circular_buffer_cur_size = circular_buffer__size_current(self->circular_buffer);
        }
    }

    va_end(ap);

    return bytes_matched;
}
#endif