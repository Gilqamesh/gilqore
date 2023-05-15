#include "../../file_path.h"

#include "types/string/string.h"
#include "libc/libc.h"
#include "math/compare/compare.h"
#include "common/error_code.h"

bool file_path__directory_part(const char* path, char* buffer, u32 buffer_size) {
    libc__strrchr(path, '/');
}

bool file_path__basename_part(const char* path, char* buffer, u32 buffer_size) {
}

bool file_path__basename_relative_part(const char* path, char* buffer, u32 buffer_size, u32 n) {
}

bool file_path__append(const char* path, char* buffer, u32 buffer_size, const char* append_str) {
}
