#ifndef COLOR_H
# define COLOR_H

# include "color_defs.h"

# include "types/vector_types/v4/v4u8.h"

struct color {
    struct v4u8 argb; // format: ARGB
};

// @brief params are from 0 to 255
GIL_API struct color color(u32 red, u32 green, u32 blue, u32 alpha);
// @returns color from 32-bit representation
GIL_API struct color color__pack(u32 value);
// @returns 32-bit representation of the color
GIL_API u32          color__unpack(struct color color);

// @brief adds and clamps each channel to 255
GIL_API struct color color__add(struct color color1, struct color color2);
// @brief subs and clamps each channel to 0
GIL_API struct color color__sub(struct color color1, struct color color2);
// @brief mul and clamps each channel in between 0 and 255
GIL_API struct color color__scale_r32(struct color color, r32 scale);
GIL_API bool color__eq(struct color color1, struct color color2);

GIL_API u8 color__channel_red(struct color color);
GIL_API u8 color__channel_green(struct color color);
GIL_API u8 color__channel_blue(struct color color);
GIL_API u8 color__channel_alpha(struct color color);

#endif
