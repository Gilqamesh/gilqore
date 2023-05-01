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

#define CONSOLE_BUFFER_SIZE 100

void test_module_main() {
    console_t console = console__init_module(CONSOLE_BUFFER_SIZE);

    if (console) {
        test_console_log(console, "yoo\n");
        test_console_log(console, "");
        char buffer[CONSOLE_BUFFER_SIZE << 1];
        buffer[ARRAY_SIZE(buffer) - 1] = '\0';
        libc__memset(buffer, (s32)'a', ARRAY_SIZE(buffer));
        test_console_log(console, buffer);

        console__deinit_module(console);
    }
}
