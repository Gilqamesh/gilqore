#ifndef V2R32_H
# define V2R32_H

# include "v2_defs.h"

struct v2r32 {
    r32 x;
    r32 y;
};

PUBLIC_API struct v2r32 v2r32(r32 x, r32 y);

PUBLIC_API struct v2r32 v2r32__scale_r32(struct v2r32 v, r32 s);
PUBLIC_API struct v2r32 v2r32__scale_v2r32(struct v2r32 v, struct v2r32 s);

PUBLIC_API struct v2r32 v2r32__add_v2r32(struct v2r32 v, struct v2r32 w);

PUBLIC_API struct v2r32 v2r32__sub_v2r32(struct v2r32 v, struct v2r32 w);

PUBLIC_API struct v2r32 v2r32__abs(struct v2r32 v);
PUBLIC_API struct v2r32 v2r32__abs_dist(struct v2r32 v, struct v2r32 w);

PUBLIC_API r32 v2r32__dot_v2r32(struct v2r32 v, struct v2r32 w);

PUBLIC_API r32 v2r32__length(struct v2r32 v);

PUBLIC_API struct v2r32 v2r32__normalize(struct v2r32 v);

PUBLIC_API bool v2r32__is_in_half_dims(struct v2r32 v, struct v2r32 half_dims);

#endif
