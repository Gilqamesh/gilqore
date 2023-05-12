#ifndef MODULE_COMPILER_UTILS_H
# define MODULE_COMPILER_UTILS_H

# include "module_compiler_defs.h"

#include "module_compiler_utils.h"
#include "io/io_defs.h"

struct module {
    struct module* first_child; // first child module
    struct module* next_sibling; // next sibling
    struct module* dependencies[16]; // hard limit (must be pow of 2) on the number of dependencies
    struct module* parent;
    char basename[64];
    char dirprefix[512];
    char application_type[16]; // either "-mwindows" or "-mconsole"
    s32 number_of_submodules; // number of submodules this module has
    s32 transient_flag_for_processing;
};

struct module* module_compiler__add_child(
    struct module* modules,
    struct module* self,
    const char* child_module_basename,
    u32* modules_size_cur,
    u32 modules_size_max
);

void module_compiler__clear_transient_flags(
    struct module* modules,
    u32 modules_size
);
// @brief print all dependencies of the module
void module_compiler__print_dependencies(struct module* self);
void module_compiler__add_dependency(struct module* self, struct module* dependency);
void module_compiler__print_branch(
    struct module* from,
    struct module* modules,
    u32 modules_size
);
// @brief check if any modules has a cyclic dependency
void module_compiler__check_cyclic_dependency(
    struct module* from,
    struct module* modules,
    u32 modules_size
);
u32 module_compiler__get_error_code(void);

#endif
