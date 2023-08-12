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

    // intern all strings into here -> == operator is super fast
    table_t  obj_str_table;

    // identifier name -> value index
    table_t     global_names_to_index;
    // identifier initializers
    value_arr_t global_values;

    allocator_t* allocator;
};

bool vm__create(vm_t* self, allocator_t* allocator);
void vm__destroy(vm_t* self);

bool vm__run_file(vm_t* self, const char* path);
bool vm__run_repl(vm_t* self);

#endif // GIES_VM
