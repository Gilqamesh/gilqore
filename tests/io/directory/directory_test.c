#include "test_framework/test_framework.h"

#include <stdio.h>

#include "io/directory/directory.h"
#include "io/file/file.h"
#include "libc/libc.h"

#define N_OF_TEST_FILES 10

static void create_test_files(const char* file_prefix);
static void directory_delete_recursive(const char* dirname);

static void directory_delete_recursive(const char* dirname) {
    struct directory dir;
    ASSERT(file__exists(dirname));
    ASSERT(directory__open(&dir, dirname) == true);
    char buffer[256];
    char buffer2[256];
    u32 bytes_written;
    while (directory__read(&dir, buffer, ARRAY_SIZE(buffer), &bytes_written) == true) {
        if ((bytes_written >= 1 && buffer[bytes_written - 1] == '.') ||
            (bytes_written >= 2 && libc__strcmp(buffer + (bytes_written - 2), "..") == 0)
        ) {
            continue ;
        }
        sprintf(buffer2, "%s/%s", dirname, buffer);
        if (file__is_directory(buffer2)) {
            directory_delete_recursive(buffer2);
        } else {
            ASSERT(file__delete(buffer2) == true);
        }
    }
    directory__close(&dir);
    directory__delete(dirname);
}

static void create_test_files(const char* file_prefix) {
    char buffer[256];
    for (u32 i = 0; i < N_OF_TEST_FILES; ++i) {
        sprintf(buffer, "%s/%s%d", file_prefix, "file", i);
        struct file file;
        ASSERT(file__open(&file, buffer, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
        file__close(&file);
    }
}

void test_module_main() {
    const char* testdir_name = "testdir";
    if (file__exists(testdir_name)) {
        directory_delete_recursive(testdir_name);
        ASSERT(file__exists(testdir_name) == false);
    }

    ASSERT(directory__create(testdir_name) == true);
    directory__create(testdir_name);
    ASSERT(file__exists(testdir_name) == true);

    ASSERT(directory__delete(testdir_name) == true);
    ASSERT(file__exists(testdir_name) == false);

    ASSERT(directory__create(testdir_name) == true);
    ASSERT(file__exists(testdir_name) == true);

    create_test_files(testdir_name);

    char buffer[256];
    for (u32 i = 0; i < 15; ++i) {
        sprintf(buffer, "%s/%s%d", testdir_name, testdir_name, i);
        ASSERT(directory__create(buffer) == true);
        create_test_files(buffer);
    }

    const char* testdir_name2 = "testdir2";
    ASSERT(file__move(testdir_name, testdir_name2) == true);
    ASSERT(file__exists(testdir_name) == false);
    if (file__exists(testdir_name2)) {
        directory_delete_recursive(testdir_name2);
    }
}
