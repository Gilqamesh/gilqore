#include "file/file.h"
#include "file_platform_specific_defs.h"

#include "common/error_code.h"

#include <fcntl.h>
#include <unistd.h>

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

    if (result == FILE_CREATION_MODE_OPEN) {
    } else if (result == FILE_CREATION_MODE_CREATE) {
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

bool file__delete(const char* path) {
    if (unlink(path) == -1) {
        // todo: diagnostic, check errno
        return false;
    }

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
