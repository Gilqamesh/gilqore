#ifndef STRING_REPLACER_H
# define STRING_REPLACER_H

# include "string_replacer_defs.h"

struct string_replacer {
    const char*  original;                  // the unmodified string currently being replaced
    
    u32*         whats;                     // indices of the replacements into the original string
    u32*         what_sizes;                // length of the replacements in the original string
    
    char**       withs;                     // pointers to the replacements
    u32*         with_sizes;                // length of the replacements
    char*        with_buffer;               // the contiguous buffer in which all the replacements are stored

    u32          withs_top;                 // the current number of replacements
    u32          withs_size;                // the allocated (max) number for replacements

    u32          with_buffer_top;           // the current size of the with buffer
    u32          with_buffer_size;          // the total size of the with buffer

    u32          original_str_len;          // the unmodified string's length
    u32          current_str_len;           // the resulting replaced string's length
};

GIL_API bool string_replacer__create(struct string_replacer* self, const char* original, u32 original_len);
GIL_API void string_replacer__destroy(struct string_replacer* self);

// @brief clears the replacements and replace the original string with a new one
GIL_API void string_replacer__clear(struct string_replacer* self, const char* original, u32 original_len);

// @brief replace part of the string with another by providing the position of the string to be replaced
// @returns the string's length after the replacement
GIL_API u32 string_replacer__replace_at_position(
    struct string_replacer* self,
    u32 what_position,
    u32 what_length,
    const char* with,
    u32 with_length
);

// @brief replace part of the string with another by providing the string to be replaced
GIL_API u32 string_replacer__replace_word(
    struct string_replacer* self,
    const char* what,
    u32 what_length,
    const char* with,
    u32 with_length
);

// @brief reads (max buffer_size bytes) the replaced string into buffer, null terminates the result
// @param offset_to_read_from offset to start reading from in the replaced string
// @returns length of the new string
GIL_API u32 string_replacer__read(
    struct string_replacer* self,
    char* buffer,
    u32 buffer_size,
    u32 offset_to_read_from
);

#endif
