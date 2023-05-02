#ifndef V3U16_H
# define V3U16_H

# include "v3_defs.h"

struct v3u16 {
    u16 x;
    u16 y;
    u16 z;
};

GIL_API struct v3u16 v3u16(u16 x, u16 y, u16 z);

GIL_API struct v3u16 v3u16__scale_u16(struct v3u16 v, u16 s);

#endif
