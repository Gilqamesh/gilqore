#ifndef V3U32_H
# define V3U32_H

# include "v3_defs.h"

struct v3u32 {
    u32 x;
    u32 y;
    u32 z;
};

GIL_API struct v3u32 v3u32(u32 x, u32 y, u32 z);

GIL_API struct v3u32 v3u32__scale_u32(struct v3u32 v, u32 s);

#endif
