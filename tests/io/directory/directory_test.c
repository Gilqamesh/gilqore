#include "test_framework/test_framework.h"

#include <stdio.h>

#include "io/directory/directory.h"
#include "io/file/file.h"
#include "libc/libc.h"

#define N_OF_TEST_FILES 10
#define TESTDIR_NAME "testdir"
#define TESTFILE_NAME "/file"

static void delete_test_files(const char* file_prefix);
static void create_test_files(const char* file_prefix, const char* filename);
static void directory_delete_recursive(const char* dirname);

static void directory_delete_recursive(const char* dirname) {
    struct directory dir;
    ASSERT(file__exists(dirname));
    ASSERT(directory__open(&dir, dirname));
    char buffer[256];
    for (u32 i = 0; i < N_OF_TEST_FILES + 2; ++i) {
        ASSERT(directory__read(&dir, buffer, ARRAY_SIZE(buffer)) == true);
        printf("yo: %s\n", buffer);
        if (libc__strcmp(buffer, ".") != 0 && libc__strcmp(buffer, "..")) {
            sprintf(buffer, "%s/%s", dirname, buffer);
            delete_test_files(buffer);
        }
    }
    directory__close(&dir);
}

static void delete_test_files(const char* file_prefix) {
    char buffer[256];
    for (u32 i = 0; i < N_OF_TEST_FILES; ++i) {
        libc__memset(buffer, 0, ARRAY_SIZE(buffer));
        libc__memcpy(buffer, file_prefix, libc__strlen(file_prefix));
        libc__strcat(buffer, TESTFILE_NAME);
        char tmp_buf[8];
        tmp_buf[0] = i + '0';
        tmp_buf[1] = '\0';
        libc__strcat(buffer, tmp_buf);
        file__delete(buffer);
    }
}

static void create_test_files(const char* file_prefix, const char* filename) {
    char buffer[256];
    for (u32 i = 0; i < N_OF_TEST_FILES; ++i) {
        libc__memset(buffer, 0, ARRAY_SIZE(buffer));
        libc__memcpy(buffer, file_prefix, libc__strlen(file_prefix));
        libc__strcat(buffer, filename);
        char tmp_buf[8];
        tmp_buf[0] = i + '0';
        tmp_buf[1] = '\0';
        libc__strcat(buffer, tmp_buf);
        struct file file;
        ASSERT(file__open(&file, buffer, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
        file__close(&file);
    }
}

void test_module_main() {
    if (file__exists(TESTDIR_NAME)) {
        directory_delete_recursive(TESTDIR_NAME);
        ASSERT(file__exists(TESTDIR_NAME) == false);
    }

    ASSERT(directory__create(TESTDIR_NAME) == true);
    directory__create(TESTDIR_NAME);
    ASSERT(file__exists(TESTDIR_NAME) == true);

    ASSERT(directory__delete(TESTDIR_NAME) == true);
    ASSERT(file__exists(TESTDIR_NAME) == false);

    ASSERT(directory__create(TESTDIR_NAME) == true);
    ASSERT(file__exists(TESTDIR_NAME) == true);

    delete_test_files(TESTDIR_NAME);

    create_test_files(TESTDIR_NAME, TESTFILE_NAME);

    struct directory dir;
    ASSERT(directory__open(&dir, TESTDIR_NAME) == true);

    char buffer[256];
    printf("Files in directory %s:\n", TESTDIR_NAME);
    for (u32 i = 0; i < N_OF_TEST_FILES + 2; ++i) {
        ASSERT(directory__read(&dir, buffer, ARRAY_SIZE(buffer)) == true);
        printf("%s\n", buffer);
    }

    delete_test_files(TESTDIR_NAME);

    directory__close(&dir);
    ASSERT(directory__delete(TESTDIR_NAME) == true);
}
