#ifndef V4U32_H
# define V4U32_H

# include "v4_defs.h"

struct v4u32 {
    u32 a;
    u32 b;
    u32 c;
    u32 d;
};

PUBLIC_API struct v4u32 v4u32(u32 a, u32 b, u32 c, u32 d);

PUBLIC_API struct v4u32 v4u32__scale_u32(struct v4u32 v, u32 s);

#endif
