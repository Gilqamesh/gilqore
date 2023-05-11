#include "file/file.h"
#include "file_platform_specific_defs.h"

#include "common/error_code.h"
#include "time/time.h"

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>

static inline u32 file_access_mode(enum file_access_mode access_mode) {
    u32 result = 0;

    if (access_mode == FILE_ACCESS_MODE_READ) {
        result = O_RDONLY;
    } else if (access_mode == FILE_ACCESS_MODE_WRITE) {
        result = O_WRONLY;
    } else if (access_mode == FILE_ACCESS_MODE_RDWR) {
        result = O_RDWR
    } else {
        error_code__exit(FILE_ERROR_CODE_OPEN_ACCESS_INVALID);
    }

    return result;
}

static inline u32 file_creation_mode(enum file_creation_mode creation_mode) {
    u32 result = 0;

    if (creation_mode == FILE_CREATION_MODE_OPEN) {
    } else if (creation_mode == FILE_CREATION_MODE_CREATE) {
        result = O_CREAT | O_TRUNC;
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
    self->fd = -1;
    if ((self->fd = open(
        path,
        file_access_mode(access_mode) | file_creation_mode(creation_mode)
    )) == -1) {
        // todo: diagnostic, check errno
        return false;
    }

    return true;
}

void file__close(struct file* self) {
    if (close(self->fd) == -1) {
        // todo: diagnostic, check errno
        error_code__exit(FILE_ERROR_CODE_LINUX_CLOSE);
    }
}

bool file__exists(const char* path) {
    return access(path, F_OK) == 0;
}

bool file__delete(const char* path) {
    if (unlink(path) == -1) {
        // todo: diagnostic, check errno
        return false;
    }

    return true;
}

bool file__move(const char* src_path, const char* dest_path) {
    if (rename(src_path, dest_path) == -1) {
        // todo: diagnostic, check errno
        return false;
    }

    return true;
}

bool file__last_modified(const char* path, struct time* last_modified) {
    struct stat file_info;
    if (stat(path, &file_info) == -1) {
        // todo: diagnostics, check errno
        return false;
    }

    last_modified->val = file_info.st_mtime;

    return true;
}

bool file__stat(const char* path, enum file_type* file_type) {
    struct stat file_info;
    if (stat(path, &file_info) == -1) {
        // todo: diagnostics, check errno
        return false;
    }

    *file_type = 0;
    *file_type = S_ISDIR(file_info.st_mode) ? FILE_TYPE_DIRECTORY : FILE_TYPE_FILE;

    return true;
}

bool file__size(const char* path, u64* file_size) {
    struct stat file_info;

    if (stat(path, &file_info) == -1) {
        // todo: diagnostics, check errno
        return false;
    }

    *file_size = file_info.st_size;

    return true;
}

u32 file__read(struct file* self, void* out, u32 size) {
    if (size == 0) {
        return 0;
    }

    s32 result;

    if ((result = read(self->fd, out, size)) == -1) {
        // todo: diagnostic, check errno
        error_code__exit(FILE_ERROR_CODE_LINUX_READ);
    }

    return result;
}

u32 file__write(struct file* self, const void* in, u32 size) {
    s32 result;

    if ((result = write(self->fd, in, size)) == -1) {
        // todo: diagnostic, check errno
        error_code__exit(FILE_ERROR_CODE_LINUX_WRITE);
    }

    return result;
}

u32 file__seek(struct file* self, u32 offset) {
    s32 result;

    if ((result = lseek(self->fd, offset, SEEK_SET)) == -1) {
        // todo: diagnostic, check errno
        error_code__exit(FILE_ERROR_CODE_LINUX_SEEK);
    }

    return result;
}
