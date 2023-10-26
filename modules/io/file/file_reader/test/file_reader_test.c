#include "test_framework/test_framework.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "gil_math/random/random.h"
#include "libc/libc.h"
#include "memory/memory.h"

#define FILE_SIZE  MEGABYTES(2)
#define CHUNK_SIZE 4096

#include <x86intrin.h>

static void test_format(file_reader_t* file_reader, char* buffer, u32 buffer_size, file_t file, const char* expected, u32 expected_bytes_matched, const char* format, ...) {
    va_list ap;
    va_start(ap, format);

    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    file__write(&file, expected, libc__strlen(expected));
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    file_reader__clear(file_reader, file);
    u32 bytes_matched = 0;
    TEST_FRAMEWORK_ASSERT(file_reader__read_formatv(file_reader, buffer, buffer_size, &bytes_matched, format, ap));
    TEST_FRAMEWORK_ASSERT(bytes_matched == expected_bytes_matched);

    va_end(ap);
}

int main() {
    file_t file;
    const char* filename = "tmp_file_name";
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);

    struct random randomizer;
    random__init(&randomizer, 42);
    const u32 buffer_size = FILE_SIZE;
    char* buffer = libc__malloc(FILE_SIZE);
    const u32 buffer2_size = KILOBYTES(1);
    char* buffer2 = libc__malloc(FILE_SIZE);
    const u32 buffer3_size = KILOBYTES(1);
    char* buffer3 = libc__malloc(FILE_SIZE);
    for (u32 i = 0; i < FILE_SIZE; ++i) {
        buffer[i] = random__s32_closed(&randomizer, 'A', 'z');
    }
    TEST_FRAMEWORK_ASSERT(file__write(&file, buffer, buffer_size) == buffer_size);
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);

    struct file_reader file_reader;
    const u32 file_reader_memory_size = KILOBYTES(4);
    void* file_reader_memory = libc__malloc(file_reader_memory_size);
    TEST_FRAMEWORK_ASSERT(file_reader__create(&file_reader, file, memory_slice__create(file_reader_memory, file_reader_memory_size)));

    // TEST_FRAMEWORK_ASSERT(buffer_size % CHUNK_SIZE == 0);
    // for (u32 i = 0; i < buffer_size; i += CHUNK_SIZE) {
    //     char res[CHUNK_SIZE];
    //     TEST_FRAMEWORK_ASSERT(file_reader__read_one(&file_reader, res, CHUNK_SIZE) == CHUNK_SIZE);
    //     TEST_FRAMEWORK_ASSERT(libc__memcmp(res, buffer + i, CHUNK_SIZE) == 0);
    // }

    file_reader__clear(&file_reader, file);
    bool format_specifier = true;
    u32 buffer_index = 0;
    const u32 buffer2_len = 9;
    ASSERT(buffer2_size >= buffer2_len);
    ASSERT(buffer2_len % 2 == 0 || buffer2_len % 3 == 0 || buffer2_len % 5 == 0);
    for (u32 buffer2_index = 0; buffer2_index < buffer2_len; ++buffer2_index, format_specifier = !format_specifier, ++buffer_index) {
        if (format_specifier) {
            buffer2[buffer2_index++] = '%';
            buffer2[buffer2_index] = 'c';
        } else {
            buffer2[buffer2_index] = buffer[buffer_index];
        }
    }
    u32 bytes_matched;
    TEST_FRAMEWORK_ASSERT(file_reader__read_format(&file_reader, buffer3, buffer3_size, &bytes_matched, buffer2, buffer[0], buffer[2], buffer[4]));

    test_format(&file_reader, buffer3, buffer3_size, file, "   f01235a", 9, "%9p", 0xf01235);
    test_format(&file_reader, buffer3, buffer3_size, file, "f01235   a", 9, "%-9p", 0xf01235);
    test_format(&file_reader, buffer3, buffer3_size, file, "123a", 3, "%d", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "0123a", 4, "%04d", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "  123a", 5, "%5d", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "123  a", 5, "%-5d", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "00a", 1, "%d", 0);
    test_format(&file_reader, buffer3, buffer3_size, file, "-1a", 2, "%d", -1);
    test_format(&file_reader, buffer3, buffer3_size, file, "-2147483648 a", 11, "%d", S32_MIN);
    test_format(&file_reader, buffer3, buffer3_size, file, "2147483647 a", 10, "%d", S32_MAX);
    test_format(&file_reader, buffer3, buffer3_size, file, "2147483647 a", 10, "%u", S32_MAX);
    ASSERT(libc__itoa((unsigned int)-1, buffer2, buffer2_size, 10));
    test_format(&file_reader, buffer3, buffer3_size, file, buffer2, 10, "%u", -1);
    test_format(&file_reader, buffer3, buffer3_size, file, "000123a", 6, "%06u", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "00a", 1, "%u", 0);
    test_format(&file_reader, buffer3, buffer3_size, file, "   123a", 6, "%6u", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "123   a", 6, "%-6u", 123);
    test_format(&file_reader, buffer3, buffer3_size, file, "fab23a", 5, "%x", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, " fab23  a", 6, "%6x", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, "fab23  a", 6, "%-6x", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, "FAB23 a", 5, "%X", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, " FAB23 a", 6, "%6X", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, "FAB23  a", 6, "%-6X", 0xfab23);
    test_format(&file_reader, buffer3, buffer3_size, file, "%1%a", 3, "%%1%%");
    test_format(&file_reader, buffer3, buffer3_size, file, "0%a", 2, "%02%");
    test_format(&file_reader, buffer3, buffer3_size, file, "% a", 2, "%-2%");
    test_format(&file_reader, buffer3, buffer3_size, file, " %a", 2, "%2%");
    const char* yoo_wadap = "yoo wadap\0";
    test_format(&file_reader, buffer3, buffer3_size, file, yoo_wadap, libc__strlen(yoo_wadap), "%s", yoo_wadap);
    test_format(&file_reader, buffer3, buffer3_size, file, yoo_wadap, 3, "%.3s", "yoo\0");

    // for (u32 i = 0; i < KILOBYTES(1); ++i) {
    //     char c;
    //     u32 res = file_reader__read_one(&file_reader, &c, 1);
    //     TEST_FRAMEWORK_ASSERT(res == 0);
    // }
    // file__close(&file);
    // TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);

    // TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE) == true);
    // file_reader__clear(&file_reader, file);
    // const char* msg = " yo whadaap   \t hello";
    // u32 msg_len = libc__strlen(msg);
    // TEST_FRAMEWORK_ASSERT(file__write(&file, msg, msg_len) == msg_len);
    // const char* word_to_match = "daap";
    // const char* expected_match = " yo whadaap";
    // u32 word_to_match_len = libc__strlen(word_to_match);
    // u32 expected_match_len = libc__strlen(expected_match);
    // TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    // u32 bytes_read;
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while_not_word(&file_reader, buffer, buffer_size, word_to_match, word_to_match_len, &bytes_read) == true);
    // TEST_FRAMEWORK_ASSERT(bytes_read == expected_match_len);
    // TEST_FRAMEWORK_ASSERT(libc__strncmp(expected_match, buffer, expected_match_len) == 0);
    // TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    // file_reader__clear(&file_reader, file);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, NULL, 0, " ") == 1);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, buffer, buffer_size, "wy ooo yy ww o") == 4);
    // buffer[4] = '\0';
    // TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, "yo w") == 0);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "             ") == 6);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while(&file_reader, buffer, 4, " \t\t  \t\t\t\t     ") == 4);
    // buffer[4] = '\0';
    // TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, "   \t") == 0);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_one(&file_reader, NULL, sizeof(char)) == 1);
    // TEST_FRAMEWORK_ASSERT(file_reader__read_while_not(&file_reader, NULL, 0, "") == 5);
    file__close(&file);

    file_reader__destroy(&file_reader);
    libc__free(file_reader_memory);
    TEST_FRAMEWORK_ASSERT(file__delete(filename));

    libc__free(buffer);
    libc__free(buffer2);
    libc__free(buffer3);

    return 0;
}
