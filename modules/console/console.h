#ifndef CONSOLE_H
# define CONSOLE_H

# include "console_defs.h"

typedef struct console *console_t; // console for window applications

GIL_API console_t console__init_module(u32 max_message_length);
GIL_API void    console__deinit_module(console_t self);

GIL_API void console__log(console_t self, char* msg, ...);

#endif
