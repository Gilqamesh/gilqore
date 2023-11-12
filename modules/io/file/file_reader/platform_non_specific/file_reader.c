#include "io/file/file_reader/file_reader.h"

#include "gil_math/compare/compare.h"
#include "libc/libc.h"
#include "algorithms/hash/hash.h"
#include "io/file/file.h"
#include "memory/memory.h"
#include "gil_math/compare/compare.h"
#include "gil_math/abs/abs.h"

bool file_reader__create(
    file_reader_t* self,
    struct file file,
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

void file_reader__destroy(file_reader_t* self) {
    circular_buffer__destroy(&self->circular_buffer);
}

void file_reader__clear(file_reader_t* self, struct file file) {
    circular_buffer__clear(&self->circular_buffer);
    self->file = file;
    self->eof_reached = false;
}

static void file_reader__ensure_fill(file_reader_t* self) {
    if (
        self->eof_reached == false &&
        circular_buffer__size_current(&self->circular_buffer) == 0
    ) {
        void* head = circular_buffer__head(&self->circular_buffer);
        void* end  = circular_buffer__end(&self->circular_buffer);
        u32 till_buffer_end = (u32)((char*) end - (char*) head);
        u32 circular_buffer_total_size = circular_buffer__size_item(&self->circular_buffer) * circular_buffer__size_total(&self->circular_buffer);
        u32 bytes_to_read = min__u32(circular_buffer_total_size, till_buffer_end);
        u32 bytes_read = file__read(&self->file, head, bytes_to_read);
        circular_buffer__advance_head(&self->circular_buffer, bytes_read);
        if (bytes_read < bytes_to_read) {
            self->eof_reached = true;
        } else if (bytes_read < circular_buffer_total_size) {
            bytes_to_read = circular_buffer_total_size - bytes_read;
            bytes_read = file__read(&self->file, head, bytes_to_read);
            circular_buffer__advance_head(&self->circular_buffer, bytes_read);
            if (bytes_read < bytes_to_read) {
                self->eof_reached = true;
            }
        }
    }
}

bool file_reader__has_reached_eof(file_reader_t* self) {
    return self->eof_reached == true && circular_buffer__size_current(&self->circular_buffer) == 0;
}

char file_reader__peek(file_reader_t* self) {
    if (circular_buffer__size_current(&self->circular_buffer) == 0) {
        file_reader__ensure_fill(self);
        if (circular_buffer__size_current(&self->circular_buffer) == 0) {
            // error_code__exit(FILE_READER_ERROR_NOTHING_TO_PEEK);
            error_code__exit(23487);
        }
    }

    return *(char*) circular_buffer__tail(&self->circular_buffer);
}

u32 file_reader__read_one(file_reader_t* self, void* out, u32 size) {
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

u32 file_reader__read_while_not(file_reader_t* self, void* out, u32 size, const char* set) {
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

u32 file_reader__read_while(file_reader_t* self, void* out, u32 size, const char* set) {
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
    file_reader_t* self,
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

bool file_reader__read_s32(file_reader_t* self, s32* out) {
    if (circular_buffer__size_current(&self->circular_buffer) == 0) {
        file_reader__ensure_fill(self);
        if (circular_buffer__size_current(&self->circular_buffer) == 0) {
            return false;
        }
    }

    if (out) {
        *out = 0;
    }

    const bool is_negative = *(char*) circular_buffer__tail(&self->circular_buffer) == '-';
    if (is_negative) {
        circular_buffer__advance_tail(&self->circular_buffer, 1);
    }

    if (circular_buffer__size_current(&self->circular_buffer) == 0) {
        file_reader__ensure_fill(self);
        if (circular_buffer__size_current(&self->circular_buffer) == 0) {
            circular_buffer__advance_tail(&self->circular_buffer, -1);
            return false;
        }
    }

    char c = *(char*) circular_buffer__tail(&self->circular_buffer);
    if (!libc__isdigit(c)) {
        circular_buffer__advance_tail(&self->circular_buffer, -1);
        return false;
    }

    circular_buffer__advance_tail(&self->circular_buffer, 1);

    if (out) {
        *out = c - '0';
    }

    //  2,147,483,647
    // got most significant digit, do it 9 more times at most
    for (int i = 0; i <= 9; ++i) {
        file_reader__ensure_fill(self);
        if (circular_buffer__size_current(&self->circular_buffer) == 0) {
            file_reader__ensure_fill(self);
            if (circular_buffer__size_current(&self->circular_buffer) == 0) {
                break ;
            }
        }

        c = *(char*) circular_buffer__tail(&self->circular_buffer);

        if (!libc__isdigit(c)) {
            break ;
        }

        circular_buffer__advance_tail(&self->circular_buffer, 1);

        if (out) {
            *out = *out * 10 + c - '0';
        }
    }
    
    return true;
}

// typedef struct conversion_flags {
//     bool  is_left_justified;  // '-'
//     bool  is_zero_padded;     // '0'
//     bool  is_there_precision; // '.'
//     s32   amount_of_precision;
//     bool  is_alternate_form;  // '#'
//     bool  is_space_prefixed;  // ' '
//     bool  is_sign_prefixed;   // '+'
//     s32   minimum_field_width;
// } _conversion_flags_t;

// static u32 _num_len(u64 a, u32 base) {
//     if (a == 0) {
//         return 1;
//     }

//     u32 result = 0;
//     while (a != 0) {
//         a /= base;
//         ++result;
//     }

//     return result;
// }

// static bool _file_reader__write_char(file_reader_t* self, char* out, u32* bytes_read) {
//     if (file_reader__has_reached_eof(self)) {
//         return false;
//     }

//     ASSERT(file_reader__read_one(self, *out, 1) == 1);
//     ++*bytes_read;

//     return true;
// }

// static bool _file_reader__write_char_from_if(file_reader_t* self, char* out, u32* bytes_read, const char expected) {
//     if (file_reader__has_reached_eof(self) || file_reader__peek(self) != expected) {
//         return false;
//     }

//     ASSERT(file_reader__read_one(self, *out, 1) == 1);
//     ++*bytes_read;

//     return true;
// }

// static bool _file_reader__write_char_from_set(file_reader_t* self, char** out_cur, const char* out_end, u32* bytes_read, char* char_read, const char* expected) {
//     if (*out_cur == out_end || file_reader__has_reached_eof(self)) {
//         return false;
//     }

//     char c = file_reader__peek(self);
//     bool found = false;
//     for (u32 i = 0; expected[i] != '\0'; ++i) {
//         if (expected[i] == c) {
//             found = true;
//             break ;
//         }
//     }
//     if (!found) {
//         return false;
//     }

//     ASSERT(file_reader__read_one(self, *char_read, 1) == 1);
//     *out_cur++ = char_read;
//     ++*bytes_read;

//     return true;
// }

// static bool _file_reader__write_str(file_reader_t* self, char* buffer, u32* bytes_read) {
//     char c;
//     while (_file_reader__write_char(self, buffer, bytes_read, &c)) {
//         if (c == '\0') {
//             break ;
//         }
//     }

//     return out_start != *out_cur;
// }

// static bool _file_reader__write_hex(file_reader_t* self, char** out_cur, const char* out_end, u32* bytes_read) {
//     char* out_start = *out_cur;

//     char c;
//     while (_file_reader__write_char_if(self, out_cur, out_end, bytes_read, &c, "0123456789abcdefABCDEF")) { }

//     return out_start != *out_cur;
// }

// static bool _file_reader__write_num(file_reader_t* self, char** out_cur, const char* out_end, u32* bytes_read) {
//     char* out_start = *out_cur;

//     char c;
//     while (_file_reader__write_char_if(self, out_cur, out_end, bytes_read, &c, "0123456789")) { }

//     return out_start != *out_cur;
// }

// static bool _file_reader__read_format_dispatch_format_specifier(
//     file_reader_t* self,
//     va_list* ap,
//     const char** format,
//     u32* bytes_matched,
//     char** out_cur, const char* const out_end
// ) {
//     bool result = true;

//     _conversion_flags_t flags;
//     libc__memset(&flags, 0, sizeof(flags));

//     while (true) {
//         bool can_leave = false;
//         switch (**format) {
//             case '#': {
//                 flags.is_alternate_form = true;
//             } break ;
//             case '0': {
//                 flags.is_zero_padded = true;
//             } break ;
//             case '-': {
//                 flags.is_left_justified = true;
//             } break ;
//             case ' ': {
//                 flags.is_space_prefixed = true;
//             } break ;
//             case '+': {
//                 flags.is_sign_prefixed = true;
//             } break ;
//             case '\0': {
//                 // error_code__exit(WRONG_FORMAT_SPECIFIER);
//                 error_code__exit(0xbaadf00d);
//             }
//             default: can_leave = true;
//         }

//         if (can_leave) {
//             break ;
//         }

//         ++*format;
//     }

//     if (libc__isdigit(**format)) {
//         flags.minimum_field_width = libc__atoi(*format, 10);
//         ASSERT(flags.minimum_field_width > 0);
//         *format += _num_len(flags.minimum_field_width, 10);
//     }

//     if (**format == '.') {
//         flags.is_there_precision = true;
//         ++*format;
//         while (**format == '0') {
//             ++*format;
//         }
//         if (libc__isdigit(**format)) {
//             flags.amount_of_precision = libc__atoi(*format, 10);
//             ASSERT(flags.amount_of_precision > 0);
//             *format += _num_len(flags.amount_of_precision, 10);
//         }
//     }

//     const char conversion = **format;
//     ++*format;
//     switch (conversion) {
//         case 'c': {
//             char expected = (char) va_arg(*ap, int);
//             result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, expected);
//         } break ;
//         case 's': {
//             char* expected = va_arg(*ap, char *);
//             s32 str_len = (s32)  libc__strlen(expected);
//             if (flags.is_there_precision) {
//                 str_len = min__s32(str_len, flags.amount_of_precision);
//             }
//             flags.minimum_field_width -= str_len;
//             if (result && flags.is_left_justified) {
//                 result = _file_reader__write_str(self, out_cur, out_end, bytes_matched, expected);
//             }
//             while (result && flags.minimum_field_width-- > 0) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//             }
//             if (result && !flags.is_left_justified) {
//                 result = _file_reader__write_str(self, out_cur, out_end, bytes_matched, expected);
//             }
//         } break ;
//         // case 'S': {
//         //     // todo: implement, only match upper-case letters
//         // } break ;
//         case 'p': {
//             size_t expected = (size_t) va_arg(*ap, void *);
//             s32 hex_len = _num_len(expected, 16);
//             if (result && flags.is_left_justified) {
//                 result = _file_reader__write_hex(self, out_cur, out_end, bytes_matched, expected, false);
//                 if (result == false) {
//                     break ;
//                 }
//             }
//             while (result && flags.minimum_field_width-- - hex_len > 0) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//             }
//             if (result && !flags.is_left_justified) {
//                 result = _file_reader__write_hex(self, out_cur, out_end, bytes_matched, expected, false);
//                 if (result == false) {
//                     break ;
//                 }
//             }
//         } break ;
//         case 'd':
//         case 'i': {
//             s32 expected = (s32) va_arg(*ap, s32);
//             if (flags.is_there_precision || flags.is_left_justified) {
//                 flags.is_zero_padded = false;
//             }
//             if (flags.is_sign_prefixed) {
//                 flags.is_space_prefixed = false;
//             }
//             s32 num_len = _num_len(expected, 10);
//             if (flags.is_there_precision && expected == 0) {
//                 num_len = 0;
//             }
//             const char* sign_prefix = expected < 0 ? "-" : flags.is_sign_prefixed ? "+" : flags.is_space_prefixed ? " " : "";
//             s32 zero_padding = max__s32(flags.amount_of_precision - num_len, 0);
//             s32 space_padding = max__s32(flags.minimum_field_width - (s32) libc__strlen(sign_prefix) - zero_padding - num_len, 0);
//             if (flags.is_zero_padded) {
//                 zero_padding = space_padding;
//                 space_padding = 0;
//             }
//             if (result && !flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//             result = _file_reader__write_str(self, out_cur, out_end, bytes_matched, sign_prefix);
//             while (result && zero_padding-- > 0) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, '0');
//             }
//             if (result && expected == S32_MIN) {
//                 result = _file_reader__write_str(self, out_cur, out_end, bytes_matched, "2147483648");
//             } else if (result && num_len > 0) {
//                 result =_file_reader__write_num(self, out_cur, out_end, bytes_matched, s32__abs(expected));
//             }
//             if (result && flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//         } break ;
//         case 'u': {
//             unsigned int expected = (unsigned int) va_arg(*ap, unsigned int);
//             if (flags.is_there_precision || flags.is_left_justified) {
//                 flags.is_zero_padded = false;
//             }
//             s32 num_len = _num_len(expected, 10);
//             if (flags.is_there_precision && expected == 0) {
//                 num_len = 0;
//             }
//             s32 zero_padding = max__s32(flags.amount_of_precision - num_len, 0);
//             s32 space_padding = max__s32(flags.minimum_field_width - zero_padding - num_len, 0);
//             if (flags.is_zero_padded) {
//                 zero_padding = max__s32(space_padding, zero_padding);
//                 space_padding = 0;
//             }
//             if (result && !flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//             while (result && zero_padding-- > 0) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, '0');
//             }
//             if (result && num_len > 0) {
//                 result =_file_reader__write_num(self, out_cur, out_end, bytes_matched, expected);
//             }
//             if (result && flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//         } break ;
//         case 'x':
//         case 'X': {
//             size_t expected = (size_t) va_arg(*ap, size_t);
//             if (flags.is_there_precision || flags.is_left_justified) {
//                 flags.is_zero_padded = false;
//             }
//             const char* prefix = flags.is_alternate_form ? conversion == 'x' ? "0x" : "0X" : "";
//             s32 hex_len = _num_len(expected, 16);
//             if (flags.is_there_precision && expected == 0) {
//                 prefix = "";
//                 hex_len = 0;
//             }
//             s32 zero_padding = max__s32(flags.amount_of_precision - hex_len, 0);
//             s32 space_padding = max__s32(flags.minimum_field_width - (s32) libc__strlen(prefix) - zero_padding - hex_len, 0);
//             if (flags.is_zero_padded) {
//                 zero_padding = max__s32(zero_padding, space_padding);
//                 space_padding = 0;
//             }
//             if (result && !flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//             if (result) {
//                 result = _file_reader__write_str(self, out_cur, out_end, bytes_matched, prefix);
//             }
//             while (result && zero_padding-- > 0) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, '0');
//             }
//             if (result) {
//                 result = _file_reader__write_hex(self, out_cur, out_end, bytes_matched, expected, conversion == 'X');
//             }
//             if (result && flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//         } break ;
//         case '%': {
//             if (flags.is_left_justified) {
//                 flags.is_zero_padded = false;
//             }
//             s32 zero_padding = 0;
//             s32 space_padding = 0;
//             if (flags.is_zero_padded) {
//                 zero_padding = max__s32(flags.minimum_field_width - 1, zero_padding);
//                 space_padding = 0;
//             } else {
//                 space_padding = max__s32(flags.minimum_field_width - 1, space_padding);
//                 zero_padding = 0;
//             }
//             if (result && !flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//             if (result) {
//                 while (result && zero_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, '0');
//                 }
//             }
//             if (result) {
//                 result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, '%');
//             }
//             if (result && flags.is_left_justified) {
//                 while (result && space_padding-- > 0) {
//                     result = _file_reader__write_char(self, out_cur, out_end, bytes_matched, ' ');
//                 }
//             }
//         } break ;
//         default: {
//             // error_code__exit(WRONG_FORMAT_SPECIFIER);
//             error_code__exit(0xbaadf00d);
//         }
//     }

//     return result;
// }

// u32 file_reader__read_formatv(file_reader_t* self, const char* format, ...) {
//     va_list ap;

//     va_start(ap, format);
//     u32 result = file_reader__read_formatv(self, format, ap);
//     va_end(ap);

//     return result;
// }

// u32 file_reader__read_formatv(file_reader_t* self, const char* format, va_list ap) {
//     u32 bytes_read = 0;

//     while (*format != '\0') {
//         if (*format == '%') {
//             ++format;

//             if (!_file_reader__read_format_dispatch_format_specifier(self, &format, &bytes_read)) {
//                 break ;
//             }
//         } else {
//             if (!_file_reader__write_char(self, &out_cur, out_end, &bytes_read)) {
//                 break ;
//             }
            
//             ++format;
//         }
//     }

//     return bytes_read;
// }
