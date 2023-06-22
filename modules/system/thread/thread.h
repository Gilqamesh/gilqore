#ifndef THREAD_H
# define THREAD_H

struct thread;

# if defined(WINDOWS)
#  include "platform_specific/windows/thread_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/thread_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/thread_platform_specific_defs.h"
# endif

PUBLIC_API bool thread__create(
    struct thread* self,
    u32 (*worker_fn)(void* user_data),
    void* user_data
);

PUBLIC_API u32 thread__destroy(struct thread* self);

PUBLIC_API void thread__wait_execution(struct thread* self);

#endif // THREAD_H
