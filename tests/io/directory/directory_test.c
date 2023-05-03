#include "test_framework/test_framework.h"

#include "io/directory/directory.h"
#include "io/file/file.h"

void directory_delete_recursive(const char* dirname) {
    (void) dirname;
}

void test_module_main() {
    const char* dirname = "testdir";
    if (file__exists(dirname)) {
        ASSERT(directory__delete(dirname) == true);
        ASSERT(file__exists(dirname) == false);
    }

    ASSERT(directory__create(dirname) == true);
    ASSERT(file__exists(dirname) == true);

    ASSERT(directory__delete(dirname) == true);
    ASSERT(file__exists(dirname) == false);

    ASSERT(directory__create(dirname) == true);
    ASSERT(file__exists(dirname) == true);

    struct directory dir;
    ASSERT(directory__open(&dir, dirname) == true);
    directory__close(&dir);
}
