#include "test_framework/test_framework.h"

#include "module_compiler.h"

#include "memory/linear_allocator/linear_allocator.h"
#include "types/string/string_replacer/string_replacer.h"
#include "libc/libc.h"

struct modules_container {
    struct module* modules;
    u32 fill;
    u32 size;
};
extern struct modules_container modules_container;

int main() {
    u64 main_memory_size = MEGABYTES(64);
    void* main_memory = libc__malloc(main_memory_size);

    struct linear_allocator linear_allocator;
    linear_allocator__create(&linear_allocator, main_memory, main_memory_size);

    modules_container.size = c256;
    modules_container.fill = 0;
    modules_container.modules = libc__calloc(modules_container.size * sizeof(*modules_container.modules));

    const u32 file_path_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) + ARRAY_SIZE_MEMBER(struct module, dirprefix);
    char* file_path_buffer = libc__malloc(file_path_buffer_size);
    u32 total_number_of_replacements = 256;
    u32 average_replacement_size = 64;
    struct string_replacer string_replacer;
    string_replacer__create(
        &string_replacer,
        NULL,
        0,
        total_number_of_replacements,
        average_replacement_size * total_number_of_replacements
    );
    u32 total_number_of_replacements_aux = 16;
    u32 average_replacement_size_aux = 64;
    // note: need this because can't replace inplace of a buffer
    struct string_replacer string_replacer_aux;
    string_replacer__create(
        &string_replacer_aux,
        NULL,
        0,
        total_number_of_replacements_aux,
        average_replacement_size_aux * total_number_of_replacements_aux
    );
    u32 file_buffer_size = 32768;
    char* file_buffer = libc__malloc(file_buffer_size);
    u32 dependencies_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) * modules_container.size / 2;
    char* dependencies_buffer = libc__malloc(dependencies_buffer_size);
    u32 auxiliary_buffer_size = 1024;
    char* auxiliary_buffer = libc__malloc(auxiliary_buffer_size);

    struct module* parent_module = modules_container.modules + modules_container.fill++;
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compiler__explore_children(parent_module);

    // todo: rename to something like update def files, and do the config file parsing prior to this
    module_compiler__parse_config_files(modules_container.modules, modules_container.fill);

    module_compiler__check_cyclic_dependency(parent_module, modules_container.modules, modules_container.fill);

    // todo: at some point merge all logical units into one path for more data locality
    module_compiler__ensure_test_file_templates_exist(&string_replacer);

    module_compiler__embed_dependencies_into_makefile(
        modules_container.modules,
        "modules",
        file_path_buffer,
        file_buffer,
        dependencies_buffer,
        auxiliary_buffer,
        &string_replacer,
        &string_replacer_aux,
        modules_container.fill,
        file_path_buffer_size,
        file_buffer_size,
        dependencies_buffer_size,
        auxiliary_buffer_size
    );

    // module_compiler__print_branch(parent_module, modules_container.modules, modules_container.fill);

    string_replacer__destroy(&string_replacer);
    string_replacer__destroy(&string_replacer_aux);
    libc__free(modules_container.modules);
    libc__free(file_buffer);
    libc__free(file_path_buffer);

    linear_allocator__destroy(&linear_allocator);
    libc__free(main_memory);

    return 0;
}
