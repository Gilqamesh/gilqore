#ifndef V4S64_H
# define V4S64_H

# include "v4_defs.h"

struct v4s64 {
    s64 a;
    s64 b;
    s64 c;
    s64 d;
};

GIL_API struct v4s64 v4s64(s64 a, s64 b, s64 c, s64 d);

GIL_API struct v4s64 v4s64__add(struct v4s64 v1, struct v4s64 v2);

GIL_API struct v4s64 v4s64__sub(struct v4s64 v1, struct v4s64 v2);

GIL_API struct v4s64 v4s64__scale_s64(struct v4s64 v, s64 s);

#endif
