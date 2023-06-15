#ifndef V3R64_H
# define V3R64_H

# include "v3_defs.h"

struct v3r64 {
    r64 x;
    r64 y;
    r64 z;
};

PUBLIC_API struct v3r64 v3r64(r64 x, r64 y, r64 z);

PUBLIC_API struct v3r64 v3r64__scale_r64(struct v3r64 v, r64 s);

#endif
