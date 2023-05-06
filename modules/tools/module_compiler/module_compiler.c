#include "module_compiler.h"
#include "module_compiler_utils.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "libc/libc.h"
#include "system/process/process.h"
#include "time/time.h"

#include <stdio.h>

#define LIBDEPS_EXTENSION ".libdeps"
#define MODULE_MAX_PATH_LENGTH 511

extern struct module g_modules[1024];
extern s32 g_modules_size;

// struct module* module_compiler__find_module_by_name(const char* basename) {
//     (void) path;
//     return NULL;
// }

void module_compiler__parse_dependencies(struct module* self) {
    struct file dependency_file;
    char dependency_file_name[MODULE_MAX_PATH_LENGTH + 1];
    u32 dependency_file_name_length = libc__strlen(self->basename);
    struct module* cur_parent = self->parent;
    snprintf(dependency_file_name, ARRAY_SIZE(dependency_file_name), "%s%s", self->basename, LIBDEPS_EXTENSION);

    if (file__exists(dependency_file_name)) {
        ASSERT(file__open(&dependency_file, dependency_file_name, FILE_ACCESS_MODE_RDWR, FILE_CREATION_MODE_OPEN));
        struct file_reader file_reader;
        ASSERT(file_reader__create(&file_reader, &dependency_file) == true);
    } else {
        ASSERT(file__open(&dependency_file, dependency_file_name, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));
        file__close(&dependency_file);
    }
}

void module_compiler__compile(void) {
    struct module* parent_module = &g_modules[g_modules_size++];
    const char* parent_module_name = "modules";
    libc__strncpy(parent_module->basename, parent_module_name, ARRAY_SIZE(parent_module->basename));
    memcpy(parent_module->basename, parent_module_name, strlen(parent_module_name));
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

    module_compiler__add_dependency(file, common);
    module_compiler__add_dependency(file, color);

    module_compiler__add_dependency(color, libc);
    module_compiler__add_dependency(color, common);

    module_compiler__add_dependency(io, directory);
    module_compiler__add_dependency(io, common);
    module_compiler__add_dependency(io, libc);

    module_compiler__add_dependency(renderer, color);
    module_compiler__add_dependency(renderer, window);

    module_compiler__add_dependency(circular_buffer, common);

    module_compiler__add_dependency(wav_parser, riff_loader);

    module_compiler__add_dependency(riff_loader, file_reader);

    module_compiler__add_dependency(file_reader, libc);
    module_compiler__add_dependency(file_reader, io);
    module_compiler__add_dependency(file_reader, common);

    module_compiler__add_dependency(data_structures, libc);
    module_compiler__add_dependency(data_structures, common);
    module_compiler__add_dependency(data_structures, common);
    module_compiler__add_dependency(data_structures, libc);
    module_compiler__add_dependency(data_structures, file);
    module_compiler__add_dependency(data_structures, io);
    module_compiler__add_dependency(data_structures, riff_loader);

    module_compiler__add_dependency(console, common);

    module_compiler__check_cyclic_dependency();

    module_compiler__print_branch(parent_module);
}
