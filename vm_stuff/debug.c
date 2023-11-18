#include "debug.h"

#include <assert.h>
#include <string.h>

debug_t debug;

void debug__create(debug_t* self, state_t* state) {
    memset(self, 0, sizeof(*self));

    self->state = state;

    self->compiled_code_file = fopen("debug/compiled_code", "w");
    self->runtime_code_file = fopen("debug/runtime_code", "w");
    self->runtime_stack_file = fopen("debug/runtime_stack", "w");
    self->crash_dump_file = fopen("debug/crash_dump", "w");
}

void debug__destroy(debug_t* self) {
    fclose(self->compiled_code_file);
    fclose(self->runtime_code_file);
    fclose(self->runtime_stack_file);
    if (
        self->byte_code_top > 0 ||
        self->instruction_operand_top > 0
    ) {
        debug__dump_line(self, self->crash_dump_file);
    }
    fclose(self->crash_dump_file);
}

void debug__set_ip(debug_t* self, uint8_t* ip) {
    self->ip = ip;
}

void debug__set_fn(debug_t* self, const char* fn) {
    self->fn = fn;
}

void debug__push_code(debug_t* self, uint8_t* bytes, uint32_t bytes_size) {
    ASSERT(self->byte_code_top < sizeof(self->byte_code));
    if (self->byte_code_top > 0) {
        self->byte_code[self->byte_code_top++] = ' ';
    }

    for (uint32_t bytes_index = 0; bytes_index < bytes_size; ++bytes_index) {
        ASSERT(self->byte_code_top + 2 < sizeof(self->byte_code));
        int32_t bytes_written = snprintf(
            self->byte_code + self->byte_code_top, sizeof(self->byte_code) - self->byte_code_top,
            "%02x", (int32_t) *bytes++
        );
        ASSERT(bytes_written == 2);
        self->byte_code_top += 2;
        if (bytes_index < bytes_size - 1) {
            ASSERT(self->byte_code_top < sizeof(self->byte_code));
            bytes_written = snprintf(
                self->byte_code + self->byte_code_top, sizeof(self->byte_code) - self->byte_code_top,
                " "
            );
            ASSERT(bytes_written == 1);
            self->byte_code_top++;
        }
    }
}

void debug__push_ins_arg(debug_t* self, const char* str) {
    size_t str_len = strlen(str);
    ASSERT(
        snprintf(
            self->instruction_operand + self->instruction_operand_top, sizeof(self->instruction_operand) - self->instruction_operand_top,
            "%s", str
        ) == str_len
    );
    self->instruction_operand_top += str_len;
}

void debug__dump_line(debug_t* self, FILE* fp) {
    if (self->fn) {
        fprintf(fp, "\n%s:\n", self->fn);
        self->fn = 0;
    }

    const uint32_t byte_code_max = max(sizeof(reg_t), sizeof(regf_t)) * 2 + max(sizeof(reg_t), sizeof(regf_t)) - 1;
    ASSERT(self->byte_code_top <= byte_code_max);
    uint32_t byte_code_index = 0;
    fprintf(fp, "    %05lx:", (uint64_t) self->ip % 1048576);
    fprintf(fp, "    ");
    
    while (byte_code_index < self->byte_code_top) {
        fprintf(fp, "%c", self->byte_code[byte_code_index++]);
    }
    if (byte_code_index < byte_code_max) {
        fprintf(fp, "%*c", byte_code_max - byte_code_index, ' ');
    }
    fprintf(fp, "    %-20s", enum_ins__to_str((ins_t) *self->ip));

    if (self->instruction_operand_top > 0) {
        fprintf(fp, "    %-20s", self->instruction_operand);
    } else {
        fprintf(fp, "    %*c", 20, ' ');
    }

    if (self->state->alive) {
        fprintf(fp, "    %05lx", (uint64_t) self->state->base_pointer % 1048576);
    }

    fprintf(fp, "\n");

    self->instruction_operand_top = 0;
    self->byte_code_top = 0;
    self->ip = 0;
}
