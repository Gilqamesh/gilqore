#ifndef LERP_H
# define LERP_H

# include "lerp_defs.h"

# include "graphics/color/color.h"

PUBLIC_API u32 lerp__u32(u32 a, r32 t, u32 b);

PUBLIC_API struct color lerp__color(struct color a, r32 t, struct color b);

#endif
