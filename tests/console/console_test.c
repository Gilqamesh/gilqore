#include "console/console.h"
#include "test_framework/test_framework.h"

u64 test_module_main() {
    console c = console__init_module(16);

    if (c) {
        console__log(c, "yoo\n");

        console__deinit_module(c);

        return 0;
    } else {
        return 1;
    }
}
