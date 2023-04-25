#ifndef V3S8_H
# define V3S8_H

# include "v3_defs.h"

struct v3s8 {
    s8 x;
    s8 y;
    s8 z;
};

GIL_API struct v3s8 v3s8(s8 x, s8 y, s8 z);

GIL_API struct v3s8 v3s8__scale_s8(struct v3s8 v, s8 s);

#endif
