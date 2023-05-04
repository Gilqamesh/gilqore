#ifndef MODULE_COMPILER_UTILS_H
# define MODULE_COMPILER_UTILS_H

# include "module_compiler_defs.h"

#include "module_compiler_utils.h"

struct module {
    struct module* first_child; // first child module
    struct module* next_sibling; // next sibling
    struct module* dependencies[16]; // hard limit (must be pow of 2) on the number of dependencies
    char name[64];
    s32 starting_error_code; // start error code this module has access to
    s32 children_starting_error_code;
    s32 ending_error_code; // end error code this module has access to
    s32 number_of_submodules; // number of submodules this module has
    s32 children_disposition; // the offset between children submodules
    s32 num_of_errors; // number of unique errors parsed from the module's config file during its compilation
    s32 transient_flag_for_processing;
};

struct module* module_compiler__add_child(struct module* self, const char* child_module_name);

// @brief update child module based on its parent
// @param child_index index of the child relative to its siblings
void module_compiler__update_child(struct module* self, struct module* child, s32 child_index);
// @brief update branch from self
void module_compiler__update_branch(struct module* self);
// todo: remove
void module_compiler__clear_transient_flags(void);
// @brief print all dependencies of the module
void module_compiler__print_dependencies(struct module* self);
void module_compiler__add_dependency(struct module* self, struct module* dependency);
void module_compiler__print_branch(struct module* self);
// @brief check if any modules has a cyclic dependency
void module_compiler__check_cyclic_dependency(void);


#endif
