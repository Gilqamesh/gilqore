#ifndef THREAD_H
# define THREAD_H

# if defined(WINDOWS)
#  include "platform_specific/windows/thread_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/thread_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/thread_platform_specific_defs.h"
# endif

PUBLIC_API bool thread__create(
    thread_t* self,
    u32 (*worker_fn)(void* user_data),
    void* user_data
);

PUBLIC_API u32 thread__destroy(thread_t* self);

PUBLIC_API void thread__wait_execution(thread_t* self);

PUBLIC_API bool mutex__create(mutex_t* self);
PUBLIC_API void mutex__destroy(mutex_t* self);

PUBLIC_API void mutex__lock(mutex_t* self);
PUBLIC_API void mutex__unlock(mutex_t* self);

#endif // THREAD_H
