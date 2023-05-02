#ifndef V4U64_H
# define V4U64_H

# include "v4_defs.h"

struct v4u64 {
    u64 a;
    u64 b;
    u64 c;
    u64 d;
};

GIL_API struct v4u64 v4u64(u64 a, u64 b, u64 c, u64 d);

GIL_API struct v4u64 v4u64__add(struct v4u64 v1, struct v4u64 v2);

GIL_API struct v4u64 v4u64__sub(struct v4u64 v1, struct v4u64 v2);

GIL_API struct v4u64 v4u64__scale_u64(struct v4u64 v, u64 s);

#endif
