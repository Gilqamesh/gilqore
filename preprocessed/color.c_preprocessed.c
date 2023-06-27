#include "graphics/color/color.h"
#define COLOR_SHIFT_RED     16
#define COLOR_SHIFT_GREEN   8
#define COLOR_SHIFT_BLUE    0
#define COLOR_SHIFT_ALPHA   24
struct color color(u32 red, u32 green, u32 blue, u32 alpha) {
    struct color result = {
        v4u8(
            (u8) alpha,
            (u8) red,
            (u8) green,
            (u8) blue
        )
    };
    return result;
}
struct color color__pack(u32 value) {
    struct color result = {
        v4u8(
            (u8) (value >> COLOR_SHIFT_ALPHA),
            (u8) (value >> COLOR_SHIFT_RED),
            (u8) (value >> COLOR_SHIFT_GREEN),
            (u8) (value >> COLOR_SHIFT_BLUE)
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
    if (color1.argb.a > 0xff - color2.argb.a) {
        color1.argb.a = 0xff;
    } else {
        color1.argb.a += color2.argb.a;
    }
    if (color1.argb.b > 0xff - color2.argb.b) {
        color1.argb.b = 0xff;
    } else {
        color1.argb.b += color2.argb.b;
    }
    if (color1.argb.c > 0xff - color2.argb.c) {
        color1.argb.c = 0xff;
    } else {
        color1.argb.c += color2.argb.c;
    }
    if (color1.argb.d > 0xff - color2.argb.d) {
        color1.argb.d = 0xff;
    } else {
        color1.argb.d += color2.argb.d;
    }
    return color1;
}
struct color color__sub(struct color color1, struct color color2) {
    if (color1.argb.a < color2.argb.a) {
        color1.argb.a = 0;
    } else {
        color1.argb.a -= color2.argb.a;
    }
    if (color1.argb.b < color2.argb.b) {
        color1.argb.b = 0;
    } else {
        color1.argb.b -= color2.argb.b;
    }
    if (color1.argb.c < color2.argb.c) {
        color1.argb.c = 0;
    } else {
        color1.argb.c -= color2.argb.c;
    }
    if (color1.argb.d < color2.argb.d) {
        color1.argb.d = 0;
    } else {
        color1.argb.d -= color2.argb.d;
    }
    return color1;
}
struct color color__scale_r32(struct color color, r32 s) {
    if (s < 0) {
        color.argb.a = 0;
        color.argb.b = 0;
        color.argb.c = 0;
        color.argb.d = 0;
    } else {
        if (color.argb.a * s > 0xff) {
            color.argb.a = 0xff;
        } else {
            color.argb.a *= s;
        }
        if (color.argb.b * s > 0xff) {
            color.argb.b = 0xff;
        } else {
            color.argb.b *= s;
        }
        if (color.argb.c * s > 0xff) {
            color.argb.c = 0xff;
        } else {
            color.argb.c *= s;
        }
        if (color.argb.d * s > 0xff) {
            color.argb.d = 0xff;
        } else {
            color.argb.d *= s;
        }
    }
    return color;
}
bool color__eq(struct color color1, struct color color2) {
    return v4u8__eq(color1.argb, color2.argb);
}
u8 color__channel_red(struct color color) {
    return (u8) color.argb.b;
}
u8 color__channel_green(struct color color) {
    return (u8) color.argb.c;
}
u8 color__channel_blue(struct color color) {
    return (u8) color.argb.d;
}
u8 color__channel_alpha(struct color color) {
    return (u8) color.argb.a;
}
