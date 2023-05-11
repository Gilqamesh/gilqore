#ifndef HASH_H
# define HASH_H

# include "hash_defs.h"

GIL_API u64 hash__sum(const char* str);
GIL_API u64 hash__sum_n(const char* str, u32 str_len);

#endif
