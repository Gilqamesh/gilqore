#include "chunk.h"
#include "vm.h"
#include "scanner.h"

#include "libc/libc.h"
#include "types/basic_types/basic_types.h"

static void chunk__init(chunk_t* self);
static u32  chunk__push(chunk_t* self, ins_mnemonic_t instruction, token_t token);

static void chunk__init(chunk_t* self) {
    libc__memset(self, 0, sizeof(*self));
}

static u32 chunk__push(chunk_t* self, ins_mnemonic_t instruction, token_t token) {
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

    if (self->token_infos_fill == self->token_infos_size) {
        u32 new_size = self->token_infos_size < 8 ? 8 : self->token_infos_size * 2;
        self->token_infos = allocator__realloc(
            allocator, self->token_infos,
            self->token_infos_size * sizeof(*self->token_infos),
            new_size * sizeof(*self->token_infos)
        );
        self->token_infos_size = new_size;
    }
    self->token_infos[self->token_infos_fill].line_s = token.line_s;
    self->token_infos[self->token_infos_fill].line_e = token.line_e;
    self->token_infos[self->token_infos_fill].col_s  = token.col_s;
    self->token_infos[self->token_infos_fill].col_e  = token.col_e;
    ++self->token_infos_fill;

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

    if (self->token_infos) {
        allocator__free(allocator, self->token_infos);
    }

    value_arr__destroy(&self->immediates, allocator);
    
    chunk__init(self);
}

u32 chunk__push_ins(chunk_t* self, ins_mnemonic_t instruction, token_t token) {
    const s32 stack_delta = self->vm->ins_infos[instruction].stack_delta;
    if (instruction == INS_POPN) {
        ASSERT(self->immediates.values_fill > 0);
        value_t index_value = self->immediates.values[self->immediates.values_fill - 1];
        r64 value_as_num = value__as_num(index_value);
        r64 value_as_num_integral_part;
        r64 value_as_num_fractional_part = r64__modular_fraction(value_as_num, &value_as_num_integral_part);
        ASSERT(value_as_num_integral_part >= 0 && value_as_num_fractional_part == 0.0);
        // + 1 because it also pops the immediate
        self->current_stack_size -= ((s32) value_as_num + 1);
    } else {
        self->current_stack_size += stack_delta;
    }
    if (self->current_stack_size > 0 && (u32) self->current_stack_size > self->values_stack_size_watermark) {
        self->values_stack_size_watermark = (u32) self->current_stack_size;
    }

    return chunk__push(self, instruction, token);
}

u32 chunk__push_imm(chunk_t* self, value_t imm, token_t token) {
    u32 imm_index = chunk__push_value(self, imm);
    if (imm_index < 4) {
        chunk__push_ins(self, INS_IMM, token);
        chunk__push(self, imm_index, token);
    } else {
        chunk__push_ins(self, INS_IMM_LONG, token);
        chunk__push(self, imm_index >> 16, token);
        chunk__push(self, imm_index >> 8, token);
        chunk__push(self, imm_index, token);
    }

    return imm_index;
}

u32 chunk__push_value(chunk_t* self, value_t immediate) {
    return value_arr__push(&self->immediates, self->vm->allocator, immediate);
}

token_info_t* chunk__get_token_info(chunk_t* self, u32 ip) {
    ASSERT(ip < self->token_infos_fill);
    return &self->token_infos[ip];
}
