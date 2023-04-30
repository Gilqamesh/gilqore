#include "test_framework/test_framework.h"

#include "console/console.h"
#include "libc/libc.h"

void test_console_log(console_t console, const char* msg) {
    u64 msg_len = libc__strlen(msg);
    u32 console_size = console__size(console);
    ASSERT(
        console__log(console, msg) ==
        ((u64) console_size < msg_len ? console_size : msg_len)
    );
}

void test_module_main() {
    u32 console_buffer_size = 10;
    console_t console = console__init_module(console_buffer_size);

    if (console) {
        test_console_log(console, "yoo\n");
        test_console_log(console, "");
        test_console_log(console, "aaaaaaaaaaaaaaaaaaaaaaaaa\n");

        console__deinit_module(console);
    }
}
