#ifndef CONSOLE_H
# define CONSOLE_H

# include "console_defs.h"

# include <windows.h>

struct console { // console for window applications
    HANDLE out_handle;

    char   *buffer;
    u32    buffer_size;
};

GIL_API bool console__init_module(struct console* self, u32 max_message_length);
GIL_API void console__deinit_module(struct console* self);

GIL_API void console__log(struct console* self, char* msg, ...);

#endif
