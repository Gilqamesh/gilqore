#ifndef WINDOW_H
# define WINDOW_H

# include "window_defs.h"

# if defined(WINDOWS)
#  include "platform_specific/windows/window_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/window_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/window_platform_specific_defs.h"
# endif

typedef struct window window_t;

PUBLIC_API bool window__create(window_t* self);
PUBLIC_API void window__destroy(window_t* self);

PUBLIC_API void window__poll_inputs(window_t* self);

PUBLIC_API bool window__is_closed(window_t* self);
PUBLIC_API void window__close(window_t* self);

PUBLIC_API void window__draw_frame(window_t* self);

PUBLIC_API void window__show(window_t* self);
PUBLIC_API void window__hide(window_t* self);

#endif //WINDOW_H
