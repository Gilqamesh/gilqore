#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"

static bool run_source(const char* source, u32 source_length) {
    (void) source_length;
    libc__printf("%s\n", source);

    return true;
}

bool interpreter__run_file(const char* path) {
    u64 script_file_size;
    if (file__size(path, &script_file_size) == false) {
        return false;
    }
    char* script_file_contents = libc__malloc(script_file_size + 1);

    struct file script_file;
    if (file__open(&script_file, path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false) {
        return false;
    }
    u32 script_file_contents_len = file__read(&script_file, script_file_contents, script_file_size);
    script_file_contents[script_file_contents_len] = '\0';
    file__close(&script_file);

    if (run_source(script_file_contents, script_file_contents_len) == false) {
        return false;
    }

    libc__free(script_file_contents);

    return true;
}

void interpreter__run_prompt() {
    console_t console = console__init_module(0, false);
    bool prompt_is_running = true;
    char line_buffer[KILOBYTES(1)];
    while (prompt_is_running) {
        libc__printf("> ");
        u32 read_line_length = console__read_line(console, line_buffer, ARRAY_SIZE(line_buffer));
        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            run_source(line_buffer, read_line_length);
        }
    }
}
