#include "test_framework/test_framework.h"

#include "io/file/file.h"

#include "libc/libc.h"
#include "math/random/random.h"

#include <stdio.h>

void test_module_main() {
    struct file file_a;

    char* filename = "asd";
    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);

    file__close(&file_a);

    ASSERT(file__delete(filename) == true);

    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);

    char* msg = "yoo wadaaap";
    u32 msg_len = libc__strlen(msg);
    ASSERT(file__write(&file_a, msg, msg_len) == msg_len);

    file__close(&file_a);

    ASSERT(file__delete(filename) == true);

    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    u32 n_of_times_written_msg = 10;
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(file__write(&file_a, msg, msg_len) == msg_len);
    }
    file__close(&file_a);

    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == true);
    char buffer[4096];
    u32 bytes_read = file__read(&file_a, buffer, ARRAY_SIZE(buffer));
    ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    file__close(&file_a);

    ASSERT(file__open(&file_a, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN) == true);
    bytes_read = file__read(&file_a, buffer, ARRAY_SIZE(buffer));
    ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    struct random randomizer;
    random__init(&randomizer, 42);

    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        ASSERT(file__seek(&file_a, seek_pos) == seek_pos);
        char out_var;
        ASSERT(file__read(&file_a, &out_var, sizeof(out_var)) == 1);
        ASSERT(out_var == buffer[seek_pos]);
    }

    ASSERT(file__seek(&file_a, 0) == 0);
    char* msg2 = "123456789nbcv/,mccnvmbnc/m,cvb/mnbcv";
    u32 msg2_len = libc__strlen(msg2);
    ASSERT(file__write(&file_a, msg2, msg2_len) == msg2_len);
    libc__memcpy(buffer, msg2, msg2_len);
    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        ASSERT(file__seek(&file_a, seek_pos) == seek_pos);
        char out_var;
        ASSERT(file__read(&file_a, &out_var, sizeof(out_var)) == 1);
        ASSERT(out_var == buffer[seek_pos]);
    }

    file__close(&file_a);

    ASSERT(file__delete(filename) == true);
}
