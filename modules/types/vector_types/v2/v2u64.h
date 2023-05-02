#ifndef V2U64_H
# define V2U64_H

# include "v2_defs.h"

struct v2u64 {
    u64 x;
    u64 y;
};

GIL_API struct v2u64 v2u64(u64 x, u64 y);

GIL_API struct v2u64 v2u64__scale_u64(struct v2u64 v, u64 s);

#endif
