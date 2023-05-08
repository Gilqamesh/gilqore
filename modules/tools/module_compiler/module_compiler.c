#include "module_compiler.h"
#include "module_compiler_utils.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "libc/libc.h"
#include "system/process/process.h"
#include "time/time.h"
#include "types/string/string.h"
#include "io/directory/directory.h"
#include "math/compare/compare.h"

#include <stdio.h>

#define CONFIG_EXTENSION "gmc"
#define PLATFORM_SPECIFIC_FOLDER_NAME "platform_specific"
#define ERROR_CODES_FILE_NAME "modules/error_codes"

#define KEY_UNIQUE_ERROR_CODES "unique_error_codes"
#define KEY_MODULE_DEPENDENCIES "module_dependencies"

extern struct module g_modules[1024];
extern u32 g_modules_size;
extern u32 g_error_code;

void module_compiler__parse_config_file(struct module* self, struct file* error_codes_file);
struct module* module_compiler__find_module_by_name(const char* basename);

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

void module_compiler__parse_config_file_recursive_helper(struct module* self, struct file* error_codes_file) {
    struct module* cur_child = self->first_child;
    while (cur_child) {
        module_compiler__parse_config_file(cur_child, error_codes_file);
        module_compiler__parse_config_file_recursive_helper(cur_child, error_codes_file);
        cur_child = cur_child->next_sibling;
    }
}

void module_compiler__parse_config_file_recursive(struct module* self) {
    struct file error_codes_file;
    ASSERT(file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));

    module_compiler__parse_config_file(self, &error_codes_file);
    module_compiler__parse_config_file_recursive_helper(self, &error_codes_file);

    file__close(&error_codes_file);
}

void module_compiler__parse_config_file(struct module* self, struct file* error_codes_file) {
    char buffer[1024];
    char buffer2[512];
    char error_code_prefix[128];
    libc__snprintf(error_code_prefix, ARRAY_SIZE(error_code_prefix), "    %s_ERROR_CODE_", self->basename);
    string__to_upper(error_code_prefix);
    u32 error_code_prefix_len = libc__strlen(error_code_prefix);

    struct file config_file;
    char config_file_name[512];
    libc__snprintf(config_file_name, ARRAY_SIZE(config_file_name), "%s/%s.%s", self->dirprefix, self->basename, CONFIG_EXTENSION);

    char def_file_name[512];
    libc__snprintf(def_file_name, ARRAY_SIZE(def_file_name), "%s/%s_defs.h", self->dirprefix, self->basename);
    struct file def_file;

    struct file def_file_template;
    ASSERT(file__open(&def_file_template, "misc/def_file_template.h", FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));

    ASSERT(file__open(&def_file, def_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE));
    // todo: start filling in from the template
    libc__snprintf(buffer2, ARRAY_SIZE(buffer2), "%s", self->basename);
    string__to_upper(buffer2);

    u64 bytes_to_write = libc__snprintf(
        buffer,
        ARRAY_SIZE(buffer),
        "#ifndef %s_DEFS_H\n"
        "# define %s_DEFS_H\n",
        buffer2,
        buffer2
    );
    ASSERT(bytes_to_write < ARRAY_SIZE(buffer));
    ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);
    if (self->parent != NULL) {
        bytes_to_write = libc__snprintf(
            buffer,
            ARRAY_SIZE(buffer),
            "\n"
            "# include \"../%s_defs.h\"\n",
            self->parent->basename
        );
        ASSERT(bytes_to_write < ARRAY_SIZE(buffer));
        ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);
    } else {
        bytes_to_write = libc__snprintf(
            buffer,
            ARRAY_SIZE(buffer),
            "\n"
            "# include \"defs.h\"\n"
        );
        ASSERT(bytes_to_write < ARRAY_SIZE(buffer));
        ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);
    }
    bytes_to_write = libc__snprintf(
        buffer,
        ARRAY_SIZE(buffer),
        "\n"
        "enum %s_error_code {\n"
        "%sSTART,\n",
        self->basename,
        error_code_prefix
    );
    ASSERT(bytes_to_write < ARRAY_SIZE(buffer));
    ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);

    if (file__exists(config_file_name)) {
        ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
        struct file_reader config_file_reader;
        ASSERT(file_reader__create(&config_file_reader, &config_file) == true);
        bool parsed_unique_error_codes = false;
        bool parsed_module_dependencies = false;
        bool parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        while (parsed_everything == false) {
            u32 read_bytes = file_reader__read_while_not(&config_file_reader, buffer, ARRAY_SIZE(buffer), ":");
            if (read_bytes + 1 >= ARRAY_SIZE(buffer)) {
                // error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_TOO_LONG);
            }
            buffer[read_bytes] = '\0';
            ASSERT(file_reader__read_one(&config_file_reader, NULL, sizeof(char)) == 1);
            if (libc__strcmp(buffer, KEY_UNIQUE_ERROR_CODES) == 0) {
                parsed_unique_error_codes = true;
                // note: read key-value pairs of unique error code
                do {
                    file_reader__read_while(&config_file_reader, buffer, ARRAY_SIZE(buffer), " [\r\n");
                    read_bytes = file_reader__read_while_not(&config_file_reader, buffer, ARRAY_SIZE(buffer), ":]");
                    if (file_reader__peek(&config_file_reader) == ']') {
                        // note: done reading unique_error_codes entry
                        file_reader__read_while_not(&config_file_reader, NULL, 0, "\r\n");
                        file_reader__read_while(&config_file_reader, NULL, 0, "\r\n");
                        break ;
                    }
                    if (read_bytes + 1 >= ARRAY_SIZE(buffer)) {
                        // error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_KEY_TOO_LONG);
                    }
                    buffer[read_bytes] = '\0';
                    u32 error_code = module_compiler__get_error_code();
                    libc__itoa(error_code, buffer2, 10);
                    bytes_to_write = libc__strlen(buffer2);
                    ASSERT(file__write(error_codes_file, buffer2, bytes_to_write) == bytes_to_write);
                    ASSERT(file__write(error_codes_file, " ", 1) == 1);
                    ASSERT(file__write(error_codes_file, buffer, read_bytes) == read_bytes);
                    ASSERT(file__write(error_codes_file, " \"", 2) == 2);
                    ASSERT(file__write(&def_file, error_code_prefix, error_code_prefix_len) == error_code_prefix_len);
                    ASSERT(file__write(&def_file, buffer, read_bytes) == read_bytes);
                    u32 bytes_to_write = libc__snprintf(buffer, ARRAY_SIZE(buffer), " = %u,\n", error_code);
                    ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);
                    file_reader__read_while(&config_file_reader, NULL, 0, ": ");
                    read_bytes = file_reader__read_while_not(&config_file_reader, buffer, ARRAY_SIZE(buffer), "\r\n");
                    if (read_bytes + 1 >= ARRAY_SIZE(buffer)) {
                        // error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_VALUE_TOO_LONG);
                    }
                    buffer[read_bytes] = '\0';
                    ASSERT(file__write(error_codes_file, buffer, read_bytes) == read_bytes);
                    ASSERT(file__write(error_codes_file, "\"\r\n", 2) == 2);
                    file_reader__read_while(&config_file_reader, NULL, 0, "\r\n");
                } while (1);
            } else if (libc__strcmp(buffer, KEY_MODULE_DEPENDENCIES) == 0) {
                parsed_module_dependencies = true;
                // note: read module dependencies
                do {
                    file_reader__read_while(&config_file_reader, buffer, ARRAY_SIZE(buffer), " ");
                    read_bytes = file_reader__read_while_not(&config_file_reader, buffer, ARRAY_SIZE(buffer), " \r\n");
                    if (read_bytes == 0) {
                        // note: done reading module dependencies
                        file_reader__read_while(&config_file_reader, NULL, 0, "\r\n");
                        break ;
                    }
                    if (read_bytes + 1 >= ARRAY_SIZE(buffer)) {
                        // error_code__exit(DEPENDENCY_MODULE_TOO_LONG);
                    }
                    buffer[read_bytes] = '\0';
                    // note: add the dependency to the module
                    struct module* found_module = module_compiler__find_module_by_name(buffer);
                    if (found_module == NULL) {
                        // error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_MODULE_DEPENDENCY_NOT_FOUND);
                    }
                    module_compiler__add_dependency(self, found_module);
                } while (1);
            } else {
                printf("[%s]\n", buffer);
                // error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_UNKNOWN);
            }
            parsed_everything = parsed_module_dependencies && parsed_unique_error_codes;
        }
        file__close(&config_file);
        file_reader__destroy(&config_file_reader);
    } else {
        ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        for (u32 dep_index = 0; dep_index < ARRAY_SIZE(self->dependencies); ++dep_index) {
            self->dependencies[dep_index] = NULL;
        }
        u32 bytes_to_write = libc__strlen(KEY_UNIQUE_ERROR_CODES);
        ASSERT(file__write(&config_file, KEY_UNIQUE_ERROR_CODES, bytes_to_write) == bytes_to_write);
        const char* empty_bracketed_list_msg = ": [\n]\n";
        bytes_to_write = libc__strlen(empty_bracketed_list_msg);
        ASSERT(file__write(&config_file, empty_bracketed_list_msg, bytes_to_write) == bytes_to_write);
        bytes_to_write = libc__strlen(KEY_MODULE_DEPENDENCIES);
        ASSERT(file__write(&config_file, KEY_MODULE_DEPENDENCIES, bytes_to_write) == bytes_to_write);
        ASSERT(file__write(&config_file, ": \n", 3) == 3);
        file__close(&config_file);
    }

    bytes_to_write = libc__snprintf(
        buffer,
        ARRAY_SIZE(buffer),
        "};\n"
        "\n"
        "#endif\n"
    );
    ASSERT(file__write(&def_file, buffer, bytes_to_write) == bytes_to_write);

    file__close(&def_file_template);
    file__close(&def_file);
}

bool pr_dir_name(const char* path) {
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
    ASSERT(bytes_to_write < ARRAY_SIZE(parent_basename));
    libc__snprintf(
        parent_basename,
        bytes_to_write,
        "%s",
        second_last_backslash
    );
    struct module* parent = module_compiler__find_module_by_name(parent_basename);
    ASSERT(parent != NULL);
    module_compiler__add_child(parent, basename);

    return true;
}

void module_compier__explore_children(struct module* self) {
    struct directory dir;

    ASSERT(directory__open(&dir, self->dirprefix) == true);
    directory__foreach_deep(self->dirprefix, &pr_dir_name, FILE_TYPE_DIRECTORY);
}

void module_compiler__compile(void) {
    struct module* parent_module = &g_modules[g_modules_size++];
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compier__explore_children(parent_module);

    module_compiler__parse_config_file_recursive(parent_module);

    module_compiler__check_cyclic_dependency();

    module_compiler__print_branch(parent_module);
}

void module_compiler__translate_error_code(u32 error_code, char* buffer, u32 buffer_size) {
    char line_buffer[512];
    char enum_buffer[512];
    char message_buffer[512];
    char format_string_buffer[128];
    if (libc__snprintf(
        format_string_buffer,
        ARRAY_SIZE(format_string_buffer),
        "%%u %%%ds \"%%%d[^\"]\"",
        ARRAY_SIZE(enum_buffer) - 1,
        ARRAY_SIZE(message_buffer) - 1
    ) == ARRAY_SIZE(format_string_buffer)) {
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
        if (libc__vsscanf(
            line_buffer,
            format_string_buffer,
            &parsed_error_code,
            enum_buffer,
            message_buffer
        ) != 3) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_VSSCANF_FAILED_TO_PARSE_LINE_ERROR_CODES);
        }
        if (parsed_error_code == error_code) {
            if (libc__snprintf(buffer, buffer_size, "%s", message_buffer) == (s32) buffer_size) {
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
