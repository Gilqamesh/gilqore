#include "module_compiler_utils.h"
#include <stdio.h>

#include "system/process/process.h"
#include "io/file/file.h"
#include "libc/libc.h"

struct module g_modules[1024];
u32 g_modules_size;

void module_compiler__clear_transient_flags(void) {
    for (u32 i = 0; i < g_modules_size; ++i) {
        g_modules[i].transient_flag_for_processing = 0;
    }
}

// @brief update sm based on pm
void module_compiler__update_child(struct module* self, struct module* child, s32 child_index) {
    child->starting_error_code = self->children_starting_error_code + child_index * self->children_disposition;
    child->ending_error_code = child->starting_error_code + self->children_disposition - 1;
    child->children_starting_error_code = child->starting_error_code + child->num_of_errors;
    child->children_disposition = (child->ending_error_code - child->children_starting_error_code + 1) / (child->number_of_submodules + 1);
}

void module_compiler__update_branch(struct module* self) {
    struct module* child = self->first_child;
    for (s32 i = 0; child != NULL; ++i, child = child->next_sibling) {
        module_compiler__update_child(self, child, i);
        module_compiler__update_branch(child);
    }
}

struct module* module_compiler__add_child(struct module* self, const char* child_module_name) {
    struct module* child = &g_modules[g_modules_size++];

    u32 name_index = 0;
    for (; name_index + 1 < ARRAY_SIZE(child->name) && child_module_name[name_index] != '\0'; ++name_index) {
        child->name[name_index] = child_module_name[name_index];
    }
    child->name[name_index] = '\0';
    child->num_of_errors = 10; // hardcoded, todo: parse from config file

    struct module* first_child = self->first_child;
    self->first_child = child;
    child->next_sibling = first_child;
    self->children_disposition = (self->ending_error_code - self->children_starting_error_code + 1) / (self->number_of_submodules++ + 1);
    // update the whole branch from here
    module_compiler__update_branch(self);

    return child;
}

void module_compiler__add_dependency(struct module* self, struct module* dependency) {
    u32 hash_value = (dependency->starting_error_code * 56237) & ARRAY_SIZE(self->dependencies);
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
    printf("hard limit (%lld) on the number of dependencies reached for module: %s\n",
    ARRAY_SIZE(self->dependencies), self->name);
    exit(1);
}

static void module_compiler__check_cyclic_dependency_helper(struct module* self) {
    if (self->transient_flag_for_processing > 0) {
        printf("\ncyclic dependency detected between these modules: ");
        for (u32 i = 0; i < g_modules_size; ++i) {
            if (g_modules[i].transient_flag_for_processing > 0) {
                printf("%s ", g_modules[i].name);
            }
        }
        printf("\n");
        exit(1);
        return ;
    }
    self->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(self->dependencies); ++i) {
        if (self->dependencies[i] != NULL) {
            module_compiler__check_cyclic_dependency_helper(self->dependencies[i]);
        }
    }
    self->transient_flag_for_processing = 0;
}

void module_compiler__check_cyclic_dependency(void) {
    module_compiler__clear_transient_flags();
    module_compiler__check_cyclic_dependency_helper(&g_modules[0]);
}

void module_compiler__print_dependencies(struct module* self) {
    self->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(self->dependencies); ++i) {
        if (self->dependencies[i] != NULL && self->dependencies[i]->transient_flag_for_processing == 0) {
            printf("%s ", self->dependencies[i]->name);
            module_compiler__print_dependencies(self->dependencies[i]);
        }
    }
}

static void module_compiler__print_branch_helper(struct module* self, s32 depth) {
    printf("%*s --== %s ==-- \n %*sstart: %d\n %*sstart_child: %d\n %*send: %d\n %*snumber of submodules: %d\n %*sdisposition: %d\n %*sunique number of errors: %d\n %*sdependencies: ",
    depth, "", self->name,
    depth, "", self->starting_error_code,
    depth, "", self->children_starting_error_code,
    depth, "", self->ending_error_code,
    depth, "", self->number_of_submodules,
    depth, "", self->children_disposition,
    depth, "", self->num_of_errors,
    depth, "");

    module_compiler__clear_transient_flags();
    module_compiler__print_dependencies(self);
    printf("\n\n");
    struct module* child = self->first_child;
    while (child) {
        module_compiler__print_branch_helper(child, depth + 4);
        child = child->next_sibling;
    }
}

void module_compiler__print_branch(struct module* self) {
    module_compiler__print_branch_helper(self, 0);
}
