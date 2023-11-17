#include "debug.h"

FILE* compiled_code_file;
FILE* runtime_code_file;
FILE* runtime_stack_file;

void debug__create() {
    compiled_code_file = fopen("debug/compiled_code", "w");
    runtime_code_file = fopen("debug/runtime_code", "w");
    runtime_stack_file = fopen("debug/runtime_stack", "w");
}

void debug__destroy() {
    fclose(compiled_code_file);
    fclose(runtime_code_file);
    fclose(runtime_stack_file);
}
