#include "../../file.h"
#include "file_platform_specific_defs.h"

#include "common/error_code.h"
#include "time/time.h"

static inline DWORD file_access_mode(enum file_access_mode access_mode) {
    DWORD result = 0;

    if (access_mode == FILE_ACCESS_MODE_READ) {
        result = GENERIC_READ;
    } else if (access_mode == FILE_ACCESS_MODE_WRITE) {
        result = GENERIC_WRITE;
    } else if (access_mode == FILE_ACCESS_MODE_RDWR) {
        result = GENERIC_READ | GENERIC_WRITE;
    } else {
        error_code__exit(FILE_ERROR_CODE_ACCESS_MODE_INVALID);
    }

    return result;
}

static inline DWORD file_creation_mode(enum file_creation_mode creation_mode) {
    DWORD result = 0;

    if (creation_mode == FILE_CREATION_MODE_OPEN) {
        result = OPEN_EXISTING;
    } else if (creation_mode == FILE_CREATION_MODE_CREATE) {
        result = CREATE_ALWAYS;
    } else {
        error_code__exit(FILE_ERROR_CODE_CREATION_MODE_INVALID);
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
        FILE_SHARE_READ | FILE_SHARE_WRITE,
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
        error_code__exit(FILE_ERROR_CODE_WINDOWS_CLOSE);
    }
}

bool file__exists(const char* path) {
    return GetFileAttributesA(path) != INVALID_FILE_ATTRIBUTES;
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

bool file__last_modified(const char* path, struct time* last_modified) {
    struct file file;

    if (file__open(&file, path, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN) == false) {
        return false;
    }

    if (GetFileTime(file.handle, NULL, NULL, &last_modified->val) == FALSE) {
        // todo: diagnostics, GetLastError()
        file__close(&file);
        return false;
    }

    file__close(&file);

    return true;
}

bool file__stat(const char* path, enum file_type* file_type) {
    DWORD file_attributes = GetFileAttributesA(path);
    if (file_attributes == INVALID_FILE_ATTRIBUTES) {
        return false;
    }

    *file_type = file_attributes & FILE_ATTRIBUTE_DIRECTORY ? FILE_TYPE_DIRECTORY : FILE_TYPE_FILE;

    return true;
}

bool file__size(const char* path, u64* file_size) {
    struct file file;
    if (file__open(&file, path, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN) == false) {
        return false;
    }

    LARGE_INTEGER size;
    if (GetFileSizeEx(file.handle, &size) == FALSE) {
        // todo: diagnostics, GetLastError()
        file__close(&file);
        return false;
    }
    *file_size = size.QuadPart;

    file__close(&file);

    return true;
}

bool file__copy(const char* dest_path, const char* src_path) {
    if (CopyFile(
        src_path,
        dest_path,
        FALSE
    ) == FALSE) {
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

static DWORD file_seek_type(enum file_seek_type type) {
    DWORD result = 0;

    if (type == FILE_SEEK_TYPE_BEGIN) {
        result = FILE_BEGIN;
    } else if (type == FILE_SEEK_TYPE_CUR) {
        result = FILE_CURRENT;
    } else if (type == FILE_SEEK_TYPE_END) {
        result = FILE_END;
    } else {
        // error_code__exit(FILE_SEEK_TYPE_INVALID);
        error_code__exit(32556);
    }

    return result;
}

u32 file__seek(struct file* self, u32 offset, enum file_seek_type type) {
    DWORD result;
    if ((result = SetFilePointer(
        self->handle,
        offset,
        NULL,
        file_seek_type(type)
    )) == INVALID_SET_FILE_POINTER) {
        // todo: diagnostics, GetLastError()
        error_code__exit(FILE_ERROR_CODE_WINDOWS_SEEK);
    }

    return result;
}
