#include "test_framework/test_framework.h"

#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"

int main(int argc, char** argv) {
    if (argc == 1) {
        interpreter__run_prompt();
    } else if (argc == 2) {
        if (interpreter__run_file(argv[1]) == false) {
            libc__printf("interpreter__run_file failed to open file [%s]\n", argv[1]);
        }
    } else {
        libc__printf("Usage: interpreter [script]\n");
        // error_code__exit(WRONG_USAGE);
        error_code__exit(3245);
    }
    return 0;
}
