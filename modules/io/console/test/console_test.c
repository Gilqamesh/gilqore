#include "test_framework/test_framework.h"

#include "io/console/console.h"
#include "libc/libc.h"

#define CONSOLE_BUFFER_SIZE 100

int main() {
    console_t console = console__init_module(CONSOLE_BUFFER_SIZE, false);
    TEST_FRAMEWORK_ASSERT(console);

    u32 bytes_written;
    bytes_written = console__write(console, "yoo\n");
    bytes_written = console__write(console, "");
    char buffer[CONSOLE_BUFFER_SIZE << 1];
    buffer[ARRAY_SIZE(buffer) - 1] = '\0';
    libc__memset(buffer, (s32)'a', ARRAY_SIZE(buffer));
    bytes_written = console__write(console, buffer);
    (void) bytes_written;

    char bufferasd[123];
    console__read_line(console, bufferasd, ARRAY_SIZE(bufferasd));
    libc__printf("bufferasd: [%s]\n", bufferasd);
    console__read_line(console, bufferasd, ARRAY_SIZE(bufferasd));
    libc__printf("bufferasd: [%s]\n", bufferasd);

    console__deinit_module(console);

    return 0;
}
