#include "tcc/libtcc/libtcc.h"

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    TCCState* tcc_state = tcc_new();

    if (tcc_add_file(tcc_state, "test_compile.c") == -1) {
        printf("tcc_add_file failed\n");
        exit(1);
    }

    if (tcc_add_include_path(tcc_state, "tcc/include") == -1) {
        printf("tcc_add_include_path failed\n");
        exit(1);
    }

    // printf("tcc_set_output_type returned %d\n", tcc_set_output_type(tcc_state, TCC_OUTPUT_OBJ));
    // printf("tcc_output_file returned %d\n", tcc_output_file(tcc_state, "output_file.o"));

    if (tcc_add_library_path(tcc_state, "tcc/lib") == -1) {
        printf("tcc_add_library_path failed\n");
        exit(1);
    }

    if (tcc_add_library(tcc_state, "tcc1-64") == -1) {
        printf("tcc_add_library failed\n");
        exit(1);
    }
    printf("tcc_set_output_type returned %d\n", tcc_set_output_type(tcc_state, TCC_OUTPUT_EXE));
    printf("tcc_output_file returned %d\n", tcc_output_file(tcc_state, "output_file.exe"));

    tcc_delete(tcc_state);
}
