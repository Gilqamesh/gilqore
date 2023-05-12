#include "test_framework/test_framework.h"

#include "io/file/file_reader/file_reader.h"
#include "math/random/random.h"
#include "libc/libc.h"

#define FILE_SIZE  MEGABYTES(64)
#define CHUNK_SIZE 4096

int main() {
    struct file file;
    const char* filename = "tmp_file_name";
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);

    struct random randomizer;
    random__init(&randomizer, 42);
    u32 buffer_size = FILE_SIZE;
    char* buffer = libc__malloc(FILE_SIZE);
    for (u32 i = 0; i < FILE_SIZE; ++i) {
        buffer[i] = random__s32_closed(&randomizer, 'A', 'z');
    }
    TEST_FRAMEWORK_ASSERT(file__write(&file, buffer, buffer_size) == buffer_size);
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0) == 0);

    struct file_reader file_reader;
    TEST_FRAMEWORK_ASSERT(file_reader__create(&file_reader, &file) == true);

    TEST_FRAMEWORK_ASSERT(buffer_size % CHUNK_SIZE == 0);
    for (u32 i = 0; i < buffer_size; i += CHUNK_SIZE) {
        char res[CHUNK_SIZE];
        TEST_FRAMEWORK_ASSERT(file_reader__read_one(&file_reader, res, CHUNK_SIZE) == CHUNK_SIZE);
        TEST_FRAMEWORK_ASSERT(libc__memcmp(res, buffer + i, CHUNK_SIZE) == 0);
    }
    for (u32 i = 0; i < KILOBYTES(1); ++i) {
        char c;
        u32 res = file_reader__read_one(&file_reader, &c, 1);
        TEST_FRAMEWORK_ASSERT(res == 0);
    }
    file__close(&file);
    TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);
    file_reader__clear(&file_reader, &file);
    const char* msg = " yo whadaap   \t hello";
    u32 msg_len = libc__strlen(msg);
    TEST_FRAMEWORK_ASSERT(file__write(&file, msg, msg_len) == msg_len);
    const char* word_to_match = "daap";
    const char* expected_match = " yo whadaap";
    u32 word_to_match_len = libc__strlen(word_to_match);
    u32 expected_match_len = libc__strlen(expected_match);
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0) == 0);
    u32 bytes_read;
    TEST_FRAMEWORK_ASSERT(file_reader__read_while_not_word(&file_reader, buffer, buffer_size, word_to_match, word_to_match_len, &bytes_read) == true);
    TEST_FRAMEWORK_ASSERT(bytes_read == expected_match_len);
    TEST_FRAMEWORK_ASSERT(libc__strncmp(expected_match, buffer, expected_match_len) == 0);
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0) == 0);
    file_reader__clear(&file_reader, &file);
    TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, NULL, 0, " ") == 1);
    TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, buffer, buffer_size, "wy ooo yy ww o") == 4);
    buffer[4] = '\0';
    TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, "yo w") == 0);
    TEST_FRAMEWORK_ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "             ") == 6);
    TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, buffer, 4, " \t\t  \t\t\t\t     ") == 4);
    buffer[4] = '\0';
    TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, "   \t") == 0);
    TEST_FRAMEWORK_ASSERT(file_reader__read_one(&file_reader, NULL, sizeof(char)) == 1);
    TEST_FRAMEWORK_ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "") == 5);
    file__close(&file);

    file_reader__destroy(&file_reader);
    TEST_FRAMEWORK_ASSERT(file__delete(filename));

    libc__free(buffer);

    return 0;
}
