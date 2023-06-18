#include "test_framework/test_framework.h"

#include "module_compiler.h"

#include "memory/linear_allocator/linear_allocator.h"
#include "libc/libc.h"
#include "data_structures/stack/stack.h"

// todo: move into its module
#include <immintrin.h>

int main() {
    u64 clock_start = __rdtsc();

    u64 main_memory_size = MEGABYTES(64);
    void* main_memory = libc__calloc(main_memory_size);

    struct linear_allocator linear_allocator;
    linear_allocator__create(
        &linear_allocator,
        memory_slice__create(main_memory, main_memory_size)
    );

    const u32 total_number_of_modules = 256;
    const u32 cache_size = 64;
    struct memory_slice modules_memory_slice = linear_allocator__push_aligned(
        &linear_allocator,
        total_number_of_modules * sizeof(struct module),
        cache_size
    );

    struct stack modules_stack;
    stack__create(&modules_stack, modules_memory_slice, sizeof(struct module));

    struct module* parent_module = stack__push(&modules_stack);
    libc__strncpy(parent_module->dirprefix, "modules", ARRAY_SIZE(parent_module->basename));
    libc__strncpy(parent_module->basename, "modules", ARRAY_SIZE(parent_module->basename));

    module_compiler__explore_children(
        &modules_stack,
        &linear_allocator,
        parent_module
    );

    // todo: rename to something like update def files, and do the config file parsing prior to this
    module_compiler__parse_config_files(&modules_stack, &linear_allocator);

    module_compiler__check_cyclic_dependency(&modules_stack);

    // todo: at some point merge all logical units into one path for more data locality
    module_compiler__ensure_test_file_templates_exist(&modules_stack, &linear_allocator);

    module_compiler__embed_dependencies_into_makefile(
        &modules_stack,
        &linear_allocator
    );

    // module_compiler__print_branch(parent_module, &modules_stack);

    stack__destroy(&modules_stack);

    linear_allocator__pop(&linear_allocator, modules_memory_slice);
    linear_allocator__destroy(&linear_allocator);
    libc__free(main_memory);

    u64 clock_end = __rdtsc();

    // todo: query this somehow at the start
    const r64 processor_speed_in_ghz = 2.11;
    u64 clock_cycles_taken = clock_end - clock_start;
    libc__printf("Clock cycles taken: %.3lfM\n", (r64) clock_cycles_taken / 1000000.0);
    libc__printf("Time taken: %.3lfs\n", (r64) clock_cycles_taken / (processor_speed_in_ghz * 1000000000.0));

    return 0;
}
