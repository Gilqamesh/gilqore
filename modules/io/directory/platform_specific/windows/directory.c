#include "directory_platform_specific_defs.h"
#include "../../directory.h"

#include "common/error_code.h"
#include "libc/libc.h"
#include "math/compare/compare.h"

#include <stdio.h>

bool directory__open(struct directory* self, const char* path) {
    char buffer[256];
    const char* wildcard = "\\*";
    u64 wildcard_len = libc__strlen(wildcard);
    u64 bytes_to_copy = min__u64(libc__strlen(path), ARRAY_SIZE(buffer) - wildcard_len - 1);
    libc__memcpy(
        buffer,
        path,
        bytes_to_copy
    );
    buffer[bytes_to_copy] = '\0';
    libc__strcat(buffer, wildcard);
    if ((self->handle = FindFirstFileA(
        buffer,
        &self->current_file_info
    )) == INVALID_HANDLE_VALUE ) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    self->no_more_files = false;

    return true;
}

void directory__close(struct directory* self) {
    if (FindClose(self->handle) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(DIRECTORY_ERROR_CODE_WINDOWS_FINDCLOSE);
    }
}

bool directory__read(struct directory* self, char* buffer, u32 buffer_size) {    
    if (buffer == NULL || buffer_size == 0) {
        error_code__exit(DIRECTORY_ERROR_CODE_WINDOWS_INVALID_DIRECTORY_READ_INPUT);
    }

    if (self->no_more_files) {
        return false;
    }

    u64 bytes_to_write = min__u64(
        libc__strlen(self->current_file_info.cFileName),
        buffer_size - 1
    );
    libc__memcpy(
        buffer,
        self->current_file_info.cFileName,
        bytes_to_write
    );
    buffer[bytes_to_write] = '\0';

    if (FindNextFileA(
        self->handle,
        &self->current_file_info
    ) == FALSE) {
        if (GetLastError() == ERROR_NO_MORE_FILES) {
            self->no_more_files = true;
        } else {
            // todo: diagnostics, GetLastError()
            error_code__exit(DIRECTORY_ERROR_CODE_WINDOWS_FIND_NEXT_FILE);
        }
    }

    return true;
}

bool directory__create(const char* path) {
    if (CreateDirectoryA(path, NULL) == FALSE) {
        // todo: diagnostics, GetLastError(), ERROR_ALREADY_EXISTS, ERROR_PATH_NOT_FOUND
        return false;
    }

    return true;
}

bool directory__delete(const char* path) {
    if (RemoveDirectoryA(path) == FALSE) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}
