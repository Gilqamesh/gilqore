#include "test_framework/test_framework.h"

#include "module_compiler.h"

#include "memory/linear_allocator/linear_allocator.h"
#include "types/string/string_replacer/string_replacer.h"
#include "libc/libc.h"
#include "data_structures/generic_array/generic_array.h"

int main() {
    u64 main_memory_size = MEGABYTES(64);
    void* main_memory = libc__calloc(main_memory_size);

    struct linear_allocator linear_allocator;
    linear_allocator__create(&linear_allocator, main_memory, main_memory_size);

    const u32 total_number_of_modules = 256;
    const u32 cache_size = 64;
    struct linear_allocator_memory_slice modules_memory_slice = linear_allocator__push_aligned(
        &linear_allocator,
        total_number_of_modules * sizeof(struct module),
        cache_size
    );

    struct generic_array modules_generic_array;
    generic_array__create(&modules_generic_array, modules_memory_slice.memory, modules_memory_slice.size, sizeof(struct module));

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
    u32 dependencies_buffer_size = ARRAY_SIZE_MEMBER(struct module, basename) * generic_array__capacity(&modules_generic_array) / 2;
    char* dependencies_buffer = libc__malloc(dependencies_buffer_size);
    u32 auxiliary_buffer_size = 1024;
    char* auxiliary_buffer = libc__malloc(auxiliary_buffer_size);

    struct module* parent_module = generic_array__push(&modules_generic_array);
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compiler__explore_children(&modules_generic_array, parent_module);

    // todo: rename to something like update def files, and do the config file parsing prior to this
    module_compiler__parse_config_files(&modules_generic_array);

    module_compiler__check_cyclic_dependency(&modules_generic_array);

    // todo: at some point merge all logical units into one path for more data locality
    module_compiler__ensure_test_file_templates_exist(&modules_generic_array, &string_replacer);

    module_compiler__embed_dependencies_into_makefile(
        &modules_generic_array,
        "modules",
        file_path_buffer,
        file_buffer,
        dependencies_buffer,
        auxiliary_buffer,
        &string_replacer,
        &string_replacer_aux,
        file_path_buffer_size,
        file_buffer_size,
        dependencies_buffer_size,
        auxiliary_buffer_size
    );

    // module_compiler__print_branch(parent_module, &modules_generic_array);

    generic_array__destroy(&modules_generic_array);

    string_replacer__destroy(&string_replacer);
    string_replacer__destroy(&string_replacer_aux);

    libc__free(file_buffer);
    libc__free(file_path_buffer);

    linear_allocator__destroy(&linear_allocator);
    libc__free(main_memory);

    return 0;
}
