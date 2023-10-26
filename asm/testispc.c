#include <stdio.h>
#include "ispcmodule.h"

int main() {
    int32_t major;
    int32_t minor;
    ispc__get_version(&major, &minor);

    printf("Ispc version, major: %d, minor: %d\n", major, minor);

    return 0;
}
