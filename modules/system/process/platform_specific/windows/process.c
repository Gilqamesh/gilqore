#include "process_platform_specific_defs.h"
#include "../../process.h"

#include <stdarg.h>

#include "libc/libc.h"
#include "common/error_code.h"

bool process__create(struct process* self, const char* path, const char* arg0, ...) {
    char cmd_line_buffer[PROCESS_MAX_PATH_LENGTH + PROCESS_MAX_CMD_LINE_ARGS * (PROCESS_MAX_CMD_LINE_ARG_SIZE + 1) + 1];

    u32 argc = 0;
    ++argc;
    char* cmd_line_buffer_cur = cmd_line_buffer;
    s32 cmd_line_buffer_remaining_bytes = ARRAY_SIZE(cmd_line_buffer);
    s32 cmd_line_buffer_written_bytes = libc__snprintf(cmd_line_buffer_cur, cmd_line_buffer_remaining_bytes, "%s", path);
    cmd_line_buffer_remaining_bytes -= cmd_line_buffer_written_bytes;
    cmd_line_buffer_cur += cmd_line_buffer_written_bytes;
    if (cmd_line_buffer_remaining_bytes < 0) {
        error_code__exit(PROCESS_ERROR_CODE_INVALID_INPUT_SIZE_PROCESS_CREATE);
    }

    va_list ap;
    va_start(ap, arg0);
    const char* arg_cur = arg0;
    while (argc < PROCESS_MAX_CMD_LINE_ARGS && arg_cur != NULL) {
        cmd_line_buffer_written_bytes = libc__snprintf(cmd_line_buffer_cur, cmd_line_buffer_remaining_bytes, " %s", arg_cur);
        cmd_line_buffer_remaining_bytes -= cmd_line_buffer_written_bytes;
        cmd_line_buffer_cur += cmd_line_buffer_written_bytes;
        if (cmd_line_buffer_remaining_bytes < 0) {
            error_code__exit(PROCESS_ERROR_CODE_INVALID_INPUT_SIZE_PROCESS_CREATE);
        }
        ++argc;
        arg_cur = va_arg(ap, char*);
    }
    va_end(ap);

    ZeroMemory(&self->process_info, sizeof(self->process_info));

    HANDLE out_handle = GetStdHandle(STD_OUTPUT_HANDLE);
    if (out_handle == INVALID_HANDLE_VALUE) {
        error_code__exit(PROCESS_ERROR_CODE_WINDOWS_GET_STD_HANDLE);
    }
    STARTUPINFO startup_info;
    ZeroMemory(&startup_info, sizeof(startup_info));
    startup_info.cb = sizeof(startup_info);
    // startup_info.hStdOutput = out_handle;
    startup_info.dwFlags = STARTF_USESHOWWINDOW;
    // startup_info.dwFlags |= STARTF_USESTDHANDLES;
    startup_info.wShowWindow = STARTF_USESHOWWINDOW;

    if (CreateProcessA(
        NULL,
        cmd_line_buffer,
        NULL,
        NULL,
        FALSE,
        DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP,
        NULL,
        NULL,
        &startup_info,
        &self->process_info
    ) == FALSE) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}

u32 process__destroy(struct process* self) {
    DWORD exit_code;
    if (GetExitCodeProcess(self->process_info.hProcess, &exit_code) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(PROCESS_ERROR_CODE_WINDOWS_GET_EXIT_CODE_PROCESS);
    }
    // todo: thanks to windows, need to sure STILL_ACTIVE is not a valid error code in the entire module library
    if (exit_code == STILL_ACTIVE) {
        TerminateProcess(self->process_info.hProcess, PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);
        if (WaitForSingleObject(self->process_info.hProcess, 0) == WAIT_FAILED) {
            // todo: diagnostics, GetLastError()
            error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
        }
        exit_code = PROCESS_ERROR_CODE_FORCED_TO_TERMINATE;
    }
    if (CloseHandle(self->process_info.hProcess) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(PROCESS_ERROR_CODE_WINDOWS_CLOSE_HANDLE);
    }

    return exit_code;
}

void process__wait_execution(struct process* self) {
    if (WaitForSingleObject(self->process_info.hProcess, INFINITE) == WAIT_FAILED) {
        // todo: diagnostics, GetLastError()
        error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
    }
}

void process__wait_timeout(struct process* self, u32 milliseconds) {
    if (WaitForSingleObject(self->process_info.hProcess, milliseconds) == WAIT_FAILED) {
        // todo: diagnostics, GetLastError()
        error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
    }
}
