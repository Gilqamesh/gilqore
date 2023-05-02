#ifndef MODULE_COMPILER_H
# define MODULE_COMPILER_H

struct dependency;

struct module {
    char name[64];
    int start; // start error code this module has access to
    int start_child;
    int end; // end error code this module has access to
    int number_of_submodules; // number of submodules this module has
    int disposition; // the offset between children submodules
    int unique_n_of_errors; // number of unique errors parsed from the module's config file during its compilation
    struct module* first_child; // first child module
    struct module* next; // next sibling
    struct module* dependencies[16]; // hard limit (must be pow of 2) on the number of dependencies
    int transient_flag_for_processing;
};

void module_add_child(struct module* pm, struct module* sm, const char* sm_name);

void module_add_dependency(struct module* m, struct module* dm);

void module_print(struct module* m);

#endif
