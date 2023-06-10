#ifndef STRING_H
# define STRING_H

# include "string_defs.h"

GIL_API void string__to_upper(char* str);

// @param return_last_occurance false for strictly at 'n'th occurance, otherwise returns the last matched occurance
// @returns the 'n'th occurance in 'str' any characters matched from 'set', or NULL
GIL_API char* string__search_n         (const char* str, u32 str_len, const char* set, u32 n, bool return_last_occurance);
// @brief increments 'str' 'max' amount while it matches either characters from 'set'
GIL_API char* string__search_while     (const char* str, u32 str_len, const char* set, u32 max);
// @brief increments 'str' 'max' amount while it does not match either characters from 'set'
GIL_API char* string__search_while_not (const char* str, u32 str_len, const char* set, u32 max);

// @param return_last_occurance false for strictly at 'n'th occurance, otherwise returns the last matched occurance
// @returns the 'n'th occurance from the back in 'str' any characters matched from 'set', or NULL
GIL_API char* string__rsearch_n        (const char* str, u32 str_len, const char* set, u32 n, bool return_last_occurance);
// @brief decrements 'str' 'max' amount from the back while it matches either characters from 'set'
GIL_API char* string__rsearch_while    (const char* str, u32 str_len, const char* set, u32 max);
// @brief decrements 'str' 'max' amount from the back while it does not match either characters from 'set'
GIL_API char* string__rsearch_while_not(const char* str, u32 str_len, const char* set, u32 max);

#endif // STRING_H
