#ifndef V2U8_H
# define V2U8_H

# include "v2_defs.h"

struct v2u8 {
    u8 x;
    u8 y;
};

PUBLIC_API struct v2u8 v2u8(u8 x, u8 y);

PUBLIC_API struct v2u8 v2u8__scale_u8(struct v2u8 v, u8 s);

#endif
