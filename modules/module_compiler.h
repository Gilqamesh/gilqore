#ifndef MODULE_COMPILER_H
# define MODULE_COMPILER_H

# include "module_compiler_defs.h"

struct linear_allocator;
struct string_replacer;
struct stack;
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
    struct stack* modules,
    struct module* self,
    const char* child_module_basename
);

PUBLIC_API void module_compiler__clear_transient_flags(struct stack* modules);

// @brief print all dependencies of the module
PUBLIC_API void module_compiler__print_dependencies(struct module* self);
PUBLIC_API void module_compiler__add_dependency(struct module* self, struct module* dependency);
PUBLIC_API void module_compiler__add_test_dependency(struct module* self, struct module* dependency);
PUBLIC_API void module_compiler__print_branch(
    struct module* from,
    struct stack* modules
);

// @brief check if any modules has a cyclic dependency
PUBLIC_API void module_compiler__check_cyclic_dependency(struct stack* modules);

PUBLIC_API u32 module_compiler__get_error_code(void);

PUBLIC_API void module_compiler__preprocess_file(const char* path);

PUBLIC_API void module_compiler__ensure_test_file_templates_exist(
    struct stack* modules,
    struct linear_allocator* allocator
);

PUBLIC_API void module_compiler__explore_children(
    struct stack* modules,
    struct linear_allocator* allocator,
    struct module* self
);

// keep either this or module_compiler__parse_config_files
PUBLIC_API void module_compiler__parse_config_file(
    struct stack* modules,
    struct module* self,
    struct linear_allocator* allocator,
    struct file* error_codes_file
);
PUBLIC_API void module_compiler__parse_config_files(
    struct stack* modules,
    struct linear_allocator* allocator
);

PUBLIC_API void module_compiler__embed_dependencies_into_makefile(
    struct stack* modules,
    struct linear_allocator* allocator
);

PUBLIC_API struct module* module_compiler__find_module_by_name(
    struct stack* modules,
    const char* basename
);

#endif
