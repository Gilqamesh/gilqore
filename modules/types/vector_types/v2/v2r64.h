#ifndef V2R64_H
# define V2R64_H

# include "v2_defs.h"

struct v2r64 {
    r64 x;
    r64 y;
};

GIL_API struct v2r64 v2r64(r64 x, r64 y);

GIL_API struct v2r64 v2r64__scale_r64(struct v2r64 v, r64 s);

#endif
