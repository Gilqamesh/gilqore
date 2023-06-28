#include "test_framework/test_framework.h"

#include "module_compiler.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "io/file/file_path/file_path.h"
#include "io/directory/directory.h"
#include "libc/libc.h"
#include "types/string/string.h"
#include "types/string/string_replacer/string_replacer.h"
#include "common/error_code.h"
#include "time/time.h"
#include "memory/linear_allocator/linear_allocator.h"
#include "data_structures/stack/stack.h"
#include "system/process/process.h"

#define PLATFORM_SPECIFIC_FOLDER_NAME "platform_specific"
#define ERROR_CODES_FILE_NAME "modules/error_codes"
#define PLATFORM_SPECIFIC_CONFIG_FILE_TEMPLATE_PATH "misc/platform_specific_gmc_file_template.txt"
#define MODULES_TEMPLATE_PATH "misc/module_template.txt"

#define DEF_FILE_TEMPLATE_PATH "misc/def_file_template.h"
#define ENUM_ERROR_CODE_MAX_SIZE 128
#define DEF_FILE_MAX_SIZE KILOBYTES(16)
#define ERROR_CODES_MAX_NUMBER 64
#define DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS ERROR_CODES_MAX_NUMBER
#define DEF_FILE_AVERAGE_REPLACEMENT_SIZE BYTES(64)

#define TEST_FILE_TEMPLATE_PATH "misc/test_file_template.txt"
#define TEST_FILE_SUFFIX "_test.c"
#define TEST_FOLDER_NAME "test"
#define TEST_FILE_TEMPLATE_MAX_SIZE KILOBYTES(4)

#define IMPLEMENTATION_FOLDER_NAME "platform_non_specific"

#define PLATFORM_SPECIFIC_WINDOWS "windows"
#define PLATFORM_SPECIFIC_CAPITALIZED_WINDOWS "WINDOWS"
#define PLATFORM_SPECIFIC_LINUX "linux"
#define PLATFORM_SPECIFIC_CAPITALIZED_LINUX "LINUX"
#define PLATFORM_SPECIFIC_MAC "mac"
#define PLATFORM_SPECIFIC_CAPITALIZED_MAC "MAC"

#define CONFIG_EXTENSION "gmc"
#define CONFIG_FILE_TEMPLATE_PATH "misc/gmc_file_template.txt"
#define CONFIG_FILE_MAX_SIZE KILOBYTES(8)

#define MAX_KEY_LENGTH BYTES(64)
#define ERROR_CODE_LINE_AVERAGE_LENGTH BYTES(256)
#define KEY_UNIQUE_ERROR_CODES "unique_error_codes"
#define KEY_MODULE_DEPENDENCIES "module_dependencies"
#define KEY_PLATFORM_SPECIFIC_MODULE_DEPENDENCIES "platform_specific_module_dependencies"
#define KEY_TEST_DEPENDENCIES "test_dependencies"
#define KEY_APPLICATION_TYPE "application_type"

#define VALUE_APPLICATION_TYPE_CONSOLE "CONSOLE"
#define VALUE_APPLICATION_TYPE_WINDOWS "WINDOWS"
#define VALUE_APPLICATION_TYPE_DEFAULT VALUE_APPLICATION_TYPE_CONSOLE

#define MODULES_PATH "modules"
#define TEST_FRAMEWORK_MODULE_NAME "test_framework"

#define PREPROCESSED_DIR "preprocessed"

// todo: put this into file module
#define MAX_FILE_PATH_SIZE 256

#define MAX_CMD_LINE_SIZE 1024

u32 module_compiler__get_error_code(void) {
    static u32 error_code = 1;

    return error_code++;
}

static void assert_create_dir(
    struct memory_slice memory_slice,
    const char* directory_path_f,
    ...
) {
    va_list ap;
    
    va_start(ap, directory_path_f);
    u32 bytes_written =
    libc__vsnprintf(
        memory_slice__memory(&memory_slice), memory_slice__size(&memory_slice),
        directory_path_f, ap);
    va_end(ap);

    if (bytes_written == memory_slice__size(&memory_slice)) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };
    if (file__exists(memory_slice__memory(&memory_slice)) == false) {
        TEST_FRAMEWORK_ASSERT(directory__create(memory_slice__memory(&memory_slice)));
        TEST_FRAMEWORK_ASSERT(file__exists(memory_slice__memory(&memory_slice)));
        libc__printf("Directory created: %s\n", memory_slice__memory(&memory_slice));
    }
}

static void assert_copy_file(
    struct memory_slice memory_slice,
    const char* src_file,
    const char* file_path_f,
    ...
) {
    va_list ap;

    va_start(ap, file_path_f);
    u32 bytes_written =
    libc__vsnprintf(
        memory_slice__memory(&memory_slice), memory_slice__size(&memory_slice),
        file_path_f, ap
    );
    va_end(ap);

    if (bytes_written == memory_slice__size(&memory_slice)) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };
    if (file__exists(memory_slice__memory(&memory_slice)) == false) {
        TEST_FRAMEWORK_ASSERT(file__copy(memory_slice__memory(&memory_slice), src_file));
        TEST_FRAMEWORK_ASSERT(file__exists(memory_slice__memory(&memory_slice)));
        libc__printf("File created: %s\n", memory_slice__memory(&memory_slice));
    }
}

static void assert_create_file(
    struct memory_slice memory_slice,
    const char* format,
    ...
) {
    va_list ap;

    va_start(ap, format);
    u32 bytes_written =
    libc__vsnprintf(
        memory_slice__memory(&memory_slice), memory_slice__size(&memory_slice),
        format, ap
    );
    va_end(ap);

    if (bytes_written == memory_slice__size(&memory_slice)) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };
    if (file__exists(memory_slice__memory(&memory_slice)) == false) {
        TEST_FRAMEWORK_ASSERT(file__create(memory_slice__memory(&memory_slice)));
        TEST_FRAMEWORK_ASSERT(file__exists(memory_slice__memory(&memory_slice)));
        libc__printf("File created: %s\n", memory_slice__memory(&memory_slice));
    }
}

void module_compiler__clear_transient_flags(struct stack* modules) {
    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        ((struct module*) stack__at(modules, module_index))->transient_flag_for_processing = 0;
    }
}

struct module* module_compiler__add_child(
    struct stack* modules,
    struct module* self,
    const char* child_module_basename
) {
    if (stack__size(modules) == stack__capacity(modules)) {
        // error_code__exit(REACHED_MAX_MODULES_SIZE);
        error_code__exit(214);
    }
    struct module* child = stack__push(modules);
    child->parent = self;
    if (
        (u32) libc__snprintf(
            child->dirprefix,
            ARRAY_SIZE(child->dirprefix),
            "%s/%s",
            self->dirprefix,
            child_module_basename
        ) >= ARRAY_SIZE(child->dirprefix)
    ) {
        // error_code__exit(CHILD_PREFIX_TOO_LONG);
        error_code__exit(836);
    }

    u32 name_index = 0;
    while (
        name_index + 1 < ARRAY_SIZE(child->basename) &&
        child_module_basename[name_index] != '\0'
    ) {
        child->basename[name_index] = child_module_basename[name_index];
        ++name_index;
    }
    child->basename[name_index] = '\0';

    struct module* first_child = self->first_child;
    self->first_child = child;
    child->next_sibling = first_child;

    return child;
}

void module_compiler__add_dependency(struct module* self, struct module* dependency) {
    u32 hash_value = (dependency->basename[0] * 56237) & ARRAY_SIZE(self->dependencies);
    for (u32 i = hash_value; i < ARRAY_SIZE(self->dependencies); ++i) {
        if (self->dependencies[i] == dependency) {
            // no need to add the dependency again
            return ;
        }
        if (self->dependencies[i] == NULL) {
            self->dependencies[i] = dependency;
            return ;
        }
    }
    for (u32 i = 0; i < hash_value; ++i) {
        if (self->dependencies[i] == dependency) {
            // no need to add the dependency again
            return ;
        }
        if (self->dependencies[i] == NULL) {
            self->dependencies[i] = dependency;
            return ;
        }
    }
    // error_code__exit(MAX_AMOUNT_OF_DEPENDENCIES_REACHED_FOR_MODULE);
    error_code__exit(43556);
}

void module_compiler__add_test_dependency(struct module* self, struct module* dependency) {
    u32 hash_value = (dependency->basename[0] * 56237) & ARRAY_SIZE(self->test_dependencies);
    for (u32 i = hash_value; i < ARRAY_SIZE(self->test_dependencies); ++i) {
        if (self->test_dependencies[i] == dependency) {
            // no need to add the dependency again
            return ;
        }
        if (self->test_dependencies[i] == NULL) {
            self->test_dependencies[i] = dependency;
            return ;
        }
    }
    for (u32 i = 0; i < hash_value; ++i) {
        if (self->test_dependencies[i] == dependency) {
            // no need to add the dependency again
            return ;
        }
        if (self->test_dependencies[i] == NULL) {
            self->test_dependencies[i] = dependency;
            return ;
        }
    }
    // error_code__exit(MAX_AMOUNT_OF_DEPENDENCIES_REACHED_FOR_MODULE);
    error_code__exit(43556);
}

static void module_compiler__check_cyclic_dependency_helper(
    struct module* module,
    struct stack* all_modules
) {
    if (module->transient_flag_for_processing > 0) {
        libc__printf("\ncyclic dependency detected between these modules: ");
        for (u32 module_index = 0; module_index < stack__size(all_modules); ++module_index) {
            if (((struct module*)stack__at(all_modules, module_index))->transient_flag_for_processing > 0) {
                libc__printf("%s ", ((struct module*)stack__at(all_modules, module_index))->basename);
            }
        }
        // error_code__exit(CYCLIC_DEPENDENCY_BETWEEN_MODULES);
        error_code__exit(8342);
    }
    module->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(module->dependencies); ++i) {
        if (module->dependencies[i] != NULL) {
            module_compiler__check_cyclic_dependency_helper(module->dependencies[i], all_modules);
        }
    }
    module->transient_flag_for_processing = 0;
}

void module_compiler__check_cyclic_dependency(struct stack* modules) {
    if (stack__size(modules) == 0) {
        return ;
    }

    module_compiler__clear_transient_flags(modules);
    module_compiler__check_cyclic_dependency_helper(stack__at(modules, 0), modules);
}

void module_compiler__print_dependencies(struct module* self) {
    self->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(self->dependencies); ++i) {
        struct module* dependency = self->dependencies[i];
        if (dependency != NULL && dependency->transient_flag_for_processing == 0) {
            libc__printf("%s ", dependency->basename);
            module_compiler__print_dependencies(dependency);
        }
    }
}

void module_compiler__print_test_dependencies(struct module* self) {
    self->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(self->test_dependencies); ++i) {
        struct module* test_dependency = self->test_dependencies[i];
        if (test_dependency != NULL && test_dependency->transient_flag_for_processing == 0) {
            libc__printf("%s ", test_dependency->basename);
            module_compiler__print_dependencies(test_dependency);
        }
    }
}

static void module_compiler__print_branch_helper(
    struct stack* modules,
    struct module* from,
    s32 cur_depth
) {
    libc__printf("%*s --== %s ==-- \n %*snumber of submodules: %d\n %*sdependencies: ",
    cur_depth << 2, "", from->basename,
    cur_depth << 2, "", from->number_of_submodules,
    cur_depth << 2, "");

    module_compiler__clear_transient_flags(modules);
    module_compiler__print_dependencies(from);
    libc__printf("\n %*stest dependencies: ", cur_depth << 2, "");
    module_compiler__clear_transient_flags(modules);
    module_compiler__print_test_dependencies(from);
    libc__printf("\n\n");
    struct module* child = from->first_child;
    while (child) {
        module_compiler__print_branch_helper(modules, child, cur_depth + 1);
        child = child->next_sibling;
    }
}

void module_compiler__print_branch(
    struct module* from,
    struct stack* modules
) {
    module_compiler__print_branch_helper(
        modules,
        from,
        0
    );
}

void module_compiler__preprocess_file(
    struct stack* modules,
    const char* file_path,
    struct memory_slice preprocessed_file_path,
    struct linear_allocator* allocator,
    struct file* error_codes_file
) {
    struct memory_slice file_path_basename = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);
    TEST_FRAMEWORK_ASSERT(file_path__decompose(
        file_path, libc__strlen(file_path),
        memory_slice__memory(&file_path_basename), memory_slice__size(&file_path_basename), NULL,
        NULL, 0, NULL
    ));
    u32 wrote_bytes = libc__snprintf(
        memory_slice__memory(&preprocessed_file_path), memory_slice__size(&preprocessed_file_path),
        "%s/%s_preprocessed.c",
        PREPROCESSED_DIR, memory_slice__memory(&file_path_basename)
    );
    linear_allocator__pop(allocator, file_path_basename);
    TEST_FRAMEWORK_ASSERT(wrote_bytes < memory_slice__size(&preprocessed_file_path));
    struct file preprocessed_file;
    TEST_FRAMEWORK_ASSERT(file__open(&preprocessed_file, memory_slice__memory(&preprocessed_file_path), FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));

    const u32 max_line_length = KILOBYTES(2);
    struct file_writer writer;
    struct memory_slice writer_internal_buffer = linear_allocator__push(allocator, max_line_length);
    file_writer__create(&writer, writer_internal_buffer);

    struct file source_file;
    TEST_FRAMEWORK_ASSERT(file__open(&source_file, file_path, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));

    struct memory_slice reader_internal_buffer = linear_allocator__push(allocator, KILOBYTES(16));
    struct memory_slice line_buffer = linear_allocator__push(allocator, max_line_length);
    struct file_reader reader;
    TEST_FRAMEWORK_ASSERT(file_reader__create(&reader, &source_file, reader_internal_buffer));

    // #import file::reader -> // #include ""
    // #import libc
    // #import math
    // #import graphics

    /*
        #fatal_error "something went wrong here";
        evaluate(#fatal_error "...")
    */

    const char token_key_import[] = "#import ";
    const char token_key_error_message[] = "#fatal_error ";

    u32 line_len;
    while (
        (line_len = file_reader__read_while_not(
            &reader,
            memory_slice__memory(&line_buffer), memory_slice__size(&line_buffer),
            "\r\n"
        )) > 0
    ) {
        TEST_FRAMEWORK_ASSERT(line_len < memory_slice__size(&line_buffer));
        ((char*)memory_slice__memory(&line_buffer))[line_len] = '\0';

        bool line_was_written = false;

        // todo: change this operation to one that can match multiple strings at the same time
        char* token_value_import = string__starts_with(memory_slice__memory(&line_buffer), token_key_import);
        char* token_value_error_message = string__search(
            memory_slice__memory(&line_buffer),
            token_key_error_message, ARRAY_SIZE(token_key_error_message) - 1
        );

        if (token_value_import) {
            struct module* found_module = module_compiler__find_module_by_name(modules, token_value_import);
            if (found_module) {
                file_writer__write_format(
                    &writer, &preprocessed_file,
                    "#include \"%s/%s.h\"\n",
                    found_module->dirprefix, found_module->basename
                );
                line_was_written = true;
            }
        } else if (token_value_error_message) {
            // todo: skip whitespaces
            if (*token_value_error_message == '\"') {
                char* enclosing_quotation_mark = string__search_n(token_value_error_message + 1, "\"", 1, false);
                if (enclosing_quotation_mark) {
                    u32 unique_error_code = module_compiler__get_error_code();
                    file_writer__write_format(
                        &writer, error_codes_file,
                        "%u REMOVE_ME %.*s\n",
                        unique_error_code,
                        enclosing_quotation_mark + 1 - token_value_error_message, token_value_error_message
                    );

                    file_writer__write_format(
                        &writer, &preprocessed_file,
                        "%.*serror_code__exit(%u)%s\n",
                        (u32) (token_value_error_message - (char*) memory_slice__memory(&line_buffer)) - (ARRAY_SIZE(token_key_error_message) - 1), memory_slice__memory(&line_buffer),
                        unique_error_code,
                        enclosing_quotation_mark + 1
                    );

                    line_was_written = true;
                }
            }
        }

        if (line_was_written == false) {
            file_writer__write_format(&writer, &preprocessed_file, "%s\n", memory_slice__memory(&line_buffer));
        }

        file_reader__read_while(&reader, NULL, 0, "\r\n");
    }

    file_reader__destroy(&reader);
    file_writer__destroy(&writer);

    linear_allocator__pop(allocator, line_buffer);
    linear_allocator__pop(allocator, reader_internal_buffer);
    linear_allocator__pop(allocator, writer_internal_buffer);

    file__close(&source_file);
    file__close(&preprocessed_file);
}

struct module_compiler__compile_file_context {
    struct stack* modules;
    struct module* module;
    struct linear_allocator* allocator;
    struct process compilation_processes[128];
    struct file error_codes_file;
    u32 compilation_processes_size;
};

bool module_compiler__compile_file(const char* file_path, void* user_data) {
    struct module_compiler__compile_file_context* context = (struct module_compiler__compile_file_context*) user_data;
    TEST_FRAMEWORK_ASSERT(file__exists(file_path));

    char* extension = string__rsearch_n(file_path, libc__strlen(file_path), ".", 1, false);
    if (extension == NULL) {
        return false;
    }
    static const char* const preprocessed_extensions[] = {
        ".h",
        ".c",
        ".gil"
    };
    const u32 c_extension_index = 1;
    (void) c_extension_index;
    // for now since I can't compile my own language, I'll just 
    const u32 gil_extension_index = 2;
    struct memory_slice cmd_line = linear_allocator__push(context->allocator, MAX_CMD_LINE_SIZE);
    struct memory_slice path_to_obj_file = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);
    for (u32 preprocessed_extensions_index = 0; preprocessed_extensions_index < ARRAY_SIZE(preprocessed_extensions); ++preprocessed_extensions_index) {
        if (libc__strcmp(preprocessed_extensions[preprocessed_extensions_index], extension) == 0) {
            // do the actual preprocessing only if necessary:
            //  - file's dependencies changed <- what are these?
            if (preprocessed_extensions_index == gil_extension_index) {
                // preprocess
                struct memory_slice preprocessed_file_path = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);
                module_compiler__preprocess_file(context->modules, file_path, preprocessed_file_path, context->allocator, &context->error_codes_file);

                // todo: remove when preprocessing is done
                // libc__strncpy(memory_slice__memory(&preprocessed_file_path), file_path, memory_slice__size(&preprocessed_file_path));

                // compilation
                u32 obj_file_len = libc__snprintf(
                    memory_slice__memory(&path_to_obj_file),
                    memory_slice__size(&path_to_obj_file),
                    "%s", file_path
                );
                TEST_FRAMEWORK_ASSERT(obj_file_len < memory_slice__size(&path_to_obj_file));
                ASSERT(obj_file_len > 1);
                ASSERT(((char*) memory_slice__memory(&path_to_obj_file))[obj_file_len - 1] == 'c');
                ((char*) memory_slice__memory(&path_to_obj_file))[obj_file_len - 1] = 'o';
                u32 cmd_line_len = libc__snprintf(
                    memory_slice__memory(&cmd_line), memory_slice__size(&cmd_line),
                    // "%s -c %s -o %s %s -MMD -MP -MF %s",
                    "%s -c %s -o %s %s",
                    "cc", memory_slice__memory(&preprocessed_file_path), memory_slice__memory(&path_to_obj_file), "-std=c2x -g -pedantic-errors -Wall -Wextra -Werror -Imodules -DGIL_DEBUG"
                );
                linear_allocator__pop(context->allocator, preprocessed_file_path);
                TEST_FRAMEWORK_ASSERT(cmd_line_len < memory_slice__size(&cmd_line));

                ASSERT(context->compilation_processes_size < ARRAY_SIZE(context->compilation_processes));
                libc__printf("%s\n", memory_slice__memory(&cmd_line));
                process__create(
                    &context->compilation_processes[context->compilation_processes_size],
                    memory_slice__memory(&cmd_line)
                );
                if (++context->compilation_processes_size == ARRAY_SIZE(context->compilation_processes)) {
                    for (u32 process_index = 0; process_index < context->compilation_processes_size; ++process_index) {
                        process__wait_execution(&context->compilation_processes[process_index]);
                        u32 error_code = process__destroy(&context->compilation_processes[process_index]);
                        (void) error_code;
                        // todo: log error
                    }
                    context->compilation_processes_size = 0;
                }
            }
        }
    }
    linear_allocator__pop(context->allocator, path_to_obj_file);
    linear_allocator__pop(context->allocator, cmd_line);

    const char import_directive[] = "import ";
    (void) import_directive;
    // this is the only thing that will dictate the dependencies of the compiler
    // so at this point we can add the dependencies instead of manually writing them into
    // configuration file and then parsing them out from that
/*
#import utils::stringbuilder;

#test
void foo() {
    // Only run during test builds...
}

void main() {
    struct stringbuilder  sb;

    // ...
}
*/
    return true;
}

void module_compiler__compile(struct module_compiler__compile_file_context* context) {
    // discover relevant files to preprocess:
    struct memory_slice file_path = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);
    // current dir
    u64 dirpath_len = libc__snprintf(
        memory_slice__memory(&file_path),
        memory_slice__size(&file_path),
        "%s", context->module->dirprefix
    );
    TEST_FRAMEWORK_ASSERT(dirpath_len < memory_slice__size(&file_path));
    directory__foreach_shallow(
        memory_slice__memory(&file_path),
        &module_compiler__compile_file,
        context,
        FILE_TYPE_FILE
    );
    if (context->compilation_processes_size == ARRAY_SIZE(context->compilation_processes)) {
        for (u32 process_index = 0; process_index < context->compilation_processes_size; ++process_index) {
            process__wait_execution(&context->compilation_processes[process_index]);
            u32 error_code = process__destroy(&context->compilation_processes[process_index]);
            (void) error_code;
            // todo: log error
        }
        context->compilation_processes_size = 0;
    }
    // non-platform specific
    dirpath_len = libc__snprintf(
        memory_slice__memory(&file_path),
        memory_slice__size(&file_path),
        "%s/%s", context->module->dirprefix, IMPLEMENTATION_FOLDER_NAME
    );
    TEST_FRAMEWORK_ASSERT(dirpath_len < memory_slice__size(&file_path));
    directory__foreach_shallow(
        memory_slice__memory(&file_path),
        &module_compiler__compile_file,
        context,
        FILE_TYPE_FILE
    );
    if (context->compilation_processes_size == ARRAY_SIZE(context->compilation_processes)) {
        for (u32 process_index = 0; process_index < context->compilation_processes_size; ++process_index) {
            process__wait_execution(&context->compilation_processes[process_index]);
            u32 error_code = process__destroy(&context->compilation_processes[process_index]);
            (void) error_code;
            // todo: log error
        }
        context->compilation_processes_size = 0;
    }
    // platform specific
    const char* platform_specific_folder_name = PLATFORM_SPECIFIC_WINDOWS;
#if defined(WINDOWS)
    platform_specific_folder_name = PLATFORM_SPECIFIC_WINDOWS;
#elif defined(LINUX)
    platform_specific_folder_name = PLATFORM_SPECIFIC_LINUX;
#elif defined(MAC)
    platform_specific_folder_name = PLATFORM_SPECIFIC_MAC;
#endif
    dirpath_len = libc__snprintf(
        memory_slice__memory(&file_path),
        memory_slice__size(&file_path),
        "%s/%s/%s", context->module->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, platform_specific_folder_name
    );
    TEST_FRAMEWORK_ASSERT(dirpath_len < memory_slice__size(&file_path));
    directory__foreach_shallow(
        memory_slice__memory(&file_path),
        &module_compiler__compile_file,
        context,
        FILE_TYPE_FILE
    );
    if (context->compilation_processes_size == ARRAY_SIZE(context->compilation_processes)) {
        for (u32 process_index = 0; process_index < context->compilation_processes_size; ++process_index) {
            process__wait_execution(&context->compilation_processes[process_index]);
            u32 error_code = process__destroy(&context->compilation_processes[process_index]);
            (void) error_code;
            // todo: log error
        }
        context->compilation_processes_size = 0;
    }

    linear_allocator__pop(context->allocator, file_path);
}

void module_compiler__compile_all(
    struct stack* modules,
    struct linear_allocator* allocator
) {
    struct module_compiler__compile_file_context context;
    context.modules = modules;
    context.allocator = allocator;
    TEST_FRAMEWORK_ASSERT(file__open(&context.error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    context.compilation_processes_size = 0;

    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        struct module* module = stack__at(modules, module_index);
        context.module = module;
        module_compiler__compile(&context);
    }
    for (u32 process_index = 0; process_index < context.compilation_processes_size; ++process_index) {
        process__wait_execution(&context.compilation_processes[process_index]);
        u32 error_code = process__destroy(&context.compilation_processes[process_index]);
        (void) error_code;
        // todo: log error
    }
    context.compilation_processes_size = 0;

    file__close(&context.error_codes_file);
}

struct module* module_compiler__find_module_by_name(
    struct stack* modules,
    const char* basename
) {
    // todo: store modules in a hashmap by their base names
    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        struct module* cur_module = stack__at(modules, module_index);
        if (libc__strcmp(cur_module->basename, basename) == 0) {
            return cur_module;
        }
    }
    return NULL;
}

void module_compiler__parse_config_file(
    struct stack* modules,
    struct module* self,
    struct linear_allocator* allocator,
    struct file* error_codes_file
);

void module_compiler__parse_config_files(
    struct stack* modules,
    struct linear_allocator* allocator
) {
    struct file error_codes_file;
    TEST_FRAMEWORK_ASSERT(file__open(&error_codes_file, ERROR_CODES_FILE_NAME, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));

    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        module_compiler__parse_config_file(
            modules,
            stack__at(modules, module_index),
            allocator,
            &error_codes_file
        );
    }

    file__close(&error_codes_file);
}

static void parse_key_from_file(
    struct file_reader* file_reader,
    struct memory_slice key
) {
    u32 read_bytes = file_reader__read_while_not(file_reader, memory_slice__memory(&key), memory_slice__size(&key), ":");
    if (read_bytes == memory_slice__size(&key)) {
        // error_code__exit(MODULE_COMPILER_ERROR_CODE_CONFIG_KEY_TOO_LONG); // todo: remove from .gmc
        // error_code__exit(KEY_BUFFER_TOO_SMALL);
        error_code__exit(32487);
    }
    ((char*) memory_slice__memory(&key))[read_bytes] = '\0';
    file_reader__read_one(file_reader, NULL, 1);
}

void parse_config_file_unique_error_codes(
    struct file_reader* config_file_reader,
    struct file_writer* file_writer,
    struct file* error_codes_file,
    char* module_name_capitalized,
    struct memory_slice config_file_memory_slice,
    struct memory_slice error_codes_memory_slice
) {
    u32 remaining_error_codes_buffer_size = memory_slice__size(&error_codes_memory_slice);
    char* error_codes_buffer = memory_slice__memory(&error_codes_memory_slice);
    // note: read key-value pairs of unique error code
    do {
        file_reader__read_while(
            config_file_reader,
            memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
            " [\r\n"
        );
        u32 read_bytes =
        file_reader__read_while_not(
            config_file_reader,
            memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
            ":]"
        );
        if (file_reader__peek(config_file_reader) == ']') {
            *error_codes_buffer = '\0';
            // note: done reading unique_error_codes entry
            file_reader__read_while_not(config_file_reader, NULL, 0, "\r\n");
            file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
            break ;
        }
        if (read_bytes == memory_slice__size(&config_file_memory_slice)) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_KEY_TOO_LONG);
        }
        ((char*) memory_slice__memory(&config_file_memory_slice))[read_bytes] = '\0';
        u32 error_code = module_compiler__get_error_code();

        file_writer__write_format(
            file_writer,
            error_codes_file,
            "%u %s",
            error_code,
            memory_slice__memory(&config_file_memory_slice)
        );

        // note: read error enum into def file
        u32 written_bytes = libc__snprintf(
            error_codes_buffer,
            remaining_error_codes_buffer_size,
            "    %s_ERROR_CODE_%s = %u,\n",
            module_name_capitalized, memory_slice__memory(&config_file_memory_slice), error_code
        );
        if (written_bytes >= remaining_error_codes_buffer_size) {
            // error_code__exit(MODULE_COMPILER_ERROR_CODE_BUFFER_SIZE_TOO_SMALL_ERROR_CODES);
            error_code__exit(992);
        }
        error_codes_buffer += written_bytes;
        remaining_error_codes_buffer_size -= written_bytes;

        file_reader__read_while(config_file_reader, NULL, 0, ": ");
        read_bytes =
        file_reader__read_while_not(
            config_file_reader,
            memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
            "\r\n"
        );
        if (read_bytes == memory_slice__size(&config_file_memory_slice)) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_UNIQUE_ERROR_CODE_VALUE_TOO_LONG);
        }
        ((char*) memory_slice__memory(&config_file_memory_slice))[read_bytes] = '\0';
        file_writer__write_format(
            file_writer,
            error_codes_file,
            " \"%s\"\n",
            memory_slice__memory(&config_file_memory_slice)
        );

        file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
    } while (1);
}

static void parse_config_file_dependencies(
    struct stack* modules,
    struct module* self,
    struct file_reader* config_file_reader,
    struct memory_slice config_file_memory_slice
) {
    // note: read module dependencies
    do {
        file_reader__read_while(config_file_reader, NULL, 0, " ");
        u32 read_bytes =
        file_reader__read_while_not(
            config_file_reader,
            memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
            " \r\n"
        );
        if (read_bytes == 0) {
            // note: done reading module dependencies
            file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
            break ;
        }
        if (read_bytes == memory_slice__size(&config_file_memory_slice)) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_MODULE_TOO_LONG);
        }
        ((char*) memory_slice__memory(&config_file_memory_slice))[read_bytes] = '\0';
        // note: add the dependency to the module
        struct module* found_module = module_compiler__find_module_by_name(modules, memory_slice__memory(&config_file_memory_slice));
        if (found_module == NULL) {
            libc__printf("%s\n", self->basename);
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
        libc__printf("unknown application type\n");
        TEST_FRAMEWORK_ASSERT(false);
    }

    return result;
}

static void parse_config_file_application_type(
    struct module* self,
    struct file_reader* config_file_reader,
    struct memory_slice config_file_memory_slice
) {
    file_reader__read_while(config_file_reader, NULL, 0, " ");
    u32 read_bytes =
    file_reader__read_while_not(
        config_file_reader,
        memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
        " \r\n"
    );
    if (read_bytes == memory_slice__size(&config_file_memory_slice)) {
        // error_code__exit(BUFFER_SIZE_TOO_SMALL_PARSE_APPLICATION_TYPE);
        error_code__exit(7632);
    }
    ((char*) memory_slice__memory(&config_file_memory_slice))[read_bytes] = '\0';
    if (
        libc__strcmp(memory_slice__memory(&config_file_memory_slice), VALUE_APPLICATION_TYPE_CONSOLE) == 0 ||
        libc__strcmp(memory_slice__memory(&config_file_memory_slice), VALUE_APPLICATION_TYPE_WINDOWS) == 0
    ) {
        const char* application_type = dispatch_by_application_type(memory_slice__memory(&config_file_memory_slice));
        libc__memcpy(self->application_type, application_type, libc__strlen(application_type));
    } else {
        libc__printf(
            "Application type parsed from module [%s] is not supported: %s\n",
            self->basename, memory_slice__memory(&config_file_memory_slice)
        );
        libc__printf("Application types supported: %s, %s\n", VALUE_APPLICATION_TYPE_CONSOLE, VALUE_APPLICATION_TYPE_WINDOWS);
        // error_code__exit(APPLICATION_TYPE_NOT_SUPPORTED);
        error_code__exit(89935);
    }
    file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
}

static void parse_config_file_test_dependencies(
    struct stack* modules,
    struct module* self,
    struct file_reader* config_file_reader,
    struct memory_slice config_file_memory_slice
) {
    do {
        file_reader__read_while(config_file_reader, NULL, 0, " ");
        u32 read_bytes =
        file_reader__read_while_not(
            config_file_reader,
            memory_slice__memory(&config_file_memory_slice), memory_slice__size(&config_file_memory_slice),
            " \r\n"
        );
        if (read_bytes == 0) {
            // note: done reading test dependencies
            file_reader__read_while(config_file_reader, NULL, 0, "\r\n");
            break ;
        }
        if (read_bytes == memory_slice__size(&config_file_memory_slice)) {
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_MODULE_TOO_LONG);
        }
        ((char*) memory_slice__memory(&config_file_memory_slice))[read_bytes] = '\0';
        // note: add the dependency to the module
        struct module* found_module = module_compiler__find_module_by_name(modules, memory_slice__memory(&config_file_memory_slice));
        if (found_module == NULL) {
            libc__printf("%s\n", self->basename);
            error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_NOT_FOUND);
        }
        module_compiler__add_test_dependency(self, found_module);
    } while (1);
}

static void def_file_add_error_codes_place_holder__create(
    struct module* self,
    struct linear_allocator* allocator,
    char* def_file_name_buffer,
    char* module_name_capitalized
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

    struct file def_file;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE));
    // todo: start filling in from the template
    struct file def_file_template;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, DEF_FILE_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    struct memory_slice def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 def_file_template_size =
    file__read(
        &def_file_template,
        memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice)
    );
    if (def_file_template_size == memory_slice__size(&def_file_memory_slice)) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }

    struct string_replacer def_file_replacer;
    ASSERT(
        string_replacer__create(
            &def_file_replacer,
            allocator,
            memory_slice__memory(&def_file_memory_slice), def_file_template_size,
            DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
        )
    );
    u32 number_of_what_replacements = 2;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_defs_h, module_defs_h_len,
        "%s_DEFS_H", module_name_capitalized
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        parent_module_name_defs, parent_module_name_defs_len,
        self->parent == NULL ? "\"%s\"" : "\"../%s_defs.h\"",
        self->parent == NULL ? "defs.h" : self->parent->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_error_codes_enum, module_error_codes_enum_len,
        "%s", self->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_error_code_enum_start, module_error_code_enum_start_len,
        "%s", module_name_capitalized
    );

    string_replacer__read_into_file(
        &def_file_replacer,
        &def_file,
        0
    );
    file__close(&def_file);

    string_replacer__destroy(&def_file_replacer);

    linear_allocator__pop(allocator, def_file_memory_slice);
}

static void def_file_add_error_codes_place_holder__create_platform_specific(
    struct module* self,
    struct linear_allocator* allocator,
    char* def_file_name_buffer,
    char* module_name_capitalized,
    const char* platform_specific,
    const char* platform_specific_capitalized
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

    struct file def_file;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_CREATE));
    // todo: start filling in from the template
    struct file def_file_template;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file_template, DEF_FILE_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    struct memory_slice def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 def_file_template_size =
    file__read(
        &def_file_template,
        memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice)
    );
    if (def_file_template_size == memory_slice__size(&def_file_memory_slice)) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }

    struct string_replacer def_file_replacer;
    ASSERT(
        string_replacer__create(
            &def_file_replacer,
            allocator,
            memory_slice__memory(&def_file_memory_slice), def_file_template_size,
            DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
        )
    );
    u32 number_of_what_replacements = 2;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_defs_h, module_defs_h_len,
        "%s_%s_DEFS_H", module_name_capitalized, platform_specific_capitalized
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        parent_module_name_defs, parent_module_name_defs_len,
        "\"../../%s_defs.h\"", self->basename
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_error_codes_enum, module_error_codes_enum_len,
        "%s_%s", self->basename, platform_specific
    );

    number_of_what_replacements = 1;
    string_replacer__replace_word_f(
        &def_file_replacer,
        number_of_what_replacements,
        module_error_code_enum_start, module_error_code_enum_start_len,
        "%s_%s", platform_specific_capitalized, module_name_capitalized
    );

    string_replacer__read_into_file(
        &def_file_replacer,
        &def_file,
        0
    );
    file__close(&def_file);

    string_replacer__destroy(&def_file_replacer);

    linear_allocator__pop(allocator, def_file_memory_slice);
}

static void def_file_add_error_codes_place_holder__update(
    struct module* self,
    struct linear_allocator* allocator,
    char* def_file_name_buffer,
    char* module_name_capitalized,
    const char* rest_of_the_error_codes
) {
    struct file def_file;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));

    struct memory_slice def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 def_file_size = file__read(&def_file, memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice));
    if (def_file_size == memory_slice__size(&def_file_memory_slice)) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }

    struct string_replacer def_file_string_replacer;
    ASSERT(
        string_replacer__create(
            &def_file_string_replacer,
            allocator,
            memory_slice__memory(&def_file_memory_slice), def_file_size,
            DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
        )
    );
    TEST_FRAMEWORK_ASSERT(file__seek(&def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    struct memory_slice file_reader_memory_slice = linear_allocator__push(allocator, KILOBYTES(2));
    struct file_reader file_reader;
    TEST_FRAMEWORK_ASSERT(
        file_reader__create(
            &file_reader,
            &def_file,
            file_reader_memory_slice
        )
    );

    struct memory_slice enum_error_code_memory_slice = linear_allocator__push(allocator, ENUM_ERROR_CODE_MAX_SIZE);
    u32 bytes_written = libc__snprintf(
        memory_slice__memory(&enum_error_code_memory_slice), memory_slice__size(&enum_error_code_memory_slice),
        "enum %s_error_code {",
        self->basename
    );
    if (bytes_written >= memory_slice__size(&enum_error_code_memory_slice)) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }

    struct memory_slice def_file_aux_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 what_position;
    bool does_enum_error_codes_exit = file_reader__read_while_not_word(
        &file_reader,
        memory_slice__memory(&def_file_aux_memory_slice), memory_slice__size(&def_file_aux_memory_slice),
        memory_slice__memory(&enum_error_code_memory_slice), bytes_written,
        &what_position
    );
    if (what_position >= memory_slice__size(&def_file_aux_memory_slice)) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }
    if (does_enum_error_codes_exit) {
        u32 what_size = file_reader__read_while_not(&file_reader, NULL, 0, "}");
        string_replacer__replace_at_position_f(
            &def_file_string_replacer,
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
            memory_slice__memory(&enum_error_code_memory_slice), memory_slice__size(&enum_error_code_memory_slice),
            self->parent == NULL ? "\"%s\"" : "\"../%s_defs.h\"",
            self->parent == NULL ? "defs.h" : self->parent->basename
        );
        if (bytes_written >= memory_slice__size(&enum_error_code_memory_slice)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        TEST_FRAMEWORK_ASSERT(file__seek(&def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
        file_reader__clear(&file_reader, &def_file);
        TEST_FRAMEWORK_ASSERT(
            file_reader__read_while_not_word(
                &file_reader,
                memory_slice__memory(&def_file_aux_memory_slice), memory_slice__size(&def_file_aux_memory_slice),
                memory_slice__memory(&enum_error_code_memory_slice), bytes_written,
                &what_position
            ) == true
        );
        string_replacer__replace_at_position_f(
            &def_file_string_replacer,
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
    file__close(&def_file);
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(
        &def_file_string_replacer,
        &def_file,
        0
    );
    file__close(&def_file);

    linear_allocator__pop(allocator, def_file_aux_memory_slice);
    linear_allocator__pop(allocator, enum_error_code_memory_slice);

    file_reader__destroy(&file_reader);
    linear_allocator__pop(allocator, file_reader_memory_slice);

    string_replacer__destroy(&def_file_string_replacer);

    linear_allocator__pop(allocator, def_file_memory_slice);
}

static void def_file_add_error_codes_place_holder__update_platform_specific(
    struct module* self,
    struct linear_allocator* allocator,
    char* def_file_name_buffer,
    char* module_name_capitalized,
    const char* rest_of_the_error_codes,
    const char* platform_specific,
    const char* platform_specific_capitalized
) {
    struct file def_file;
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));

    struct memory_slice def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 def_file_size = file__read(&def_file, memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice));
    if (def_file_size == memory_slice__size(&def_file_memory_slice)) {
        // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(999);
    }

    struct string_replacer def_file_string_replacer;
    ASSERT(
        string_replacer__create(
            &def_file_string_replacer,
            allocator,
            memory_slice__memory(&def_file_memory_slice), def_file_size,
            DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
        )
    );
    TEST_FRAMEWORK_ASSERT(file__seek(&def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
    struct memory_slice file_reader_memory_slice = linear_allocator__push(allocator, KILOBYTES(2));
    struct file_reader file_reader;
    TEST_FRAMEWORK_ASSERT(
        file_reader__create(
            &file_reader,
            &def_file,
            file_reader_memory_slice
        )
    );

    struct memory_slice enum_error_code_memory_slice = linear_allocator__push(allocator, ENUM_ERROR_CODE_MAX_SIZE);
    u32 bytes_written = libc__snprintf(
        memory_slice__memory(&enum_error_code_memory_slice), memory_slice__size(&enum_error_code_memory_slice),
        "enum %s_%s_error_code {",
        platform_specific, self->basename
    );
    if (bytes_written >= memory_slice__size(&enum_error_code_memory_slice)) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }

    struct memory_slice def_file_aux_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
    u32 what_position;
    bool does_enum_error_codes_exit = file_reader__read_while_not_word(
        &file_reader,
        memory_slice__memory(&def_file_aux_memory_slice), memory_slice__size(&def_file_aux_memory_slice),
        memory_slice__memory(&enum_error_code_memory_slice), bytes_written,
        &what_position
    );
    if (what_position >= memory_slice__size(&def_file_aux_memory_slice)) {
        // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
        error_code__exit(32476);
    }
    if (does_enum_error_codes_exit) {
        u32 what_size = file_reader__read_while_not(&file_reader, NULL, 0, "}");
        string_replacer__replace_at_position_f(
            &def_file_string_replacer,
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
            memory_slice__memory(&enum_error_code_memory_slice), memory_slice__size(&enum_error_code_memory_slice),
            "\"../../%s_defs.h\"", self->basename
        );
        if (bytes_written >= memory_slice__size(&enum_error_code_memory_slice)) {
            // error_code__exit(BUFFER2_SIZE_TOO_SMALL);
            error_code__exit(32476);
        }
        TEST_FRAMEWORK_ASSERT(file__seek(&def_file, 0, FILE_SEEK_TYPE_BEGIN) == 0);
        file_reader__clear(&file_reader, &def_file);
        TEST_FRAMEWORK_ASSERT(
            file_reader__read_while_not_word(
                &file_reader,
                memory_slice__memory(&def_file_aux_memory_slice), memory_slice__size(&def_file_aux_memory_slice),
                memory_slice__memory(&enum_error_code_memory_slice), bytes_written,
                &what_position
            ) == true
        );
        string_replacer__replace_at_position_f(
            &def_file_string_replacer,
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
    file__close(&def_file);
    TEST_FRAMEWORK_ASSERT(file__open(&def_file, def_file_name_buffer, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(
        &def_file_string_replacer,
        &def_file,
        0
    );
    file__close(&def_file);

    linear_allocator__pop(allocator, def_file_aux_memory_slice);
    linear_allocator__pop(allocator, enum_error_code_memory_slice);

    file_reader__destroy(&file_reader);
    linear_allocator__pop(allocator, file_reader_memory_slice);

    string_replacer__destroy(&def_file_string_replacer);

    linear_allocator__pop(allocator, def_file_memory_slice);
}

static void parse_and_handle_config_file(
    struct stack* modules,
    struct linear_allocator* allocator,
    struct module* self,
    struct file* error_codes_file,
    char* config_file_name,
    char* module_name_capitalized,
    struct memory_slice error_codes_memory_slice
) {
    struct file config_file;
    TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    struct memory_slice file_reader_memory_slice = linear_allocator__push(allocator, KILOBYTES(1));
    struct file_reader config_file_reader;
    TEST_FRAMEWORK_ASSERT(
        file_reader__create(
            &config_file_reader,
            &config_file,
            file_reader_memory_slice
        )
    );

    struct memory_slice key_memory_slice = linear_allocator__push(allocator, CONFIG_FILE_MAX_SIZE);
    struct memory_slice config_file_memory_slice = linear_allocator__push(allocator, CONFIG_FILE_MAX_SIZE);
    struct memory_slice def_file_writer_memory = linear_allocator__push(allocator, KILOBYTES(1));
    struct file_writer def_file_writer;
    TEST_FRAMEWORK_ASSERT(file_writer__create(&def_file_writer, def_file_writer_memory));
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
        parse_key_from_file(&config_file_reader, key_memory_slice);

        if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_UNIQUE_ERROR_CODES) == 0) {
            parse_config_file_unique_error_codes(
                &config_file_reader,
                &def_file_writer,
                error_codes_file,
                module_name_capitalized,
                config_file_memory_slice,
                error_codes_memory_slice
            );
            parsed_unique_error_codes = true;
        } else if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_MODULE_DEPENDENCIES) == 0) {
            parse_config_file_dependencies(
                modules,
                self,
                &config_file_reader,
                config_file_memory_slice
            );
            parsed_module_dependencies = true;
        } else if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_APPLICATION_TYPE) == 0) {
            parse_config_file_application_type(
                self,
                &config_file_reader,
                config_file_memory_slice
            );
            parsed_application_type = true;
        } else if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_TEST_DEPENDENCIES) == 0) {
            parse_config_file_test_dependencies(
                modules,
                self,
                &config_file_reader,
                config_file_memory_slice
            );
            parsed_test_dependencies = true;
        } else {
            file__seek(&config_file, 0, FILE_SEEK_TYPE_END);
            if (parsed_module_dependencies == false) {
                file_writer__write_format(
                    &def_file_writer,
                    &config_file,
                    "%s: \n",
                    KEY_MODULE_DEPENDENCIES
                );
                parsed_module_dependencies = true;
            }
            if (parsed_test_dependencies == false) {
                file_writer__write_format(
                    &def_file_writer,
                    &config_file,
                    "%s: \n",
                    KEY_TEST_DEPENDENCIES
                );
                parsed_test_dependencies = true;
            }
            if (parsed_unique_error_codes == false) {
                file_writer__write_format(
                    &def_file_writer,
                    &config_file,
                    "%s: [\n"
                    "]\n",
                    KEY_UNIQUE_ERROR_CODES
                );
                parsed_unique_error_codes = true;
            }
            if (parsed_application_type == false) {
                file_writer__write_format(
                    &def_file_writer,
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

    file_writer__destroy(&def_file_writer);
    linear_allocator__pop(allocator, def_file_writer_memory);

    linear_allocator__pop(allocator, config_file_memory_slice);
    linear_allocator__pop(allocator, key_memory_slice);

    file_reader__destroy(&config_file_reader);
    linear_allocator__pop(allocator, file_reader_memory_slice);
}

static void parse_and_handle_platform_specific_config_file(
    struct stack* modules,
    struct linear_allocator* allocator,
    struct module* self,
    struct file* error_codes_file,
    char* config_file_name,
    char* module_name_capitalized,
    struct memory_slice error_codes_memory_slice
) {
    struct file config_file;
    TEST_FRAMEWORK_ASSERT(file__open(&config_file, config_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
    struct memory_slice file_reader_memory_slice = linear_allocator__push(allocator, KILOBYTES(1));
    struct file_reader config_file_reader;
    TEST_FRAMEWORK_ASSERT(
        file_reader__create(
            &config_file_reader,
            &config_file,
            file_reader_memory_slice
        )
    );

    struct memory_slice key_memory_slice = linear_allocator__push(allocator, CONFIG_FILE_MAX_SIZE);
    struct memory_slice config_file_memory_slice = linear_allocator__push(allocator, CONFIG_FILE_MAX_SIZE);
    struct memory_slice def_file_writer_memory = linear_allocator__push(allocator, KILOBYTES(1));
    struct file_writer def_file_writer;
    TEST_FRAMEWORK_ASSERT(file_writer__create(&def_file_writer, def_file_writer_memory));
    bool parsed_unique_error_codes = false;
    bool parsed_platform_specific_dependencies = false;
    while (
        parsed_unique_error_codes == false
    ) {
        parse_key_from_file(&config_file_reader, key_memory_slice);

        if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_UNIQUE_ERROR_CODES) == 0) {
            parse_config_file_unique_error_codes(
                &config_file_reader,
                &def_file_writer,
                error_codes_file,
                module_name_capitalized,
                config_file_memory_slice,
                error_codes_memory_slice
            );
            parsed_unique_error_codes = true;
        } else if (libc__strcmp(memory_slice__memory(&key_memory_slice), KEY_PLATFORM_SPECIFIC_MODULE_DEPENDENCIES) == 0) {
            parse_config_file_dependencies(
                modules,
                self,
                &config_file_reader,
                config_file_memory_slice
            );
            parsed_platform_specific_dependencies = true;
        } else {
            file__seek(&config_file, 0, FILE_SEEK_TYPE_END);
            if (parsed_unique_error_codes == false) {
                file_writer__write_format(
                    &def_file_writer,
                    &config_file,
                    "%s: [\n"
                    "]\n",
                    KEY_UNIQUE_ERROR_CODES
                );
                parsed_unique_error_codes = true;
            }
            if (parsed_platform_specific_dependencies == false) {
                file_writer__write_format(
                    &def_file_writer,
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

    file_writer__destroy(&def_file_writer);
    linear_allocator__pop(allocator, def_file_writer_memory);

    linear_allocator__pop(allocator, config_file_memory_slice);
    linear_allocator__pop(allocator, key_memory_slice);

    file_reader__destroy(&config_file_reader);
    linear_allocator__pop(allocator, file_reader_memory_slice);
}

// static void parse_gmc_file(
//     const char* gmc_file_path,
//     struct file* error_files
// ) {
// }

static void update_gmc_files(
    struct module* self,
    struct linear_allocator* allocator
) {
    struct memory_slice file_path_memory_slice = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);
    // MODULE CONFIG FILE
    assert_copy_file(
        file_path_memory_slice,
        CONFIG_FILE_TEMPLATE_PATH,
        "%s/%s.%s", self->dirprefix, self->basename, CONFIG_EXTENSION
    );
    // todo: parse out .gmc key/values

    if (libc__strcmp(self->basename, MODULES_PATH) == 0) {
        linear_allocator__pop(allocator, file_path_memory_slice);
        return ;
    }

    // PLATFORM SPECIFIC CONFIG FILES
    //  PLATFORM SPECIFIC FOLDER
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME
    );

    //  WINDOWS
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_WINDOWS
    );
    assert_copy_file(
        file_path_memory_slice,
        CONFIG_FILE_TEMPLATE_PATH,
        "%s/%s/%s/%s_%s.%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_WINDOWS,
        self->basename, PLATFORM_SPECIFIC_WINDOWS, CONFIG_EXTENSION
    );
    // todo: parse out .gmc key/values

    //  LINUX
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_LINUX
    );
    assert_copy_file(
        file_path_memory_slice,
        CONFIG_FILE_TEMPLATE_PATH,
        "%s/%s/%s/%s_%s.%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_LINUX,
        self->basename, PLATFORM_SPECIFIC_LINUX, CONFIG_EXTENSION
    );
    // todo: parse out .gmc key/values

    //  MAC
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_MAC
    );
    assert_copy_file(
        file_path_memory_slice,
        CONFIG_FILE_TEMPLATE_PATH,
        "%s/%s/%s/%s_%s.%s",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, PLATFORM_SPECIFIC_MAC,
        self->basename, PLATFORM_SPECIFIC_MAC, CONFIG_EXTENSION
    );
    // todo: parse out .gmc key/values

    linear_allocator__pop(allocator, file_path_memory_slice);
}

void module_compiler__parse_config_file(
    struct stack* modules,
    struct module* self,
    struct linear_allocator* allocator,
    struct file* error_codes_file
) {
    if (libc__strcmp("compiler", self->basename) == 0) {
        int dbg = 0;
        ++dbg;
    }
    update_gmc_files(self, allocator);

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
    struct memory_slice config_file_path_memory_slice = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);
    TEST_FRAMEWORK_ASSERT(
        (u32) libc__snprintf(
            memory_slice__memory(&config_file_path_memory_slice),
            memory_slice__size(&config_file_path_memory_slice),
            "%s/%s.%s",
            self->dirprefix, self->basename, CONFIG_EXTENSION
        ) < memory_slice__size(&config_file_path_memory_slice)
    );
    TEST_FRAMEWORK_ASSERT(file__exists(memory_slice__memory(&config_file_path_memory_slice)));

    struct memory_slice def_file_path_memory_slice = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);
    u32 bytes_written =
    libc__snprintf(
        memory_slice__memory(&def_file_path_memory_slice), memory_slice__size(&def_file_path_memory_slice),
        "%s/%s_defs.h",
        self->dirprefix, self->basename
    );
    if (bytes_written >= memory_slice__size(&def_file_path_memory_slice)) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }

    // note: string_replacer doesn't support replacing replacements, so I do this in two write steps if the def_file doesn't exist
    // first, I replace the template, then write it out to the def file
    // second, read from the now existing def file and replace its contents
    bool should_update_def_file = true;
    if (file__exists(memory_slice__memory(&def_file_path_memory_slice)) == false) {
        def_file_add_error_codes_place_holder__create(
            self,
            allocator,
            memory_slice__memory(&def_file_path_memory_slice),
            module_name_capitalized
        );
    } else {
        if (file__exists(memory_slice__memory(&config_file_path_memory_slice))) {
            struct time config_file_last_modified;
            struct time def_file_last_modified;
            TEST_FRAMEWORK_ASSERT(file__last_modified(memory_slice__memory(&config_file_path_memory_slice), &config_file_last_modified));
            TEST_FRAMEWORK_ASSERT(file__last_modified(memory_slice__memory(&def_file_path_memory_slice), &def_file_last_modified));
            // note: only update def file if:
            //  - .gmc file is newer
            if (time__cmp(def_file_last_modified, config_file_last_modified) >= 0) {
                should_update_def_file = false;
            }
            // todo: determine when exactly to update def file
            // if I just set it to true, def files will always be updated and a full
            // rebuild will be forced on each compile 
            // should_update_def_file = true;
        }
        if (should_update_def_file) {
            def_file_add_error_codes_place_holder__update(
                self,
                allocator,
                memory_slice__memory(&def_file_path_memory_slice),
                module_name_capitalized,
                rest_of_the_error_codes
            );
        }
    }

    u32 def_file_size = 0;
    struct memory_slice def_file_memory_slice;
    struct string_replacer def_file_string_replacer;
    if (should_update_def_file) {
        def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
        struct file def_file;
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, memory_slice__memory(&def_file_path_memory_slice), FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
        def_file_size = file__read(&def_file, memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice));
        file__close(&def_file);
        if (def_file_size == memory_slice__size(&def_file_memory_slice)) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        ASSERT(
            string_replacer__create(
                &def_file_string_replacer,
                allocator,
                memory_slice__memory(&def_file_memory_slice), def_file_size,
                DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
            )
        );
    }

    struct memory_slice error_codes_memory_slice = linear_allocator__push(allocator, ERROR_CODE_LINE_AVERAGE_LENGTH * ERROR_CODES_MAX_NUMBER);
    parse_and_handle_config_file(
        modules,
        allocator,
        self,
        error_codes_file,
        memory_slice__memory(&config_file_path_memory_slice),
        module_name_capitalized,
        error_codes_memory_slice
    );

    if (should_update_def_file) {
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word_f(
            &def_file_string_replacer,
            number_of_what_replacements,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            "%s", memory_slice__memory(&error_codes_memory_slice)
        );
        struct file def_file;
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, memory_slice__memory(&def_file_path_memory_slice), FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        string_replacer__read_into_file(
            &def_file_string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);

        linear_allocator__pop(allocator, error_codes_memory_slice);

        string_replacer__destroy(&def_file_string_replacer);
        
        linear_allocator__pop(allocator, def_file_memory_slice);
    } else {
        linear_allocator__pop(allocator, error_codes_memory_slice);
    }


    if (self->parent == NULL) {
        linear_allocator__pop(allocator, def_file_path_memory_slice);
        linear_allocator__pop(allocator, config_file_path_memory_slice);
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
            memory_slice__memory(&config_file_path_memory_slice),
            memory_slice__size(&config_file_path_memory_slice),
            "%s/%s/%s/%s_%s.%s",
            self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, platform_specific,
            self->basename, platform_specific, CONFIG_EXTENSION
        ) < memory_slice__size(&config_file_path_memory_slice)
    );
    TEST_FRAMEWORK_ASSERT(file__exists(memory_slice__memory(&config_file_path_memory_slice)));

    bytes_written = libc__snprintf(
        memory_slice__memory(&def_file_path_memory_slice),
        memory_slice__size(&def_file_path_memory_slice),
        "%s/%s/%s/%s_platform_specific_defs.h",
        self->dirprefix, PLATFORM_SPECIFIC_FOLDER_NAME, platform_specific, self->basename
    );
    if (bytes_written >= memory_slice__size(&def_file_path_memory_slice)) {
        // error_code__exit(DEF_FILE_NAME_BUFFER_SIZE_TOO_SMALL);
        error_code__exit(867);
    }

    should_update_def_file = true;
    if (file__exists(memory_slice__memory(&def_file_path_memory_slice)) == false) {
        def_file_add_error_codes_place_holder__create_platform_specific(
            self,
            allocator,
            memory_slice__memory(&def_file_path_memory_slice),
            module_name_capitalized,
            platform_specific,
            platform_specific_capitalized
        );
    } else {
        if (file__exists(memory_slice__memory(&config_file_path_memory_slice))) {
            struct time config_file_last_modified;
            struct time def_file_last_modified;
            TEST_FRAMEWORK_ASSERT(file__last_modified(memory_slice__memory(&config_file_path_memory_slice), &config_file_last_modified));
            TEST_FRAMEWORK_ASSERT(file__last_modified(memory_slice__memory(&def_file_path_memory_slice), &def_file_last_modified));
            // note: only update def file if .gmc file is newer
            if (time__cmp(def_file_last_modified, config_file_last_modified) >= 0) {
                should_update_def_file = false;
            }
        }
        if (should_update_def_file) {
            def_file_add_error_codes_place_holder__update_platform_specific(
                self,
                allocator,
                memory_slice__memory(&def_file_path_memory_slice),
                module_name_capitalized,
                rest_of_the_error_codes,
                platform_specific,
                platform_specific_capitalized
            );
        }
    }

    def_file_size = 0;
    if (should_update_def_file) {
        def_file_memory_slice = linear_allocator__push(allocator, DEF_FILE_MAX_SIZE);
        struct file def_file;
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, memory_slice__memory(&def_file_path_memory_slice), FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
        def_file_size = file__read(&def_file, memory_slice__memory(&def_file_memory_slice), memory_slice__size(&def_file_memory_slice));
        file__close(&def_file);
        if (def_file_size == memory_slice__size(&def_file_memory_slice)) {
            // error_code__exit(DEF_FILE_BUFFER_SIZE_TOO_SMALL);
            error_code__exit(999);
        }
        ASSERT(
            string_replacer__create(
                &def_file_string_replacer,
                allocator,
                memory_slice__memory(&def_file_memory_slice), def_file_size,
                DEF_FILE_MAX_NUMBER_OF_STRING_REPLACEMENTS, DEF_FILE_AVERAGE_REPLACEMENT_SIZE
            )
        );
    }

    error_codes_memory_slice = linear_allocator__push(allocator, ERROR_CODE_LINE_AVERAGE_LENGTH * ERROR_CODES_MAX_NUMBER);
    parse_and_handle_platform_specific_config_file(
        modules,
        allocator,
        self,
        error_codes_file,
        memory_slice__memory(&config_file_path_memory_slice),
        module_name_capitalized,
        error_codes_memory_slice
    );

    if (should_update_def_file) {
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word_f(
            &def_file_string_replacer,
            number_of_what_replacements,
            rest_of_the_error_codes, rest_of_the_error_codes_len,
            "%s", memory_slice__memory(&error_codes_memory_slice)
        );
        struct file def_file;
        TEST_FRAMEWORK_ASSERT(file__open(&def_file, memory_slice__memory(&def_file_path_memory_slice), FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        string_replacer__read_into_file(
            &def_file_string_replacer,
            &def_file,
            0
        );
        file__close(&def_file);

        linear_allocator__pop(allocator, error_codes_memory_slice);

        string_replacer__destroy(&def_file_string_replacer);
        
        linear_allocator__pop(allocator, def_file_memory_slice);
    } else {
        linear_allocator__pop(allocator, error_codes_memory_slice);
    }

    linear_allocator__pop(allocator, def_file_path_memory_slice);
    linear_allocator__pop(allocator, config_file_path_memory_slice);

}

static void update_platform_specific_directories(
    struct linear_allocator* allocator,
    const char* path
) {
    struct memory_slice file_path_memory_slice = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/windows",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_file(
        file_path_memory_slice,
        "%s/%s/windows/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/linux",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_file(
        file_path_memory_slice,
        "%s/%s/linux/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_dir(
        file_path_memory_slice,
        "%s/%s/mac",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    assert_create_file(
        file_path_memory_slice,
        "%s/%s/mac/.gitkeep",
        path, PLATFORM_SPECIFIC_FOLDER_NAME
    );
    linear_allocator__pop(allocator, file_path_memory_slice);
}

static void ensure_test_file_template_exists(
    struct module* self,
    struct linear_allocator* allocator,
    struct memory_slice test_file_template_contents
) {
    if (self->parent == NULL) {
        return ;
    }

    char module_test_file_path[256];
    u32 bytes_written = libc__snprintf( 
        module_test_file_path,
        ARRAY_SIZE(module_test_file_path),
        "%s/%s/%s%s",
        self->dirprefix, TEST_FOLDER_NAME,  self->basename, TEST_FILE_SUFFIX
    );
    if (bytes_written == ARRAY_SIZE(module_test_file_path)) {
        // error_code__exit(BUFFER_IS_TOO_SMALL_IN_SBPRINF_ERROR);
        error_code__exit(354553);
    };

    if (file__exists(module_test_file_path)) {
        return;
    }

    u32 max_number_of_replacements = 1;
    u32 average_number_of_replacement_size = MAX_FILE_PATH_SIZE + 16;
    struct string_replacer test_file_template_replacer;
    string_replacer__create(
        &test_file_template_replacer,
        allocator,
        memory_slice__memory(&test_file_template_contents), memory_slice__size(&test_file_template_contents),
        max_number_of_replacements,
        average_number_of_replacement_size
    );
    static char what[] = "$(MODULE_HEADER)";
    // todo: remove this unnecessary work and the assumption about self->dirprefix
    const char modules_prefix[] = "modules/";
    TEST_FRAMEWORK_ASSERT(libc__strncmp(modules_prefix, self->dirprefix, ARRAY_SIZE(modules_prefix) - 1) == 0);
    string_replacer__replace_word_f(
        &test_file_template_replacer,
        1, what, ARRAY_SIZE(what) - 1,
        "%s/%s.h", self->dirprefix + ARRAY_SIZE(modules_prefix) - 1, self->basename
    );

    struct file module_test_file;
    TEST_FRAMEWORK_ASSERT(file__open(&module_test_file, module_test_file_path, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
    string_replacer__read_into_file(&test_file_template_replacer, &module_test_file, 0);
    file__close(&module_test_file);

    string_replacer__destroy(&test_file_template_replacer);
}

struct is_module_path_context {
    struct stack* modules;
    struct linear_allocator* allocator;
};

// @returns true if path is a module
// @note as a side effect:
//  - adds the module to its parent
bool is_module_path(const char* path, void* user_data) {
    struct is_module_path_context* context = (struct is_module_path_context*) user_data;
    struct memory_slice parent_path_memory_slice = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);
    struct memory_slice child_basename_memory_slice = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);
    struct memory_slice parent_basename_memory_slice = linear_allocator__push(context->allocator, MAX_FILE_PATH_SIZE);

    u32 path_len = libc__strlen(path);
    u32 basename_len;
    u32 directory_len;
    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            path, path_len,
            memory_slice__memory(&child_basename_memory_slice), memory_slice__size(&child_basename_memory_slice), &basename_len,
            memory_slice__memory(&parent_path_memory_slice), memory_slice__size(&parent_path_memory_slice), &directory_len
        )
    );
    if (
        directory_len == 0 ||
        libc__strcmp(PLATFORM_SPECIFIC_FOLDER_NAME, memory_slice__memory(&child_basename_memory_slice)) == 0 ||
        libc__strcmp(TEST_FOLDER_NAME, memory_slice__memory(&child_basename_memory_slice)) == 0 ||
        libc__strcmp(IMPLEMENTATION_FOLDER_NAME, memory_slice__memory(&child_basename_memory_slice)) == 0
    ) {
        linear_allocator__pop(context->allocator, parent_basename_memory_slice);
        linear_allocator__pop(context->allocator, child_basename_memory_slice);
        linear_allocator__pop(context->allocator, parent_path_memory_slice);
        // skip if:
        //  - root module
        //  - platform specific folder
        //  - test folder
        //  - implementation folder
        return false;
    }

    update_platform_specific_directories(context->allocator, path);
    // create test folder
    // todo: merge these 2 (or 3) into one since we already know the prefix which is the test folder, no need to recreate them again and again
    if (libc__strcmp(memory_slice__memory(&child_basename_memory_slice), TEST_FRAMEWORK_MODULE_NAME) != 0) {
        assert_create_dir(
            parent_basename_memory_slice,
            "%s/%s",
            path, TEST_FOLDER_NAME
        );
        assert_create_file(
            parent_basename_memory_slice,
            "%s/%s/.gitkeep",
            path, TEST_FOLDER_NAME, PLATFORM_SPECIFIC_FOLDER_NAME
        );
        assert_create_dir(
            parent_basename_memory_slice,
            "%s/%s",
            path, IMPLEMENTATION_FOLDER_NAME
        );
        assert_create_file(
            parent_basename_memory_slice,
            "%s/%s/.gitkeep",
            path, IMPLEMENTATION_FOLDER_NAME, PLATFORM_SPECIFIC_FOLDER_NAME
        );
    }

    u32 parent_basename_len;
    TEST_FRAMEWORK_ASSERT(
        file_path__decompose(
            memory_slice__memory(&parent_path_memory_slice), directory_len,
            memory_slice__memory(&parent_basename_memory_slice), memory_slice__size(&parent_basename_memory_slice), &parent_basename_len,
            NULL, 0, NULL
        )
    );

    struct module* parent = module_compiler__find_module_by_name(context->modules, memory_slice__memory(&parent_basename_memory_slice));
    TEST_FRAMEWORK_ASSERT(parent != NULL);
    module_compiler__add_child(context->modules, parent, memory_slice__memory(&child_basename_memory_slice));

    linear_allocator__pop(context->allocator, parent_basename_memory_slice);
    linear_allocator__pop(context->allocator, child_basename_memory_slice);
    linear_allocator__pop(context->allocator, parent_path_memory_slice);

    return true;
}

void module_compiler__explore_children(
    struct stack* modules,
    struct linear_allocator* allocator,
    struct module* self
) {
    struct directory dir;

    struct is_module_path_context is_module_path_context;
    is_module_path_context.allocator = allocator;
    is_module_path_context.modules = modules;

    TEST_FRAMEWORK_ASSERT(directory__open(&dir, self->dirprefix) == true);
    directory__foreach_deep(self->dirprefix, &is_module_path, &is_module_path_context, FILE_TYPE_DIRECTORY);
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
    struct stack* modules,
    struct module* self,
    char** dependency_buffer,
    u32 dependency_buffer_size
) {
    module_compiler__write_dependency_into_buffer_and_increment(self, dependency_buffer, &dependency_buffer_size);
    dependency_buffer_size = module_compiler__get_dependencies(self, dependency_buffer, dependency_buffer_size);

    struct module* common_test_dependency = module_compiler__find_module_by_name(modules, TEST_FRAMEWORK_MODULE_NAME);
    if (common_test_dependency == NULL) {
        libc__printf("%s\n", self->basename);
        error_code__exit(MODULE_COMPILER_ERROR_CODE_DEPENDENCY_NOT_FOUND);
    }
    bool added_common_test_dependency = false;
    if (self == common_test_dependency) {
        added_common_test_dependency = true;
    }

    for (u32 dependency_index = 0; dependency_index < ARRAY_SIZE_MEMBER(struct module, test_dependencies); ++dependency_index) {
        struct module* test_dependency = self->test_dependencies[dependency_index];
        if (test_dependency != NULL && test_dependency->transient_flag_for_processing == 0) {
            if (test_dependency == common_test_dependency) {
                if (added_common_test_dependency) {
                    continue ;
                }
                added_common_test_dependency = true;
            }
            module_compiler__write_dependency_into_buffer_and_increment(test_dependency, dependency_buffer, &dependency_buffer_size);
            dependency_buffer_size = module_compiler__get_dependencies(
                test_dependency,
                dependency_buffer,
                dependency_buffer_size
            );
        }
    }

    if (added_common_test_dependency == false) {
        module_compiler__write_dependency_into_buffer_and_increment(common_test_dependency, dependency_buffer, &dependency_buffer_size);
        dependency_buffer_size = module_compiler__get_dependencies(common_test_dependency, dependency_buffer, dependency_buffer_size);
    }

    return dependency_buffer_size;
}

void module_compiler__embed_dependencies_into_makefile(
    struct stack* modules,
    struct linear_allocator* allocator
) {
    struct file modules_makefile_template_file;
    ASSERT(file__open(&modules_makefile_template_file, MODULES_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    u32 modules_makefile_max_size = KILOBYTES(32);
    ASSERT(modules_makefile_max_size <= linear_allocator__available(allocator));
    struct memory_slice modules_makefile_template_memory_slice = linear_allocator__push(allocator, modules_makefile_max_size);
    u32 modules_makefile_template_file_size = file__read(
        &modules_makefile_template_file,
        memory_slice__memory(&modules_makefile_template_memory_slice),
        memory_slice__size(&modules_makefile_template_memory_slice)
    );
    if (modules_makefile_template_file_size == (u32) memory_slice__size(&modules_makefile_template_memory_slice)) {
        // error_code__exit(FILE_BUFFER_TOO_SMALL);
        error_code__exit(43825);
    }
    file__close(&modules_makefile_template_file);

    struct memory_slice makefile_path_memory_slice = linear_allocator__push(allocator, MAX_FILE_PATH_SIZE);

    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        struct module* cur_module = (struct module*) stack__at(modules, module_index);

        struct memory_slice dependencies_memory_slice = linear_allocator__push(allocator, ARRAY_SIZE(cur_module->basename) * (stack__capacity(modules) >> 1));
        char* cur_dependency_buffer = memory_slice__memory(&dependencies_memory_slice);
        module_compiler__clear_transient_flags(modules);
        u32 dependencies_buffer_size_left = module_compiler__get_dependencies(cur_module, &cur_dependency_buffer, memory_slice__size(&dependencies_memory_slice));

        static const char module_dependency_replace_what[] = "$(MODULE_LIBDEP_MODULES)";
        static const char module_test_dependency_replace_what[] = "$(MODULE_TEST_DEPENDS)";
        static const char module_name_replace_what[] = "$(MODULE_NAME)";
        static const char module_lflags_specific_replace_what[] = "$(LFLAGS_SPECIFIC)";
        static const u32 module_dependency_replace_what_len = ARRAY_SIZE(module_dependency_replace_what) - 1;
        static const u32 module_test_dependency_replace_what_len = ARRAY_SIZE(module_test_dependency_replace_what) - 1;
        static const u32 module_name_replace_what_len = ARRAY_SIZE(module_name_replace_what) - 1;
        static const u32 module_lflags_specific_replace_what_len = ARRAY_SIZE(module_lflags_specific_replace_what) - 1;

        static const u32 max_number_of_module_name_occurances = 128;
        static const u32 max_number_of_occurances_aux = 16;
        static const u32 average_replacement_size = 32;
        struct string_replacer modules_makefile_template_replacer;
        ASSERT(string_replacer__create(
            &modules_makefile_template_replacer,
            allocator,
            memory_slice__memory(&modules_makefile_template_memory_slice),
            modules_makefile_template_file_size,
            max_number_of_module_name_occurances + max_number_of_occurances_aux,
            average_replacement_size
        ));
        u32 number_of_what_replacements = 1;
        string_replacer__replace_word(
            &modules_makefile_template_replacer,
            number_of_what_replacements,
            module_dependency_replace_what,
            module_dependency_replace_what_len,
            memory_slice__memory(&dependencies_memory_slice),
            memory_slice__size(&dependencies_memory_slice) - dependencies_buffer_size_left
        );

        module_compiler__clear_transient_flags(modules);
        cur_dependency_buffer = memory_slice__memory(&dependencies_memory_slice);
        dependencies_buffer_size_left = module_compiler__get_test_dependencies(modules, cur_module, &cur_dependency_buffer, memory_slice__size(&dependencies_memory_slice));
        number_of_what_replacements = (u32) 1;
        string_replacer__replace_word(
            &modules_makefile_template_replacer,
            number_of_what_replacements,
            module_test_dependency_replace_what,
            module_test_dependency_replace_what_len,
            memory_slice__memory(&dependencies_memory_slice),
            memory_slice__size(&dependencies_memory_slice) - dependencies_buffer_size_left
        );

        number_of_what_replacements = (u32) -1;
        string_replacer__replace_word(
            &modules_makefile_template_replacer,
            number_of_what_replacements,
            module_name_replace_what,
            module_name_replace_what_len,
            cur_module->basename,
            libc__strlen(cur_module->basename)
        );

        number_of_what_replacements = 1;
        u32 new_makefile_size = string_replacer__replace_word(
            &modules_makefile_template_replacer,
            number_of_what_replacements,
            module_lflags_specific_replace_what,
            module_lflags_specific_replace_what_len,
            cur_module->application_type,
            libc__strlen(cur_module->application_type)
        );

        u32 written_bytes = libc__snprintf(
            memory_slice__memory(&makefile_path_memory_slice),
            memory_slice__size(&makefile_path_memory_slice),
            "%s/%s.mk",
            cur_module->dirprefix, cur_module->basename
        );
        TEST_FRAMEWORK_ASSERT(written_bytes < memory_slice__size(&makefile_path_memory_slice));
        static const char modules_dir_path[] = "modules";
        const u32 modules_dir_path_size = ARRAY_SIZE(modules_dir_path) - 1;

        struct string_replacer string_replacer_aux;
        ASSERT(string_replacer__create(
            &string_replacer_aux,
            allocator,
            memory_slice__memory(&makefile_path_memory_slice),
            written_bytes,
            1,
            libc__strlen(MODULES_PATH)
        ));
        string_replacer__replace_word(
            &string_replacer_aux,
            1,
            modules_dir_path, modules_dir_path_size,
            MODULES_PATH, libc__strlen(MODULES_PATH)
        );
        struct memory_slice file_path_memory =
        linear_allocator__push(
            allocator,
            ARRAY_SIZE(cur_module->basename) + ARRAY_SIZE(cur_module->dirprefix)
        );
        TEST_FRAMEWORK_ASSERT(
            string_replacer__read(
                &string_replacer_aux,
                memory_slice__memory(&file_path_memory),
                memory_slice__size(&file_path_memory),
                0
            ) < memory_slice__size(&file_path_memory)
        );
        struct file makefile;
        TEST_FRAMEWORK_ASSERT(file__open(&makefile, memory_slice__memory(&file_path_memory), FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        TEST_FRAMEWORK_ASSERT(
            string_replacer__read_into_file(
                &modules_makefile_template_replacer,
                &makefile,
                0
            ) == new_makefile_size
        );

        linear_allocator__pop(allocator, file_path_memory);
        string_replacer__destroy(&string_replacer_aux);
        string_replacer__destroy(&modules_makefile_template_replacer);
        linear_allocator__pop(allocator, dependencies_memory_slice);
        file__close(&makefile);
    }

    linear_allocator__pop(allocator, makefile_path_memory_slice);
    linear_allocator__pop(allocator, modules_makefile_template_memory_slice);
}

void module_compiler__ensure_test_file_templates_exist(
    struct stack* modules,
    struct linear_allocator* allocator
) {
    struct memory_slice test_file_template_memory_slice = linear_allocator__push(allocator, TEST_FILE_TEMPLATE_MAX_SIZE);
    struct file test_file_template;
    TEST_FRAMEWORK_ASSERT(file__open(&test_file_template, TEST_FILE_TEMPLATE_PATH, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));
    u32 read_bytes = file__read(&test_file_template, memory_slice__memory(&test_file_template_memory_slice), memory_slice__size(&test_file_template_memory_slice));
    file__close(&test_file_template);
    TEST_FRAMEWORK_ASSERT(read_bytes < memory_slice__size(&test_file_template_memory_slice));
    ((char*) memory_slice__memory(&test_file_template_memory_slice))[read_bytes] = '\0';

    for (u32 module_index = 0; module_index < stack__size(modules); ++module_index) {
        struct module* module = stack__at(modules, module_index);
        if (libc__strcmp(module->basename, TEST_FRAMEWORK_MODULE_NAME) == 0) {
            continue;
        }

        ensure_test_file_template_exists(module, allocator, test_file_template_memory_slice);
    }

    linear_allocator__pop(allocator, test_file_template_memory_slice);
}
