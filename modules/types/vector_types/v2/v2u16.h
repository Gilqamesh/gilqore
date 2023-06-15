#ifndef V2U16_H
# define V2U16_H

# include "v2_defs.h"

struct v2u16 {
    u16 x;
    u16 y;
};

PUBLIC_API struct v2u16 v2u16(u16 x, u16 y);

PUBLIC_API struct v2u16 v2u16__scale_u16(struct v2u16 v, u16 s);

#endif
