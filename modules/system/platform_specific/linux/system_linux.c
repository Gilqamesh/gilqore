#include "system_linux.h"
#include "system_platform_specific_defs.h"

#include <unistd.h>

#include "common/error_code.h"

s32 system_linux__open(const char* path, s32 flags) {
    s32 fd = open(path, flags);
    if (fd == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_OPEN);
    }

    return fd;
}

void system_linux__close(s32 fd) {
    if (close(fd) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_CLOSE);
    }
}

pid_t system_linux__fork(void) {
    pid_t pid;

    if ((pid = fork()) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_FORK);
    }

    return pid;
}

pid_t system_linux__waitpid(pid_t pid, s32* status, s32 options) {
    pid_t pid;

    if ((pid = waitpid(pid, status, options)) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_WAITPID);
    }

    return pid;
}

void system_linux__pipe(s32 p[2]) {
    if (pipe(p) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_PIPE);
    }
}

void system_linux__pipe2(s32 p[2], s32 flags) {
    if (pipe2(p, flags) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_PIPE2);
    }
}

u64 system_linux__write(s32 fd, const void* buffer, u64 size) {
    s64 res = write(fd, buffer, size);
    if (res == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_WRITE);
    }

    return res;
}

u64 system_linux__read(s32 fd, void* buffer, u64 size) {
    s64 res = read(fd, buffer, size);
    if (res == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_READ);
    }

    return res;
}

void system_linux__usleep(u64 usec) {
    if (usleep(usec) == -1) {
        // todo: diagnostics, errno
        error_code__exit(SYSTEM_LINUX_ERROR_CODE_USLEEP);
    }
}
