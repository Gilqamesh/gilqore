#include "test_framework/test_framework.h"

#include "data_structures/bucket_array/bucket_array.h"

// import data_structures::bucket_array

int main() {
    struct bucket_array bucket_array;

    // bucket_array::create(&bucket_array);

    TEST_FRAMEWORK_ASSERT(bucket_array__create(&bucket_array));

    TEST_FRAMEWORK_ASSERT(bucket_array.i == 42);

    return 0;
}
