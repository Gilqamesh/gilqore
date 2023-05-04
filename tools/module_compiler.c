#include "module_compiler.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "system/process/process.h"
#include "io/file/file.h"
#include "libc/libc.h"

struct module g_modules[1024];
s32 g_modules_size;

static void module_compiler__update(struct module* parent, struct module* child, s32 child_index);
static void module_compiler__update_branch(struct module* pm);
static void module_compiler__clear_transient_flags(void);
static void module_compiler__print_dependencies(struct module* self);

static void module_compiler__clear_transient_flags(void) {
    for (s32 i = 0; i < g_modules_size; ++i) {
        g_modules[i].transient_flag_for_processing = 0;
    }
}

// @brief update sm based on pm
static void module_compiler__update(struct module* parent, struct module* child, s32 child_index) {
    child->starting_error_code = parent->children_starting_error_code + child_index * parent->children_disposition;
    child->ending_error_code = child->starting_error_code + parent->children_disposition - 1;
    child->children_starting_error_code = child->starting_error_code + child->num_of_errors;
    child->children_disposition = (child->ending_error_code - child->children_starting_error_code + 1) / (child->number_of_submodules + 1);
}

static void module_compiler__update_branch(struct module* pm) {
    struct module* child = pm->first_child;
    for (s32 i = 0; child; ++i) {
        module_compiler__update(pm, child, i);
        module_compiler__update_branch(child);
        child = child->next_sibling;
    }
}

struct module* module_compiler__add_child(struct module* self, const char* child_module_name) {
    struct module* child = &g_modules[g_modules_size++];

    s32 i = 0;
    for (; i + 1 < ARRAY_SIZE(child->name) && child_module_name[i] != '\0'; ++i) {
        child->name[i] = child_module_name[i];
    }
    child->name[i] = '\0';
    child->num_of_errors = 10; // hardcoded, todo: parse from config file

    struct module* first_child = self->first_child;
    self->first_child = child;
    child->next_sibling = first_child;
    self->children_disposition = (self->ending_error_code - self->children_starting_error_code + 1) / (self->number_of_submodules++ + 1);
    // update the whole branch from here
    module_compiler__update_branch(self);

    return sm;
}

void module_add_dependency(struct module* m, struct module* dm) {
    s32 hash_value = (dm->starting_error_code * 56237) & ARRAY_SIZE(m->dependencies);
    for (s32 i = hash_value; i < ARRAY_SIZE(m->dependencies); ++i) {
        if (m->dependencies[i] == dm) {
            // no need to add the dependency again
            return ;
        }
        if (m->dependencies[i] == NULL) {
            m->dependencies[i] = dm;
            return ;
        }
    }
    for (s32 i = 0; i < hash_value; ++i) {
        if (m->dependencies[i] == dm) {
            // no need to add the dependency again
            return ;
        }
        if (m->dependencies[i] == NULL) {
            m->dependencies[i] = dm;
            return ;
        }
    }
    printf("hard limit (%ld) on the number of dependencies reached for module: %s\n",
    ARRAY_SIZE(m->dependencies), m->name);
    exit(1);
}

static void module_compiler__check_cyclic_dependency_helper(struct module* self) {
    if (self->transient_flag_for_processing > 0) {
        printf("\ncyclic dependency detected between these modules: ");
        for (s32 i = 0; i < g_modules_size; ++i) {
            if (g_modules[i].transient_flag_for_processing > 0) {
                printf("%s ", g_modules[i].name);
            }
        }
        printf("\n");
        exit(1);
        return ;
    }
    self->transient_flag_for_processing = 1;
    for (s32 i = 0; i < ARRAY_SIZE(self->dependencies); ++i) {
        if (self->dependencies[i] != NULL) {
            module_compiler__check_cyclic_dependency_helper(self->dependencies[i]);
        }
    }
    self->transient_flag_for_processing = 0;
}

static void module_compiler__check_cyclic_dependency(void) {
    module_compiler__clear_transient_flags();
    module_compiler__check_cyclic_dependency_helper(&g_modules[0]);
}

static void module_compiler__print_dependencies(struct module* self) {
    self->transient_flag_for_processing = 1;
    for (s32 i = 0; i < ARRAY_SIZE(self->dependencies); ++i) {
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

s32 main() {
    struct module* parent_module = &g_modules[g_modules_size++];
    const char* parent_module_name = "top level module";
    memcpy(parent_module->name, parent_module_name, strlen(parent_module_name));
    parent_module->starting_error_code = 1;
    parent_module->children_starting_error_code = 1;
    parent_module->ending_error_code = 100000000;

    struct module* common = module_compiler__add_child(parent_module, "common");
    struct module* io = module_compiler__add_child(parent_module, "io");
    struct module* libc = module_compiler__add_child(parent_module, "libc");
    struct module* data_structures = module_compiler__add_child(parent_module, "data_structures");
    struct module* graphics = module_compiler__add_child(parent_module, "graphics");

    struct module* file = module_compiler__add_child(io, "file");
    struct module* directory = module_compiler__add_child(io, "directory");
    struct module* console = module_compiler__add_child(io, "console");

    struct module* color = module_compiler__add_child(graphics, "color");
    struct module* renderer = module_compiler__add_child(graphics, "renderer");
    struct module* window = module_compiler__add_child(graphics, "window");

    struct module* file_reader = module_compiler__add_child(file, "file_reader");
    struct module* riff_loader = module_compiler__add_child(file, "riff_loader");

    struct module* wav_parser = module_compiler__add_child(riff_loader, "wav_parser");

    struct module* circular_buffer = module_compiler__add_child(data_structures, "circular_buffer");

    module_add_dependency(file, common);
    module_add_dependency(file, color);

    module_add_dependency(color, libc);
    module_add_dependency(color, common);

    module_add_dependency(io, directory);
    module_add_dependency(io, common);
    module_add_dependency(io, libc);

    module_add_dependency(renderer, color);
    module_add_dependency(renderer, window);

    module_add_dependency(circular_buffer, common);

    module_add_dependency(wav_parser, riff_loader);

    module_add_dependency(riff_loader, file_reader);

    module_add_dependency(file_reader, libc);
    module_add_dependency(file_reader, io);
    module_add_dependency(file_reader, common);

    module_add_dependency(data_structures, libc);
    module_add_dependency(data_structures, common);
    module_add_dependency(data_structures, common);
    module_add_dependency(data_structures, libc);
    module_add_dependency(data_structures, file);
    module_add_dependency(data_structures, io);
    module_add_dependency(data_structures, riff_loader);

    module_compiler__check_cyclic_dependency();

    module_compiler__print_branch(parent_module);
}
