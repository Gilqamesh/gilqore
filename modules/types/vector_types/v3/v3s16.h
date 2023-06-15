#ifndef V3S16_H
# define V3S16_H

# include "v3_defs.h"

struct v3s16 {
    s16 x;
    s16 y;
    s16 z;
};

PUBLIC_API struct v3s16 v3s16(s16 x, s16 y, s16 z);

PUBLIC_API struct v3s16 v3s16__scale_s16(struct v3s16 v, s16 s);

#endif
