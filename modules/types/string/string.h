#ifndef STRING_H
# define STRING_H

# include "string_defs.h"

GIL_API void string__to_upper(char* str);

// @returns the 'n'th occurance in 'str' of the char 'c', or NULL
GIL_API char* string__strchr_n(const char* str, char c, u32 n);
// @returns the first occurance in 'str' any characters matched from 'set', or NULL
GIL_API char* string__strchr_set(const char* str, const char* set);
// @returns the 'n'th occurance in 'str' any characters matched from 'set', or NULL
GIL_API char* string__strchr_set_n(const char* str, const char* set, u32 n);

// @returns the 'n'th occurance from the back in 'str' of the char 'c', or NULL
GIL_API char* string__strrchr_n(const char* str, char c, u32 n);
// @returns the 'n'th occurance from the back in 'str' any characters matched from 'set', or NULL
GIL_API char* string__strrchr_set(const char* str, const char* set);
// @returns the 'n'th occurance from the back in 'str' any characters matched from 'set', or NULL
GIL_API char* string__strrchr_set_n(const char* str, const char* set, u32 n);

#endif
