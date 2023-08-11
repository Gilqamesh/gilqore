#ifndef GIES_VM
# define GIES_VM

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
# include "allocator.h"
# include "table.h"

struct vm {
    u8* ip;

    value_t* values_data;
    value_t* values_top;
    u32      values_size;

    obj_t* objs;

    table_t  obj_str_table;
    table_t  globals_table;
};

bool vm__create(vm_t* self, allocator_t* allocator);
void vm__destroy(vm_t* self, allocator_t* allocator);

bool vm__run_file(vm_t* self, allocator_t* allocator, const char* path);
bool vm__run_repl(vm_t* self, allocator_t* allocator);

#endif // GIES_VM
