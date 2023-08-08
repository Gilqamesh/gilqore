#ifndef GIES_VM
# define GIES_VM

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
# include "allocator.h"

struct values_stack {
    value_t* data;
    value_t* top;
    u32      data_size;
};

struct vm {
    u8* ip;

    values_stack_t values;
};

bool vm__create(vm_t* self, allocator_t* allocator);
void vm__destroy(vm_t* self, allocator_t* allocator);

bool vm__run_file(vm_t* self, allocator_t* allocator, const char* path);
bool vm__run_repl(vm_t* self, allocator_t* allocator);

typedef enum vm_code {
    VM_OK,
    VM_COMPILE_ERROR,
    VM_RUNTIME_ERROR
} vm_code_t;

vm_code_t vm__interpret(vm_t* self, allocator_t* allocator, chunk_t* chunk);

#endif // GIES_VM
