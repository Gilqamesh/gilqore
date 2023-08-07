#ifndef GIES_CHUNK_H
# define GIES_CHUNK_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
# include "value.h"

struct chunk {
    u32          code_fill;
    u32          code_size;
    u8*          code;

    u32          lines_fill;
    u32          lines_size;
    u32*         lines; // RLE encoded, format: [n, line] [n, line]

    value_arr_t  immediates;
};

void chunk__create(chunk_t* self, memory_t* memory);
void chunk__destroy(chunk_t* self, memory_t* memory);

typedef enum op_code {
    OP_IMM,      // [op, imm index]
    OP_IMM_LONG, // [op, imm_index_high, imm_index_mid, imm_index_low]
    OP_RETURN,   // [op]
} op_code_t;

// @returns ip of pushed op
u32 chunk__push_op(chunk_t* self, memory_t* memory, op_code_t code, u32 line);
u32 chunk__push_value(chunk_t* self, memory_t* memory, value_t value);

//> convenience functions
// @brief pushes an OP_IMM_LONG op code, use when the index of the immediate can't be represented by 1 byte, but can be with 3 bytes
// @returns ip of pushed immediate
u32 chunk__push_imm_long(chunk_t* self, memory_t* memory, value_t immediate, u32 line);
// @brief pushes an OP_IMM op code
// @returns ip of pushed immediate
u32 chunk__push_imm(chunk_t* self, memory_t* memory, value_t immediate, u32 line);
//< convenience functions

#endif // GIES_CHUNK_H
