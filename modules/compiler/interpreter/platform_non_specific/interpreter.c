#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"
#include "compiler/tokenizer/tokenizer.h"
#include "memory/memory.h"

// static void error_print(u32 line, const char* message, ...) {
//     va_list ap;

//     libc__printf("%u | Error: ", line);

//     va_start(ap, message);
//     libc__vprintf(message, ap);
//     va_end(ap);

//     libc__printf("\n");
// }

static bool run_source(const char* source, u32 source_length) {
    // error_print(12, "Unexpected \",\" in argument list");

    u32 tokenizer_memory_size = KILOBYTES(1);
    void* tokenizer_memory = malloc(tokenizer_memory_size);
    struct tokenizer tokenizer;
    if (tokenizer__create(&tokenizer, memory_slice__create(tokenizer_memory, tokenizer_memory_size)) == false) {
        return false;
    }

    tokenizer__tokenize_comments(&tokenizer, source);

    for (u32 token_index = 0; token_index < tokenizer.tokens_fill; ++token_index) {
        libc__printf("[%.*s]\n", tokenizer.tokens[token_index].len, tokenizer.tokens[token_index].end - tokenizer.tokens[token_index].len);
    }

    tokenizer__destroy(&tokenizer);
    (void) source_length;

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
    console_t console = console__init_module(KILOBYTES(1), false);
    bool prompt_is_running = true;
    char line_buffer[KILOBYTES(1)];
    while (prompt_is_running) {
        console__write(console, "> ");
        // libc__printf("> ");
        u32 read_line_length = console__read_line(console, line_buffer, ARRAY_SIZE(line_buffer));
        line_buffer[read_line_length] = '\n';
        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            prompt_is_running |= run_source(line_buffer, read_line_length);
        }
    }
}
