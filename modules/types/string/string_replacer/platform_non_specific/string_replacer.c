#include "types/string/string_replacer/string_replacer.h"

#include "libc/libc.h"
#include "math/compare/compare.h"
#include "common/error_code.h"
#include "io/file/file.h"
#include "algorithms/hash/hash.h"

bool string_replacer__create(
    struct string_replacer* self,
    const char* original,
    u32 original_len,
    u32 max_number_of_replacements,
    u32 total_size_of_replacements_in_bytes
) {
    self->original = original;
    self->original_str_len = original_len;
    self->current_str_len = self->original_str_len;

    self->withs_top = 0;
    self->withs_size = max_number_of_replacements;

    self->whats = libc__malloc(self->withs_size * sizeof(*self->whats));
    self->withs = libc__malloc(self->withs_size * sizeof(*self->withs));
    self->with_sizes = libc__malloc(self->withs_size * sizeof(*self->with_sizes));
    self->what_sizes = libc__malloc(self->withs_size * sizeof(*self->what_sizes));
    
    self->with_buffer_top = 0;
    self->with_buffer_size = self->withs_size * total_size_of_replacements_in_bytes;
    self->with_buffer = libc__malloc(self->with_buffer_size);

    return true;
}

void string_replacer__destroy(struct string_replacer* self) {
    libc__free(self->whats);
    libc__free(self->withs);
    libc__free(self->with_sizes);
    libc__free(self->what_sizes);
    libc__free(self->with_buffer);
}

void string_replacer__clear(struct string_replacer* self, const char* original, u32 original_len) {
    self->original = original;
    self->original_str_len = original_len;
    self->current_str_len = self->original_str_len;
    self->withs_top = 0;
    self->with_buffer_top = 0;
}

void string_replacer_sort_indices(struct string_replacer* self) {
    // todo: better sorting algorithm
    // ASSERT(
    //     self->withs_size < 20 &&
    //     "too many replacements allowed, this shouldn't be a bottleneck so should implement a better sorting algorithm at this point, currently its O(n^2)"
    // );

    // note: sort based on whats
    for (u32 outer_what_index = 0; outer_what_index < self->withs_top; ++outer_what_index) {
        for (u32 inner_what_index = outer_what_index + 1; inner_what_index < self->withs_top; ++inner_what_index) {
            if (self->whats[inner_what_index] < self->whats[outer_what_index]) {
                u32 tmp_u32 = self->whats[inner_what_index];
                self->whats[inner_what_index] = self->whats[outer_what_index];
                self->whats[outer_what_index] = tmp_u32;

                tmp_u32 = self->what_sizes[inner_what_index];
                self->what_sizes[inner_what_index] = self->what_sizes[outer_what_index];
                self->what_sizes[outer_what_index] = tmp_u32;

                char* tmp_pchar = self->withs[inner_what_index];
                self->withs[inner_what_index] = self->withs[outer_what_index];
                self->withs[outer_what_index] = tmp_pchar;

                tmp_u32 = self->with_sizes[inner_what_index];
                self->with_sizes[inner_what_index] = self->with_sizes[outer_what_index];
                self->with_sizes[outer_what_index] = tmp_u32;
            }
        }
    }
}

static void string_replacer_sanitize_what_position(
    struct string_replacer* self,
    u32 what_position,
    u32* what_length
) {
    if (self->withs_top == self->withs_size) {
        error_code__exit(STRING_REPLACER_ERROR_CODE_REACHED_MAXIMUM_AMOUNT_OF_REPLACEMENTS);
    }

    if (what_position >= self->original_str_len) {
        error_code__exit(STRING_REPLACER_ERROR_CODE_WHAT_POSITION_OUTSIDE_OF_ORIGINAL);
    }

    if (what_position + *what_length > self->original_str_len) {
        *what_length = self->original_str_len - what_position;
    }

    // note: what_position + what_length straddles the next what position is not supported
    if (self->withs_top > 0) {
        // note: assumes that the indices are sorted
        u32 next_what_index = 0;
        u32 next_what_position = self->whats[next_what_index];
        while (
            next_what_position < what_position &&
            next_what_index + 1 < self->withs_top
        ) {
            next_what_position = self->whats[++next_what_index];
        }
        if (next_what_position == what_position) {
            error_code__exit(STRING_REPLACER_ERROR_CODE_WHAT_POSITION_ALREADY_EXISTS);
        }
        if (
            (next_what_position < what_position && next_what_position + self->what_sizes[next_what_index] > what_position) ||
            (what_position < next_what_position && next_what_position < what_position + *what_length)
        ) {
            error_code__exit(STRING_REPLACER_ERROR_CODE_WHAT_STRADDLES_ANOTHER_WHAT);
        }
    }
}

u32 string_replacer__replace_at_position(
    struct string_replacer* self,
    u32 what_position,
    u32 what_length,
    const char* with,
    u32 with_length
) {
    string_replacer_sanitize_what_position(self, what_position, &what_length);

    self->whats[self->withs_top] = what_position;
    self->what_sizes[self->withs_top] = what_length;

    self->withs[self->withs_top] = self->with_buffer + self->with_buffer_top;
    self->with_sizes[self->withs_top] = with_length;

    if (with_length + self->with_buffer_top > self->with_buffer_size) {
        error_code__exit(STRING_REPLACER_ERROR_CODE_REACHED_MAXIMUM_WITH_BUFFER_SIZE);
    }

    libc__memcpy(self->withs[self->withs_top], with, with_length);

    ++self->withs_top;
    self->with_buffer_top += with_length;

    // note: in order to keep the read easier, sort the indices..
    string_replacer_sort_indices(self);

    // note: careful, these are unsigned
    self->current_str_len = self->current_str_len + with_length - what_length;
    return self->current_str_len;
}

u32 string_replacer__replace_at_position_f(
    struct string_replacer* self,
    u32 what_position,
    u32 what_length,
    const char* with_format,
    ...
) {
    va_list  ap;
    va_start(ap, with_format);

    u32 result = string_replacer__replace_at_position_vf(
        self,
        what_position,
        what_length,
        with_format,
        ap
    );

    va_end(ap);

    return result;
}

u32 string_replacer__replace_at_position_vf(
    struct string_replacer* self,
    u32 what_position,
    u32 what_length,
    const char* with_format,
    va_list ap
) {
    string_replacer_sanitize_what_position(self, what_position, &what_length);

    self->whats[self->withs_top] = what_position;
    self->what_sizes[self->withs_top] = what_length;

    self->withs[self->withs_top] = self->with_buffer + self->with_buffer_top;

    u32 remaining_with_buffer = self->with_buffer_size - self->with_buffer_top;
    // note: technically don't need to null-terminate the written string, but vsnprint does it
    u32 with_length = libc__vsnprintf(
        self->withs[self->withs_top],
        remaining_with_buffer,
        with_format,
        ap
    );
    if (with_length >= remaining_with_buffer) {
        error_code__exit(STRING_REPLACER_ERROR_CODE_REACHED_MAXIMUM_WITH_BUFFER_SIZE);
    }
    self->with_sizes[self->withs_top] = with_length;

    ++self->withs_top;
    self->with_buffer_top += with_length;

    // note: in order to keep the read easier, sort the indices..
    string_replacer_sort_indices(self);

    // note: careful, these are unsigned
    self->current_str_len = self->current_str_len + with_length - what_length;
    return self->current_str_len;
}

u32 string_replacer__replace_word(
    struct string_replacer* self,
    u32 max_number_of_what_occurances,
    const char* what,
    u32 what_length,
    const char* with,
    u32 with_length
) {
    if (what_length == 0 || max_number_of_what_occurances == 0) {
        return self->current_str_len;
    }

    u64 hash_value = hash__sum_n(what, what_length);
    u32 rolling_hash_value = 0;
    u32 with_index = 0;
    u32 next_taken_what_index = with_index == self->withs_top ? (u32) -1 : self->whats[with_index];
    u32 lag_index = 0;
    u32 original_index = 0;
    while (
        max_number_of_what_occurances > 0 &&
        original_index < self->original_str_len
    ) {
        if (original_index == next_taken_what_index) {
            original_index += self->what_sizes[with_index] - 1;
            ++with_index;
            next_taken_what_index = with_index == self->withs_top ? (u32) -1 : self->whats[with_index];
            rolling_hash_value = 0;
            lag_index = 0;
            ++original_index;
            continue ;
        }
        rolling_hash_value += self->original[original_index];
        if (lag_index + 1 >= what_length) {
            if (lag_index >= what_length) {
                rolling_hash_value -= self->original[original_index - what_length];
            }
            u32 what_position = original_index + 1 - what_length;
            if (
                rolling_hash_value == hash_value &&
                libc__strncmp(
                    self->original + what_position,
                    what,
                    what_length
                ) == 0
            ) {
                string_replacer__replace_at_position(
                    self,
                    what_position,
                    what_length,
                    with,
                    with_length
                );
                --max_number_of_what_occurances;
                rolling_hash_value = 0;
                lag_index = 0;
                ++original_index;
                continue ;
            }
        }

        ++lag_index;
        ++original_index;
    }

    return self->current_str_len;
}

u32 string_replacer__replace_word_f(
    struct string_replacer* self,
    u32 max_number_of_what_occurances,
    const char* what,
    u32 what_length,
    const char* with_format,
    ...
) {
    va_list  ap;

    va_start(ap, with_format);

    u32 result = string_replacer__replace_word_vf(
        self,
        max_number_of_what_occurances,
        what,
        what_length,
        with_format,
        ap
    );

    va_end(ap);

    return result;
}

u32 string_replacer__replace_word_vf(
    struct string_replacer* self,
    u32 max_number_of_what_occurances,
    const char* what,
    u32 what_length,
    const char* with_format,
    va_list ap
) {
    if (what_length == 0 || max_number_of_what_occurances == 0) {
        return self->current_str_len;
    }

    u64 hash_value = hash__sum_n(what, what_length);
    u32 rolling_hash_value = 0;
    u32 with_index = 0;
    u32 next_taken_what_index = with_index == self->withs_top ? (u32) -1 : self->whats[with_index];
    u32 lag_index = 0;
    u32 original_index = 0;
    while (
        max_number_of_what_occurances > 0 &&
        original_index < self->original_str_len
    ) {
        if (original_index == next_taken_what_index) {
            original_index += self->what_sizes[with_index] - 1;
            ++with_index;
            next_taken_what_index = with_index == self->withs_top ? (u32) -1 : self->whats[with_index];
            rolling_hash_value = 0;
            lag_index = 0;
            ++original_index;
            continue ;
        }
        rolling_hash_value += self->original[original_index];
        if (lag_index + 1 >= what_length) {
            if (lag_index >= what_length) {
                rolling_hash_value -= self->original[original_index - what_length];
            }
            u32 what_position = original_index + 1 - what_length;
            if (
                rolling_hash_value == hash_value &&
                libc__strncmp(
                    self->original + what_position,
                    what,
                    what_length
                ) == 0
            ) {
                string_replacer__replace_at_position_vf(
                    self,
                    what_position,
                    what_length,
                    with_format,
                    ap
                );
                --max_number_of_what_occurances;
                rolling_hash_value = 0;
                lag_index = 0;
                ++original_index;
                continue ;
            }
        }

        ++lag_index;
        ++original_index;
    }

    return self->current_str_len;
}

u32 string_replacer__read(
    struct string_replacer* self,
    char* buffer,
    u32 buffer_size,
    u32 offset_to_read_from
) {
    u32 bytes_written = 0;

    u32 original_index = 0;
    u32 replacement_index_cur = 0;
    const char* replace_str;
    u32 replace_size;

    bool original_turn = true;

    while (
        original_index != self->original_str_len &&
        buffer_size > 1
    ) {
        if (replacement_index_cur == self->withs_top) {             // LAST PART
            replace_size = self->original_str_len - original_index;
            replace_str = self->original + original_index;
            original_index += replace_size;
        } else if (original_turn == true) {                         // ORIGINAL PART
            replace_size = self->whats[replacement_index_cur] - original_index;
            replace_str = self->original + original_index;
            original_index += replace_size;
        } else {                                                    // REPLACEMENT PART
            replace_size = self->with_sizes[replacement_index_cur];
            replace_str = self->withs[replacement_index_cur];
            original_index += self->what_sizes[replacement_index_cur];
            ++replacement_index_cur;
        }
        original_turn = !original_turn;

        u32 bytes_to_write = min__u32(buffer_size, replace_size);
        if (offset_to_read_from > 0) {
            if (bytes_to_write > offset_to_read_from) {
                bytes_to_write -= offset_to_read_from;
                replace_str += offset_to_read_from;
                offset_to_read_from = 0;
            } else {
                offset_to_read_from -= bytes_to_write;
                bytes_to_write = 0;
            }
        }

        if (bytes_to_write > 0) {
            libc__memcpy(buffer, replace_str, bytes_to_write);
            buffer_size -= bytes_to_write;
            buffer += bytes_to_write;
            bytes_written += bytes_to_write;
        }
    }

    *buffer = '\0';

    return bytes_written;
}

u32 string_replacer__read_into_file(
    struct string_replacer* self,
    struct file* file,
    u32 offset_to_read_from
) {
    u32 bytes_written = 0;

    u32 original_index = 0;
    u32 replacement_index_cur = 0;
    const char* replace_str;
    u32 replace_size;

    bool original_turn = true;

    while (original_index != self->original_str_len) {
        if (replacement_index_cur == self->withs_top) {             // LAST PART
            replace_size = self->original_str_len - original_index;
            replace_str = self->original + original_index;
            original_index += replace_size;
        } else if (original_turn == true) {                         // ORIGINAL PART
            replace_size = self->whats[replacement_index_cur] - original_index;
            replace_str = self->original + original_index;
            original_index += replace_size;
        } else {                                                    // REPLACEMENT PART
            replace_size = self->with_sizes[replacement_index_cur];
            replace_str = self->withs[replacement_index_cur];
            original_index += self->what_sizes[replacement_index_cur];
            ++replacement_index_cur;
        }
        original_turn = !original_turn;

        u32 bytes_to_write = replace_size;
        if (offset_to_read_from > 0) {
            if (bytes_to_write > offset_to_read_from) {
                bytes_to_write -= offset_to_read_from;
                replace_str += offset_to_read_from;
                offset_to_read_from = 0;
            } else {
                offset_to_read_from -= bytes_to_write;
                bytes_to_write = 0;
            }
        }

        if (bytes_to_write > 0) {
            if (file__write(file, replace_str, bytes_to_write) != bytes_to_write) {
                // error_code__exit(NUMBER_OF_BYTES_WRITTEN_TO_FILE_IS_TRUNCATED);
                error_code__exit(999);
            }
            bytes_written += bytes_to_write;
        }
    }

    return bytes_written;
}
