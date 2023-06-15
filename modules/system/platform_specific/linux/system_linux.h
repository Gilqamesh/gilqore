#ifndef SYSTEM_LINUX_H
# define SYSTEM_LINUX_H

# include "../../system_defs.h"

PUBLIC_API s32 system_linux__open(const char* path, s32 flags);
PUBLIC_API void system_linux__close(s32 fd);

PUBLIC_API pid_t system_linux__fork(void);
PUBLIC_API pid_t system_linux__waitpid(pid_t pid, s32* status, s32 options);

PUBLIC_API void system_linux__pipe(s32 p[2]);
PUBLIC_API void system_linux__pipe2(s32 p[2], s32 flags);

PUBLIC_API u64 system_linux__write(s32 fd, const void* buffer, u64 size);
PUBLIC_API u64 system_linux__read(s32 fd, void* buffer, u64 size);

PUBLIC_API void system_linux__usleep(u64 usec);

#endif
