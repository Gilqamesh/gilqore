#include "test_framework/test_framework.h"

#include "io/file/file_path/file_path.h"

#include "libc/libc.h"

#include <stdio.h>

static void test_path_decompose(
    const char* path,
    char* basename_buffer,
    u32 basename_buffer_size,
    char* directory_buffer,
    u32 directory_buffer_size,
    const char* expected_basename,
    const char* expected_directory
) {
    u32 path_len = libc__strlen(path);

    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            path, path_len,
            basename_buffer, basename_buffer_size,
            directory_buffer, directory_buffer_size
        )
    );
    if (expected_basename != NULL) {
        TEST_FRAMEWORK_ASSERT(
            libc__strcmp(
                basename_buffer,
                expected_basename
            ) == 0
        );
    }
    if (expected_directory) {
        TEST_FRAMEWORK_ASSERT(
            libc__strcmp(
                directory_buffer,
                expected_directory
            ) == 0
        );
    }
}

int main() {
    char basename_buffer[64];
    char directory_buffer[256];

    const char* path = "modules/io/file/file.h";
    test_path_decompose(
        path,
        basename_buffer,
        ARRAY_SIZE(basename_buffer),
        directory_buffer,
        ARRAY_SIZE(directory_buffer),
        "file.h",
        "modules/io/file"
    );

    test_path_decompose(
        path,
        NULL,
        ARRAY_SIZE(basename_buffer),
        NULL,
        ARRAY_SIZE(directory_buffer),
        NULL,
        NULL
    );

    const char* path2 = "";
    test_path_decompose(
        path2,
        basename_buffer,
        ARRAY_SIZE(basename_buffer),
        directory_buffer,
        ARRAY_SIZE(directory_buffer),
        "",
        "."
    );

    const char* path3 = "modules";
    test_path_decompose(
        path3,
        basename_buffer,
        ARRAY_SIZE(basename_buffer),
        directory_buffer,
        ARRAY_SIZE(directory_buffer),
        "modules",
        "."
    );
}
