#include "module_tester.h"

void module_update(struct module* pm, struct module* sm, int sm_index);

void module_update_branch(struct module* pm);

// @brief the starting point of the child module
int module_child_base(struct module m, int child_index) {
    int children_range = (m.end - m.start_child) / m.number_of_submodules;
    return child_index * children_range;
}

// @brief update sm based on pm
void module_update(struct module* pm, struct module* sm, int sm_index) {
    sm->start = pm->start_child + sm_index * pm->disposition;
    sm->end = sm->start + pm->disposition - 1;
    int sm_n_error_codes = (sm->end - sm->start + 1) * sm->unique_error_percentage;
    sm->start_child = sm->start + sm_n_error_codes;
    sm->disposition = (sm->end - sm->start_child + 1) / (sm->number_of_submodules + 1);
}

void module_update_branch(struct module* pm) {
    struct module* child = pm->first_child;
    for (int i = 0; child; ++i) {
        module_update(pm, child, i);
        module_update_branch(child);
        child = child->next;
    }
}

void module_add_child(struct module* pm, struct module* sm, const char* sm_name, float sm_unique_error_percentage) {
    int i = 0;
    for (i = 0; sm_name[i] != '\0'; ++i) {
        sm->name[i] = sm_name[i];
    }
    sm->name[i] = '\0';
    sm->number_of_submodules = 0;
    sm->unique_error_percentage = sm_unique_error_percentage;
    sm->first_child = 0;
    sm->next = 0;

    struct module* first_child = pm->first_child;
    pm->first_child = sm;
    sm->next = first_child;
    pm->disposition = (pm->end - pm->start_child + 1) / (pm->number_of_submodules++ + 1);
    // update the whole branch from here
    module_update_branch(pm);
}

#include <stdio.h>
void module_print_helper(struct module* m, int depth) {
    printf("%*s --== %s ==-- \n %*sstart: %d\n %*sstart_child: %d\n %*send: %d\n %*snumber of submodules: %d\n %*sdisposition: %d\n %*scapita in percentage: %f\n\n",
    depth, "", m->name,
    depth, "", m->start,
    depth, "", m->start_child,
    depth, "", m->end,
    depth, "", m->number_of_submodules,
    depth, "", m->disposition,
    depth, "", m->unique_error_percentage);
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
    struct module pm = {
        .name = "top level module",
        .start = 1,
        .start_child = 1,
        .end = 1000000,
        .number_of_submodules = 0,
        .disposition = 1000000,
        .unique_error_percentage = 0.0f,
        .first_child = 0,
        .next = 0
    };

    struct module io; module_add_child(&pm, &io, "io", 0.1f);
    struct module data_structures; module_add_child(&pm, &data_structures, "data_structures", 0.12f);
    struct module graphics; module_add_child(&pm, &graphics, "graphics", 0.05f);

        struct module file; module_add_child(&io, &file, "file", 0.2f);
        struct module directory; module_add_child(&io, &directory, "directory", 0.3f);
        struct module console; module_add_child(&io, &console, "console", 0.13f);

        struct module color; module_add_child(&graphics, &color, "color", 0.05f);
        struct module renderer; module_add_child(&graphics, &renderer, "renderer", 0.4f);
        struct module window; module_add_child(&graphics, &window, "window", 0.5f);

            struct module file_reader; module_add_child(&file, &file_reader, "file_reader", 0.3f);
            struct module riff_loader; module_add_child(&file, &riff_loader, "riff_loader", 0.25f);
                struct module wav_parser; module_add_child(&riff_loader, &wav_parser, "wav_parser", 0.1f);

        struct module circular_buffer; module_add_child(&data_structures, &circular_buffer, "circular_buffer", 0.1f);
    
    module_print(&pm);
}
