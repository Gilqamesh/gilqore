#ifndef CONSOLE_H
# define CONSOLE_H

# include "console_defs.h"

typedef struct console *console; // console for window applications

GIL_API console console__init_module(u32 max_message_length);
GIL_API void    console__deinit_module(console self);

GIL_API void console__log(console self, char* msg, ...);

#endif
