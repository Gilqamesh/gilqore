#ifndef STRING_REPLACER_DEFS_H
# define STRING_REPLACER_DEFS_H

# include "../string_defs.h"

enum string_replacer_error_code {
    STRING_REPLACER_ERROR_CODE_START,
    STRING_REPLACER_ERROR_CODE_REACHED_MAXIMUM_AMOUNT_OF_REPLACEMENTS = 2,
    STRING_REPLACER_ERROR_CODE_REACHED_MAXIMUM_WITH_BUFFER_SIZE = 3,
    STRING_REPLACER_ERROR_CODE_WHAT_POSITION_ALREADY_EXISTS = 4,
    STRING_REPLACER_ERROR_CODE_WHAT_STRADDLES_ANOTHER_WHAT = 5,
    STRING_REPLACER_ERROR_CODE_WHAT_POSITION_OUTSIDE_OF_ORIGINAL = 6,

};

#endif
