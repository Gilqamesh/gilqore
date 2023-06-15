#ifndef V3U64_H
# define V3U64_H

# include "v3_defs.h"

struct v3u64 {
    u64 x;
    u64 y;
    u64 z;
};

PUBLIC_API struct v3u64 v3u64(u64 x, u64 y, u64 z);

PUBLIC_API struct v3u64 v3u64__scale_u64(struct v3u64 v, u64 s);

#endif
