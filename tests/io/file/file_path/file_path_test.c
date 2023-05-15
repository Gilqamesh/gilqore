#include "test_framework/test_framework.h"

#include "io/file/file_path/file_path.h"

#include "libc/libc.h"

#include <stdio.h>
#include <stdarg.h>

static void test_path_decompose(
    const char* path,
    char* basename_buffer,
    u32 basename_buffer_size,
    char* directory_buffer,
    u32 directory_buffer_size,
    const char* expected_basename,
    const char* expected_directory,
    bool expected_decompose_result
) {
    u32 path_len = libc__strlen(path);

    u32 basename_len;
    u32 directory_len;
    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            path, path_len,
            basename_buffer, basename_buffer_size, &basename_len,
            directory_buffer, directory_buffer_size, &directory_len
        ) == expected_decompose_result
    );
    if (expected_decompose_result == false) {
        return ;
    }
    if (expected_basename != NULL) {
        u32 expected_basename_len = libc__strlen(expected_basename);
        TEST_FRAMEWORK_ASSERT(
            libc__strcmp(
                basename_buffer,
                expected_basename
            ) == 0
        );
        TEST_FRAMEWORK_ASSERT(expected_basename_len == basename_len);
    }
    if (expected_directory != NULL) {
        u32 expected_directory_len = libc__strlen(expected_directory);
        TEST_FRAMEWORK_ASSERT(
            libc__strcmp(
                directory_buffer,
                expected_directory
            ) == 0
        );
        TEST_FRAMEWORK_ASSERT(expected_directory_len == directory_len);
    }
}

#define TERMINATING_PTR ((void*) 0x12345678)

static void test_path_decompose_v(
    char* basename_buffer,
    u32 basename_buffer_size,
    char* directory_buffer,
    u32 directory_buffer_size,
    ...
) {
    va_list ap;

    va_start(ap, directory_buffer_size);
    
    while (1) {
        char* path = va_arg(ap, char*);
        if (path == TERMINATING_PTR) {
            break ;
        }
        char* expected_basename = va_arg(ap, char*);
        char* expected_directory = va_arg(ap, char*);
        bool expected_decompose_result = va_arg(ap, s32);
        test_path_decompose(
            path,
            basename_buffer, basename_buffer_size,
            directory_buffer, directory_buffer_size,
            expected_basename,
            expected_directory,
            expected_decompose_result
        );
    }

    va_end(ap);
}

int main() {
    char basename_buffer[64];
    char directory_buffer[256];

    test_path_decompose_v(
        basename_buffer, ARRAY_SIZE(basename_buffer),
        directory_buffer, ARRAY_SIZE(directory_buffer),
        "modules/io/file/file.h", "file.h",  "modules/io/file", true,
        "modules/io/file/file.h", NULL,      NULL,              true,
        "",                       "",        "",                true,
        "modules",                "modules", "",                true,
        ".",                      NULL,      NULL,              false,
        "..",                     NULL,      NULL,              false,
        "./..",                   "..",      ".",               true,
        "./../modules/io",        "io",      "./../modules",    true,
        TERMINATING_PTR
    );

    return 0;
}
