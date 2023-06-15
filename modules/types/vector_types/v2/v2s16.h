#ifndef V2S16_H
# define V2S16_H

# include "v2_defs.h"

struct v2s16 {
    s16 x;
    s16 y;
};

PUBLIC_API struct v2s16 v2s16(s16 x, s16 y);

PUBLIC_API struct v2s16 v2s16__scale_s16(struct v2s16 v, s16 s);

#endif
