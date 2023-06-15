#ifndef V2S32_H
# define V2S32_H

# include "v2_defs.h"

struct v2s32 {
    s32 x;
    s32 y;
};

PUBLIC_API struct v2s32 v2s32(s32 x, s32 y);

PUBLIC_API struct v2s32 v2s32__scale_s32(struct v2s32 v, s32 s);

PUBLIC_API bool v2s32__is_equal(struct v2s32 v1, struct v2s32 v2);

PUBLIC_API struct v2s32 v2s32__sub_v2s32(struct v2s32 v, struct v2s32 w);

#endif
