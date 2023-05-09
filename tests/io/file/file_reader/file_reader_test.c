#include "io/file/file_reader/file_reader.h"
#include "math/random/random.h"
#include "libc/libc.h"

#define FILE_SIZE  MEGABYTES(64)
#define CHUNK_SIZE 4096

int main() {
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
        ASSERT(file_reader__read_one(&file_reader, res, CHUNK_SIZE) == CHUNK_SIZE);
        ASSERT(libc__memcmp(res, buffer + i, CHUNK_SIZE) == 0);
    }
    for (u32 i = 0; i < KILOBYTES(1); ++i) {
        char c;
        u32 res = file_reader__read_one(&file_reader, &c, 1);
        ASSERT(res == 0);
    }
    file__close(&file);
    ASSERT(file__delete(filename) == true);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);
    file_reader__clear(&file_reader);
    const char* msg = " yo whadaap   \t hello";
    u32 msg_len = libc__strlen(msg);
    ASSERT(file__write(&file, msg, msg_len) == msg_len);
    ASSERT(file__seek(&file, 0) == 0);
    ASSERT(file_reader__read_while(&file_reader, NULL, 0, " ") == 1);
    ASSERT(file_reader__read_while(&file_reader, buffer, FILE_SIZE, "wy ooo yy ww o") == 4);
    buffer[4] = '\0';
    ASSERT(libc__strcmp(buffer, "yo w") == 0);
    ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "             ") == 6);
    ASSERT(file_reader__read_while(&file_reader, buffer, 4, " \t\t  \t\t\t\t     ") == 4);
    buffer[4] = '\0';
    ASSERT(libc__strcmp(buffer, "   \t") == 0);
    ASSERT(file_reader__read_one(&file_reader, NULL, sizeof(char)) == 1);
    ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "") == 5);
    file__close(&file);

    file_reader__destroy(&file_reader);
    ASSERT(file__delete(filename));

    libc__free(buffer);

    return 0;
}
