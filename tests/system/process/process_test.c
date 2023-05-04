#include "test_framework/test_framework.h"

#include "system/process/process.h"

#include <stdio.h>

void test_module_main() {
    // todo: measure time
    struct process process;

    const char* test_program_path = "test_program.exe";
    ASSERT(process__create(&process, test_program_path, "yo", "whats", "good", "hello", NULL));
    ASSERT(process__destroy(&process) == PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);

    ASSERT(process__create(&process, test_program_path, NULL));
    process__wait_timeout(&process, 5000);
    ASSERT(process__destroy(&process) == PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);

    ASSERT(process__create(&process, test_program_path, NULL));
    process__wait_execution(&process);
    ASSERT(process__destroy(&process) == 5);
}
