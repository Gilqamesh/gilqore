#ifndef CONSOLE_H
# define CONSOLE_H

# include "console_defs.h"

typedef struct console *console_t; // console for window applications

PUBLIC_API console_t console__init_module(u32 max_message_length, bool attach_to_parent);
PUBLIC_API void console__deinit_module(console_t self);

PUBLIC_API u32 console__write(console_t self, const char* format, ...);
PUBLIC_API u32 console__write_error(console_t self, const char* format, ...);
// @returns length of the line that was read from the input
PUBLIC_API u32 console__read_line(console_t self, char* buffer, u32 buffer_size);

#endif // CONSOLE_H
