#ifndef V4S32_H
# define V4S32_H

# include "v4_defs.h"

struct v4s32 {
    s32 a;
    s32 b;
    s32 c;
    s32 d;
};

GIL_API struct v4s32 v4s32(s32 a, s32 b, s32 c, s32 d);

GIL_API struct v4s32 v4s32__add(struct v4s32 v1, struct v4s32 v2);

GIL_API struct v4s32 v4s32__sub(struct v4s32 v1, struct v4s32 v2);

GIL_API struct v4s32 v4s32__scale_s32(struct v4s32 v, s32 s);

#endif
