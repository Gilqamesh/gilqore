#ifndef V2S8_H
# define V2S8_H

# include "v2_defs.h"

struct v2s8 {
    s8 x;
    s8 y;
};

GIL_API struct v2s8 v2s8(s8 x, s8 y);

GIL_API struct v2s8 v2s8__scale_s8(struct v2s8 v, s8 s);

#endif
