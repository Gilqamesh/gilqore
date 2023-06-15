#ifndef V4U8_H
# define V4U8_H

# include "v4_defs.h"

struct v4u8 {
    u8 a;
    u8 b;
    u8 c;
    u8 d;
};

PUBLIC_API struct v4u8 v4u8(u8 a, u8 b, u8 c, u8 d);

PUBLIC_API struct v4u8 v4u8__add(struct v4u8 v1, struct v4u8 v2);

PUBLIC_API struct v4u8 v4u8__sub(struct v4u8 v1, struct v4u8 v2);

PUBLIC_API struct v4u8 v4u8__scale_u8(struct v4u8 v, u8 s);
PUBLIC_API struct v4u8 v4u8__scale_r32(struct v4u8 v, r32 s);

PUBLIC_API bool v4u8__eq(struct v4u8 v, struct v4u8 w);

#endif
