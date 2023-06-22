#include "thread_platform_specific_defs.h"

bool thread__create(
    struct thread* self,
    u32 (*worker_fn)(void* user_data),
    void* user_data
) {
    if ((self->handle = CreateThread(
        NULL,
        0,
        (DWORD (*)(void*))worker_fn,
        user_data,
        0,
        NULL
    )) == NULL) {
        // todo: GetLastError
        // error_code__exit(CREATE_THREAD_FAILED);
        error_code__exit(34527);
    }

    return true;
}

void thread__wait_execution(struct thread* self) {
    if (WaitForSingleObject(self->handle, INFINITE) == WAIT_FAILED) {
        // todo: diagnostics, GetLastError()
        // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
    }
}

u32 thread__destroy(struct thread* self) {
    DWORD exit_code;
    if (GetExitCodeThread(self->handle, &exit_code) == FALSE) {
        // todo: diagnostics, GetLastError()
        // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_GET_EXIT_CODE_PROCESS);
    }
    // todo: thanks to windows, need to sure STILL_ACTIVE is not a valid error code in the entire module library
    if (exit_code == STILL_ACTIVE) {
        // TerminateThread(self->handle, PROCESS_ERROR_CODE_FORCED_TO_TERMINATE); // code remain from process' copy pasta
        TerminateThread(self->handle, 999);
        if (WaitForSingleObject(self->handle, 0) == WAIT_FAILED) {
            // todo: diagnostics, GetLastError()
            // error_code__exit(PROCESS_ERROR_CODE_WINDOWS_WAIT_FOR_SINGLE_OBJECT);
        }
        // exit_code = PROCESS_ERROR_CODE_FORCED_TO_TERMINATE;
        exit_code = 999;
    }
    if (CloseHandle(self->handle) == FALSE) {
        // todo: diagnostics, GetLastError()
        // error_code__exit(THREAD_ERROR_CODE_WINDOWS_CLOSE_HANDLE);
        error_code__exit(433455);
    }

    return exit_code;
}
