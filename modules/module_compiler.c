#include "test_framework/test_framework.h"

#include "module_compiler.h"
#include "module_compiler_utils.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "io/file/file_path/file_path.h"
#include "libc/libc.h"
#include "types/string/string.h"
#include "io/directory/directory.h"
#include "types/string/string_replacer/string_replacer.h"
#include "common/error_code.h"
#include "time/time.h"

#include <stdio.h>

#define CONFIG_EXTENSION "gmc"
#define PLATFORM_SPECIFIC_FOLDER_NAME "platform_specific"
#define TEST_FOLDER_NAME "test"
#define ERROR_CODES_FILE_NAME "modules/error_codes"
// todo(david) remove and make file__create to just create a file "without opening it"
#define GITKEEP_PATH "misc/.gitkeep"
#define CONFIG_FILE_TEMPLATE_PATH "misc/gmc_file_template.txt"
#define PLATFORM_SPECIFIC_CONFIG_FILE_TEMPLATE_PATH "misc/platform_specific_gmc_file_template.txt"
#define MODULES_TEMPLATE_PATH "misc/module_template.txt"
#define TESTS_TEMPLATE_PATH "misc/tests_template.txt"
#define DEF_FILE_TEMPLATE_PATH "misc/def_file_template.h"

#define PLATFORM_SPECIFIC_WINDOWS "windows"
#define PLATFORM_SPECIFIC_CAPITALIZED_WINDOWS "WINDOWS"
#define PLATFORM_SPECIFIC_LINUX "linux"
#define PLATFORM_SPECIFIC_CAPITALIZED_LINUX "LINUX"
#define PLATFORM_SPECIFIC_MAC "mac"
#define PLATFORM_SPECIFIC_CAPITALIZED_MAC "MAC"

#define KEY_UNIQUE_ERROR_CODES "unique_error_codes"
#define KEY_MODULE_DEPENDENCIES "module_dependencies"
#define KEY_PLATFORM_SPECIFIC_MODULE_DEPENDENCIES "platform_specific_module_dependencies"
#define KEY_TEST_DEPENDENCIES "test_dependencies"
#define KEY_APPLICATION_TYPE "application_type"

#define VALUE_APPLICATION_TYPE_CONSOLE "CONSOLE"
#define VALUE_APPLICATION_TYPE_WINDOWS "WINDOWS"
#define VALUE_APPLICATION_TYPE_DEFAULT VALUE_APPLICATION_TYPE_CONSOLE

#define MODULES_PATH "modules"

#define COMMON_TEST_DEPENDENCY_MODULE "test_framework"

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
        struct module* cur_module = modules + module_index;
        if (libc__strcmp(cur_module->basename, basename) == 0) {
            return cur_module;
        }
    }
    return NULL;
}

void module_compiler__parse_config_files(
    struct module* modules,
    u32 modules_size
) {
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

    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        module_compiler__parse_config_file(
            modules + module_index,
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
    }

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

static void parse_key_from_file(
    struct file_reader* file_reader,
    char* key_buffer,
    u32 key_buffer_size
) {
    u32 read_bytes = file_reader__read_while_not(file_reader, key_buffer, key_buffer_size, ":");
    if (read_bytes == key_buffer_size) {
        // error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_TOO_LONG); // todo: remove from .gmc
        // error_code__exit(KEY_BUFFER_TOO_SMALL);
        error_code__exit(32487);
    }
    key_buffer[read_bytes] = '\0';
    file_reader__read_one(file_reader, NULL, 1);
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

static void parse_config_file_dependencies(
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

static const char* dispatch_by_application_type(const char* application_type) {
    const char* result = NULL;

    if (libc__strcmp(application_type, VALUE_APPLICATION_TYPE_CONSOLE) == 0) {
        static const char* app_lflag_console = "-mconsole";
        result = app_lflag_console;
    } else if (libc__strcmp(application_type, VALUE_APPLICATION_TYPE_WINDOWS) == 0) {
        static const char* app_lflag_windows = "-mwindows";
        result = app_lflag_windows;
    } else {
        printf("unknown application type\n");
        TEST_FRAMEWORK_ASSERT(false);
    }

    return result;
}

static void parse_config_file_application_type(
    struct module* self,
    struct file_reader* config_file_reader,
    char* buffer,
    u32 buffer_size
) {
    file_reader__read_while(config_file_reader, NULL, 0, " ");
    u32 read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, " \r\n");
    if (read_bytes == buffer_size) {
        // error_code__exit(BUFFER_SIZE_TOO_SMALL_PARSE_APPLICATION_TYPE);
        error_code__exit(7632);
    }
    buffer[read_bytes] = '\0';
    if (
        libc__strcmp(buffer, VALUE_APPLICATION_TYPE_CONSOLE) == 0 ||
        libc__strcmp(buffer, VALUE_APPLICATION_TYPE_WINDOWS) == 0
    ) {
        const char* application_type = dispatch_by_application_type(buffer);
        libc__memcpy(self->application_type, application_type, libc__strlen(application_type));
    } else {
        printf("Application type parsed from module [%s] is not supported: %s\n", self->basename, buffer);
        printf("Application types supported: %s, %s\n", VALUE_APPLICATION_TYPE_CONSOLE, VALUE_APPLICATION_TYPE_WINDOWS);
        // error_code__exit(APPLICATION_TYPE_NOT_SUPPORTED);
        error_code__exit(89935);
    }
    file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
}

static void parse_config_file_test_dependencies(
    struct module* self,
    struct file_reader* config_file_reader,
    char* buffer,
    u32 buffer_size
) {
    do {
        file_reader__read_while(config_file_reader, NULL, 0, " ");
        u32 read_bytes = file_reader__read_while_not(config_file_reader, buffer, buffer_size, " \r\n");
        if (read_bytes == 0) {
            // note: done reading test dependencies
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
        module_compiler__add_test_dependency(self, found_module);
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
    TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, DEF_FILE_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
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

static void def_file_add_error_codes_place_holder__create_platform_specific(
    struct module* self,
    struct file* def_file,
    struct string_replacer* string_replacer,
    char* def_file_name_buffer,
    char* def_file_buffer,
    char* module_name_capitalized,
    const char* platform_specific,
    const char* platform_specific_capitalized,
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
    TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, DEF_FILE_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
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
        "%s_%s_DEFS_H", module_name_capitalized, platform_specific_capitalized
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        parent_module_name_defs, parent_module_name_defs_len,
        "\"../../%s_defs.h\"", self->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        module_error_codes_enum, module_error_codes_enum_len,
        "%s_%s", self->basename, platform_specific
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        string_replacer,
        number_of_what_replacements,
        module_error_code_enum_start, module_error_code_enum_start_len,
        "%s_%s", platform_specific_capitalized, module_name_capitalized
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
    TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
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
        TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
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

static void def_file_add_error_codes_place_holder__update_platform_specific(
    struct module* self,
    struct file* def_file,
    struct file_reader* file_reader,
    struct string_replacer* string_replacer,
    char* def_file_name_buffer,
    char* auxiliary_buffer,
    char* def_file_buffer,
    char* module_name_capitalized,
    const char* rest_of_the_error_codes,
    const char* platform_specific,
    const char* platform_specific_capitalized,
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
    TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    file_reader__clear(file_reader, def_file);
    u32 what_position;
    char buffer[128];
    u32 bytes_written = libc__snprintf(
        buffer,
        ARRAY_SIZE(buffer),
        "enum %s_%s_error_code {",
        platform_specific, self->basename
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
            "    %s_%s_ERROR_CODE_START,\n"
            "%s",
            platform_specific_capitalized, module_name_capitalized,
            rest_of_the_error_codes
        );
    } else {
        bytes_written = libc__snprintf(
            buffer,
            ARRAY_SIZE(buffer),
            "\"../../%s_defs.h\"", self->basename
        );
        if (bytes_written >= ARRAY_SIZE(buffer)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        TEST_FRAMEWORK_ASSERT(file__seek(def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
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
            "\n\nenum %s_%s_error_code {\n"
            "    %s_%s_ERROR_CODE_START,\n"
            "%s"
            "};\n",
            self->basename, platform_specific,
            platform_specific_capitalized, module_name_capitalized,
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

static void parse_and_handle_config_file(
    struct module* self,
    struct file_reader* file_reader,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    char* config_file_name,
    char* auxiliary_buffer,
    char* error_codes_buffer,
    char* module_name_capitalized,
    u32 auxiliary_buffer_size,
    u32 error_codes_buffer_size
) {
    struct file config_file;
    TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    file_reader__clear(file_reader, &config_file);
    bool parsed_unique_error_codes = false;
    bool parsed_module_dependencies = false;
    bool parsed_application_type = false;
    bool parsed_test_dependencies = false;
    while (
        parsed_module_dependencies == false ||
        parsed_test_dependencies == false ||
        parsed_unique_error_codes == false ||
        parsed_application_type == false
    ) {
        parse_key_from_file(file_reader, auxiliary_buffer, auxiliary_buffer_size);

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
        } else if (libc__strcmp(auxiliary_buffer, KEY_MODULE_DEPENDENCIES) == 0) {
            parse_config_file_dependencies(
                self,
                file_reader,
                auxiliary_buffer,
                auxiliary_buffer_size
            );
            parsed_module_dependencies = true;
        } else if (libc__strcmp(auxiliary_buffer, KEY_APPLICATION_TYPE) == 0) {
            parse_config_file_application_type(
                self,
                file_reader,
                auxiliary_buffer,
                auxiliary_buffer_size
            );
            parsed_application_type = true;
        } else if (libc__strcmp(auxiliary_buffer, KEY_TEST_DEPENDENCIES) == 0) {
            parse_config_file_test_dependencies(
                self,
                file_reader,
                auxiliary_buffer,
                auxiliary_buffer_size
            );
            parsed_test_dependencies = true;
        } else {
            file__seek(&config_file, 0, FILE_SEEK_TYPE_END);
            if (parsed_module_dependencies == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: \n",
                    KEY_MODULE_DEPENDENCIES
                );
                parsed_module_dependencies = true;
            }
            if (parsed_test_dependencies == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: \n",
                    KEY_TEST_DEPENDENCIES
                );
                parsed_test_dependencies = true;
            }
            if (parsed_unique_error_codes == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: [\n"
                    "]\n",
                    KEY_UNIQUE_ERROR_CODES
                );
                parsed_unique_error_codes = true;
            }
            if (parsed_application_type == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: %s\n",
                    KEY_APPLICATION_TYPE, VALUE_APPLICATION_TYPE_DEFAULT
                );
                parsed_application_type = true;
            }
            libc__printf("Updated .gmc file for module %s\n", self->basename);
        }
    }
    file__close(&config_file);
}

static void parse_and_handle_platform_specific_config_file(
    struct module* self,
    struct file_reader* file_reader,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    char* config_file_name,
    char* auxiliary_buffer,
    char* error_codes_buffer,
    char* module_name_capitalized,
    u32 auxiliary_buffer_size,
    u32 error_codes_buffer_size
) {
    struct file config_file;
    TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    file_reader__clear(file_reader, &config_file);
    bool parsed_unique_error_codes = false;
    bool parsed_platform_specific_dependencies = false;
    while (
        parsed_unique_error_codes == false
    ) {
        parse_key_from_file(file_reader, auxiliary_buffer, auxiliary_buffer_size);

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
        } else if (libc__strcmp(auxiliary_buffer, KEY_PLATFORM_SPECIFIC_MODULE_DEPENDENCIES) == 0) {
            parse_config_file_dependencies(
                self,
                file_reader,
                auxiliary_buffer,
                auxiliary_buffer_size
            );
            parsed_platform_specific_dependencies = true;
        } else {
            file__seek(&config_file, 0, FILE_SEEK_TYPE_END);
            if (parsed_unique_error_codes == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: [\n"
                    "]\n",
                    KEY_UNIQUE_ERROR_CODES
                );
                parsed_unique_error_codes = true;
            }
            if (parsed_platform_specific_dependencies == false) {
                file_writer__write_format(
                    file_writer,
                    &config_file,
                    "%s: \n",
                    KEY_PLATFORM_SPECIFIC_MODULE_DEPENDENCIES
                );
                parsed_platform_specific_dependencies = true;
            }
            libc__printf("Updated .gmc file for module %s\n", self->basename);
        }
    }
    file__close(&config_file);
}

// static void parse_gmc_file(
//     const char* gmc_file_path,
//     struct file* error_files
// ) {
// }

static void update_gmc_files(
    struct module* self,
    char* config_file_name_buffer,
    char* config_file_name_buffer_2,
    struct string_replacer* string_replacer, 
    u32 config_file_name_buffer_size,
    u32 config_file_name_buffer_2_size
) {
    (void) string_replacer;

    // MODULE CONFIG FILE
    u32 config_file_name_len;
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer, config_file_name_buffer_size,
            "%s/%s.%s", self->dirprefix, self->basename, CONFIG_EXTENSION
        )) < config_file_name_buffer_size
    );
    if (file__exists(config_file_name_buffer) == false) {
        TEST_FRAMEWORK_ASSERT(file__copy(config_file_name_buffer, CONFIG_FILE_TEMPLATE_PATH));
        printf("File created: %s\n", config_file_name_buffer);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer));
    // todo: parse out .gmc key/values

    // PLATFORM SPECIFIC CONFIG FILES
    if (libc__strcmp(self->basename, MODULES_PATH) == 0) {
        return ;
    }
    //  PLATFORM SPECIFIC FOLDER
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(config_file_name_buffer_2));
        printf("Directory created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));

    //  WINDOWS
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_WINDOWS
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(config_file_name_buffer_2));
        printf("Directory created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s/%s_%s.%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_WINDOWS,
            self->basename, PLATFORM_SPECIFIC_WINDOWS, CONFIG_EXTENSION
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(file__copy(config_file_name_buffer_2, PLATFORM_SPECIFIC_CONFIG_FILE_TEMPLATE_PATH));
        printf("File created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    // todo: parse out .gmc key/values

    //  LINUX
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_LINUX
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(config_file_name_buffer_2));
        printf("Directory created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s/%s_%s.%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_LINUX,
            self->basename, PLATFORM_SPECIFIC_LINUX, CONFIG_EXTENSION
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(file__copy(config_file_name_buffer_2, PLATFORM_SPECIFIC_CONFIG_FILE_TEMPLATE_PATH));
        printf("File created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    // todo: parse out .gmc key/values

    //  MAC
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_MAC
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(config_file_name_buffer_2));
        printf("Directory created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    TEST_FRAMEWORK_ASSERT(
        (config_file_name_len = libc__snprintf(
            config_file_name_buffer_2, config_file_name_buffer_2_size,
            "%s/%s/%s/%s_%s.%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_MAC,
            self->basename, PLATFORM_SPECIFIC_MAC, CONFIG_EXTENSION
        )) < config_file_name_buffer_2_size
    );
    if (file__exists(config_file_name_buffer_2) == false) {
        TEST_FRAMEWORK_ASSERT(file__copy(config_file_name_buffer_2, PLATFORM_SPECIFIC_CONFIG_FILE_TEMPLATE_PATH));
        printf("File created: %s\n", config_file_name_buffer_2);
    }
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer_2));
    // todo: parse out .gmc key/values
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
    update_gmc_files(
        self,
        config_file_name_buffer,
        auxiliary_buffer,
        string_replacer,
        config_file_name_buffer_size,
        auxiliary_buffer_size
    );

    // todo: parse these out from def_file_template_h
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

    /*
        ----== NON-PLATFORM SPECIFIC ==----
            1 def file update
            2 config file parsing
            3 adding dependencies
    */
    TEST_FRAMEWORK_ASSERT(
        (u32) libc__snprintf(
            config_file_name_buffer,
            config_file_name_buffer_size,
            "%s/%s.%s",
            self->dirprefix, self->basename, CONFIG_EXTENSION
        ) < config_file_name_buffer_size
    );
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer));

    u32 bytes_written = libc__snprintf(def_file_name_buffer, def_file_name_buffer_size, "%s/%s_defs.h", self->dirprefix, self->basename);
    if (bytes_written >= def_file_name_buffer_size) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }

    // note: string_replacer doesn't support replacing replacements, so I do this in two write steps if the def_file doesn't exist
    // first, I replace the template, then write it out to the def file
    // second, read from the now existing def file and replace its contents
    bool should_update_def_file = true;
    struct file def_file;
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
        if (file__exists(config_file_name_buffer)) {
            struct time config_file_last_modified;
            struct time def_file_last_modified;
            TEST_FRAMEWORK_ASSERT(file__last_modified(config_file_name_buffer, &config_file_last_modified));
            TEST_FRAMEWORK_ASSERT(file__last_modified(def_file_name_buffer, &def_file_last_modified));
            // note: only update def file if .gmc file is newer
            if (time__cmp(def_file_last_modified, config_file_last_modified) >= 0) {
                should_update_def_file = false;
            }
        }
        if (should_update_def_file) {
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
    }

    u32 def_file_size = 0;
    if (should_update_def_file) {
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
        def_file_size = file__read(&def_file, def_file_buffer, def_file_buffer_size);
        file__close(&def_file);
        if (def_file_size == def_file_buffer_size) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        string_replacer__clear(string_replacer, def_file_buffer, def_file_size);
    }

    parse_and_handle_config_file(
        self,
        file_reader,
        file_writer,
        error_codes_file,
        config_file_name_buffer,
        auxiliary_buffer,
        error_codes_buffer,
        module_name_capitalized,
        auxiliary_buffer_size,
        error_codes_buffer_size
    );

    if (should_update_def_file) {
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word_f(
            string_replacer,
            number_of_what_replacements,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            "%s", error_codes_buffer
        );
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        string_replacer__read_into_file(
            string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);
    }

    if (self->parent == NULL) {
        return ;
    }

    /*
        ----== PLATFORM SPECIFIC ==----
            1 def file update
            2 config file parsing
            3 adding dependencies
    */

    const char* platform_specific = PLATFORM_SPECIFIC_WINDOWS;
    const char* platform_specific_capitalized = PLATFORM_SPECIFIC_CAPITALIZED_WINDOWS;
#if defined(WINDOWS)
        platform_specific = PLATFORM_SPECIFIC_WINDOWS;
        platform_specific_capitalized = PLATFORM_SPECIFIC_CAPITALIZED_WINDOWS;
#elif defined(LINUX)
        platform_specific = PLATFORM_SPECIFIC_LINUX;
        platform_specific_capitalized = PLATFORM_SPECIFIC_CAPITALIZED_LINUX;
#elif defined(MAC)
        platform_specific = PLATFORM_SPECIFIC_MAC;
        platform_specific_capitalized = PLATFORM_SPECIFIC_CAPITALIZED_MAC;
#endif

    TEST_FRAMEWORK_ASSERT(
        (u32) libc__snprintf(
            config_file_name_buffer,
            config_file_name_buffer_size,
            "%s/%s/%s/%s_%s.%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, platform_specific,
            self->basename, platform_specific, CONFIG_EXTENSION
        ) < config_file_name_buffer_size
    );
    TEST_FRAMEWORK_ASSERT(file__exists(config_file_name_buffer));

    bytes_written = libc__snprintf(
        def_file_name_buffer,
        def_file_name_buffer_size,
        "%s/%s/%s/%s_platform_specific_defs.h",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, platform_specific, self->basename
    );
    if (bytes_written >= def_file_name_buffer_size) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }

    should_update_def_file = true;
    if (file__exists(def_file_name_buffer) == false) {
        def_file_add_error_codes_place_holder__create_platform_specific(
            self,
            &def_file,
            string_replacer,
            def_file_name_buffer,
            def_file_buffer,
            module_name_capitalized,
            platform_specific,
            platform_specific_capitalized,
            def_file_buffer_size
        );
    } else {
        if (file__exists(config_file_name_buffer)) {
            struct time config_file_last_modified;
            struct time def_file_last_modified;
            TEST_FRAMEWORK_ASSERT(file__last_modified(config_file_name_buffer, &config_file_last_modified));
            TEST_FRAMEWORK_ASSERT(file__last_modified(def_file_name_buffer, &def_file_last_modified));
            // note: only update def file if .gmc file is newer
            if (time__cmp(def_file_last_modified, config_file_last_modified) >= 0) {
                should_update_def_file = false;
            }
        }
        if (should_update_def_file) {
            def_file_add_error_codes_place_holder__update_platform_specific(
                self,
                &def_file,
                file_reader,
                string_replacer,
                def_file_name_buffer,
                auxiliary_buffer,
                def_file_buffer,
                module_name_capitalized,
                rest_of_the_error_codes,
                platform_specific,
                platform_specific_capitalized,
                auxiliary_buffer_size,
                def_file_buffer_size
            );
        }
    }

    def_file_size = 0;
    if (should_update_def_file) {
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
        def_file_size = file__read(&def_file, def_file_buffer, def_file_buffer_size);
        file__close(&def_file);
        if (def_file_size == def_file_buffer_size) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        string_replacer__clear(string_replacer, def_file_buffer, def_file_size);
    }

    parse_and_handle_platform_specific_config_file(
        self,
        file_reader,
        file_writer,
        error_codes_file,
        config_file_name_buffer,
        auxiliary_buffer,
        error_codes_buffer,
        module_name_capitalized,
        auxiliary_buffer_size,
        error_codes_buffer_size
    );

    if (should_update_def_file) {
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word_f(
            string_replacer,
            number_of_what_replacements,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            "%s", error_codes_buffer
        );
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        string_replacer__read_into_file(
            string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);
    }
}

static void assert_create_dir(
    char* buffer,
    u32 buffer_size,
    const char* format,
    ...
) {
    va_list ap;
    
    va_start(ap, format);
    u32 bytes_written = libc__vsnprintf(buffer, buffer_size, format, ap);
    va_end(ap);

    if (bytes_written == buffer_size) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };
    if (file__exists(buffer) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(buffer));
        printf("Directory created: %s\n", buffer);
    }
}

static void assert_create_gitkeep(
    char* buffer,
    u32 buffer_size,
    const char* format,
    ...
) {
    va_list ap;

    va_start(ap, format);
    u32 bytes_written = libc__vsnprintf(buffer, buffer_size, format, ap);
    va_end(ap);

    if (bytes_written == buffer_size) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };
    if (file__exists(buffer) == false) {
        TEST_FRAMEWORK_ASSERT(
            file__copy(
                buffer,
                GITKEEP_PATH
            )
        );
        printf("File created: %s\n", buffer);
    }
}

static void update_platform_specific_directories(const char* path) {
    static char auxiliary_buffer[256];
    assert_create_dir(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/windows",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_gitkeep(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/windows/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/linux",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_gitkeep(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/linux/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/mac",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_gitkeep(
        auxiliary_buffer,
        ARRAY_SIZE(auxiliary_buffer),
        "%s/%s/mac/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
}

// @returns true if path is a module
// @note as a side effect, also adds the module to its parent
bool is_module_path(const char* path) {
    static char parent_path_buffer[512];
    static char child_basename_buffer[128];
    static char parent_basename_buffer[128];

    u32 path_len = libc__strlen(path);
    u32 basename_len;
    u32 directory_len;
    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            path, path_len,
            child_basename_buffer, ARRAY_SIZE(child_basename_buffer), &basename_len,
            parent_path_buffer, ARRAY_SIZE(parent_path_buffer), &directory_len
        )
    );
    if (
        directory_len == 0 ||
        libc__strcmp(PLATFORM_SPECIFIC_FOLDER_NAME, child_basename_buffer) == 0 ||
        libc__strcmp(TEST_FOLDER_NAME, child_basename_buffer) == 0
    ) {
        // note: root module or we are in a platform specific folder or we are in the module's test folder
        return false;
    }

    update_platform_specific_directories(path);
    // create test folder
    assert_create_dir(
        parent_basename_buffer,
        ARRAY_SIZE(parent_basename_buffer),
        "%s/%s",
        path, TEST_FOLDER_NAME
    );
    assert_create_gitkeep(
        parent_basename_buffer,
        ARRAY_SIZE(parent_basename_buffer),
        "%s/%s/.gitkeep",
        path, TEST_FOLDER_NAME, PLATFORM_SPECIFIC_FOLDER_NAME
    );

    u32 parent_basename_len;
    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            parent_path_buffer, directory_len,
            parent_basename_buffer, ARRAY_SIZE(parent_basename_buffer), &parent_basename_len,
            NULL, 0, NULL
        )
    );

    struct module* parent = module_compiler__find_module_by_name(g_modules, parent_basename_buffer, *g_modules_size_cur);
    TEST_FRAMEWORK_ASSERT(parent != NULL);
    module_compiler__add_child(g_modules, parent, child_basename_buffer, g_modules_size_cur, g_modules_size_max);

    return true;
}

void module_compiler__explore_children(struct module* self) {
    struct directory dir;

    TEST_FRAMEWORK_ASSERT(directory__open(&dir, self->dirprefix) == true);
    directory__foreach_deep(self->dirprefix, &is_module_path, FILE_TYPE_DIRECTORY);
}

static void module_compiler__write_dependency_into_buffer_and_increment(
    struct module* self,
    char** dependency_buffer,
    u32 *dependency_buffer_size
) {
    u32 bytes_written = libc__snprintf(
        *dependency_buffer,
        *dependency_buffer_size,
        "%s ",
        self->basename
    );

    if (bytes_written >= *dependency_buffer_size) {
        // error_code__exit(DEPENDENCIES_BUFFER_TOO_SMALL)
        error_code__exit(2714);
    }

    *dependency_buffer += bytes_written;
    *dependency_buffer_size -= bytes_written;
}

static u32 module_compiler__get_dependencies(
    struct module* self,
    char** dependency_buffer,
    u32 dependency_buffer_size
) {
    self->transient_flag_for_processing = 1;
    for (u32 dependency_index = 0; dependency_index < ARRAY_SIZE_MEMBER(struct module, dependencies); ++dependency_index) {
        struct module* dependency = self->dependencies[dependency_index];
        if (dependency != NULL && dependency->transient_flag_for_processing == 0) {
            module_compiler__write_dependency_into_buffer_and_increment(dependency, dependency_buffer, &dependency_buffer_size);
            dependency_buffer_size = module_compiler__get_dependencies(
                dependency,
                dependency_buffer,
                dependency_buffer_size
            );
        }
    }

    return dependency_buffer_size;
}

static u32 module_compiler__get_test_dependencies(
    struct module* self,
    char** dependency_buffer,
    u32 dependency_buffer_size
) {
    module_compiler__write_dependency_into_buffer_and_increment(self, dependency_buffer, &dependency_buffer_size);
    self->transient_flag_for_processing = 1;

    struct module* common_test_dependency = module_compiler__find_module_by_name(g_modules, COMMON_TEST_DEPENDENCY_MODULE, *g_modules_size_cur);
    if (common_test_dependency == NULL) {
        error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_NOT_FOUND);
    }
    module_compiler__write_dependency_into_buffer_and_increment(common_test_dependency, dependency_buffer, &dependency_buffer_size);
    common_test_dependency->transient_flag_for_processing = 1;
    dependency_buffer_size = module_compiler__get_dependencies(common_test_dependency, dependency_buffer, dependency_buffer_size);

    dependency_buffer_size = module_compiler__get_dependencies(self, dependency_buffer, dependency_buffer_size);


    for (u32 dependency_index = 0; dependency_index < ARRAY_SIZE_MEMBER(struct module, test_dependencies); ++dependency_index) {
        struct module* test_dependency = self->test_dependencies[dependency_index];
        if (test_dependency != NULL && test_dependency->transient_flag_for_processing == 0) {
            module_compiler__write_dependency_into_buffer_and_increment(test_dependency, dependency_buffer, &dependency_buffer_size);
            dependency_buffer_size = module_compiler__get_dependencies(
                test_dependency,
                dependency_buffer,
                dependency_buffer_size
            );
        }
    }

    return dependency_buffer_size;
}

void module_compiler__embed_dependencies_into_makefile(
    struct module* modules,
    char* makefile_template_path,
    const char* file_path_prefix,
    char* file_path_buffer,
    char* file_buffer,
    char* dependencies_buffer,
    char* auxiliary_buffer,
    struct string_replacer* string_replacer,
    struct string_replacer* string_replacer_aux,
    u32 modules_size,
    u32 file_path_buffer_size,
    u32 file_buffer_size,
    u32 dependencies_buffer_size,
    u32 auxiliary_buffer_size
) {
    struct file modules_makefile_template_file;
    TEST_FRAMEWORK_ASSERT(file__open(&modules_makefile_template_file, makefile_template_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    u32 modules_makefile_template_file_size = file__read(&modules_makefile_template_file, file_buffer, file_buffer_size);
    if (modules_makefile_template_file_size == file_buffer_size) {
        // error_code__exit(FILE_BUFFER_TOO_SMALL);
        error_code__exit(43825);
    }
    file__close(&modules_makefile_template_file);

    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        struct module* cur_module = modules + module_index;

        module_compiler__clear_transient_flags(g_modules, *g_modules_size_cur);
        char* cur_dependency_buffer = dependencies_buffer;
        u32 dependencies_buffer_size_left = module_compiler__get_dependencies(cur_module, &cur_dependency_buffer, dependencies_buffer_size);

        static const char module_dependency_replace_what[] = "$(MODULE_LIBDEP_MODULES)";
        static const char module_test_dependency_replace_what[] = "$(MODULE_TEST_DEPENDS)";
        static const char module_name_replace_what[] = "$(MODULE_NAME)";
        static const char module_lflags_specific_replace_what[] = "$(LFLAGS_SPECIFIC)";
        static const u32 module_dependency_replace_what_len = ARRAY_SIZE(module_dependency_replace_what) - 1;
        static const u32 module_test_dependency_replace_what_len = ARRAY_SIZE(module_test_dependency_replace_what) - 1;
        static const u32 module_name_replace_what_len = ARRAY_SIZE(module_name_replace_what) - 1;
        static const u32 module_lflags_specific_replace_what_len = ARRAY_SIZE(module_lflags_specific_replace_what) - 1;

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

        module_compiler__clear_transient_flags(g_modules, *g_modules_size_cur);
        cur_dependency_buffer = dependencies_buffer;
        dependencies_buffer_size_left = module_compiler__get_test_dependencies(cur_module, &cur_dependency_buffer, dependencies_buffer_size);
        number_of_what_replacements = (u32) 1;
        string_replacer__replace_word(
            string_replacer,
            number_of_what_replacements,
            module_test_dependency_replace_what,
            module_test_dependency_replace_what_len,
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
            cur_module->application_type,
            libc__strlen(cur_module->application_type)
        );

        u32 written_bytes = libc__snprintf(
            auxiliary_buffer,
            auxiliary_buffer_size,
            "%s/%s.mk",
            cur_module->dirprefix, cur_module->basename
        );
        TEST_FRAMEWORK_ASSERT(written_bytes < auxiliary_buffer_size);
        static const char modules_dir_path[] = "modules";
        const u32 modules_dir_path_size = ARRAY_SIZE(modules_dir_path) - 1;
        string_replacer__clear(string_replacer_aux, auxiliary_buffer, written_bytes);
        string_replacer__replace_word(
            string_replacer_aux,
            1,
            modules_dir_path, modules_dir_path_size,
            file_path_prefix, libc__strlen(file_path_prefix)
        );
        TEST_FRAMEWORK_ASSERT(
            string_replacer__read(
                string_replacer_aux,
                file_path_buffer,
                file_path_buffer_size,
                0
            ) < file_path_buffer_size
        );
        struct file makefile;
        TEST_FRAMEWORK_ASSERT(file__open(&makefile, file_path_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
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

void module_compiler__compile(void) {
    u32 max_number_of_modules = 256;
    g_modules_size_max = 256;
    u32 cur_number_of_modules = 0;
    g_modules_size_cur = &cur_number_of_modules;
    struct module* modules = libc__calloc(max_number_of_modules * sizeof(*modules));
    g_modules = modules;
    const u32 file_path_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) + ARRAY_SIZE_MEMBER(struct module, dirprefix);
    char* file_path_buffer = libc__malloc(file_path_buffer_size);
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
    u32 total_number_of_replacements_aux = 16;
    u32 average_replacement_size_aux = 64;
    // note: need this because can't replace inplace of a buffer
    struct string_replacer string_replacer_aux;
    string_replacer__create(
        &string_replacer_aux,
        NULL,
        0,
        total_number_of_replacements_aux,
        average_replacement_size_aux * total_number_of_replacements_aux
    );
    u32 file_buffer_size = 32768;
    char* file_buffer = libc__malloc(file_buffer_size);
    u32 dependencies_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) * g_modules_size_max / 2;
    char* dependencies_buffer = libc__malloc(dependencies_buffer_size);
    u32 auxiliary_buffer_size = 1024;
    char* auxiliary_buffer = libc__malloc(auxiliary_buffer_size);

    struct module* parent_module = modules + cur_number_of_modules++;
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compiler__explore_children(parent_module);

    // todo: rename to something like update def files, and do the config file parsing prior to this
    module_compiler__parse_config_files(modules, cur_number_of_modules);

    module_compiler__check_cyclic_dependency(parent_module, modules, cur_number_of_modules);

    module_compiler__embed_dependencies_into_makefile(
        modules,
        MODULES_TEMPLATE_PATH,
        "modules",
        file_path_buffer,
        file_buffer,
        dependencies_buffer,
        auxiliary_buffer,
        &string_replacer,
        &string_replacer_aux,
        cur_number_of_modules,
        file_path_buffer_size,
        file_buffer_size,
        dependencies_buffer_size,
        auxiliary_buffer_size
    );

    // module_compiler__print_branch(parent_module, modules, cur_number_of_modules);

    string_replacer__destroy(&string_replacer);
    string_replacer__destroy(&string_replacer_aux);
    libc__free(modules);
    libc__free(file_buffer);
    libc__free(file_path_buffer);
}
