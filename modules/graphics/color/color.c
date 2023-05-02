#include "color.h"

#define COLOR_SHIFT_RED     16
#define COLOR_SHIFT_GREEN   8
#define COLOR_SHIFT_BLUE    0
#define COLOR_SHIFT_ALPHA   24

struct color color__pack(u32 red, u32 green, u32 blue, u32 alpha) {
    struct color result = {
        v4u8(
            (alpha & 0xff) << COLOR_SHIFT_ALPHA,
            (red   & 0xff) << COLOR_SHIFT_RED,
            (green & 0xff) << COLOR_SHIFT_GREEN,
            (blue  & 0xff) << COLOR_SHIFT_BLUE
        )
    };

    return result;
}

u32 color__unpack(struct color color) {
    return
    ((u32) color__channel_alpha(color) << COLOR_SHIFT_ALPHA) |
    ((u32) color__channel_red(color)   << COLOR_SHIFT_RED)   |
    ((u32) color__channel_green(color) << COLOR_SHIFT_GREEN) |
    ((u32) color__channel_blue(color)  << COLOR_SHIFT_BLUE);
}

struct color color__add(struct color color1, struct color color2) {
    color1.argb = v4u8__add(color1.argb, color2.argb);

    return color1;
}

struct color color__sub(struct color color1, struct color color2) {
    color1.argb = v4u8__sub(color1.argb, color2.argb);

    return color1;
}

struct color color__scale_r32(struct color color, r32 s) {
    color.argb = v4u8__scale_r32(color.argb, s);

    return color;
}

u8 color__channel_red(struct color color) {
    return color.argb.b;
}

u8 color__channel_green(struct color color) {
    return color.argb.c;
}

u8 color__channel_blue(struct color color) {
    return color.argb.d;
}

u8 color__channel_alpha(struct color color) {
    return color.argb.a;
}
