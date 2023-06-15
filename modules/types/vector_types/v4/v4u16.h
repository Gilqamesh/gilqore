#ifndef V4U16_H
# define V4U16_H

# include "v4_defs.h"

struct v4u16 {
    u16 a;
    u16 b;
    u16 c;
    u16 d;
};

PUBLIC_API struct v4u16 v4u16(u16 a, u16 b, u16 c, u16 d);

PUBLIC_API struct v4u16 v4u16__add(struct v4u16 v1, struct v4u16 v2);

PUBLIC_API struct v4u16 v4u16__sub(struct v4u16 v1, struct v4u16 v2);

PUBLIC_API struct v4u16 v4u16__scale_u16(struct v4u16 v, u16 s);

#endif
