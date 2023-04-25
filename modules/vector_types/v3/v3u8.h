#ifndef V3U8_H
# define V3U8_H

# include "v3_defs.h"

struct v3u8 {
    u8 x;
    u8 y;
    u8 z;
};

GIL_API struct v3u8 v3u8(u8 x, u8 y, u8 z);

GIL_API struct v3u8 v3u8__scale_u8(struct v3u8 v, u8 s);

#endif
