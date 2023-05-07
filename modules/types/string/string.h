#ifndef STRING_H
# define STRING_H

# include "string_defs.h"

GIL_API void string__to_upper(char* str);
// @returns the pointer to the nth char in str or NULL if there wasn't any
GIL_API char* string__strchr_n(const char* str, char c, u32 n);
// @returns the pointer to the nth char from the back in str or NULL if there wasn't any
GIL_API char* string__strrchr_n(const char* str, char c, u32 n);

#endif
