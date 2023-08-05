#include "chunk.h"
#include "memory.h"

static void chunk__init(chunk_t* self) {
    self->code_fill = 0;
    self->code_size = 0;
    self->code = 0;
    self->lines_fill = 0;
    self->lines_size = 0;
    self->lines = 0;
}

void chunk__create(chunk_t* self, memory_t* memory) {
    chunk__init(self);

    value_arr__create(&self->immediates, memory);
}

void chunk__destroy(chunk_t* self, memory_t* memory) {
    FREE_ARRAY(memory, u8, self->code, self->code_size);
    FREE_ARRAY(memory, u32, self->lines, self->lines_size);
    value_arr__destroy(&self->immediates, memory);
    
    chunk__init(self);
}

u32 chunk__push_op(chunk_t* self, memory_t* memory, op_code_t code, u32 line) {
    if (self->code_fill == self->code_size) {
        u32 new_size = GROW_CAPACITY(self->code_size);
        self->code = GROW_ARRAY(memory, u8, self->code, self->code_size, new_size);
        self->code_size = new_size;
    }
    u32 ip = self->code_fill++;
    self->code[ip] = code;

    ASSERT(self->lines_fill % 2 == 0);
    if (self->lines_fill > 0 && self->lines[self->lines_fill - 1] == line) {
        ++self->lines[self->lines_fill - 2];
    } else {
        if (self->lines_fill == self->lines_size) {
            u32 new_size = GROW_CAPACITY(self->lines_size);
            self->lines = GROW_ARRAY(memory, u32, self->lines, self->lines_size, new_size);
            self->lines_size = new_size;
        }
        self->lines[self->lines_fill++] = 1;
        self->lines[self->lines_fill++] = line;
    }

    return ip;
}

u32 chunk__push_value(chunk_t* self, memory_t* memory, value_t immediate) {
    return value_arr__push(&self->immediates, memory, immediate);
}

u32 chunk__push_imm_long(chunk_t* self, memory_t* memory, value_t immediate, u32 line) {
    u32 imm_ip = chunk__push_value(self, memory, immediate);
    chunk__push_op(self, memory, OP_IMM_LONG, line);
    chunk__push_op(self, memory, imm_ip >> 16, line);
    chunk__push_op(self, memory, imm_ip >> 8, line);
    chunk__push_op(self, memory, imm_ip, line);

    return imm_ip;
}

u32 chunk__push_imm(chunk_t* self, memory_t* memory, value_t immediate, u32 line) {
    u32 imm_ip = chunk__push_value(self, memory, immediate);
    chunk__push_op(self, memory, OP_IMM, line);
    chunk__push_op(self, memory, imm_ip, line);

    return imm_ip;
}
