#ifndef V3S32_H
# define V3S32_H

# include "v3_defs.h"

struct v3s32 {
    s32 x;
    s32 y;
    s32 z;
};

PUBLIC_API struct v3s32 v3s32(s32 x, s32 y, s32 z);

PUBLIC_API struct v3s32 v3s32__scale_s32(struct v3s32 v, s32 s);

#endif
