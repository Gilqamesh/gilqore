#ifndef V4R32_H
# define V4R32_H

# include "v4_defs.h"

struct v4r32 {
    r32 a;
    r32 b;
    r32 c;
    r32 d;
};

PUBLIC_API struct v4r32 v4r32(r32 a, r32 b, r32 c, r32 d);

PUBLIC_API struct v4r32 v4r32__add(struct v4r32 v1, struct v4r32 v2);

PUBLIC_API struct v4r32 v4r32__sub(struct v4r32 v1, struct v4r32 v2);

PUBLIC_API struct v4r32 v4r32__scale_r32(struct v4r32 v, r32 s);

#endif
