#include "../../file.h"
#include "file_platform_specific_defs.h"

#include "common/error_code.h"

static inline DWORD file_access_mode(enum file_access_mode access_mode) {
    DWORD result = 0;

    if (access_mode & FILE_ACCESS_MODE_READ) {
        result = GENERIC_READ;
    } else if (access_mode & FILE_ACCESS_MODE_WRITE) {
        result = GENERIC_WRITE;
    } else if (access_mode & FILE_ACCESS_MODE_RDWR) {
        result = GENERIC_READ | GENERIC_WRITE;
    } else {
        error_code__exit(FILE_ERROR_CODE_OPEN_ACCESS_INVALID);
    }

    return result;
}

static inline DWORD file_creation_mode(enum file_creation_mode creation_mode) {
    DWORD result = 0;

    if (creation_mode & FILE_CREATION_MODE_OPEN) {
        result = OPEN_EXISTING;
    } else if (creation_mode & FILE_CREATION_MODE_CREATE) {
        result = CREATE_ALWAYS;
    } else {
        error_code__exit(FILE_ERROR_CODE_OPEN_CREATION_INVALID);
    }

    return result;
}

bool file__open(
    struct file* self,
    const char* path,
    enum file_access_mode access_mode,
    enum file_creation_mode creation_mode
) {
    if ((self->handle = CreateFileA(
        path,
        file_access_mode(access_mode),
        0,
        NULL,
        file_creation_mode(creation_mode),
        FILE_ATTRIBUTE_NORMAL,
        NULL
    )) == INVALID_HANDLE_VALUE) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}

void file__close(struct file* self) {
    if (CloseHandle(self->handle) == FALSE) {
        error_code__exit(FILE_ERROR_CODE_WINDOWS_CLOSEHANDLE);
    }
}

bool file__exists(const char* path) {
    return GetFileAttributesA(path) != INVALID_FILE_ATTRIBUTES;
}

bool file__is_directory(const char* path) {
    DWORD file_attributes = GetFileAttributesA(path);

    return
    file_attributes != INVALID_FILE_ATTRIBUTES &&
    (file_attributes & FILE_ATTRIBUTE_DIRECTORY);
}

bool file__delete(const char* path) {
    if (DeleteFile(path) == FALSE) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}

bool file__move(const char* src_path, const char* dest_path) {
    if (MoveFile(src_path, dest_path) == FALSE) {
        // todo: diagnostics, GetLastError()
        return false;
    }

    return true;
}

u32 file__read(struct file* self, void* out, u32 size) {
    if (size == 0) {
        return 0;
    }

    DWORD bytes_read;

    if (ReadFile(
        self->handle,
        out,
        size,
        &bytes_read,
        NULL
    ) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(FILE_ERROR_CODE_WINDOWS_READ);
    }

    return bytes_read;
}

u32 file__write(struct file* self, const void* in, u32 size) {
    DWORD bytes_written;

    if (WriteFile(
        self->handle,
        in,
        size,
        &bytes_written,
        NULL
    ) == FALSE) {
        // todo: diagnostics, GetLastError()
        error_code__exit(FILE_ERROR_CODE_WINDOWS_WRITE);
    }

    return bytes_written;
}

u32 file__seek(struct file* self, u32 offset) {
    DWORD result;
    if ((result = SetFilePointer(
        self->handle,
        offset,
        NULL,
        FILE_BEGIN
    )) == INVALID_SET_FILE_POINTER) {
        // todo: diagnostics, GetLastError()
        error_code__exit(FILE_ERROR_CODE_WINDOWS_SEEK);
    }

    return result;
}