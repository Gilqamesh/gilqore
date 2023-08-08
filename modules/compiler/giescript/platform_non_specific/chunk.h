#ifndef GIES_CHUNK_H
# define GIES_CHUNK_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
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
};

void chunk__create(chunk_t* self, allocator_t* allocator);
void chunk__destroy(chunk_t* self, allocator_t* allocator);

typedef enum ins_mnemonic {
    INS_RETURN,   // [ins]
    INS_IMM,      // [ins, imm index]
    INS_IMM_LONG, // [ins, imm_index_high, imm_index_mid, imm_index_low]
    INS_NEG,      // [ins]
    INS_ADD,      // [ins]
    INS_SUB,      // [ins]
    INS_MUL,      // [ins]
    INS_DIV,      // [ins]
} ins_mnemonic_t;

// @returns ip of pushed instruction
u32 chunk__push_ins(chunk_t* self, allocator_t* allocator, ins_mnemonic_t instruction, u32 line);
u32 chunk__push_value(chunk_t* self, allocator_t* allocator, value_t value);

//> convenience functions
// @brief pushes an INS_IMM_LONG instruction, use when the index of the immediate can't be represented by 1 byte, but can be with 3 bytes
// @returns ip of pushed immediate
u32 chunk__push_imm_long(chunk_t* self, allocator_t* allocator, value_t immediate, u32 line);
// @brief pushes an INS_IMM instruction
// @returns ip of pushed immediate
u32 chunk__push_imm(chunk_t* self, allocator_t* allocator, value_t immediate, u32 line);
//< convenience functions

#endif // GIES_CHUNK_H
