#include "test_framework/test_framework.h"

#include "module_compiler.h"
#include "module_compiler_utils.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "libc/libc.h"
#include "types/string/string.h"
#include "io/directory/directory.h"
#include "types/string/string_replacer/string_replacer.h"
#include "common/error_code.h"

#include <stdio.h>

#define CONFIG_EXTENSION "gmc"
#define PLATFORM_SPECIFIC_FOLDER_NAME "platform_specific"
#define ERROR_CODES_FILE_NAME "modules/error_codes"

#define KEY_UNIQUE_ERROR_CODES "unique_error_codes"
#define KEY_MODULE_DEPENDENCIES "module_dependencies"

static struct module* g_modules;
static u32* g_modules_size_cur;
static u32 g_modules_size_max;

struct module* module_compiler__find_module_by_name(struct module* modules, const char* basename, u32 modules_size);
void module_compiler__parse_config_file(
    struct module* self,
    struct file_writer* file_writer,
    struct file_reader* file_reader,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    char* error_codes_buffer,
    char* auxiliary_buffer,
    char* def_file_name_buffer,
    char* config_file_name_buffer,
    u32 def_file_buffer_size,
    u32 error_codes_buffer_size,
    u32 auxiliary_buffer_size,
    u32 def_file_name_buffer_size,
    u32 config_file_name_buffer_size
);

struct module* module_compiler__find_module_by_name(struct module* modules, const char* basename, u32 modules_size) {
    // todo: store modules in a hashmap by their base names
    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        struct module* cur_module = &modules[module_index];
        if (libc__strcmp(cur_module->basename, basename) == 0) {
            return cur_module;
        }
    }
    return NULL;
}

void module_compiler__parse_config_file_recursive_helper(
    struct module* self,
    struct file_writer* file_writer,
    struct file_reader* file_reader,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    char* error_codes_buffer,
    char* auxiliary_buffer,
    char* def_file_name_buffer,
    char* config_file_name_buffer,
    u32 def_file_buffer_size,
    u32 error_codes_buffer_size,
    u32 auxiliary_buffer_size,
    u32 def_file_name_buffer_size,
    u32 config_file_name_buffer_size
) {
    struct module* cur_child = self->first_child;
    while (cur_child) {
        module_compiler__parse_config_file(
            cur_child,
            file_writer,
            file_reader,
            error_codes_file,
            string_replacer,
            def_file_buffer,
            error_codes_buffer,
            auxiliary_buffer,
            def_file_name_buffer,
            config_file_name_buffer,
            def_file_buffer_size,
            error_codes_buffer_size,
            auxiliary_buffer_size,
            def_file_name_buffer_size,
            config_file_name_buffer_size
        );
        module_compiler__parse_config_file_recursive_helper(
            cur_child,
            file_writer,
            file_reader,
            error_codes_file,
            string_replacer,
            def_file_buffer,
            error_codes_buffer,
            auxiliary_buffer,
            def_file_name_buffer,
            config_file_name_buffer,
            def_file_buffer_size,
            error_codes_buffer_size,
            auxiliary_buffer_size,
            def_file_name_buffer_size,
            config_file_name_buffer_size
        );
        cur_child = cur_child->next_sibling;
    }
}

void module_compiler__parse_config_file_recursive(struct module* self) {
    struct file error_codes_file;
    struct file_writer file_writer;
    struct file_reader file_reader;
    struct string_replacer string_replacer;
    TEST_FRAMEWORK_ASSERT(file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    u32 max_number_of_replacements_in_def_files = 16;
    u32 average_size_of_replacement_in_bytes = 256;
    u32 max_module_defs_file_size_in_bytes = max_number_of_replacements_in_def_files * average_size_of_replacement_in_bytes;
    file_writer__create(&file_writer);
    file_reader__create(&file_reader, NULL);
    TEST_FRAMEWORK_ASSERT(
        string_replacer__create(
            &string_replacer,
            "",
            0,
            max_number_of_replacements_in_def_files,
            max_module_defs_file_size_in_bytes
        ) == true
    );

    u32 def_file_buffer_size = 16384;
    u32 error_codes_buffer_size = 2048;
    u32 auxiliary_buffer_size = 1024;
    u32 def_file_name_buffer_size = 256;
    u32 config_file_name_buffer_size = 256;
    char* def_file_buffer = libc__malloc(def_file_buffer_size);
    char* error_codes_buffer = libc__malloc(error_codes_buffer_size);
    char* auxiliary_buffer = libc__malloc(auxiliary_buffer_size);
    char* def_file_name_buffer = libc__malloc(def_file_name_buffer_size);
    char* config_file_name_buffer = libc__malloc(config_file_name_buffer_size);
    module_compiler__parse_config_file(
        self,
        &file_writer,
        &file_reader,
        &error_codes_file,
        &string_replacer,
        def_file_buffer,
        error_codes_buffer,
        auxiliary_buffer,
        def_file_name_buffer,
        config_file_name_buffer,
        def_file_buffer_size,
        error_codes_buffer_size,
        auxiliary_buffer_size,
        def_file_name_buffer_size,
        config_file_name_buffer_size
    );
    module_compiler__parse_config_file_recursive_helper(
        self,
        &file_writer,
        &file_reader,
        &error_codes_file,
        &string_replacer,
        def_file_buffer,
        error_codes_buffer,
        auxiliary_buffer,
        def_file_name_buffer,
        config_file_name_buffer,
        def_file_buffer_size,
        error_codes_buffer_size,
        auxiliary_buffer_size,
        def_file_name_buffer_size,
        config_file_name_buffer_size
    );

    string_replacer__destroy(&string_replacer);
    file_writer__destroy(&file_writer);
    file_reader__destroy(&file_reader);
    file__close(&error_codes_file);
    libc__free(def_file_buffer);
    libc__free(error_codes_buffer);
    libc__free(auxiliary_buffer);
    libc__free(def_file_name_buffer);
    libc__free(config_file_name_buffer);
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
        struct module* found_module = module_compiler__find_module_by_name(g_modules, buffer, *g_modules_size_cur);
        if (found_module == NULL) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_NOT_FOUND);
        }
        module_compiler__add_dependency(self, found_module);
    } while (1);
}

static void def_file_add_error_codes_place_holder__create(
    struct module* self,
    struct file* def_file,
    struct string_replacer* string_replacer,
    char* def_file_name_buffer,
    char* def_file_buffer,
    char* module_name_capitalized,
    u32 def_file_buffer_size
) {
    // todo: optimally, I'd like to parse these out from def_file_template_h
    static const char module_error_codes_enum[] = "${module_error_codes}";
    static const char module_error_code_enum_start[] = "${module_error_code_start}";
    static const char module_defs_h[] = "${module_defs_h}";
    static const char parent_module_name_defs[] = "${parent_module_name_defs}";
    static const u32 module_error_codes_enum_len = ARRAY_SIZE(module_error_codes_enum) - 1;
    static const u32 module_error_code_enum_start_len = ARRAY_SIZE(module_error_code_enum_start) - 1;
    static const u32 module_defs_h_len = ARRAY_SIZE(module_defs_h) - 1;
    static const u32 parent_module_name_defs_len = ARRAY_SIZE(parent_module_name_defs) - 1;

    TEST_FRAMEWORK_ASSERT(file__open(def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE));
    // todo: start filling in from the template
    struct file def_file_template;
    static const char* def_file_template_path = "misc/def_file_template.h";
    TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, def_file_template_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    u32 def_file_template_size = file__read(&def_file_template, def_file_buffer, def_file_buffer_size);
    if (def_file_template_size == def_file_buffer_size) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }
    string_replacer__clear(string_replacer, def_file_buffer, def_file_template_size);
    u32 number_of_what_replacements = 2;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        module_defs_h, module_defs_h_len,
        "%s_DEFS_H", module_name_capitalized
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        parent_module_name_defs, parent_module_name_defs_len,
        self->parent == NULL ? "\"%s\"" : "\"../%s_defs.h\"",
        self->parent == NULL ? "defs.h" : self->parent->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        module_error_codes_enum, module_error_codes_enum_len,
        "%s", self->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        module_error_code_enum_start, module_error_code_enum_start_len,
        "%s", module_name_capitalized
    );

    string_replacer__read_into_file(
        string_replacer,
        def_file,
        0
    );
    file__close(def_file);
}

static void def_file_add_error_codes_place_holder__update(
    struct module* self,
    struct file* def_file,
    struct file_reader* file_reader,
    struct string_replacer* string_replacer,
    char* def_file_name_buffer,
    char* auxiliary_buffer,
    char* def_file_buffer,
    char* module_name_capitalized,
    const char* rest_of_the_error_codes,
    u32 auxiliary_buffer_size,
    u32 def_file_buffer_size
) {
    TEST_FRAMEWORK_ASSERT(file__open(def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    u32 def_file_size = file__read(def_file, def_file_buffer, def_file_buffer_size);
    if (def_file_size == def_file_buffer_size) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }
    string_replacer__clear(string_replacer, def_file_buffer, def_file_size);
    TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0) == 0);
    file_reader__clear(file_reader, def_file);
    u32 what_position;
    char buffer[128];
    u32 bytes_written = libc__snprintf(
        buffer,
        ARRAY_SIZE(buffer),
        "enum %s_error_code {",
        self->basename
    );
    if (bytes_written >= ARRAY_SIZE(buffer)) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }
    bool does_enum_error_codes_exit = file_reader__read_while_not_word(
        file_reader,
        auxiliary_buffer,
        auxiliary_buffer_size,
        buffer,
        bytes_written,
        &what_position
    );
    if (what_position >= auxiliary_buffer_size) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }
    if (does_enum_error_codes_exit) {
        u32 what_size = file_reader__read_while_not(file_reader, NULL, 0, "}");
        string_replacer__replace_at_position_f(
            string_replacer,
            what_position,
            what_size,
            "\n"
            "    %s_ERROR_CODE_START,\n"
            "%s",
            module_name_capitalized,
            rest_of_the_error_codes
        );
    } else {
        bytes_written = libc__snprintf(
            buffer,
            ARRAY_SIZE(buffer),
            self->parent == NULL ? "\"%s\"" : "\"../%s_defs.h\"",
            self->parent == NULL ? "defs.h" : self->parent->basename
        );
        if (bytes_written >= ARRAY_SIZE(buffer)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0) == 0);
        file_reader__clear(file_reader, def_file);
        TEST_FRAMEWORK_ASSERT(
            file_reader__read_while_not_word(
                file_reader,
                auxiliary_buffer,
                auxiliary_buffer_size,
                buffer,
                bytes_written,
                &what_position
            ) == true
        );
        string_replacer__replace_at_position_f(
            string_replacer,
            what_position,
            0,
            "\n\nenum %s_error_code {\n"
            "    %s_ERROR_CODE_START,\n"
            "%s"
            "};\n",
            self->basename,
            module_name_capitalized,
            rest_of_the_error_codes
        );
    }
    file__close(def_file);
    TEST_FRAMEWORK_ASSERT(file__open(def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(
        string_replacer,
        def_file,
        0
    );
    file__close(def_file);
}

static void def_file_replace_error_codes_place_holder_and_append_error_codes_file(
    struct module* self,
    struct string_replacer* string_replacer,
    struct file_reader* file_reader,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    struct file* def_file,
    char* def_file_buffer,
    char* def_file_name_buffer,
    char* config_file_name_buffer,
    char* auxiliary_buffer,
    char* error_codes_buffer,
    char* module_name_capitalized,
    const char* rest_of_the_error_codes,
    u32 def_file_size,
    u32 config_file_name_buffer_size,
    u32 auxiliary_buffer_size,
    u32 error_codes_buffer_size,
    u32 rest_of_the_error_codes_len
) {
    string_replacer__clear(string_replacer, def_file_buffer, def_file_size);
    struct file config_file;
    u32 bytes_written = libc__snprintf(
        config_file_name_buffer,
        config_file_name_buffer_size,
        "%s/%s.%s",
        self->dirprefix, self->basename, CONFIG_EXTENSION
    );
    if (bytes_written >= config_file_name_buffer_size) {
        // error_code__exit(CONFIG_FILE_NAME_BUFFER_TOO_SMALL);
        error_code__exit(867);
    }
    if (file__exists(config_file_name_buffer)) {
        TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
        file_reader__clear(file_reader, &config_file);
        bool parsed_unique_error_codes = false;
        bool parsed_module_dependencies = false;
        bool parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        while (parsed_everything == false) {
            parse_config_file_directive(file_reader, auxiliary_buffer, auxiliary_buffer_size);

            if (libc__strcmp(auxiliary_buffer, KEY_UNIQUE_ERROR_CODES) == 0) {
                parse_config_file_unique_error_codes(
                    file_reader,
                    file_writer,
                    error_codes_file,
                    module_name_capitalized,
                    auxiliary_buffer,
                    auxiliary_buffer_size,
                    error_codes_buffer,
                    error_codes_buffer_size
                );
                parsed_unique_error_codes = true;
                u32 number_of_what_replacements = 1;
                string_replacer__replace_word_f(
                    string_replacer,
                    number_of_what_replacements,
                    rest_of_the_error_codes, rest_of_the_error_codes_len,
                    "%s", error_codes_buffer
                );
            } else if (libc__strcmp(auxiliary_buffer, KEY_MODULE_DEPENDENCIES) == 0) {
                parse_config_file_dependencies(
                    self,
                    file_reader,
                    auxiliary_buffer,
                    auxiliary_buffer_size
                );
                parsed_module_dependencies = true;
            } else {
                printf("[%s]\n", auxiliary_buffer);
                error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_UNKNOWN);
            }
            parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        }
        file__close(&config_file);
    } else {
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word_f(
            string_replacer,
            number_of_what_replacements,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            ""
        );

        static const char* config_file_template_path = "misc/gmc_file_template.txt";
        file__copy(config_file_name_buffer, config_file_template_path);

        for (u32 dep_index = 0; dep_index < ARRAY_SIZE(self->dependencies); ++dep_index) {
            self->dependencies[dep_index] = NULL;
        }
    }
    TEST_FRAMEWORK_ASSERT(file__open(def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(
        string_replacer,
        def_file,
        0
    );
    file__close(def_file);
}

void module_compiler__parse_config_file(
    struct module* self,
    struct file_writer* file_writer,
    struct file_reader* file_reader,
    struct file* error_codes_file,
    struct string_replacer* string_replacer,
    char* def_file_buffer,
    char* error_codes_buffer,
    char* auxiliary_buffer,
    char* def_file_name_buffer,
    char* config_file_name_buffer,
    u32 def_file_buffer_size,
    u32 error_codes_buffer_size,
    u32 auxiliary_buffer_size,
    u32 def_file_name_buffer_size,
    u32 config_file_name_buffer_size
) {
    // todo: optimally, I'd like to parse these out from def_file_template_h
    static const char rest_of_the_error_codes[] = "${rest_of_the_error_codes}";
    static const u32 rest_of_the_error_codes_len = ARRAY_SIZE(rest_of_the_error_codes) - 1;

    char module_name_capitalized[64];
    if (
        (u32) libc__snprintf(
            module_name_capitalized,
            ARRAY_SIZE(module_name_capitalized),
            "%s",
            self->basename
        ) >= ARRAY_SIZE(module_name_capitalized)
    ) {
        error_code__exit(990);
    }
    string__to_upper(module_name_capitalized);

    u32 bytes_written = libc__snprintf(def_file_name_buffer, def_file_name_buffer_size, "%s/%s_defs.h", self->dirprefix, self->basename);
    if (bytes_written >= def_file_name_buffer_size) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }
    struct file def_file;

    // note: string_replacer doesn't support replacing replacements, so I do this in two write steps if the def_file doesn't exist
    // first, I replace the template, then write it out to the def file
    // second, read from the now existing def file and replace its contents
    if (file__exists(def_file_name_buffer) == false) {
        def_file_add_error_codes_place_holder__create(
            self,
            &def_file,
            string_replacer,
            def_file_name_buffer,
            def_file_buffer,
            module_name_capitalized,
            def_file_buffer_size
        );
    } else {
        def_file_add_error_codes_place_holder__update(
            self,
            &def_file,
            file_reader,
            string_replacer,
            def_file_name_buffer,
            auxiliary_buffer,
            def_file_buffer,
            module_name_capitalized,
            rest_of_the_error_codes,
            auxiliary_buffer_size,
            def_file_buffer_size
        );
    }

    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    u32 def_file_size = file__read(&def_file, def_file_buffer, def_file_buffer_size);
    file__close(&def_file);
    if (def_file_size == def_file_buffer_size) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }

    def_file_replace_error_codes_place_holder_and_append_error_codes_file(
        self,
        string_replacer,
        file_reader,
        file_writer,
        error_codes_file,
        &def_file,
        def_file_buffer,
        def_file_name_buffer,
        config_file_name_buffer,
        auxiliary_buffer,
        error_codes_buffer,
        module_name_capitalized,
        rest_of_the_error_codes,
        def_file_size,
        config_file_name_buffer_size,
        auxiliary_buffer_size,
        error_codes_buffer_size,
        rest_of_the_error_codes_len
    );

    // todo: implement
//     // platform-specific part
// #if defined(WINDOWS)
//     static const char* platform = "windows";
// #elif defined(LINUX)
//     static const char* platform = "linux";
// #elif defined(MAC)
//     static const char* platform = "mac";
// #endif
//     if (
//         (u32) libc__snprintf(
//             module_name_capitalized,
//             ARRAY_SIZE(module_name_capitalized),
//             "%s",
//             self->basename
//         ) >= ARRAY_SIZE(module_name_capitalized)
//     ) {
//         error_code__exit(990);
//     }
//     string__to_upper(module_name_capitalized);
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
    static char parent_basename[512];
    u32 bytes_to_write = last_backslash - second_last_backslash + 1;
    TEST_FRAMEWORK_ASSERT(bytes_to_write < ARRAY_SIZE(parent_basename));
    libc__snprintf(
        parent_basename,
        bytes_to_write,
        "%s",
        second_last_backslash
    );
    struct module* parent = module_compiler__find_module_by_name(g_modules, parent_basename, *g_modules_size_cur);
    TEST_FRAMEWORK_ASSERT(parent != NULL);
    module_compiler__add_child(g_modules, parent, basename, g_modules_size_cur, g_modules_size_max);

    return true;
}

void module_compiler__explore_children(struct module* self) {
    struct directory dir;

    TEST_FRAMEWORK_ASSERT(directory__open(&dir, self->dirprefix) == true);
    directory__foreach_deep(self->dirprefix, &is_module_path, FILE_TYPE_DIRECTORY);
}

static u32 module_compiler__get_dependencies(
    struct module* self,
    char** dependency_buffer,
    u32 dependency_buffer_size
) {
    self->transient_flag_for_processing = 1;
    for (u32 dependency_index = 0; dependency_index < ARRAY_SIZE_MEMBER(struct module, dependencies); ++dependency_index) {
        if (self->dependencies[dependency_index] != NULL && self->dependencies[dependency_index]->transient_flag_for_processing == 0) {
            u32 bytes_written = libc__snprintf(
                *dependency_buffer,
                dependency_buffer_size,
                "%s ",
                self->dependencies[dependency_index]->basename
            );

            if (bytes_written >= dependency_buffer_size) {
                // error_code__exit(DEPENDENCIES_BUFFER_TOO_SMALL)
                error_code__exit(2714);
            }

            *dependency_buffer += bytes_written;
            dependency_buffer_size -= bytes_written;
            dependency_buffer_size = module_compiler__get_dependencies(
                self->dependencies[dependency_index],
                dependency_buffer,
                dependency_buffer_size
            );
        }
    }

    return dependency_buffer_size;
}

void module_compiler__embed_dependencies_into_makefile(
    struct module* modules,
    char* file_path_buffer,
    char* file_buffer,
    char* dependencies_buffer,
    struct string_replacer* string_replacer,
    u32 modules_size,
    u32 file_path_buffer_size,
    u32 file_buffer_size,
    u32 dependencies_buffer_size
) {
    static const char modules_makefile_template_path[] = "misc/module_template.txt";
    struct file modules_makefile_template_file;
    TEST_FRAMEWORK_ASSERT(file__open(&modules_makefile_template_file, modules_makefile_template_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    u32 modules_makefile_template_file_size = file__read(&modules_makefile_template_file, file_buffer, file_buffer_size);
    if (modules_makefile_template_file_size == file_buffer_size) {
        // error_code__exit(FILE_BUFFER_TOO_SMALL);
        error_code__exit(43825);
    }
    file__close(&modules_makefile_template_file);

    /*
    $(MODULE_NAME) <- replace with basename
    $(LFLAGS_SPECIFIC) <- replace with:
        console_application = '-mconsole' // for now, todo: add this to .gmc file as a config option
        window_application = '-mwindows'
    */

    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        struct module* cur_module = &modules[module_index];

        module_compiler__clear_transient_flags(g_modules, *g_modules_size_cur);
        char* cur_dependency_buffer = dependencies_buffer;
        u32 dependencies_buffer_size_left = module_compiler__get_dependencies(cur_module, &cur_dependency_buffer, dependencies_buffer_size);

        static const char module_dependency_replace_what[] = "$(MODULE_LIBDEP_MODULES)";
        static const char module_name_replace_what[] = "$(MODULE_NAME)";
        static const char module_lflags_specific_replace_what[] = "$(LFLAGS_SPECIFIC)";
        // todo: add type of application (console/windows) to .gmc file
        static const char module_lflags_specific_replace_with[] = "-mconsole";
        static const u32 module_dependency_replace_what_len = ARRAY_SIZE(module_dependency_replace_what) - 1;
        static const u32 module_name_replace_what_len = ARRAY_SIZE(module_name_replace_what) - 1;
        static const u32 module_lflags_specific_replace_what_len = ARRAY_SIZE(module_lflags_specific_replace_what) - 1;
        static const u32 module_lflags_specific_replace_with_len = ARRAY_SIZE(module_lflags_specific_replace_with) - 1;

        string_replacer__clear(string_replacer, file_buffer, modules_makefile_template_file_size);
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word(
            string_replacer,
            number_of_what_replacements,
            module_dependency_replace_what,
            module_dependency_replace_what_len,
            dependencies_buffer,
            dependencies_buffer_size - dependencies_buffer_size_left
        );

        number_of_what_replacements = (u32) -1;
        string_replacer__replace_word(
            string_replacer,
            number_of_what_replacements,
            module_name_replace_what,
            module_name_replace_what_len,
            cur_module->basename,
            libc__strlen(cur_module->basename)
        );

        number_of_what_replacements = 1;
        u32 new_makefile_size = string_replacer__replace_word(
            string_replacer,
            number_of_what_replacements,
            module_lflags_specific_replace_what,
            module_lflags_specific_replace_what_len,
            module_lflags_specific_replace_with,
            module_lflags_specific_replace_with_len
        );

        libc__snprintf(
            file_path_buffer,
            file_path_buffer_size,
            "%s/%s.mk",
            cur_module->dirprefix, cur_module->basename
        );
        struct file makefile;
        TEST_FRAMEWORK_ASSERT(file__open(&makefile, file_path_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        // replace  with dependency->basename in makefile
        TEST_FRAMEWORK_ASSERT(
            string_replacer__read_into_file(
                string_replacer,
                &makefile,
                0
            ) == new_makefile_size
        );
        file__close(&makefile);
    }
}

void module_compiler__create_test_directories(
    char* file_path_buffer,
    char* file_buffer,
    struct string_replacer* string_replacer,
    struct module* modules,
    u32 modules_size,
    u32 file_path_buffer_size,
    u32 file_buffer_size
) {
    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        struct module* cur_module = &modules[module_index];
        u32 written_bytes = libc__snprintf(
            file_buffer,
            file_buffer_size,
            "%s",
            cur_module->dirprefix
        );
        if (written_bytes >= file_path_buffer_size) {
            // error_code__exit(FILE_BUFFER_TOO_SMALL);
            error_code__exit(4723);
        }
        static const char modules_directory_name[] = "modules";
        static const char tests_directory_name[] = "tests";
        static const u32 modules_directory_name_size = ARRAY_SIZE(modules_directory_name) - 1;
        static const u32 tests_directory_name_size = ARRAY_SIZE(tests_directory_name) - 1;
        string_replacer__clear(string_replacer, file_buffer, written_bytes + 1);
        u32 number_of_what_replacements = 1;
        u32 bytes_to_write = string_replacer__replace_word(
            string_replacer,
            number_of_what_replacements,
            modules_directory_name,
            modules_directory_name_size,
            tests_directory_name,
            tests_directory_name_size
        );
        written_bytes = string_replacer__read(
            string_replacer,
            file_path_buffer,
            file_path_buffer_size,
            0
        );
        if (written_bytes < bytes_to_write) {
            // error_code__exit(FILE_PATH_BUFFER_TOO_SMALL);
            error_code__exit(4383);
        }

        if (directory__create(file_path_buffer) == true) {
            printf("Test directory created: %s\n", file_path_buffer);
        }
    }
}

void module_compiler__compile(void) {
    u32 max_number_of_modules = 256;
    g_modules_size_max = 256;
    u32 cur_number_of_modules = 0;
    g_modules_size_cur = &cur_number_of_modules;
    struct module* modules = libc__calloc(max_number_of_modules * sizeof(*modules));
    g_modules = modules;
    static const u32 file_path_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) + ARRAY_SIZE_MEMBER(struct module, dirprefix);
    char file_path_buffer[file_path_buffer_size];
    u32 total_number_of_replacements = 256;
    u32 average_replacement_size = 64;
    struct string_replacer string_replacer;
    string_replacer__create(
        &string_replacer,
        NULL,
        0,
        total_number_of_replacements,
        average_replacement_size * total_number_of_replacements
    );
    u32 file_buffer_size = 32768;
    char* file_buffer = libc__malloc(file_buffer_size);
    u32 dependencies_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) * g_modules_size_max / 2;
    char* dependencies_buffer = libc__malloc(dependencies_buffer_size);

    struct module* parent_module = &modules[cur_number_of_modules++];
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));


    module_compiler__explore_children(parent_module);

    module_compiler__parse_config_file_recursive(parent_module);

    module_compiler__create_test_directories(
        file_path_buffer,
        file_buffer,
        &string_replacer,
        modules,
        cur_number_of_modules,
        file_path_buffer_size,
        file_buffer_size
    );

    module_compiler__check_cyclic_dependency(parent_module, modules, cur_number_of_modules);

    module_compiler__embed_dependencies_into_makefile(
        modules,
        file_path_buffer,
        file_buffer,
        dependencies_buffer,
        &string_replacer,
        cur_number_of_modules,
        file_path_buffer_size,
        file_buffer_size,
        dependencies_buffer_size
    );

    // module_compiler__print_branch(parent_module, modules, cur_number_of_modules);


    string_replacer__destroy(&string_replacer);
    libc__free(modules);
    libc__free(file_buffer);
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
