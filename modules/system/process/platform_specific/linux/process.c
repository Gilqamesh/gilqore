#include "process_platform_specific_defs.h"
#include "../../process.h"

#include <stdarg.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

#include "common/error_code.h"
#include "system/platform_specific/linux/system_linux.h"
#include "libc/libc.h"

#define EXIT_CODE_UNINITIALIZED -1

#define ARBITRARY_MAX_ARGC 20

bool process__create(struct process* self, const char* path) {
    self->exit_code = EXIT_CODE_UNINITIALIZED;

    // todo: split path by whitespace
    char arg_buffer[PROCESS_MAX_PATH_LENGTH + ARBITRARY_MAX_ARGC] = { 0 };
    char* arg_buffer_start = arg_buffer;
    char* arg_buffer_end = arg_buffer + ARRAY_SIZE(arg_buffer);
    char* argv[ARBITRARY_MAX_ARGC] = { 0 };
    u32 argc = 0;
    while (argc < ARBITRARY_MAX_ARGC && *path != '\0') {
        argv[argc] = arg_buffer_start;
        while (*path != '\0' && libc__isspace(*path) == true) {
            ++path;
        }
        u32 i = 0;
        while (
            *path != '\0' &&
            arg_buffer_start + 1 < arg_buffer_end &&
            libc__isspace(*path) == false
        ) {
            *arg_buffer_start++ = *path;
            ++path;
        }
        *arg_buffer_start++ = '\0';
        while (*path != '\0' && libc__isspace(*path) == true) {
            ++path;
        }
        ++argc;
    }
    argv[argc] = NULL;
    if (argc == ARBITRARY_MAX_ARGC) {
        error_code__exit(PROCESS_ERROR_CODE_LINUX_ARBITRARY_MAX_ARGC);
    }

    int tmp_pipe[2];
    system_linux__pipe2(tmp_pipe, O_CLOEXEC);
    self->pid = system_linux__fork();

    if (self->pid == 0) {
        system_linux__close(tmp_pipe[0]);
        if (execv(argv[0], argv) == -1) {
            u32 err_code = PROCESS_ERROR_CODE_LINUX_EXECV;
            system_linux__write(tmp_pipe[1], &err_code, sizeof(err_code));
            system_linux__close(tmp_pipe[1]);
            exit(PROCESS_ERROR_CODE_LINUX_EXECV);
        } else {
            UNREACHABLE_CODE;
            return true;
        }
    } else {
        // note: check if execv was successful or not
        system_linux__close(tmp_pipe[1]);
        u32 err_code;
        s32 read_result = system_linux__read(tmp_pipe[0], &err_code, sizeof(err_code));
        system_linux__close(tmp_pipe[0]);
        if (read_result == -1) {
            // todo: diagnostics, error
            error_code__exit(PROCESS_ERROR_CODE_LINUX_READ);
        }
        if (read_result == 0) {
            return true;
        } else {
            return false;
        }
    }
}

u32 process__destroy(struct process* self) {
    if (self->exit_code != EXIT_CODE_UNINITIALIZED) {
        return self->exit_code;
    }

    s32 status;
    pid_t waitpid_res = system_linux__waitpid(self->pid, &status, WNOHANG);
    if (waitpid_res == 0) {
        // note: child process hasn't finished its execution yet
        kill(self->pid, SIGKILL);
        waitpid_res = system_linux__waitpid(self->pid, &status, 0);
        if (WIFSIGNALED(status) == false) {
            error_code__exit(PROCESS_ERROR_CODE_LINUX_WIFSIGNALED);
        }
        self->exit_code = PROCESS_ERROR_CODE_FORCED_TO_TERMINATE;
    } else {
        if (WIFEXITED(status) == false) {
            self->exit_code = PROCESS_ERROR_CODE_TERMINATED_ABRUPTLY;
        } else {
            self->exit_code = WEXITSTATUS(status);
        }
    }

    return self->exit_code;
}

void process__wait_execution(struct process* self) {
    s32 status;
    system_linux__waitpid(self->pid, &status, 0);
    if (WIFEXITED(status) == false) {
        self->exit_code = PROCESS_ERROR_CODE_TERMINATED_ABRUPTLY;
    } else {
        self->exit_code = WEXITSTATUS(status);
    }
}

void process__wait_timeout(struct process* self, u32 milliseconds) {
    s32 milliseconds_left = milliseconds;
    s32 delta_us = 200;
    s32 epsilon_us = 50;
    while (milliseconds_left > 0) {
        pid waitpid_res = system_linux__waitpid(self->pid, &status, WNOHANG);
        if (waitpid_res != 0) {
            if (WIFEXITED(status) == false) {
                self->exit_code = PROCESS_ERROR_CODE_TERMINATED_ABRUPTLY;
            } else {
                self->exit_code = WEXITSTATUS(status);
            }
            break ;
        }
        system_linux__usleep(delta_us);
        milliseconds_left -= delta_us + epsilon_us;
    }
}
