#ifndef V4S8_H
# define V4S8_H

# include "v4_defs.h"

struct v4s8 {
    s8 a;
    s8 b;
    s8 c;
    s8 d;
};

PUBLIC_API struct v4s8 v4s8(s8 a, s8 b, s8 c, s8 d);

PUBLIC_API struct v4s8 v4s8__add(struct v4s8 v1, struct v4s8 v2);

PUBLIC_API struct v4s8 v4s8__sub(struct v4s8 v1, struct v4s8 v2);

PUBLIC_API struct v4s8 v4s8__scale_s8(struct v4s8 v, s8 s);

PUBLIC_API struct v4s8 v4s8__scale_r32(struct v4s8 v, r32 s);

PUBLIC_API bool v4s8__eq(struct v4s8 v, struct v4s8 w);

#endif
