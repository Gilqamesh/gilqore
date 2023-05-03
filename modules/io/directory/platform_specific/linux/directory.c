#include "../../directory.h"
#include "directory_platform_specific_defs.h"

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "common/error_code.h"
#include "libc/libc.h"
#include "math/compare/compare.h"

bool directory__open(struct directory* self, const char* path) {
    if ((self->handle = opendir(path)) == NULL) {
        // todo: diagnostics, errno
        return false;
    }

    return true;
}

void directory__close(struct directory* self) {
    if (closedir(self->handle) == -1) {
        // todo: diagnostics, errno
        error_code__exit(DIRECTORY_ERROR_CODE_LINUX_CLOSEDIR);
    }
}

bool directory__read(struct directory* self, char* buffer, u32 buffer_size) {
    if (buffer == NULL || buffer_size == 0) {
        error_code__exit(DIRECTORY_ERROR_CODE_LINUX_INVALID_DIRECTORY_READ_INPUT);
    }

    struct dirent* file_info;
    if ((file_info = readdir(self->handle)) == NULL) {
        // todo: diagnostics, save errno value and check if it has changed, if it didn't, then we reached the end of the directory stream
        return false;
    }

    u64 bytes_to_write = min__u64(buffer_size - 1, libc__strlen(file_info.d_name));
    libc__memcpy(buffer, file_info.d_name, bytes_to_write);

    return true;
}

bool directory__create(const char* path) {
    return mkdir(path, 0777) == 0;
}

bool directory__delete(const char* path) {
    return rmdir(path) == 0;
}
