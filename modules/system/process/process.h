#ifndef PROCESS_H
# define PROCESS_H

# include "process_defs.h"

struct process;

# if defined(WINDOWS)
#  include "platform_specific/windows/process_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/process_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/process_platform_specific_defs.h"
# endif

// @brief creates a new process
// @param path to the executable, max length of PROCESS_MAX_PATH_LENGTH
// @note example: process__create(&self, "ls -la testdir")
GIL_API bool process__create(struct process* self, const char* path);
// @brief terminates the process, regardless if it has stopped its execution or not
// @returns the exit code of the process,
// PROCESS_ERROR_CODE_FORCED_TO_TERMINATE if it has been forcefully stopped or
// PROCESS_ERROR_CODE_TERMINATED_ABRUPTLY if it has terminated unexpectedly (for example to external signals)
GIL_API u32 process__destroy(struct process* self);

// @brief wait until the process has stopped execution
GIL_API void process__wait_execution(struct process* self);
// @brief wait for the process for the specified time
// @note the granularity of this function can be high, do not use this function if accuracy to such a degree matters
// todo: what to use instead?
GIL_API void process__wait_timeout(struct process* self, u32 milliseconds);

#endif
