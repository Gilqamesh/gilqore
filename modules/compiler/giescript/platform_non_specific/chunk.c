#include "chunk.h"
#include "allocator.h"

#include "libc/libc.h"

static void chunk__init(chunk_t* self) {
    libc__memset(self, 0, sizeof(*self));

    self->values_stack_size_watermark = 8;
}

void chunk__create(chunk_t* self, allocator_t* allocator) {
    chunk__init(self);

    value_arr__create(&self->immediates, allocator);
}

void chunk__destroy(chunk_t* self, allocator_t* allocator) {
    FREE_ARRAY(allocator, u8, self->instructions, self->instructions_size);
    FREE_ARRAY(allocator, u32, self->lines, self->lines_size);
    value_arr__destroy(&self->immediates, allocator);
    
    chunk__init(self);
}

u32 chunk__push_ins(chunk_t* self, allocator_t* allocator, ins_mnemonic_t instruction, u32 line) {
    if (self->instructions_fill == self->instructions_size) {
        u32 new_size = GROW_CAPACITY(self->instructions_size);
        GROW_ARRAY(self->instructions, allocator, u8, self->instructions, self->instructions_size, new_size);
        self->instructions_size = new_size;
    }
    u32 ip = self->instructions_fill++;
    self->instructions[ip] = instruction;

    ASSERT(self->lines_fill % 2 == 0);
    if (self->lines_fill > 0 && self->lines[self->lines_fill - 1] == line) {
        ++self->lines[self->lines_fill - 2];
    } else {
        if (self->lines_fill == self->lines_size) {
            u32 new_size = GROW_CAPACITY(self->lines_size);
            GROW_ARRAY(self->lines, allocator, u32, self->lines, self->lines_size, new_size);
            self->lines_size = new_size;
        }
        self->lines[self->lines_fill++] = 1;
        self->lines[self->lines_fill++] = line;
    }

    return ip;
}

u32 chunk__push_value(chunk_t* self, allocator_t* allocator, value_t immediate) {
    return value_arr__push(&self->immediates, allocator, immediate);
}

u32 chunk__push_imm_long(chunk_t* self, allocator_t* allocator, value_t immediate, u32 line) {
    u32 imm_ip = chunk__push_value(self, allocator, immediate);
    chunk__push_ins(self, allocator, INS_IMM_LONG, line);
    chunk__push_ins(self, allocator, imm_ip >> 16, line);
    chunk__push_ins(self, allocator, imm_ip >> 8, line);
    chunk__push_ins(self, allocator, imm_ip, line);

    return imm_ip;
}

u32 chunk__push_imm(chunk_t* self, allocator_t* allocator, value_t immediate, u32 line) {
    u32 imm_ip = chunk__push_value(self, allocator, immediate);
    chunk__push_ins(self, allocator, INS_IMM, line);
    chunk__push_ins(self, allocator, imm_ip, line);

    return imm_ip;
}
