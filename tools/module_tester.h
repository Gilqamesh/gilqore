struct module {
    char name[64];
    int start; // start error code this module has access to
    int start_child;
    int end; // end error code this module has access to
    int number_of_submodules; // number of submodules this module has
    int disposition; // the offset between children submodules
    float unique_error_percentage;
    struct module* first_child; // first child module
    struct module* next; // next sibling
};

// @brief the starting point of the child module
int module_child_base(struct module m, int child_index);
// @brief update sm based on pm

void module_add_child(struct module* pm, struct module* sm, const char* sm_name, float sm_unique_error_percentage);

void module_print(struct module* m);
