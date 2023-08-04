#ifndef CHUNK_H
# define CHUNK_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
# include "value.h"

typedef enum op_code {
    OP_CONSTANT, // [opcode, constant index]
    OP_CONSTANT_LONG, // 
    OP_RETURN,   // [opcode]
} op_code_t;

struct chunk {
    u32          code_fill;
    u32          code_size;
    u8*          code;

    u32          lines_fill;
    u32          lines_size;
    u32*         lines; // RLE encoded, format: [n, line] [n, line]

    value_arr_t  values;
};

void chunk__create(chunk_t* self, memory_t* memory);
void chunk__destroy(chunk_t* self, memory_t* memory);

// @returns index of pushed op
u32 chunk__push_op(chunk_t* self, memory_t* memory, op_code_t code, u32 line);
// @returns index of pushed constant
u32 chunk__push_constant(chunk_t* self, memory_t* memory, value_t value, u32 line);

// @returns index of pushed value
u32 chunk__push_value(chunk_t* self, memory_t* memory, value_t value);

#endif // CHUNK_H
