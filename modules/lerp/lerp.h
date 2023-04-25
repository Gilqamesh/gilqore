#ifndef LERP_H
# define LERP_H

# include "lerp_defs.h"

# include "color/color.h"

GIL_API u32 lerp__u32(u32 a, r32 normalized_value, u32 b);

GIL_API struct color lerp__color(struct color a, r32 normalized_value, struct color b);

#endif
