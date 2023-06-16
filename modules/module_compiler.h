#ifndef MODULE_COMPILER_H
# define MODULE_COMPILER_H

# include "module_compiler_defs.h"

struct string_replacer;
struct generic_array;
struct file;
struct file_reader;
struct file_writer;

struct module {
    struct module* first_child; // first child module
    struct module* next_sibling; // next sibling
    struct module* dependencies[16]; // hard limit (must be pow of 2) on the number of dependencies
    struct module* test_dependencies[16];
    struct module* parent;
    char basename[64];
    char dirprefix[512];
    // todo: remove
    char application_type[16]; // either "-mwindows" or "-mconsole"
    char test_application_type[16]; // either "-mwindows" or "-mconsole"

    s32 number_of_submodules; // number of submodules this module has
    s32 transient_flag_for_processing;
};

PUBLIC_API struct module* module_compiler__add_child(
    struct generic_array* modules,
    struct module* self,
    const char* child_module_basename
);

PUBLIC_API void module_compiler__clear_transient_flags(struct generic_array* modules);

// @brief print all dependencies of the module
PUBLIC_API void module_compiler__print_dependencies(struct module* self);
PUBLIC_API void module_compiler__add_dependency(struct module* self, struct module* dependency);
PUBLIC_API void module_compiler__add_test_dependency(struct module* self, struct module* dependency);
PUBLIC_API void module_compiler__print_branch(
    struct module* from,
    struct generic_array* modules
);

// @brief check if any modules has a cyclic dependency
PUBLIC_API void module_compiler__check_cyclic_dependency(struct generic_array* modules);

PUBLIC_API u32 module_compiler__get_error_code(void);

PUBLIC_API void module_compiler__preprocess_file(const char* path);

PUBLIC_API void module_compiler__ensure_test_file_templates_exist(
    struct generic_array* modules,
    struct string_replacer* string_replacer
);

PUBLIC_API void module_compiler__explore_children(
    struct generic_array* modules,
    struct module* self
);

PUBLIC_API void module_compiler__parse_config_file(
    struct generic_array* modules,
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
PUBLIC_API void module_compiler__parse_config_files(struct generic_array* modules);

PUBLIC_API void module_compiler__embed_dependencies_into_makefile(
    struct generic_array* modules,
    const char* file_path_prefix,
    char* file_path_buffer,
    char* file_buffer,
    char* dependencies_buffer,
    char* auxiliary_buffer,
    struct string_replacer* string_replacer,
    struct string_replacer* string_replacer_aux,
    u32 file_path_buffer_size,
    u32 file_buffer_size,
    u32 dependencies_buffer_size,
    u32 auxiliary_buffer_size
);

PUBLIC_API struct module* module_compiler__find_module_by_name(
    struct generic_array* modules,
    const char* basename
);

#endif
