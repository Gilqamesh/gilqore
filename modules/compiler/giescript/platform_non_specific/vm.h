#ifndef GIES_VM
# define GIES_VM

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

struct vm {
    u8* ip;
};

void vm__create(vm_t* self);
void vm__destroy(vm_t* self);

typedef enum vm_code {
    VM_OK,
    VM_COMPILE_ERROR,
    VM_RUNTIME_ERROR
} vm_code_t;

vm_code_t vm__interpret(vm_t* self, chunk_t* chunk);

#endif // GIES_VM
