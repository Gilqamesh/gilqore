#ifndef APP_H
# define APP_H

# include "state.h"
# include "compiler.h"
# include "shared_lib.h"

typedef struct cmd_line_flags {
    compiler_flags_t    compiler_flags;

    uint32_t            files_to_compile_size;
    uint32_t            files_to_compile_top;
    const char**        files_to_compile;
} cmd_line_flags_t;

typedef struct app {
    state_t             state;
    shared_lib_t        shared_libs;

    cmd_line_flags_t    cmd_line_flags;
} app_t;

bool app__create_and_run(app_t* self, int argc, char** argv);
void app__destroy(app_t* self);

#endif // APP_H
