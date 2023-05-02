#include "directory_platform_specific_defs.h"
#include "../../directory.h"

#include "common/error_code.h"

bool directory__open(struct directory* self, const char* path) {
    if (FindFirstFileA(
        path,
        &self->current_file_info
    ) == INVALID_HANDLE_VALUE ) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}

void directory__close(struct directory* self) {
    if (FindClose(self->handle) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit();
    }
}

struct directory_entry directory__read(struct directory* self) {
}

bool directory__create(const char* path) {
}

bool directory__delete(const char* path) {
}

bool directory__rename(const char* path) {
}
