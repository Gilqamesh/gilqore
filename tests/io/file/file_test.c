#include "test_framework/test_framework.h"

#include "io/file/file.h"

#include "libc/libc.h"
#include "math/random/random.h"
#include "time/time.h"
#include "system/process/process.h"

#include <stdio.h>

void test_module_main() {
    struct file file;
    enum file_type file_type;
    struct time last_modified1;
    struct time last_modified2;
    char buffer[4096];

    char* filename = "asd";
    if (file__exists(filename)) {
        file__delete(filename);
    }

    ASSERT(file__exists(filename) == false);
    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    ASSERT(file__exists(filename) == false);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_CREATE) == true);
    ASSERT(file__exists(filename) == true);
    ASSERT(file__stat(filename, &file_type));
    ASSERT(file_type == FILE_TYPE_FILE);

    file__close(&file);

    ASSERT(file__delete(filename) == true);
    ASSERT(file__exists(filename) == false);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false);
    ASSERT(file__exists(filename) == false);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    ASSERT(file__exists(filename) == true);
    ASSERT(file__last_modified(filename, &last_modified1));

    char* msg = "yoo wadaaap";
    u32 msg_len = libc__strlen(msg);
    ASSERT(file__write(&file, msg, msg_len) == msg_len);
    ASSERT(file__last_modified(filename, &last_modified2));
    ASSERT(time__cmp(last_modified1, last_modified2) < 0);

    file__close(&file);

    ASSERT(file__delete(filename) == true);
    ASSERT(file__exists(filename) == false);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    ASSERT(file__exists(filename) == true);

    u32 n_of_times_written_msg = 10;
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(file__write(&file, msg, msg_len) == msg_len);
    }
    file__close(&file);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == true);
    u32 bytes_read = file__read(&file, buffer, ARRAY_SIZE(buffer));
    ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    file__close(&file);

    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN) == true);
    bytes_read = file__read(&file, buffer, ARRAY_SIZE(buffer));
    ASSERT(bytes_read == n_of_times_written_msg * msg_len);
    for (u32 i = 0; i < n_of_times_written_msg; ++i) {
        ASSERT(libc__memcmp(buffer + i * msg_len, msg, msg_len) == 0);
    }

    struct random randomizer;
    random__init(&randomizer, 42);

    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        ASSERT(file__seek(&file, seek_pos) == seek_pos);
        char out_var;
        ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        ASSERT(out_var == buffer[seek_pos]);
    }

    ASSERT(file__seek(&file, 0) == 0);
    char* msg2 = "123456789nbcv/,mccnvmbnc/m,cvb/mnbcv";
    u32 msg2_len = libc__strlen(msg2);
    ASSERT(file__write(&file, msg2, msg2_len) == msg2_len);
    libc__memcpy(buffer, msg2, msg2_len);
    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        ASSERT(file__seek(&file, seek_pos) == seek_pos);
        char out_var;
        ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        ASSERT(out_var == buffer[seek_pos]);
    }
    file__close(&file);

    const char* new_filename = "asd2";
    if (file__exists(new_filename)) {
        file__delete(new_filename);
    }
    ASSERT(file__exists(new_filename) == false);
    ASSERT(file__move(filename, new_filename) == true);
    ASSERT(file__exists(filename) == false);
    ASSERT(file__exists(new_filename) == true);

    ASSERT(file__open(&file, new_filename, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == true);
    for (u32 i = 0; i < 10000; ++i) {
        u32 seek_pos = random__u32_closed(&randomizer, 0, n_of_times_written_msg * msg_len - 1);
        ASSERT(file__seek(&file, seek_pos) == seek_pos);
        char out_var;
        ASSERT(file__read(&file, &out_var, sizeof(out_var)) == 1);
        ASSERT(out_var == buffer[seek_pos]);
    }
    file__close(&file);


    ASSERT(file__delete(filename) == false);
    ASSERT(file__exists(filename) == false);

    ASSERT(file__delete(new_filename) == true);
    ASSERT(file__exists(new_filename) == false);
}
