#ifndef GIES_CHUNK_H
# define GIES_CHUNK_H

# include "compiler/giescript/giescript_defs.h"

# include "common.h"
# include "value.h"

struct chunk {
    u32          instructions_fill;
    u32          instructions_size;
    u8*          instructions;

    u32          lines_fill;
    u32          lines_size;
    u32*         lines; // RLE encoded, format: [n, line] [n, line]

    value_arr_t  immediates;

    // maximum values stack size necessary for the vm
    u32          values_stack_size_watermark;
    s32          current_stack_size;

    vm_t*        vm;
};

void chunk__create(chunk_t* self, vm_t* vm);
void chunk__destroy(chunk_t* self);

// @returns ip of pushed instruction
u32 chunk__push_ins(chunk_t* self, ins_mnemonic_t instruction, u32 line);
// @returns index of pushed immediate instruction
u32 chunk__push_imm(chunk_t* self, value_t imm, u32 line);
// @returns index of pushed value
u32 chunk__push_value(chunk_t* self, value_t value);
// @returns the line in the source code associated with the instruction pointer
u32 chunk__ins_get_line(chunk_t* self, u32 ip);

#endif // GIES_CHUNK_H
