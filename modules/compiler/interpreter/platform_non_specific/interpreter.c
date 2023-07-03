#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"
#include "compiler/tokenizer/tokenizer.h"
#include "memory/memory.h"

bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
) {
    switch (type) {
        case INTERPRETER_TYPE_COMMENT: {
            self->tokenizer_tokenize_fn = &tokenizer__tokenize_comments;
            self->token_type_name_fn = &token__type_name_comment;
        } break ;
        case INTERPRETER_TYPE_C: {
            self->tokenizer_tokenize_fn = &tokenizer__tokenize_c_source_code;
            self->token_type_name_fn = &token__type_name_c;
        } break ;
        case INTERPRETER_TYPE_LOX: {
            self->tokenizer_tokenize_fn = &tokenizer__tokenize_lox;
            self->token_type_name_fn = &token__type_name_lox;
        } break ;
        default: {
            // error_code__exit(UNKNOWN_INTERPRETER_TYPE);
            error_code__exit(4356);
        }
    }

    if (tokenizer__create(&self->tokenizer, internal_buffer) == false) {
        return false;
    }

    return true;
}

void interpreter__destroy(struct interpreter* self) {
    tokenizer__destroy(&self->tokenizer);
}

static bool run_source(
    struct interpreter* self,
    const char* source,
    u32 source_length
) {
    (void) source_length;

if (tokenizer__had_error(&self->tokenizer) == true) {
        // error_code__exit(HAD_ERROR_IS_TRUE_IN_RUN_SOURCE);
        error_code__exit(342554);
    }

    struct tokenizer* tokenizer = &self->tokenizer;

    tokenizer__clear(tokenizer);
    self->tokenizer_tokenize_fn(tokenizer, source);
    for (u32 token_index = 0; token_index < tokenizer->tokens_fill; ++token_index) {
        libc__printf(
            "[%.*s], type: %s\n",
            tokenizer->tokens[token_index].lexeme_len, tokenizer->tokens[token_index].lexeme,
            self->token_type_name_fn(&tokenizer->tokens[token_index])
        );
    }

    return true;
}

bool interpreter__run_file(struct interpreter* self, const char* path) {
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

    if (run_source(self, script_file_contents, script_file_contents_len) == false) {
        return false;
    }

    libc__free(script_file_contents);

    return true;
}

void interpreter__run_prompt(struct interpreter* self) {
    console_t console = console__init_module(KILOBYTES(1), false);
    bool prompt_is_running = true;
    char line_buffer[KILOBYTES(1)];
    while (prompt_is_running) {
        console__write(console, "> ");
        // libc__printf("> ");
        u32 read_line_length = console__read_line(console, line_buffer, ARRAY_SIZE(line_buffer) - 2);
        line_buffer[read_line_length] = '\n';
        line_buffer[read_line_length + 1] = '\0';
        if (read_line_length == 0) {
            prompt_is_running = false;
        } else {
            prompt_is_running |= run_source(self, line_buffer, read_line_length);
            tokenizer__clear_error(&self->tokenizer);
        }
    }

    console__deinit_module(console);
}
