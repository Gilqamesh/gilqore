#include "test_framework/test_framework.h"

#include "module_compiler.h"
#include "module_compiler_utils.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "libc/libc.h"
#include "system/process/process.h"
#include "time/time.h"
#include "types/string/string.h"
#include "io/directory/directory.h"
#include "math/compare/compare.h"
#include "types/string/string_replacer/string_replacer.h"

#include <stdio.h>

#define CONFIG_EXTENSION "gmc"
#define PLATFORM_SPECIFIC_FOLDER_NAME "platform_specific"
#define ERROR_CODES_FILE_NAME "modules/error_codes"

#define KEY_UNIQUE_ERROR_CODES "unique_error_codes"
#define KEY_MODULE_DEPENDENCIES "module_dependencies"

extern struct module g_modules[1024];
extern u32 g_modules_size;
extern u32 g_error_code;

struct module* module_compiler__find_module_by_name(const char* basename);
void module_compiler__parse_config_file(
    struct module* self,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    u32 def_file_buffer_size
);

struct module* module_compiler__find_module_by_name(const char* basename) {
    // todo: store modules in a hashmap by their base names
    for (u32 module_index = 0; module_index < g_modules_size; ++module_index) {
        struct module* cur_module = &g_modules[module_index];
        if (libc__strcmp(cur_module->basename, basename) == 0) {
            return cur_module;
        }
    }
    return NULL;
}

void module_compiler__parse_config_file_recursive_helper(
    struct module* self,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    u32 def_file_buffer_size
) {
    struct module* cur_child = self->first_child;
    while (cur_child) {
        module_compiler__parse_config_file(cur_child, file_writer, error_codes_file, string_replacer, def_file_buffer, def_file_buffer_size);
        module_compiler__parse_config_file_recursive_helper(cur_child, file_writer, error_codes_file, string_replacer, def_file_buffer, def_file_buffer_size);
        cur_child = cur_child->next_sibling;
    }
}

void module_compiler__parse_config_file_recursive(struct module* self) {
    struct file error_codes_file;
    struct file_writer file_writer;
    struct string_replacer string_replacer;
    TEST_FRAMEWORK_ASSERT(file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    u32 max_number_of_replacements_in_def_files = 16;
    u32 average_size_of_replacement_in_bytes = 256;
    u32 max_module_defs_file_size_in_bytes = max_number_of_replacements_in_def_files * average_size_of_replacement_in_bytes;
    u32 def_file_buffer_size = 16384;
    char* def_file_buffer = libc__malloc(def_file_buffer_size);
    file_writer__create(&file_writer);
    TEST_FRAMEWORK_ASSERT(
        string_replacer__create(
            &string_replacer,
            "",
            0,
            max_number_of_replacements_in_def_files,
            max_module_defs_file_size_in_bytes
        ) == true
    );

    module_compiler__parse_config_file(self, &file_writer, &error_codes_file, &string_replacer, def_file_buffer, def_file_buffer_size);
    module_compiler__parse_config_file_recursive_helper(self, &file_writer, &error_codes_file, &string_replacer, def_file_buffer, def_file_buffer_size);

    string_replacer__destroy(&string_replacer);
    file_writer__destroy(&file_writer);
    file__close(&error_codes_file);
    libc__free(def_file_buffer);
}

void parse_config_file_directive(
    struct file_reader* config_file_reader,
    char* buffer,
    u32 buffer_size
) {
    u32 read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, ":");
    if (read_bytes == buffer_size) {
        error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_TOO_LONG);
    }
    buffer[read_bytes] = '\0';
    TEST_FRAMEWORK_ASSERT(file_reader__read_one(config_file_reader, NULL, sizeof(char)) == 1);
}

void parse_config_file_unique_error_codes(
    struct file_reader* config_file_reader,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    char* module_name_capitalized,
    char* buffer,
    u32 buffer_size,
    char* error_codes_buffer,
    u32 error_codes_buffer_size
) {
    u32 remaining_error_codes_buffer_size = error_codes_buffer_size;
    // note: read key-value pairs of unique error code
    do {
        file_reader__read_while(config_file_reader, buffer, buffer_size, " [\r\n");
        u32 read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, ":]");
        if (file_reader__peek(config_file_reader) == ']') {
            *error_codes_buffer = '\0';
            // note: done reading unique_error_codes entry
            file_reader__read_while_not(config_file_reader, NULL, 0, "\r\n");
            file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
            break ;
        }
        if (read_bytes == buffer_size) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_KEY_TOO_LONG);
        }
        buffer[read_bytes] = '\0';
        u32 error_code = module_compiler__get_error_code();

        file_writer__write_format(
            file_writer,
            error_codes_file,
            "%u %s",
            error_code,
            buffer
        );

        // note: read error enum into def file
        u32 written_bytes = libc__snprintf(
            error_codes_buffer,
            remaining_error_codes_buffer_size,
            "    %s_ERROR_CODE_%s = %u,\n",
            module_name_capitalized, buffer, error_code
        );
        if (written_bytes >= remaining_error_codes_buffer_size) {
            // error_code__exit(MODULE_COMPILER_ERROR_CODE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
            error_code__exit(992);
        }
        error_codes_buffer += written_bytes;
        remaining_error_codes_buffer_size -= written_bytes;

        file_reader__read_while(config_file_reader, NULL, 0, ": ");
        read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, "\r\n");
        if (read_bytes == buffer_size) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_VALUE_TOO_LONG);
        }
        buffer[read_bytes] = '\0';
        file_writer__write_format(
            file_writer,
            error_codes_file,
            " \"%s\"\n",
            buffer
        );

        file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
    } while (1);
}

void parse_config_file_dependencies(
    struct module* self,
    struct file_reader* config_file_reader,
    char* buffer,
    u32 buffer_size
) {
    // note: read module dependencies
    do {
        file_reader__read_while(config_file_reader, NULL, 0, " ");
        u32 read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, " \r\n");
        if (read_bytes == 0) {
            // note: done reading module dependencies
            file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
            break ;
        }
        if (read_bytes == buffer_size) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_MODULE_TOO_LONG);
        }
        buffer[read_bytes] = '\0';
        // note: add the dependency to the module
        struct module* found_module = module_compiler__find_module_by_name(buffer);
        if (found_module == NULL) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_NOT_FOUND);
        }
        module_compiler__add_dependency(self, found_module);
    } while (1);
}

void module_compiler__parse_config_file(
    struct module* self,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    u32 def_file_buffer_size
) {
    // todo: optimally, I'd like to parse these out from def_file_template_h
    const char* module_defs_h = "${module_defs_h}";
    const char* parent_module_name_defs = "${parent_module_name_defs}";
    const char* module_error_codes_enum = "${module_error_codes}";
    const char* module_error_code_enum_start = "${module_error_code_start}";
    const char* rest_of_the_error_codes = "${rest_of_the_error_codes}";
    u32 module_defs_h_len = libc__strlen(module_defs_h);
    u32 parent_module_name_defs_len = libc__strlen(parent_module_name_defs);
    u32 module_error_codes_enum_len = libc__strlen(module_error_codes_enum);
    u32 module_error_code_enum_start_len = libc__strlen(module_error_code_enum_start);
    u32 rest_of_the_error_codes_len = libc__strlen(rest_of_the_error_codes);

    char error_codes_buffer[2048];
    char buffer[1024];
    char module_name_capitalized[64];
    if ((u32) libc__snprintf(module_name_capitalized, ARRAY_SIZE(module_name_capitalized), "%s", self->basename) >= ARRAY_SIZE(module_name_capitalized)) {
        error_code__exit(990);
    }
    string__to_upper(module_name_capitalized);

    struct file config_file;
    char config_file_name[512];
    u32 bytes_written = libc__snprintf(config_file_name, ARRAY_SIZE(config_file_name), "%s/%s.%s", self->dirprefix, self->basename, CONFIG_EXTENSION);
    if (bytes_written >= ARRAY_SIZE(config_file_name)) {
        // error_code__exit(CONFIG_FILE_NAME_BUFFER_TOO_SMALL);
        error_code__exit(867);
    }

    char def_file_name[512];
    bytes_written = libc__snprintf(def_file_name, ARRAY_SIZE(def_file_name), "%s/%s_defs.h", self->dirprefix, self->basename);
    if (bytes_written >= ARRAY_SIZE(def_file_name)) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }
    struct file def_file;

    // note: string_replacer doesn't support replacing replacements, so I do this in two write steps if the def_file doesn't exist
    // first, I replace the template, then write it out to the def file
    // second, read from the now existing def file and replace its contents
    if (file__exists(def_file_name) == false) {
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE));
        // todo: start filling in from the template
        struct file def_file_template;
        const char* def_file_template_path = "misc/def_file_template.h";
        TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, def_file_template_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
        u32 def_file_template_size = file__read(&def_file_template, def_file_buffer, def_file_buffer_size);
        if (def_file_template_size == def_file_buffer_size) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        string_replacer__clear(string_replacer, def_file_buffer, def_file_template_size);
        // note: do this two times, because the string_replacer only replaces the first occurance of the word and not all occurances
        string_replacer__replace_word_f(
            string_replacer,
            module_defs_h, module_defs_h_len,
            "%s_DEFS_H", module_name_capitalized
        );
        string_replacer__replace_word_f(
            string_replacer,
            module_defs_h, module_defs_h_len,
            "%s_DEFS_H", module_name_capitalized
        );
        string_replacer__replace_word_f(
            string_replacer,
            parent_module_name_defs, parent_module_name_defs_len,
            self->parent == NULL ? "\"%s\"" : "\"../%s_defs.h\"",
            self->parent == NULL ? "defs.h" : self->parent->basename
        );
        string_replacer__replace_word_f(
            string_replacer,
            module_error_codes_enum, module_error_codes_enum_len,
            "%s", self->basename
        );
        string_replacer__replace_word_f(
            string_replacer,
            module_error_code_enum_start, module_error_code_enum_start_len,
            "%s", module_name_capitalized
        );
        string_replacer__read_into_file(
            string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);
    } else {
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
        u32 def_file_size = file__read(&def_file, def_file_buffer, def_file_buffer_size);
        if (def_file_size == def_file_buffer_size) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        string_replacer__clear(string_replacer, def_file_buffer, def_file_size);
        // note: find somehow the what position, which is where the rest of the error codes would start, and then insert ${rest_of_the_error_codes}
        struct file_reader def_file_reader;
        file_reader__create(&def_file_reader, &def_file);
        file_reader__clear(&def_file_reader);
        u32 what_position;
        char buffer2[128];
        u32 bytes_written = libc__snprintf(
            buffer2,
            ARRAY_SIZE(buffer2),
            "enum %s_error_code {",
            self->basename
        );
        if (bytes_written >= ARRAY_SIZE(buffer2)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        bool does_enum_error_codes_exit = file_reader__read_while_not_word(
            &def_file_reader,
            buffer,
            ARRAY_SIZE(buffer),
            buffer2,
            bytes_written,
            &what_position
        );
        if (what_position >= ARRAY_SIZE(buffer)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        if (does_enum_error_codes_exit) {
            u32 what_size = file_reader__read_while_not(&def_file_reader, NULL, 0, "}");
            string_replacer__replace_at_position_f(
                string_replacer,
                what_position,
                what_size,
                "\n"
                "    %s_ERROR_CODE_START,\n"
                "%s\n",
                module_name_capitalized,
                rest_of_the_error_codes
            );
        } else {
            bytes_written = libc__snprintf(
                buffer2,
                ARRAY_SIZE(buffer2),
                self->parent == NULL ? "\"%s\"\n\n" : "\"../%s_defs.h\"\n\n",
                self->parent == NULL ? "defs.h" : self->parent->basename
            );
            if (bytes_written >= ARRAY_SIZE(buffer2)) {
                // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
                error_code__exit(32476);
            }
            file_reader__clear(&def_file_reader);
            printf("cur module: %s\n", self->basename);
            printf("[%s]\n", buffer2);
            TEST_FRAMEWORK_ASSERT(
                file_reader__read_while_not_word(
                    &def_file_reader,
                    buffer,
                    ARRAY_SIZE(buffer),
                    buffer2,
                    bytes_written,
                    &what_position
                ) == true
            );
            string_replacer__replace_at_position_f(
                string_replacer,
                what_position,
                0,
                "enum %s_error_code {\n"
                "    %s_ERROR_CODE_START,\n"
                "%s\n"
                "};\n\n",
                self->basename,
                module_name_capitalized,
                rest_of_the_error_codes
            );
        }
        file__close(&def_file);
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        string_replacer__read_into_file(
            string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);
    }

    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    u32 def_file_size = file__read(&def_file, def_file_buffer, def_file_buffer_size);
    file__close(&def_file);
    if (def_file_size == def_file_buffer_size) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }
    string_replacer__clear(string_replacer, def_file_buffer, def_file_size);

    if (file__exists(config_file_name)) {
        TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
        struct file_reader config_file_reader;
        TEST_FRAMEWORK_ASSERT(file_reader__create(&config_file_reader, &config_file) == true);
        bool parsed_unique_error_codes = false;
        bool parsed_module_dependencies = false;
        bool parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        while (parsed_everything == false) {
            parse_config_file_directive(&config_file_reader, buffer, ARRAY_SIZE(buffer));

            if (libc__strcmp(buffer, KEY_UNIQUE_ERROR_CODES) == 0) {
                parse_config_file_unique_error_codes(
                    &config_file_reader,
                    file_writer,
                    error_codes_file,
                    module_name_capitalized,
                    buffer,
                    ARRAY_SIZE(buffer),
                    error_codes_buffer,
                    ARRAY_SIZE(error_codes_buffer)
                );
                parsed_unique_error_codes = true;
                string_replacer__replace_word_f(
                    string_replacer,
                    rest_of_the_error_codes, rest_of_the_error_codes_len,
                    "%s", error_codes_buffer
                );
            } else if (libc__strcmp(buffer, KEY_MODULE_DEPENDENCIES) == 0) {
                parse_config_file_dependencies(
                    self,
                    &config_file_reader,
                    buffer,
                    ARRAY_SIZE(buffer)
                );
                parsed_module_dependencies = true;
            } else {
                printf("[%s]\n", buffer);
                error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_UNKNOWN);
            }
            parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        }
        file__close(&config_file);
        file_reader__destroy(&config_file_reader);
    } else {
        string_replacer__replace_word_f(
            string_replacer,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            ""
        );

        TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        for (u32 dep_index = 0; dep_index < ARRAY_SIZE(self->dependencies); ++dep_index) {
            self->dependencies[dep_index] = NULL;
        }
        file_writer__write_format(
            file_writer,
            &config_file,
            "%s: [\n"
            "]\n"
            "%s: \n",
            KEY_UNIQUE_ERROR_CODES,
            KEY_MODULE_DEPENDENCIES
        );
        file__close(&config_file);
    }

    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(
        string_replacer,
        &def_file,
        0
    );
    file__close(&def_file);
}

// @returns true if path is a module
// @note as a side effect, also adds the module to its parent
bool is_module_path(const char* path) {
    char* last_backslash = libc__strrchr(path, '/');
    if (last_backslash == NULL) {
        return false;
    }

    char* basename = last_backslash + 1;
    if (libc__strcmp(PLATFORM_SPECIFIC_FOLDER_NAME, basename) == 0) {
        return false;
    }
    char* second_last_backslash = string__strrchr_n(path, '/', 2);
    if (second_last_backslash == NULL) {
        second_last_backslash = (char*) path;
    } else {
        ++second_last_backslash;
    }
    char parent_basename[512];
    u32 bytes_to_write = last_backslash - second_last_backslash + 1;
    TEST_FRAMEWORK_ASSERT(bytes_to_write < ARRAY_SIZE(parent_basename));
    libc__snprintf(
        parent_basename,
        bytes_to_write,
        "%s",
        second_last_backslash
    );
    struct module* parent = module_compiler__find_module_by_name(parent_basename);
    TEST_FRAMEWORK_ASSERT(parent != NULL);
    module_compiler__add_child(parent, basename);

    return true;
}

void module_compiler__explore_children(struct module* self) {
    struct directory dir;

    TEST_FRAMEWORK_ASSERT(directory__open(&dir, self->dirprefix) == true);
    directory__foreach_deep(self->dirprefix, &is_module_path, FILE_TYPE_DIRECTORY);
}

void module_compiler__compile(void) {
    struct module* parent_module = &g_modules[g_modules_size++];
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compiler__explore_children(parent_module);

    module_compiler__parse_config_file_recursive(parent_module);

    module_compiler__check_cyclic_dependency();

    // module_compiler__print_branch(parent_module);
}

void module_compiler__translate_error_code(u32 error_code, char* buffer, u32 buffer_size) {
    char line_buffer[512];
    char enum_buffer[512];
    char message_buffer[512];
    char format_string_buffer[128];
    if ((u32) libc__snprintf(
        format_string_buffer,
        ARRAY_SIZE(format_string_buffer),
        "%%u %%%ds \"%%%d[^\"]\"",
        ARRAY_SIZE(enum_buffer) - 1,
        ARRAY_SIZE(message_buffer) - 1
    ) >= ARRAY_SIZE(format_string_buffer)) {
        error_code__exit(MODULE_COMPILER_ERROR_CODE_FORMAT_STRING_BUFFER_TOO_SMALL);
    }

    struct file error_codes_file;
    if (file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN) == false) {
        error_code__exit(MODULE_COMPILER_ERROR_CODE_ERROR_CODES_FILE_OPEN_FAIL);
    }
    struct file_reader reader;
    file_reader__create(&reader, &error_codes_file);
    u32 bytes_read;
    do {
        bytes_read = file_reader__read_while_not(&reader, line_buffer, ARRAY_SIZE(line_buffer), "\r\n");
        if (bytes_read == 0) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_UNEXPECTED_EOF_REACHED_ERROR_CODES);
        }
        if (bytes_read == ARRAY_SIZE(line_buffer)) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_LINE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
        }
        line_buffer[bytes_read] = '\0';
        u32 parsed_error_code;
        if (libc__sscanf(
            line_buffer,
            format_string_buffer,
            &parsed_error_code,
            enum_buffer,
            message_buffer
        ) != 3) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_VSSCANF_FAILED_TO_PARSE_LINE_ERROR_CODES);
        }
        if (parsed_error_code == error_code) {
            if (libc__snprintf(buffer, buffer_size, "%s", message_buffer) >= (s32) buffer_size) {
                error_code__exit(MODULE_COMPILER_ERROR_CODE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
            }
            return ;
        }
        file_reader__read_while(&reader, NULL, 0, "\r\n");
    } while (bytes_read > 0);

    file_reader__destroy(&reader);
    file__close(&error_codes_file);

    error_code__exit(MODULE_COMPILER_ERROR_CODE_DID_NOT_FIND_ERROR_CODE);
}
