#include "defs.h"
#include "utils.h"

#include <stdlib.h>

#define G_FILE_MAX_SIZE MEGABYTES(16)
#define G_FILE_MAX_LINE_LEN KILOBYTES(4)

u32 get_unique_error_code() {
    static u32 error_code = 0;

    return error_code++;
}
// too yoo #fatal_error "suppppp"; asddddd
void transpile(
    char* buffer,
    u32 buffer_len,
    FILE* out_file
) {
    struct memory file_write_format_memory = {
        .data = malloc(G_FILE_MAX_LINE_LEN),
        .size = G_FILE_MAX_LINE_LEN
    };
    if (file_write_format_memory.data == NULL) {
        fatal_error("malloc failed to allocate for file_write_format_memory");
    }

    const char token_key_import[] = "#import ";
    const char token_key_error_message[] = "#fatal_error \"";

    // u64 token_key_import_hash = hash__sum_n(token_key_import, ARRAY_SIZE(token_key_import) - 1);
    // u64 token_key_error_message_hash = hash__sum_n(token_key_error_message, ARRAY_SIZE(token_key_error_message) - 1);

    char* start_of_line = buffer;
    while (*start_of_line != '\0') {
        char* end_of_line = string__search_n(start_of_line, buffer_len, "\r\n", 1, false);
        if (end_of_line == NULL) {
            end_of_line = buffer + buffer_len;
        }
        u32 line_len = end_of_line - start_of_line;

        bool found_matching_token = false;
        bool line_was_written = false;

        if (found_matching_token == false) {
            char* token_value_import = string__starts_with(start_of_line, token_key_import);
            if (token_value_import) {
                found_matching_token = true;

                /*
                struct module* found_module = module_compiler__find_module_by_name(modules, token_value_import);
                if (found_module) {
                    file_writer__write_format(
                        &writer, &preprocessed_file,
                        "#include \"%s/%s.h\"\n",
                        found_module->dirprefix, found_module->basename
                    );
                    line_was_written = true;
                }
                */

                line_was_written = true;
            }
        }

        if (found_matching_token == false) {
            char* token_value_error_message = string__search(start_of_line, line_len, token_key_error_message, ARRAY_SIZE(token_key_error_message) - 1);
            if (token_value_error_message) {
                found_matching_token = true;

                char* enclosing_quotation_mark = string__search_n(
                    token_value_error_message + 1, end_of_line - (token_value_error_message + 1),
                    "\"", 1, false
                );
                if (enclosing_quotation_mark) {
                    u32 unique_error_code = get_unique_error_code();

                    /*
                    file_writer__write_format(
                        &writer, error_codes_file,
                        "%u REMOVE_ME %.*s\n",
                        unique_error_code,
                        enclosing_quotation_mark + 1 - token_value_error_message, token_value_error_message
                    );
                    */
                    file_write_format(
                        out_file, file_write_format_memory,
                        "%.*serror_code__exit(%u)%.*s\n",
                        (u32) (token_value_error_message - start_of_line) - (ARRAY_SIZE(token_key_error_message) - 1), start_of_line,
                        unique_error_code,
                        (u32) (end_of_line - enclosing_quotation_mark - 1), enclosing_quotation_mark + 1
                    );

                    line_was_written = true;
                }
            }
        }

        if (line_was_written == false) {
            file_write_format(out_file, file_write_format_memory, "%.*s\n", line_len, start_of_line);
        }

        while (
            *end_of_line != '\0' &&
            end_of_line < buffer + buffer_len &&
            (*end_of_line == '\r' ||
            *end_of_line == '\n')
        ) {
            ++end_of_line;
        }
        start_of_line = end_of_line;
    }

    free(file_write_format_memory.data);
}

int main(int argc, char** argv) {
    if (argc != 3) {
        fatal_error("Usage: transpiler <g_file_path> <dest_path>");
    }

    const char* g_file_path = argv[1];
    // todo: check if it's .g extension

    const char* out_file_path = argv[2];

    FILE* g_file = fopen(g_file_path, "r");
    if (g_file == NULL) {
        fatal_error("Couldn't open file for reading: '%s'", g_file_path);
    }

    FILE* out_file = fopen(out_file_path, "w");
    if (out_file == NULL) {
        fatal_error("Couldn't create file for writing: '%s'", out_file_path);
    }

    char* g_file_buffer = malloc(G_FILE_MAX_SIZE);
    if (g_file_buffer == NULL) {
        fatal_error("Malloc failed");
    }

    u32 g_file_len = (u32) fread(g_file_buffer, sizeof(char), G_FILE_MAX_SIZE - 1, g_file);
    g_file_buffer[g_file_len] = '\0';
    fclose(g_file);

    transpile(g_file_buffer, g_file_len, out_file);
    fclose(out_file);

    free(g_file_buffer);

    return 0;
}
