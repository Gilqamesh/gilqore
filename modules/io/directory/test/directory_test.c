#include "test_framework/test_framework.h"

#include <stdio.h>

#include "io/directory/directory.h"
#include "io/file/file.h"
#include "libc/libc.h"

#define N_OF_TEST_FILES 10
#define TESTDIR_NAME "testdir"
#define TESTDIR_NAME2 "testdir2"

struct aux_buffer {
    char _[256];
};

static bool create_test_files(const char* dirpath, void* buffer) {
    struct aux_buffer* aux_buffer = buffer;
    for (u32 i = 0; i < N_OF_TEST_FILES; ++i) {
        TEST_FRAMEWORK_ASSERT(libc__snprintf(aux_buffer->_, ARRAY_SIZE(aux_buffer->_), "%s/%s%d", dirpath, "file", i) < (s32) ARRAY_SIZE(aux_buffer->_));
        struct file file;
        TEST_FRAMEWORK_ASSERT(file__open(&file, aux_buffer->_, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
        file__close(&file);
        TEST_FRAMEWORK_ASSERT(libc__snprintf(aux_buffer->_, ARRAY_SIZE(aux_buffer->_), "%s/%s%d", dirpath, TESTDIR_NAME, i) < (s32) ARRAY_SIZE(aux_buffer->_));
        directory__create(aux_buffer->_);
    }

    return true;
}

bool file_del(const char* path, void* user_data) {
    (void) user_data;

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
        directory__foreach_deep(TESTDIR_NAME, &file_del, NULL, FILE_TYPE_FILE);
        directory__foreach_deep(TESTDIR_NAME, &file_del, NULL, FILE_TYPE_DIRECTORY);
        TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME) == true);
        TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);
    }
    if (file__exists(TESTDIR_NAME2)) {
        directory__foreach_deep(TESTDIR_NAME2, &file_del, NULL, FILE_TYPE_FILE);
        directory__foreach_deep(TESTDIR_NAME2, &file_del, NULL, FILE_TYPE_DIRECTORY);
        TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME2) == true);
        TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME2) == false);
    }

    TEST_FRAMEWORK_ASSERT(directory__create(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == true);

    TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);

    TEST_FRAMEWORK_ASSERT(directory__create(TESTDIR_NAME) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == true);

    struct aux_buffer aux_buffer;
    create_test_files(TESTDIR_NAME, &aux_buffer);
    directory__foreach_deep(TESTDIR_NAME, &create_test_files, &aux_buffer, FILE_TYPE_DIRECTORY);

    TEST_FRAMEWORK_ASSERT(file__move(TESTDIR_NAME, TESTDIR_NAME2) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(TESTDIR_NAME2) == true);
    directory__foreach_deep(TESTDIR_NAME2, &file_del, NULL, FILE_TYPE_FILE);
    directory__foreach_deep(TESTDIR_NAME2, &file_del, NULL, FILE_TYPE_DIRECTORY);
    TEST_FRAMEWORK_ASSERT(directory__delete(TESTDIR_NAME2) == true);

    return 0;
}
