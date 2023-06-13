#ifndef HASH_H
# define HASH_H

# include "hash_defs.h"

// @returns sum of bytes in the string
GIL_API u64 hash__sum(const char* str);
// @param n max number of bytes to sum from string
// @returns sum of bytes in the string
GIL_API u64 hash__sum_n(const char* str, u32 n);

#endif
