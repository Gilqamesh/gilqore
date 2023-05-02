#ifndef V2S64_H
# define V2S64_H

# include "v2_defs.h"

struct v2s64 {
    s64 x;
    s64 y;
};

GIL_API struct v2s64 v2s64(s64 x, s64 y);

GIL_API struct v2s64 v2s64__scale_s64(struct v2s64 v, s64 s);

#endif
