#include "test_framework/test_framework.h"

#include "libc/libc.h"

static void test_itoa(char* buffer, u32 buffer_size, s64 n, const char* expected) {
    libc__itoa(n, buffer, buffer_size);
    libc__printf("Buffer: [%s], expected: [%s], n: %d\n", buffer, expected, n);
    libc__printf("[");
    for (u32 i = 0; buffer[i]; ++i) {
        libc__printf("%c", buffer[i]);
    }
    libc__printf("]");
    libc__printf("\n");
    libc__printf("[");
    for (u32 i = 0; expected[i]; ++i) {
        libc__printf("%c", expected[i]);
    }
    libc__printf("]");
    libc__printf("\n");
    libc__printf("libc__strcmp(buffer, expected): %d\n", libc__strcmp(buffer, expected));
    TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, expected) == 0);
}

int main() {
    char buffer[64];
    test_itoa(buffer, ARRAY_SIZE(buffer), 2321, "2321");
    test_itoa(buffer, ARRAY_SIZE(buffer), 0, "0");
    test_itoa(buffer, ARRAY_SIZE(buffer), -1, "-1");

    return 0;
}
