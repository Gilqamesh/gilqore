#include "test_framework/test_framework.h"

#include "algorithms/hash/hash.h"

#include "libc/libc.h"

void test_hash_sum_n(const char* hashed_str, u32 n) {
    u64 expected_result = 0;
    u64 num_of_iters = n;
    for (s32 i = 0; hashed_str[i] != '\0' && num_of_iters > 0; ++i, --num_of_iters) {
        expected_result += hashed_str[i];
    }
    TEST_FRAMEWORK_ASSERT(hash__sum_n(hashed_str, n) == expected_result);
}

void test_hash_sums(const char* hashed_str) {
    u64 expected_result = 0;
    u32 hashed_str_len = 0;
    for (s32 i = 0; hashed_str[i] != '\0'; ++i, ++hashed_str_len) {
        expected_result += hashed_str[i];
    }
    TEST_FRAMEWORK_ASSERT(hash__sum(hashed_str) == expected_result);
    for (u32 i = 0; i < hashed_str_len + 10; ++i) {
        test_hash_sum_n(hashed_str, i);
    }
}

int main() {
    test_hash_sums("blah123");
    test_hash_sums("");
    test_hash_sums("a");

    return 0;
}
