#ifndef GIES_CHUNK_H
# define GIES_CHUNK_H

# include "compiler/giescript/giescript_defs.h"

# include "common.h"
# include "value.h"

struct token_info {
    u32 line_s;
    u32 line_e;
    u32 col_s;
    u32 col_e;
};

struct chunk {
    u32          instructions_fill;
    u32          instructions_size;
    u8*          instructions;

    token_info_t* token_infos;
    u32           token_infos_fill;
    u32           token_infos_size;

    value_arr_t  immediates;

    // maximum values stack size necessary for the vm
    u32          values_stack_size_watermark;
    s32          current_stack_size;

    vm_t*        vm;
};

void chunk__create(chunk_t* self, vm_t* vm);
void chunk__destroy(chunk_t* self);

// @returns ip of pushed instruction
u32 chunk__push_ins(chunk_t* self, ins_mnemonic_t instruction, token_t token);
// @returns index of pushed immediate instruction
u32 chunk__push_imm(chunk_t* self, value_t imm, token_t token);
// @returns index of pushed value
u32 chunk__push_value(chunk_t* self, value_t value);
token_info_t* chunk__get_token_info(chunk_t* self, u32 ip);

#endif // GIES_CHUNK_H
