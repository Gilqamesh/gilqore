#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"
#include "memory/memory.h"

#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"
#include "compiler/tokenizer/comment_tokenizer/comment_tokenizer.h"

#include "compiler/parser/lox_parser/lox_parser.h"

#include "compiler/interpreter/lox_interpreter/lox_interpreter.h"

bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
) {
    switch (type) {
        case INTERPRETER_TYPE_COMMENT: {
            self->tokenizer_fn = &tokenizer__tokenize_comments;
            self->convert_token_to_string_fn = &token__type_name_comment;

            self->parser_clear = NULL;
            self->parser_parse_ast = NULL;
            self->parser_ast_is_valid = NULL;
            self->parser_ast_print = NULL;
            self->parser_is_finished_parsing = NULL;
            self->parser_convert_expr_to_string = NULL;

            self->interpreter_interpret_ast = NULL;
            self->interpreter_initialize = NULL;
            self->interpreter_clear = NULL;
        } break ;
        case INTERPRETER_TYPE_LOX: {
            self->interpreter_initialize = &lox_interpreter__initialize;
        } break ;
        default: {
            // error_code__exit(UNKNOWN_INTERPRETER_TYPE);
            error_code__exit(4356);
        }
    }

    return self->interpreter_initialize(self, internal_buffer);
}

void interpreter__destroy(struct interpreter* self) {
    parser__destroy(&self->parser);
    tokenizer__destroy(&self->tokenizer);
}

void interpreter__print_tokens(struct interpreter* self) {
    struct tokenizer* tokenizer = &self->tokenizer;
    for (u32 token_index = 0; token_index < tokenizer->tokens_fill; ++token_index) {
        struct token* token = &tokenizer->tokens[token_index];
        libc__printf(
            "[%.*s], n: %u, type: %s\n",
            token->lexeme_len, token->lexeme,
            tokenizer__occurance_counter(&self->tokenizer, token),
            self->convert_token_to_string_fn(token->type)
        );
    }
}

#include <intrin.h>
static bool run_source(
    struct interpreter* self,
    const char* source,
    u32 source_length
) {
    (void) source_length;

    if (
        self->tokenizer.had_error == true ||
        self->parser.had_syntax_error == true ||
        self->parser.had_runtime_error == true
    ) {
        // error_code__exit(HAD_ERROR_IS_TRUE_IN_RUN_SOURCE);
        error_code__exit(342554);
    }

    struct tokenizer* tokenizer = &self->tokenizer;

    tokenizer__clear(tokenizer);
    // u64 time_start = __rdtsc();
    self->tokenizer_fn(tokenizer, source);
    // u64 time_end = __rdtsc();
    // libc__printf("Tokenizer Cy taken: %.2fk\n", (r64)(time_end - time_start) / 1000.0);
    // interpreter__print_tokens(self);

    struct parser* parser = &self->parser;
    // time_start = __rdtsc();
    if (self->parser_clear(parser) == false) {
        return false;
    }

    if (self->interpreter_clear(self) == false) {
        return false;
    }

    do {
        struct parser_ast ast = self->parser_parse_ast(parser);
        if (self->parser_ast_is_valid(ast)) {
            self->parser_ast_print(ast);
            self->interpreter_interpret_ast(self, ast);
        }
    } while (self->parser_is_finished_parsing(parser) == false);
    // time_end = __rdtsc();
    // libc__printf("Statement parse and evaluate Cy taken: %.2fk\n", (r64)(time_end - time_start) / 1000.0);

    lox_parser__print_expressions_table_stats(parser);
    lox_parser__print_literal_table_stats(parser);
    lox_parser__print_statements_table_stats(parser);

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
            // todo: clear these at the appropriate places
            self->tokenizer.had_error = false;
            self->parser.had_syntax_error = false;
            self->parser.had_runtime_error = false;
        }
    }

    console__deinit_module(console);
}

void interpreter__runtime_error(
    struct interpreter* self,
    const char* format, ...
) {
    self->had_runtime_error = true;
    va_list ap;

    libc__printf("Runtime error: ");

    va_start(ap, format);
    libc__vprintf(format, ap);
    va_end(ap);

    libc__printf("\n");
}
