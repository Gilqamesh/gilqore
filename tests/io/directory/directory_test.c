#include "test_framework/test_framework.h"

#include <stdio.h>

#include "io/directory/directory.h"
#include "io/file/file.h"
#include "libc/libc.h"

#define N_OF_TEST_FILES 10
#define TESTDIR_NAME "testdir"
#define TESTDIR_NAME2 "testdir2"

static bool create_test_files(const char* dirpath);

static bool create_test_files(const char* dirpath) {
    char buffer[256];
    for (u32 i = 0; i < N_OF_TEST_FILES; ++i) {
        TEST_FRAMEWORK_ASSERT(libc__snprintf(buffer, ARRAY_SIZE(buffer), "%s/%s%d", dirpath, "file", i) < ARRAY_SIZE(BUFFER));
        struct file file;
        TEST_FRAMEWORK_ASSERT(file__open(&file, buffer, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
        file__close(&file);
        TEST_FRAMEWORK_ASSERT(libc__snprintf(buffer, ARRAY_SIZE(buffer), "%s/%s%d", dirpath, TESTDIR_NAME, i) < ARRAY_SIZE(BUFFER));
        directory__create(buffer);
    }

    return true;
}

bool file_del(const char* path) {
    enum file_type type;
    if (file__stat(path, &type) == false) {
        return false;
    }

    if (type == FILE_TYPE_FILE) {
        return file__delete(path);
    } else if (type == FILE_TYPE_DIRECTORY) {
        return directory__delete(path);
    }

    return false;
}

int main() {
    if (file__exists(TESTDIR_NAME)) {
        directory__foreach_deep(TESTDIR_NAME, &file_del, FILE_TYPE_FILE);
        directory__foreach_deep(TESTDIR_NAME, &file_del, FILE_TYPE_DIRECTORY);
        TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME) == true);
        TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);
    }
    if (file__exists(TESTDIR_NAME2)) {
        directory__foreach_deep(TESTDIR_NAME2, &file_del, FILE_TYPE_FILE);
        directory__foreach_deep(TESTDIR_NAME2, &file_del, FILE_TYPE_DIRECTORY);
        TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME2) == true);
        TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME2) == false);
    }

    TEST_FRAMEWORK_ASSERT(directory__create(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == true);

    TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);

    TEST_FRAMEWORK_ASSERT(directory__create(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == true);

    create_test_files(TESTDIR_NAME);
    directory__foreach_deep(TESTDIR_NAME, &create_test_files, FILE_TYPE_DIRECTORY);

    TEST_FRAMEWORK_ASSERT(file__move(TESTDIR_NAME, TESTDIR_NAME2) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME2) == true);
    directory__foreach_deep(TESTDIR_NAME2, &file_del, FILE_TYPE_FILE);
    directory__foreach_deep(TESTDIR_NAME2, &file_del, FILE_TYPE_DIRECTORY);
    TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME2) == true);

    return 0;
}
