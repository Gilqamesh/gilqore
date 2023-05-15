#include "module_compiler_utils.h"
#include <stdio.h>

#include "libc/libc.h"

void module_compiler__clear_transient_flags(
    struct module* modules,
    u32 modules_size
) {
    for (u32 module_index = 0; module_index < modules_size; ++module_index) {
        modules[module_index].transient_flag_for_processing = 0;
    }
}

struct module* module_compiler__add_child(
    struct module* modules,
    struct module* self,
    const char* child_module_basename,
    u32* modules_size_cur,
    u32 modules_size_max
) {
    if (*modules_size_cur == modules_size_max) {
        // error_code__exit(REACHED_MAX_MODULES_SIZE);
        error_code__exit(214);
    }
    struct module* child = modules + (*modules_size_cur)++;
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
    // error_code__exit(MAX_AMOUNT_OF_DEPENDENCIES_REACHED_FOR_MODULE);
    error_code__exit(43556);
}

static void module_compiler__check_cyclic_dependency_helper(
    struct module* from,
    struct module* modules,
    u32 modules_size
) {
    if (from->transient_flag_for_processing > 0) {
        printf("\ncyclic dependency detected between these modules: ");
        for (u32 module_index = 0; module_index < modules_size; ++module_index) {
            if (modules[module_index].transient_flag_for_processing > 0) {
                printf("%s ", modules[module_index].basename);
            }
        }
        // error_code__exit(CYCLIC_DEPENDENCY_BETWEEN_MODULES);
        error_code__exit(8342);
    }
    from->transient_flag_for_processing = 1;
    for (u32 i = 0; i < ARRAY_SIZE(from->dependencies); ++i) {
        if (from->dependencies[i] != NULL) {
            module_compiler__check_cyclic_dependency_helper(from->dependencies[i], modules, modules_size);
        }
    }
    from->transient_flag_for_processing = 0;
}

void module_compiler__check_cyclic_dependency(
    struct module* from,
    struct module* modules,
    u32 modules_size
) {
    module_compiler__clear_transient_flags(modules, modules_size);
    module_compiler__check_cyclic_dependency_helper(from, modules, modules_size);
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

static void module_compiler__print_branch_helper(
    struct module* modules,
    struct module* from,
    u32 modules_size,
    s32 cur_depth
) {
    printf("%*s --== %s ==-- \n %*snumber of submodules: %d\n %*sdependencies: ",
    cur_depth << 2, "", from->basename,
    cur_depth << 2, "", from->number_of_submodules,
    cur_depth << 2, "");

    module_compiler__clear_transient_flags(modules, modules_size);
    module_compiler__print_dependencies(from);
    printf("\n\n");
    struct module* child = from->first_child;
    while (child) {
        module_compiler__print_branch_helper(modules, child, modules_size, cur_depth + 1);
        child = child->next_sibling;
    }
}

void module_compiler__print_branch(
    struct module* from,
    struct module* modules,
    u32 modules_size
) {
    module_compiler__print_branch_helper(
        modules,
        from,
        modules_size,
        0
    );
}

u32 module_compiler__get_error_code(void) {
    static u32 error_code;

    return error_code++;
}
