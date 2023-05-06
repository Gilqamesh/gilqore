#include "directory_platform_specific_defs.h"
#include "../../directory.h"

#include "common/error_code.h"
#include "libc/libc.h"
#include "math/compare/compare.h"
#include "io/file/file.h"

bool directory__open(struct directory* self, const char* path) {
    char buffer[MAX_PATH];
    const char* wildcard = "\\*";
    u64 wildcard_len = libc__strlen(wildcard);
    u64 path_len = libc__strlen(path);
    u64 bytes_to_copy = min__u64(path_len, ARRAY_SIZE(buffer) - wildcard_len - 1);
    if (bytes_to_copy == ARRAY_SIZE(buffer) - wildcard_len - 1) {
        error_code__exit(DIRECTORY_ERROR_CODE_WINDOWS_PATH_TRUNCATED);
    }
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
    )) == INVALID_HANDLE_VALUE) {
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

bool directory__read(struct directory* self, char* buffer, u32 buffer_size, u32* bytes_written) {    
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
    if (bytes_written != NULL) {
        *bytes_written = bytes_to_write;
    }

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

void directory__foreach_shallow(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags) {
    directory__foreach(path, fn, file_type_flags, 0);
}

void directory__foreach_deep(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags) {
    directory__foreach(path, fn, file_type_flags, (u32) -1);
}

void directory__foreach(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags, u32 depth) {
    struct directory dir;
    char* buffer = libc__malloc(MAX_PATH);
    char* buffer2 = libc__malloc(MAX_PATH);
    if (directory__open(&dir, path)) {
        u32 bytes_written;
        while (directory__read(&dir, buffer, MAX_PATH, &bytes_written) == true) {
            if ((bytes_written >= 1 && buffer[bytes_written - 1] == '.') ||
                (bytes_written >= 2 && libc__strcmp(buffer + (bytes_written - 2), "..") == 0)
            ) {
                continue ;
            }
            libc__snprintf(buffer2, MAX_PATH, "%s/%s", path, buffer);
            enum file_type type;
            if (file__stat(buffer2, &type) == false) {
                continue ;
            }

            if (depth > 0 && type == FILE_TYPE_DIRECTORY) {
                directory__foreach(buffer2, fn, file_type_flags, depth - 1);
            }
            if (type & file_type_flags) {
                fn(buffer2);
            }
        }
        directory__close(&dir);
    }
    libc__free(buffer2);
    libc__free(buffer);
}
