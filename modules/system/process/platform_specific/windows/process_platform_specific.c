#include "process_platform_specific_defs.h"
#include "../../process.h"

#include <stdarg.h>

#include "libc/libc.h"
#include "common/error_code.h"

#include <x86intrin.h>

bool process__create(struct process* self, const char* path) {
    ZeroMemory(&self->process_info, sizeof(self->process_info));

    // note: child process shares the same stdin/stdout/stderr currently

    STARTUPINFO startup_info;
    ZeroMemory(&startup_info, sizeof(startup_info));
    startup_info.cb = sizeof(startup_info);

    if (CreateProcessA(
        NULL,
        (char*) path,
        NULL,
        NULL,
        TRUE,
        0,
        NULL,
        NULL,
        (LPSTARTUPINFOA)&startup_info,
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
        // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_GET_EXIT_CODE_PROCESS);
    }
    // todo: thanks to windows, need to sure STILL_ACTIVE is not a valid error code in the entire module library
    if (exit_code == STILL_ACTIVE) {
        // TerminateProcess(self->process_info.hProcess, PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);
        TerminateProcess(self->process_info.hProcess, 999);
        if (WaitForSingleObject(self->process_info.hProcess, 0) == WAIT_FAILED) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
        }
        // exit_code = PROCESS_ERROR_CODE_FORCED_TO_TERMINATE;
        exit_code = 999;
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
        // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
    }
}

void process__wait_timeout(struct process* self, u32 milliseconds) {
    if (WaitForSingleObject(self->process_info.hProcess, milliseconds) == WAIT_FAILED) {
        // todo: diagnostics, GetLastError()
        // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
    }
}
