#ifndef V4R64_H
# define V4R64_H

# include "v4_defs.h"

struct v4r64 {
    r64 a;
    r64 b;
    r64 c;
    r64 d;
};

PUBLIC_API struct v4r64 v4r64(r64 a, r64 b, r64 c, r64 d);

PUBLIC_API struct v4r64 v4r64__add(struct v4r64 v1, struct v4r64 v2);

PUBLIC_API struct v4r64 v4r64__sub(struct v4r64 v1, struct v4r64 v2);

PUBLIC_API struct v4r64 v4r64__scale_r64(struct v4r64 v, r64 s);

#endif
