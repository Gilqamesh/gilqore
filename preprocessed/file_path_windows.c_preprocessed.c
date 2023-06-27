#include "../../file_path.h"
#include "types/string/string.h"
#include "libc/libc.h"
#include "common/error_code.h"
bool file_path__decompose(
    const char* path, u32 path_len,
    char* basename_buffer, u32 basename_buffer_size, u32* basename_len,
    char* directory_buffer, u32 directory_buffer_size, u32* directory_len
) {
    if (
        libc__strcmp(path, ".") == 0 ||
        libc__strcmp(path, "..") == 0
    ) {
        return false;
    }
    char* basename = string__rsearch_n(path, path_len, "/\\", 1, false);
    if (basename == NULL) {
        if (directory_buffer != NULL) {
            if (directory_buffer_size == 0) {
                error_code__exit(FILE_PATH_ERROR_CODE_DIRECTORY_BUFFER_TOO_SMALL);
            }
            directory_buffer[0] = '\0';
            if (directory_len != NULL) {
                *directory_len = 0;
            }
        }
        if (basename_buffer != NULL) {
            if (basename_buffer_size <= path_len) {
                error_code__exit(FILE_PATH_ERROR_CODE_BASENAME_BUFFER_TOO_SMALL);
            }
            libc__strcpy(basename_buffer, path);
            if (basename_len != NULL) {
                *basename_len = path_len;
            }
        }
    } else {
        if (directory_buffer != NULL) {
            ASSERT(basename > path);
            u32 bytes_to_write = (u32)(basename - path);
            if (directory_buffer_size < bytes_to_write) {
                error_code__exit(FILE_PATH_ERROR_CODE_DIRECTORY_BUFFER_TOO_SMALL);
            }
            libc__memcpy(directory_buffer, path, bytes_to_write);
            directory_buffer[bytes_to_write] = '\0';
            if (directory_len != NULL) {
                *directory_len = bytes_to_write;
            }
        }
        if (basename_buffer != NULL) {
            ++basename;
            ASSERT(path + path_len > basename);
            u32 bytes_to_write = (u32)((path + path_len) - basename);
            if (basename_buffer_size <= bytes_to_write) {
                error_code__exit(FILE_PATH_ERROR_CODE_BASENAME_BUFFER_TOO_SMALL);
            }
            libc__memcpy(basename_buffer, basename, bytes_to_write);
            basename_buffer[bytes_to_write] = '\0';
            if (basename_len != NULL) {
                *basename_len = bytes_to_write;
            }
        }
    }
    return true;
}
