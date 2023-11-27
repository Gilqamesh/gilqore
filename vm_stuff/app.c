#include "app.h"

#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

#include "debug.h"
#include "scanner.h"
#include "compiler.h"
#include "libc.h"

static void app__load_shared_libs(app_t* self);
static void app__run_src(app_t* self, const char* source, uint64_t source_len);
static uint64_t app__read_from_fd(int fd, char* buffer, uint64_t buffer_size);
static bool app__process_cmd_line_argument(app_t* self, const char* arg);
static void app__compile_file(app_t* self, const char* path);
static void app__compile_files(app_t* self);
static void app__run_repl(app_t* self);

static void app__load_shared_libs(app_t* self) {
    shared_lib__add(&self->shared_libs, "libtest.so");
}

void app__destroy(app_t* self) {
    (void) self;
}

static bool app__process_cmd_line_argument(app_t* self, const char* arg) {
    if (*arg == '-') {
        compiler_flag_t* compiler_flag = compiler__flag_find(arg + 1);
        if (compiler_flag) {
            if (!compiler_flag->fn(arg, &self->cmd_line_flags.compiler_flags)) {
                return false;
            }
        } else {
            fprintf(stderr, "unrecognized command-line option [%s]\n", arg);
            return false;
        }
    } else {
        // add to files to compile
        if (self->cmd_line_flags.files_to_compile_size == self->cmd_line_flags.files_to_compile_top) {
            if (self->cmd_line_flags.files_to_compile_size == 0) {
                self->cmd_line_flags.files_to_compile_size = 8;
                self->cmd_line_flags.files_to_compile = malloc(self->cmd_line_flags.files_to_compile_size * sizeof(*self->cmd_line_flags.files_to_compile));
            } else {
                self->cmd_line_flags.files_to_compile_size <<= 1;
                self->cmd_line_flags.files_to_compile = realloc(self->cmd_line_flags.files_to_compile, self->cmd_line_flags.files_to_compile_size * sizeof(*self->cmd_line_flags.files_to_compile));
            }
        }

        ASSERT(self->cmd_line_flags.files_to_compile_top < self->cmd_line_flags.files_to_compile_size);
        self->cmd_line_flags.files_to_compile[self->cmd_line_flags.files_to_compile_top++] = arg;
    }

    return true;
}

bool app__create_and_run(app_t* self, int argc, char** argv) {
    memset(self, 0, sizeof(*self));

    self->cmd_line_flags.compiler_flags.compiler_flag_limit_errors_n = UINT32_MAX;
    for (int arg_index = 1; arg_index < argc; ++arg_index) {
        if (!app__process_cmd_line_argument(self, argv[arg_index])) {
            return false;
        }
    }

    if (!state__create(&self->state)) {
        return false;
    }

    if (!shared_lib__create(&self->shared_libs)) {
        return false;
    }

    app__load_shared_libs(self);

    if (self->cmd_line_flags.files_to_compile_top == 0) {
        app__run_repl(self);
    } else {
        app__compile_files(self);
    }

    // type_t* type = (type_t*) types__type_find(&self->types, "_start");
    // ASSERT(type);
    // ASSERT(type->type_specifier == TYPE_FUNCTION_INTERNAL);
    // type_internal_function_t* entry_fn = (type_internal_function_t*) type;

    // state__init(&self->state, type_internal_function__start_ip(entry_fn));

    return true;
}

static void app__run_src(app_t* self, const char* source, uint64_t source_len) {
    compiler_t compiler;
    compiler_flags_t compiler_flags = self->cmd_line_flags.compiler_flags;

    if (!compiler__create(&compiler, &compiler_flags, source, source_len)) {
        return ;
    }

    compiler__define_builtins(&compiler);

    uint8_t* start_ip = self->state.buffer[BUFFER_TYPE_IP].cur;
    uint8_t* end_ip = self->state.buffer[BUFFER_TYPE_IP].end;
    if (!compiler__compile(&compiler, "_start", start_ip, end_ip)) {
        return ;
    }

    state__run(&self->state);
}

static uint64_t app__read_from_fd(int fd, char* buffer, uint64_t buffer_size) {
    ASSERT(buffer_size > 0);

    int64_t bytes_read = read(fd, buffer, buffer_size - 1);
    if (bytes_read == -1) {
        perror("Read failed");
        return 0;
    }

    if (bytes_read == 0) {
        return 0;
    }

    if (bytes_read > 1 && buffer[bytes_read - 2] == '\r' && buffer[bytes_read - 1] == '\n') {
        buffer[bytes_read - 2] = '\0';
    } else if (bytes_read > 0 && buffer[bytes_read - 1] == '\n') {
        buffer[bytes_read - 1] = '\0';
    }

    ASSERT(bytes_read < (int64_t) buffer_size);
    buffer[bytes_read] = '\0';

    return bytes_read;

}

static void app__run_repl(app_t* self) {
    char buffer[1024];
    while (true) {
        printf("> ");
        fflush(stdout);
        uint64_t buffer_len = app__read_from_fd(0, buffer, sizeof(buffer));
        if (!buffer_len) {
            break ;
        }

        app__run_src(self, buffer, buffer_len);
    }
}

static void app__compile_file(app_t* self, const char* path) {
    int fd = open(path, O_RDONLY);
    if (fd == -1) {
        perror("Failed to open file");
        return ;
    }

    struct stat file_info;

    if (stat(path, &file_info) == -1) {
        close(fd);
        perror("Stat failed");
        return ;
    }
    uint64_t file_size = file_info.st_size;
    if (file_size == 0) {
        return ;
    }

    char* source = malloc((file_size << 15) + 1);
    if (!source) {
        close(fd);
        perror("Malloc failed");
        return ;
    }

    uint64_t source_len = app__read_from_fd(fd, source, file_size);
    if (!source_len) {
        free(source);
        close(fd);
        return ;
    }

    app__run_src(self, source, source_len);
}

static void app__compile_files(app_t* self) {
    for (uint32_t file_index = 0; file_index < self->cmd_line_flags.files_to_compile_top; ++file_index) {
        app__compile_file(self, self->cmd_line_flags.files_to_compile[file_index]);
    }
}

int main(int argc, char** argv) {
    if (!compiler__module_init()) {
        exit(1);
    }

    app_t app;

    ASSERT(debug__create(&debug));
    app__create_and_run(&app, argc, argv);

    app__destroy(&app);
    debug__destroy(&debug);

    return 0;
}

// todo: instruction to load in from dll

// lower priority todos:
// todo: control flow graph
