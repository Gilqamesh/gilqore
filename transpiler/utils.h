#ifndef UTILS_H
# define UTILS_H

# include "defs.h"

# include <stdio.h>
# include <stdarg.h>

struct memory {
    void* data;
    u32 size;
};

void fatal_error(const char* format, ...);

// HASH
u64 hash__sum_n(const char* str, u32 str_len);

// STRING
char* string__search(
    const char* str, u32 str_len,
    const char* what, u32 what_len
);
char* string__starts_with(const char* str, const char* prefix);
char* string__search_n(const char* str, const char* set, u32 n, bool return_last_occurance);

// FILE
u32 file_write_format(FILE* file, struct memory format_memory, const char* format, ...);

#endif // UTILS_H
