#ifndef CONSOLE_H
# define CONSOLE_H

# include "console_defs.h"

typedef struct console *console_t; // console for window applications

PUBLIC_API console_t console__init_module(u32 max_message_length);
PUBLIC_API void console__deinit_module(console_t self);

PUBLIC_API u32 console__log(console_t self, const char* msg, ...);

PUBLIC_API u32 console__size(console_t self);

#endif // CONSOLE_H
