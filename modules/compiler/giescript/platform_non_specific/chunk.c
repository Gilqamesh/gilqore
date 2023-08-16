#include "chunk.h"
#include "vm.h"

#include "libc/libc.h"

static void chunk__init(chunk_t* self);
static u32  chunk__push(chunk_t* self, ins_mnemonic_t instruction, u32 line);

static void chunk__init(chunk_t* self) {
    libc__memset(self, 0, sizeof(*self));
}

static u32 chunk__push(chunk_t* self, ins_mnemonic_t instruction, u32 line) {
    allocator_t* allocator = self->vm->allocator;

    if (self->instructions_fill == self->instructions_size) {
        u32 new_size = self->instructions_size < 8 ? 8 : self->instructions_size * 2;
        self->instructions = allocator__realloc(
            allocator, self->instructions,
            self->instructions_size * sizeof(*self->instructions),
            new_size * sizeof(*self->instructions)
        );
        self->instructions_size = new_size;
    }
    u32 ip = self->instructions_fill++;
    self->instructions[ip] = instruction;

    ASSERT(self->lines_fill % 2 == 0);
    if (self->lines_fill > 0 && self->lines[self->lines_fill - 1] == line) {
        ++self->lines[self->lines_fill - 2];
    } else {
        if (self->lines_fill == self->lines_size) {
            u32 new_size = self->lines_size < 8 ? 8 : self->lines_size * 2;
            self->lines = allocator__realloc(
                allocator, self->lines,
                self->lines_size * sizeof(*self->lines),
                new_size * sizeof(*self->lines)
            );
            self->lines_size = new_size;
        }
        self->lines[self->lines_fill++] = 1;
        self->lines[self->lines_fill++] = line;
    }

    return ip;
}

void chunk__create(chunk_t* self, vm_t* vm) {
    chunk__init(self);

    self->vm = vm;
    
    value_arr__create(&self->immediates, vm->allocator);
}

void chunk__destroy(chunk_t* self) {
    allocator_t* allocator = self->vm->allocator;

    if (self->instructions) {
        allocator__free(allocator, self->instructions);
    }

    if (self->lines) {
        allocator__free(allocator, self->lines);
    }

    value_arr__destroy(&self->immediates, allocator);
    
    chunk__init(self);
}

u32 chunk__push_ins(chunk_t* self, ins_mnemonic_t instruction, u32 line) {
    const s32 stack_delta = self->vm->ins_infos[instruction].stack_delta;
    self->current_stack_size += stack_delta;
    if (self->current_stack_size > 0 && (u32) self->current_stack_size > self->values_stack_size_watermark) {
        self->values_stack_size_watermark = (u32) self->current_stack_size;
    }

    return chunk__push(self, instruction, line);
}

u32 chunk__push_imm(chunk_t* self, value_t imm, u32 line) {
    u32 imm_index = chunk__push_value(self, imm);
    if (imm_index < 256) {
        chunk__push_ins(self, INS_IMM, line);
        chunk__push(self, imm_index, line);
    } else {
        chunk__push_ins(self, INS_IMM_LONG, line);
        chunk__push(self, imm_index >> 16, line);
        chunk__push(self, imm_index >> 8, line);
        chunk__push(self, imm_index, line);
    }

    return imm_index;
}

u32 chunk__push_value(chunk_t* self, value_t immediate) {
    return value_arr__push(&self->immediates, self->vm->allocator, immediate);
}

u32 chunk__ins_get_line(chunk_t* self, u32 ip) {
    u32 lines_index = 0;
    while (lines_index < self->lines_fill) {
        u32 n = self->lines[lines_index];
        u32 line = self->lines[lines_index + 1];
        if (ip < n) {
            return line;
        }
        ip -= n;

        lines_index += 2;
    }

    ASSERT(false);
    return -1;
}
