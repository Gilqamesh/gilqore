#include "test_framework/test_framework.h"

#include "libc/libc.h"

// static void test_itoa(char* buffer, u32 buffer_size, s64 n, const char* expected) {
//     libc__itoa(n, buffer, buffer_size);
//     libc__printf("Buffer: [%s], expected: [%s], n: %d\n", buffer, expected, n);
//     libc__printf("[");
//     for (u32 i = 0; buffer[i]; ++i) {
//         libc__printf("%c", buffer[i]);
//     }
//     libc__printf("]");
//     libc__printf("\n");
//     libc__printf("[");
//     for (u32 i = 0; expected[i]; ++i) {
//         libc__printf("%c", expected[i]);
//     }
//     libc__printf("]");
//     libc__printf("\n");
//     libc__printf("libc__strcmp(buffer, expected): %d\n", libc__strcmp(buffer, expected));
//     TEST_FRAMEWORK_ASSERT(libc__strcmp(buffer, expected) == 0);
// }

#include <intrin.h>
int main() {
    // char buffer[64];
    // test_itoa(buffer, ARRAY_SIZE(buffer), 2321, "2321");
    // test_itoa(buffer, ARRAY_SIZE(buffer), 0, "0");
    // test_itoa(buffer, ARRAY_SIZE(buffer), -1, "-1");

    libc__printf("%lf\n", libc__strtod("123"));
    u64 time_start = __rdtsc();
    r64 res = libc__strtod("-153243534534535353334243243249327557478943.354325533875428757844738978924342234543234253252435453221.32432");
    u64 time_end = __rdtsc();
    libc__printf("Cy taken to evaluate libc__strtod(\"-153243534534535353334243243249327557478943.354325533875428757844738978924342234543234253252435453221.32432\"): %.2f, res: %.2lf\n", (r64)(time_end - time_start), res);
    libc__printf("%lf\n", libc__strtod("-12.321.32432"));
    libc__printf("%lf\n", libc__strtod("000002943280348940923480943809324"));

    libc__printf("%lf\n", libc__strntod("123.4", 2));
    libc__printf("%lf\n", libc__strntod("123.4", 300));

    return 0;
}
