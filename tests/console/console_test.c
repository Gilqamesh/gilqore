#include "test_framework/test_framework.h"

#include "console/console.h"

void test_module_main() {
    console_t console = console__init_module(42);

    if (console) {
        console__log(console, "yoo\n");

        console__deinit_module(console);

    }
}
