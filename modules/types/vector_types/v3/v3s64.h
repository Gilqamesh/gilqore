#ifndef V3S64_H
# define V3S64_H

# include "v3_defs.h"

struct v3s64 {
    s64 x;
    s64 y;
    s64 z;
};

PUBLIC_API struct v3s64 v3s64(s64 x, s64 y, s64 z);

PUBLIC_API struct v3s64 v3s64__scale_s64(struct v3s64 v, s64 s);

#endif
