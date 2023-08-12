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
    INS_RETURN,             // [ins]
    INS_IMM,                // [ins, imm index]
    INS_IMM_LONG,           // [ins, imm_index_high, imm_index_mid, imm_index_low]
    INS_NIL,                // [ins]
    INS_TRUE,               // [ins]
    INS_FALSE,              // [ins]
    INS_NEG,                // [ins]
    INS_ADD,                // [ins]
    INS_SUB,                // [ins]
    INS_MUL,                // [ins]
    INS_DIV,                // [ins]
    INS_NOT,                // [ins]
    INS_EQ,                 // [ins]
    INS_GT,                 // [ins]
    INS_LT,                 // [ins]
    INS_PRINT,              // [ins]
    INS_POP,                // [ins]
    INS_DEFINE_GLOBAL,      // [ins]
    INS_GET_GLOBAL,         // [ins]
    INS_SET_GLOBAL,         // [ins]
} ins_mnemonic_t;

// @returns ip of pushed instruction
u32 chunk__push_ins(chunk_t* self, allocator_t* allocator, ins_mnemonic_t instruction, u32 line);
// @returns index of pushed immediate instruction
u32 chunk__push_imm(chunk_t* self, allocator_t* allocator, value_t imm, u32 line);
// @returns index of pushed value
u32 chunk__push_value(chunk_t* self, allocator_t* allocator, value_t value);
// @returns the line in the source code associated with the instruction pointer
u32 chunk__ins_get_line(chunk_t* self, u32 ip);

#endif // GIES_CHUNK_H
