#ifndef V4S16_H
# define V4S16_H

# include "v4_defs.h"

struct v4s16 {
    s16 a;
    s16 b;
    s16 c;
    s16 d;
};

PUBLIC_API struct v4s16 v4s16(s16 a, s16 b, s16 c, s16 d);

PUBLIC_API struct v4s16 v4s16__add(struct v4s16 v1, struct v4s16 v2);

PUBLIC_API struct v4s16 v4s16__sub(struct v4s16 v1, struct v4s16 v2);

PUBLIC_API struct v4s16 v4s16__scale_s16(struct v4s16 v, s16 s);

#endif
