#include "../../file_path.h"

#include "types/string/string.h"
#include "libc/libc.h"
#include "common/error_code.h"

bool file_path__decompose(
    const char* path, u32 path_len,
    char* basename_buffer, u32 basename_buffer_size,
    char* directory_buffer, u32 directory_buffer_size
) {
    char* basename = string__rsearch_n(path, path_len, "/\\", 1, false);
    if (basename == NULL) {
        if (directory_buffer != NULL) {
            if (directory_buffer_size < 2) {
                error_code__exit(FILE_PATH_ERROR_CODE_DIRECTORY_BUFFER_TOO_SMALL);
            }
            libc__memcpy(directory_buffer, ".", 1);
            directory_buffer[1] = '\0';
        }
        if (basename_buffer != NULL) {
            if (basename_buffer_size <= path_len) {
                error_code__exit(FILE_PATH_ERROR_CODE_BASENAME_BUFFER_TOO_SMALL);
            }
            libc__strcpy(basename_buffer, path);
        }
    } else {
        if (directory_buffer != NULL) {
            u32 bytes_to_write = basename - path;
            if (directory_buffer_size < bytes_to_write) {
                error_code__exit(FILE_PATH_ERROR_CODE_DIRECTORY_BUFFER_TOO_SMALL);
            }
            libc__memcpy(directory_buffer, path, bytes_to_write);
            directory_buffer[bytes_to_write] = '\0';
        }
        if (basename_buffer != NULL) {
            u32 bytes_to_write = path + path_len - (basename + 1) + 1;
            if (basename_buffer_size <= bytes_to_write) {
                error_code__exit(FILE_PATH_ERROR_CODE_BASENAME_BUFFER_TOO_SMALL);
            }
            libc__memcpy(basename_buffer, basename + 1, bytes_to_write);
            basename_buffer[bytes_to_write] = '\0';
        }
    }

    return true;
}
