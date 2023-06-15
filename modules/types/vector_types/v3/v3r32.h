#ifndef V3R32_H
# define V3R32_H

# include "v3_defs.h"

struct v3r32 {
    r32 x;
    r32 y;
    r32 z;
};

PUBLIC_API struct v3r32 v3r32(r32 x, r32 y, r32 z);

PUBLIC_API struct v3r32 v3r32__scale_r32(struct v3r32 v, r32 s);

#endif
