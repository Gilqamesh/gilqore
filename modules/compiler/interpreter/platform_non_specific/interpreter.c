#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/console/console.h"
#include "memory/memory.h"

#include "compiler/tokenizer/lox_tokenizer/lox_tokenizer.h"
#include "compiler/tokenizer/comment_tokenizer/comment_tokenizer.h"

#include "compiler/parser/lox_parser/lox_parser.h"

bool interpreter__create(
    struct interpreter* self,
    enum interpreter_type type,
    struct memory_slice internal_buffer
) {
    switch (type) {
        case INTERPRETER_TYPE_COMMENT: {
            self->tokenizer_fn = &tokenizer__tokenize_comments;
            self->convert_token_to_string_fn = &token__type_name_comment;

            self->token_parser_fn = NULL;
            self->convert_expr_to_string_fn = NULL;

            self->evaluate_expr_fn = NULL;
            self->evaluate_statement_fn = NULL;
        } break ;
        case INTERPRETER_TYPE_LOX: {
            self->tokenizer_fn = &lox_tokenizer__tokenize;
            self->convert_token_to_string_fn = &lox_token__type_name;

            self->token_parser_fn = &lox_parser__parse_tokens;
            self->convert_expr_to_string_fn = &lox_parser__convert_to_string;

            self->evaluate_expr_fn = &lox_parser__evaluate_expr_fn;
            self->evaluate_statement_fn = &lox_parser__evaluate_statement_fn;
        } break ;
        default: {
            // error_code__exit(UNKNOWN_INTERPRETER_TYPE);
            error_code__exit(4356);
        }
    }

    u64 total_memory_size = memory_slice__size(&internal_buffer);
    void* total_memory = memory_slice__memory(&internal_buffer);
    
    u64 cur_memory_size = total_memory_size;
    void* cur_memory = total_memory;

    u64 tokenizer_memory_size = cur_memory_size / 2;
    cur_memory_size -= tokenizer_memory_size;
    struct memory_slice tokenizer_memory = {
        .memory = cur_memory,
        .size = tokenizer_memory_size
    };
    cur_memory = (char*) cur_memory + tokenizer_memory_size;

    if (tokenizer__create(&self->tokenizer, tokenizer_memory) == false) {
        return false;
    }

    u64 parser_memory_size = cur_memory_size;
    cur_memory_size -= parser_memory_size;
    struct memory_slice parser_memory = {
        .memory = cur_memory,
        .size = parser_memory_size
    };
    cur_memory = (char*) cur_memory + parser_memory_size;

    if (parser__create(&self->parser, parser_memory) == false) {
        tokenizer__destroy(&self->tokenizer);
        return false;
    }

    return true;
}

void interpreter__destroy(struct interpreter* self) {
    parser__destroy(&self->parser);
    tokenizer__destroy(&self->tokenizer);
}

void interpreter__print_tokens(struct interpreter* self) {
    struct tokenizer* tokenizer = &self->tokenizer;
    for (u32 token_index = 0; token_index < tokenizer->tokens_fill; ++token_index) {
        struct tokenizer_token* token = &tokenizer->tokens[token_index];
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
        self->parser.had_error == true ||
        self->parser.had_runtime_error == true
    ) {
        // error_code__exit(HAD_ERROR_IS_TRUE_IN_RUN_SOURCE);
        error_code__exit(342554);
    }

    struct tokenizer* tokenizer = &self->tokenizer;

    tokenizer__clear(tokenizer);
    u64 time_start = __rdtsc();
    self->tokenizer_fn(tokenizer, source);
    u64 time_end = __rdtsc();
    libc__printf("Tokenizer Cy taken: %.2fk\n", (r64)(time_end - time_start) / 1000.0);
    // interpreter__print_tokens(self);

    struct parser_statement* parsed_statement = NULL;
    self->parser.token_index = 0;
    do {
        time_start = __rdtsc();
        parsed_statement = self->token_parser_fn(&self->parser, &self->tokenizer);
        time_end = __rdtsc();
        libc__printf("Statement parse Cy taken: %.2fk\n", (r64)(time_end - time_start) / 1000.0);
        if (parsed_statement != NULL) {
            self->evaluate_statement_fn(&self->parser, parsed_statement);
        }
    } while (parsed_statement != NULL);

    lox_parser__print_expressions_table_stats(&self->parser);
    lox_parser__print_literal_table_stats(&self->parser);
    lox_parser__print_statements_table_stats(&self->parser);

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
            self->tokenizer.had_error = false;
            self->parser.had_error = false;
            self->parser.had_runtime_error = false;
        }
    }

    console__deinit_module(console);
}
