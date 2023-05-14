#include "test_framework/test_framework.h"

#include "io/file/file.h"

#include "libc/libc.h"
#include "math/random/random.h"
#include "math/compare/compare.h"
#include "time/time.h"
#include "system/process/process.h"

#include <stdio.h>

int main() {
    struct file file;
    enum file_type file_type;
    struct time last_modified1;
    struct time last_modified2;
    u32 buffer_size = 4096;
    u32 buffer2_size = 4096;
    char* buffer = libc__malloc(buffer_size);
    char* buffer2 = libc__malloc(buffer2_size);
    u64 file_size;

    char* filename = "asd";
    if (file__exists(filename)) {
        file__delete(filename);
    }

    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == true);
    TEST_FRAMEWORK_ASSERT(file__stat(filename, &file_type));
    TEST_FRAMEWORK_ASSERT(file_type == FILE_TYPE_FILE);
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == 0);

    file__close(&file);

    TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == true);
    TEST_FRAMEWORK_ASSERT(file__last_modified(filename, &last_modified1));
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == 0);

    char* msg = "yoo wadaaap";
    u32 msg_len = libc__strlen(msg);
    TEST_FRAMEWORK_ASSERT(file__write(&file, msg, msg_len) == msg_len);
    TEST_FRAMEWORK_ASSERT(file__last_modified(filename, &last_modified2));
    TEST_FRAMEWORK_ASSERT(time__cmp(last_modified1, last_modified2) < 0);
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == msg_len);

    file__close(&file);

    TEST_FRAMEWORK_ASSERT(file__delete(filename) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == true);
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == 0);

    u32 n_of_times_written_msg = 10;
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        TEST_FRAMEWORK_ASSERT(file__write(&file, msg, msg_len) == msg_len);
    }
    file__close(&file);
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == n_of_times_written_msg * msg_len);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == true);
    u32 bytes_read = file__read(&file, buffer, buffer_size);
    TEST_FRAMEWORK_ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        TEST_FRAMEWORK_ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    file__close(&file);

    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN) == true);
    bytes_read = file__read(&file, buffer, buffer_size);
    TEST_FRAMEWORK_ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        TEST_FRAMEWORK_ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    struct random randomizer;
    random__init(&randomizer, 42);

    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        TEST_FRAMEWORK_ASSERT(file__seek(&file, seek_pos, FILE_SEEK_TYPE_BEGIN) == seek_pos);
        char out_var;
        TEST_FRAMEWORK_ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        TEST_FRAMEWORK_ASSERT(out_var == buffer[seek_pos]);
    }

    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    char* msg2 = "123456789nbcv/,mccnvmbnc/m,cvb/mnbcv";
    u32 msg2_len = libc__strlen(msg2);
    TEST_FRAMEWORK_ASSERT(file__write(&file, msg2, msg2_len) == msg2_len);
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size) == true);
    u32 expected_file_size = max__u32(n_of_times_written_msg * msg_len, msg2_len);
    TEST_FRAMEWORK_ASSERT(file_size == expected_file_size);
    libc__memcpy(buffer, msg2, msg2_len);
    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        TEST_FRAMEWORK_ASSERT(file__seek(&file, seek_pos, FILE_SEEK_TYPE_BEGIN) == seek_pos);
        char out_var;
        TEST_FRAMEWORK_ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        TEST_FRAMEWORK_ASSERT(out_var == buffer[seek_pos]);
    }
    file__close(&file);

    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size));
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_OPEN));
    // note: according to microsoft this is bad practice, use file__size instead
    TEST_FRAMEWORK_ASSERT(file__seek(&file, 0, FILE_SEEK_TYPE_END) == file_size);
    file__close(&file);

    const char* copied_filename = "iafhdsiusdfha";
    TEST_FRAMEWORK_ASSERT(file__copy(copied_filename, filename));
    TEST_FRAMEWORK_ASSERT(file__exists(copied_filename));
    u64 file_size2;
    TEST_FRAMEWORK_ASSERT(file__size(filename, &file_size));
    TEST_FRAMEWORK_ASSERT(file__size(copied_filename, &file_size2));
    TEST_FRAMEWORK_ASSERT(file_size2 == file_size);
    struct file copied_file;
    TEST_FRAMEWORK_ASSERT(file__open(&copied_file, copied_filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    TEST_FRAMEWORK_ASSERT(file_size2 < buffer2_size);
    TEST_FRAMEWORK_ASSERT(file__read(&copied_file, buffer2, buffer2_size) == file_size2);
    file__close(&copied_file);
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    TEST_FRAMEWORK_ASSERT(file_size < buffer_size);
    TEST_FRAMEWORK_ASSERT(file__read(&file, buffer, buffer_size) == file_size);
    file__close(&file);
    TEST_FRAMEWORK_ASSERT(libc__memcmp(buffer, buffer2, file_size) == 0);

    const char* new_filename = "asd2";
    if (file__exists(new_filename)) {
        file__delete(new_filename);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(new_filename) == false);
    TEST_FRAMEWORK_ASSERT(file__move(filename, new_filename) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(new_filename) == true);
    TEST_FRAMEWORK_ASSERT(file__size(new_filename, &file_size) == true);
    TEST_FRAMEWORK_ASSERT(file_size == expected_file_size);

    TEST_FRAMEWORK_ASSERT(file__open(&file, new_filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == true);
    u32 number_of_random_reads = 10000;
    for (u32 read_counter = 0; read_counter < number_of_random_reads; ++read_counter) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        TEST_FRAMEWORK_ASSERT(file__seek(&file, seek_pos, FILE_SEEK_TYPE_BEGIN) == seek_pos);
        char out_var;
        TEST_FRAMEWORK_ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        TEST_FRAMEWORK_ASSERT(out_var == buffer[seek_pos]);
    }
    file__close(&file);


    TEST_FRAMEWORK_ASSERT(file__delete(filename) == false);
    TEST_FRAMEWORK_ASSERT(file__exists(filename) == false);

    TEST_FRAMEWORK_ASSERT(file__delete(new_filename) == true);
    TEST_FRAMEWORK_ASSERT(file__exists(new_filename) == false);

    libc__free(buffer);
    libc__free(buffer2);

    return 0;
}
