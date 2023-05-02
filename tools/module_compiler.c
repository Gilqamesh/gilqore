#include "module_compiler.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct module g_modules[1024];
int g_modules_size;

#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof((arr)[0]))

static void module_update(struct module* pm, struct module* sm, int sm_index);
static void module_update_branch(struct module* pm);
static void modules_prepare_processing(void);
static void module_print_dependencies(struct module* m);

static void modules_prepare_processing(void) {
    for (int i = 0; i < g_modules_size; ++i) {
        g_modules[i].transient_flag_for_processing = 0;
    }
}

// @brief update sm based on pm
static void module_update(struct module* pm, struct module* sm, int sm_index) {
    sm->start = pm->start_child + sm_index * pm->disposition;
    sm->end = sm->start + pm->disposition - 1;
    sm->start_child = sm->start + sm->unique_n_of_errors;
    sm->disposition = (sm->end - sm->start_child + 1) / (sm->number_of_submodules + 1);
}

static void module_update_branch(struct module* pm) {
    struct module* child = pm->first_child;
    for (int i = 0; child; ++i) {
        module_update(pm, child, i);
        module_update_branch(child);
        child = child->next;
    }
}

struct module* module_add_child(struct module* pm, const char* sm_name) {
    struct module* sm = &g_modules[g_modules_size++];

    memset(sm, 0, sizeof(*sm));
    int i = 0;
    for (i = 0; sm_name[i] != '\0'; ++i) {
        sm->name[i] = sm_name[i];
    }
    sm->unique_n_of_errors = 10; // hardcoded, todo: parse from config file

    struct module* first_child = pm->first_child;
    pm->first_child = sm;
    sm->next = first_child;
    pm->disposition = (pm->end - pm->start_child + 1) / (pm->number_of_submodules++ + 1);
    // update the whole branch from here
    module_update_branch(pm);

    return sm;
}

void module_add_dependency(struct module* m, struct module* dm) {
    int hash_value = (dm->start * 56237) & ARRAY_SIZE(m->dependencies);
    for (int i = hash_value; i < ARRAY_SIZE(m->dependencies); ++i) {
        if (m->dependencies[i] == dm) {
            // no need to add the dependency again
            return ;
        }
        if (m->dependencies[i] == NULL) {
            m->dependencies[i] = dm;
            return ;
        }
    }
    for (int i = 0; i < hash_value; ++i) {
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

static void module_check_cyclic_dependency_helper(struct module* m) {
    if (m->transient_flag_for_processing > 0) {
        printf("\ncyclic dependency detected between these modules: ");
        for (int i = 0; i < g_modules_size; ++i) {
            if (g_modules[i].transient_flag_for_processing > 0) {
                printf("%s ", g_modules[i].name);
            }
        }
        printf("\n");
        exit(1);
        return ;
    }
    m->transient_flag_for_processing = 1;
    for (int i = 0; i < ARRAY_SIZE(m->dependencies); ++i) {
        if (m->dependencies[i] != NULL) {
            module_check_cyclic_dependency_helper(m->dependencies[i]);
        }
    }
    m->transient_flag_for_processing = 0;
}

static void module_check_cyclic_dependency(void) {
    modules_prepare_processing();
    module_check_cyclic_dependency_helper(&g_modules[0]);
}

static void module_print_dependencies(struct module* m) {
    m->transient_flag_for_processing = 1;
    for (int i = 0; i < ARRAY_SIZE(m->dependencies); ++i) {
        if (m->dependencies[i] != NULL && m->dependencies[i]->transient_flag_for_processing == 0) {
            printf("%s ", m->dependencies[i]->name);
            module_print_dependencies(m->dependencies[i]);
        }
    }
}

static void module_print_helper(struct module* m, int depth) {
    printf("%*s --== %s ==-- \n %*sstart: %d\n %*sstart_child: %d\n %*send: %d\n %*snumber of submodules: %d\n %*sdisposition: %d\n %*sunique number of errors: %d\n %*sdependencies: ",
    depth, "", m->name,
    depth, "", m->start,
    depth, "", m->start_child,
    depth, "", m->end,
    depth, "", m->number_of_submodules,
    depth, "", m->disposition,
    depth, "", m->unique_n_of_errors,
    depth, "");

    modules_prepare_processing();
    module_print_dependencies(m);
    printf("\n\n");
    struct module* child = m->first_child;
    while (child) {
        module_print_helper(child, depth + 4);
        child = child->next;
    }
}
void module_print(struct module* m) {
    module_print_helper(m, 0);
}

int main() {
    struct module* pm = &g_modules[g_modules_size++];
    const char* pm_name = "top level module";
    memcpy(pm->name, pm_name, strlen(pm_name));
    pm->start = 1;
    pm->start_child = 1;
    pm->end = 1000000;
    pm->disposition = 1000000;

    struct module* common = module_add_child(pm, "common");
    struct module* io = module_add_child(pm, "io");
    struct module* libc = module_add_child(pm, "libc");
    struct module* data_structures = module_add_child(pm, "data_structures");
    struct module* graphics = module_add_child(pm, "graphics");

    struct module* file = module_add_child(io, "file");
    struct module* directory = module_add_child(io, "directory");
    struct module* console = module_add_child(io, "console");

    struct module* color = module_add_child(graphics, "color");
    struct module* renderer = module_add_child(graphics, "renderer");
    struct module* window = module_add_child(graphics, "window");

    struct module* file_reader = module_add_child(file, "file_reader");
    struct module* riff_loader = module_add_child(file, "riff_loader");

    struct module* wav_parser = module_add_child(riff_loader, "wav_parser");

    struct module* circular_buffer = module_add_child(data_structures, "circular_buffer");

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

    module_check_cyclic_dependency();

    module_print(pm);
}
