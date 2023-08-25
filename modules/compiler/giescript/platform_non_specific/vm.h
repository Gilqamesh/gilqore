#ifndef GIES_VM
# define GIES_VM

# include "compiler/giescript/giescript_defs.h"

# include "common.h"
# include "allocator.h"
# include "table.h"

struct abi {
    s32 stack_delta[_INS_MNEMONIC_SIZE]; // how the instruction affects the stack
};

struct stack_frame {
    obj_fun_t* caller;
    u8*        ip;
    value_t*   slots;
};

struct vm {
    value_t* values_stack_data;
    value_t* values_stack_top;
    u32      values_stack_size;

    obj_t* objs;

    // intern all strings into here -> == operator is super fast
    table_t  obj_str_table;

    abi_t abi;

    stack_frame_t stack_frames[256];
    u32 stack_frames_fill;

    allocator_t* allocator;
};

bool vm__create(vm_t* self, allocator_t* allocator);
void vm__destroy(vm_t* self);

bool vm__run_file(vm_t* self, const char* path);
bool vm__run_repl(vm_t* self);

// @param ... INS_RETURN terminated sequence of instruction mnemonics
bool vm__test_source(vm_t* self, const char* script, ...);
bool vm__vtest_source(vm_t* self, const char* script, va_list ap);

#endif // GIES_VM
