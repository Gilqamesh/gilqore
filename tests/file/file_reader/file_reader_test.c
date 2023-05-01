#include "test_framework/test_framework.h"

#include "file/file_reader/file_reader.h"
#include "random/random.h"
#include "libc/libc.h"

#define FILE_SIZE  MEGABYTES(64)
#define CHUNK_SIZE 4096

void test_module_main() {
    struct file file;
    const char* filename = "tmp_file_name";
    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);

    struct random randomizer;
    random__init(&randomizer, 42);
    char* buffer = libc__malloc(FILE_SIZE);
    for (u32 i = 0; i < FILE_SIZE; ++i) {
        buffer[i] = random__s32_closed(&randomizer, 'A', 'z');
    }
    ASSERT(file__write(&file, buffer, FILE_SIZE) == FILE_SIZE);
    ASSERT(file__seek(&file, 0) == 0);

    struct file_reader file_reader;
    ASSERT(file_reader__create(&file_reader, &file) == true);

    ASSERT(FILE_SIZE % CHUNK_SIZE == 0);
    for (u32 i = 0; i < FILE_SIZE; i += CHUNK_SIZE) {
        char res[CHUNK_SIZE];
        ASSERT(file_reader__read(&file_reader, res, CHUNK_SIZE) == CHUNK_SIZE);
        ASSERT(libc__memcmp(res, buffer + i, CHUNK_SIZE) == 0);
    }
    for (u32 i = 0; i < KILOBYTES(1); ++i) {
        char c;
        u32 res = file_reader__read(&file_reader, &c, 1);
        ASSERT(res == 0);
    }

    libc__free(buffer);

    file_reader__destroy(&file_reader);
    file__close(&file);
    file__delete(filename);
}
