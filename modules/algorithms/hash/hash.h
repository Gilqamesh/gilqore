#ifndef HASH_H
# define HASH_H

# include "hash_defs.h"

// @returns sum of bytes in the string
PUBLIC_API u64 hash__sum(const char* str);
// @param n max number of bytes to sum from string
// @returns sum of bytes in the string
PUBLIC_API u64 hash__sum_n(const char* str, u32 n);
// @brief Fowler-Noll-Vo non-cryptographic hash fn
// @param len len of str
// @param prev_hash previous hash result, should be 0 if first time hashing, otherwise the result of the previous op with this fn
PUBLIC_API u32 hash__fnv_1a(const char* str, u32 len, u32 prev_hash);

#endif
