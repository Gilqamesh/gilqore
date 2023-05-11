#include "module_compiler_utils.h"
#include <stdio.h>

#include "system/process/process.h"
#include "io/file/file.h"
#include "libc/libc.h"

struct module g_modules[1024];
u32 g_modules_size;
u32 g_error_code = 1;

void module_compiler__clear_transient_flags(void) {
    for (u32 i = 0; i < g_modules_size; ++i) {
        g_modules[i].transient_flag_for_processing = 0;
    }
}

struct module* module_compiler__add_child(struct module* self, const char* child_module_basename) {
    struct module* child = &g_modules[g_modules_size++];
    child->parent = self;
    if ((u32) libc__snprintf(child->dirprefix, ARRAY_SIZE(child->dirprefix), "%s/%s", self->dirprefix, child_module_basename) >= ARRAY_SIZE(child->dirprefix)) {
        // error_code__exit(CHILD_PREFIX_TOO_LONG);
        error_code__exit(836);
    }

    u32 name_index = 0;
    for (; name_index + 1 < ARRAY_SIZE(child->basename) && child_module_basename[name_index] != '\0'; ++name_index) {
        child->basename[name_index] = child_module_basename[name_index];
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
    printf("hard limit (%lld) on the number of dependencies reached for module: %s\n",
    ARRAY_SIZE(self->dependencies), self->basename);
    exit(1);
}

static void module_compiler__check_cyclic_dependency_helper(struct module* self) {
    if (self->transient_flag_for_processing > 0) {
        printf("\ncyclic dependency detected between these modules: ");
        for (u32 i = 0; i < g_modules_size; ++i) {
            if (g_modules[i].transient_flag_for_processing > 0) {
                printf("%s ", g_modules[i].basename);
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
            printf("%s ", self->dependencies[i]->basename);
            module_compiler__print_dependencies(self->dependencies[i]);
        }
    }
}

static void module_compiler__print_branch_helper(struct module* self, s32 depth) {
    printf("%*s --== %s ==-- \n %*snumber of submodules: %d\n %*sdependencies: ",
    depth, "", self->basename,
    depth, "", self->number_of_submodules,
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

u32 module_compiler__get_error_code(void) {
    return g_error_code++;
}
