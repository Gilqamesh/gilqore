#include "test_framework/test_framework.h"

#include "system/process/process.h"
#include "io/file/file.h"
#include "libc/libc.h"

#include <stdio.h>

int main() {
    // todo: measure time
    struct process process;
    struct file file;

    const char* test_program_source = "test_program.c";
    const char* test_program_exe = "test_program.exe";
    ASSERT(file__open(&file, test_program_source, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    const char* filecontent =
    "#include <stdio.h>\n"
    "int main() {\n"
        "printf(\"start mining\\n\");\n"
        "for (int i = 0; i < 5; ++i) {\n"
            "printf(\".\");\n"
            "for (int j = 0; j < 100000000; ++j) {\n"
                "int b = 0;\n"
                "b += 105;\n"
                "b *= 203;\n"
            "}\n"
        "}\n"
        "printf(\"\\n\");\n"
        "printf(\"finished mining\\n\");\n"
        "return 5;\n"
    "}";

    u32 filecontent_size = libc__strlen(filecontent);
    ASSERT(file__write(&file, filecontent, filecontent_size) == filecontent_size);
    file__close(&file);

    ASSERT(process__create(&process, "cc test_program.c -o test_program.exe"));
    process__wait_execution(&process);
    u32 exit_code = process__destroy(&process);
    printf("exit_code: %u\n", exit_code);
    ASSERT(exit_code == 0);

    ASSERT(file__exists(test_program_exe));

    ASSERT(process__create(&process, "test_program.exe yo whats good hello"));
    ASSERT(process__destroy(&process) == PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);

    ASSERT(process__create(&process, test_program_exe));
    process__wait_timeout(&process, 1000);
    ASSERT(process__destroy(&process) == PROCESS_ERROR_CODE_FORCED_TO_TERMINATE);

    ASSERT(process__create(&process, test_program_exe));
    process__wait_execution(&process);
    ASSERT(process__destroy(&process) == 5);

    ASSERT(file__delete(test_program_exe));
    ASSERT(file__exists(test_program_exe) == false);
    ASSERT(file__delete(test_program_source));
    ASSERT(file__exists(test_program_source) == false);

    return 0;
}
