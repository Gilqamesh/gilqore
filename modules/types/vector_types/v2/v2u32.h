#ifndef V2U32_H
# define V2U32_H

# include "v2_defs.h"

struct v2u32 {
    u32 x;
    u32 y;
};

PUBLIC_API struct v2u32 v2u32(u32 x, u32 y);

PUBLIC_API struct v2u32 v2u32__scale_u32(struct v2u32 v, u32 s);

PUBLIC_API struct v2u32 v2u32__add_v2u32(struct v2u32 v, struct v2u32 w);

PUBLIC_API struct v2u32 v2u32__sub_v2u32(struct v2u32 v, struct v2u32 w);

PUBLIC_API struct v2u32 v2u32__abs_dist(struct v2u32 v, struct v2u32 w);

PUBLIC_API bool v2u32__is_less(struct v2u32 v, struct v2u32 relative);

#endif
