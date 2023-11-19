#include "debug.h"

#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>

debug_t debug;

static const char* first_col  = "ip";
static const char* second_col = "ins bytecode";
static const char* third_col  = "instruction mnemonic";
static const char* forth_col  = "stack bytecode";
static const char* fifth_col  = "base pointer";

static const uint32_t col_padding = 4;
static const uint32_t first_col_len  = max(sizeof(uint64_t) * 2 + 1 /* : */, sizeof(first_col));
static const uint32_t second_col_len = max(2 * (3 * max(sizeof(reg_t), sizeof(regf_t))) - 1, sizeof(second_col));
static const uint32_t third_col_len  = max(20, sizeof(third_col));
static const uint32_t forth_col_len  = max(3 * (3 * max(sizeof(reg_t), sizeof(regf_t))) - 1, sizeof(forth_col));
static const uint32_t fifth_col_len  = max(sizeof(uint64_t) * 2, sizeof(fifth_col));

static uint32_t debug__push_hex(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* bytes, uint32_t bytes_size);

void debug__create(debug_t* self, state_t* state) {
    memset(self, 0, sizeof(*self));

    self->state = state;

    const char* compiled_code_file_str = "compiled_code";
    const char* runtime_code_file_str = "runtime_code";
    const char* runtime_stack_file_str = "runtime_stack";

    char dir_buffer[128];
    time_t cur_time = time(0);
    struct tm* local_time = localtime(&cur_time);
    snprintf(
        dir_buffer, sizeof(dir_buffer),
        "debug/%02d-%02d-%02d-%02d",
        local_time->tm_mday, local_time->tm_hour, local_time->tm_min, local_time->tm_sec
    );

    ASSERT(mkdir(dir_buffer, 0777) == 0);
    ASSERT(access(dir_buffer, F_OK) == 0);

    char path_buffer[256];

    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, compiled_code_file_str);
    self->compiled_code_file = fopen(path_buffer, "w");
    fprintf(
        self->compiled_code_file,
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col,
        col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col
    );

    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, runtime_code_file_str);
    self->runtime_code_file = fopen(path_buffer, "w");
    fprintf(
        self->runtime_code_file,
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col,
        col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col
    );

    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, runtime_stack_file_str);
    self->runtime_stack_file = fopen(path_buffer, "w");
    fprintf(
        self->runtime_stack_file,
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col,
        col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col
    );
}

void debug__destroy(debug_t* self) {
    fclose(self->compiled_code_file);
    fclose(self->runtime_code_file);
    fclose(self->runtime_stack_file);
}

void debug__set_ip(debug_t* self, uint8_t* ip) {
    self->ip = ip;
}

void debug__set_fn(debug_t* self, const char* fn) {
    self->fn = fn;
}

static uint32_t debug__push_hex(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* bytes, uint32_t bytes_size) {
    bytes = bytes + bytes_size;
    uint8_t* buffer_top_start = buffer_top;

    ASSERT(buffer_top < buffer_end);
    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }

    for (uint32_t bytes_index = 0; bytes_index < bytes_size; ++bytes_index) {
        ASSERT(buffer_top + 2 < buffer_end);
        int32_t bytes_written = snprintf(
            buffer_top, buffer_end - buffer_top,
            "%02x", (int32_t) *--bytes
        );
        ASSERT(bytes_written == 2);
        buffer_top += bytes_written;
        // if (bytes_index < bytes_size - 1) {
        //     ASSERT(buffer_top < buffer_end);
        //     bytes_written = snprintf(
        //         buffer_top, buffer_end - buffer_top,
        //         " "
        //     );
        //     ASSERT(bytes_written == 1);
        //     buffer_top += bytes_written;
        // }
    }

    return buffer_top - buffer_top_start;
}

void debug__push_code(debug_t* self, uint8_t* bytes, uint32_t bytes_size) {
    self->byte_code_top += debug__push_hex(self->byte_code, self->byte_code + self->byte_code_top, self->byte_code + sizeof(self->byte_code), bytes, bytes_size);
}

void debug__push_ins_arg_str(debug_t* self, const char* str) {
    ASSERT(self->instruction_operand_top < sizeof(self->instruction_operand));
    if (self->instruction_operand_top > 0) {
        self->instruction_operand[self->instruction_operand_top++] = ' ';
    }
    size_t str_len = strlen(str);
    ASSERT(
        snprintf(
            self->instruction_operand + self->instruction_operand_top, sizeof(self->instruction_operand) - self->instruction_operand_top,
            "%s", str
        ) == str_len
    );
    self->instruction_operand_top += str_len;
}

void debug__push_ins_arg_bytes(debug_t* self, uint8_t* bytes, uint32_t bytes_size) {
    self->instruction_operand_top += debug__push_hex(self->instruction_operand, self->instruction_operand + self->instruction_operand_top, self->instruction_operand + sizeof(self->instruction_operand), bytes, bytes_size);
}

void debug__dump_line(debug_t* self, FILE* fp) {
    if (self->fn) {
        fprintf(fp, "\n%s:\n", self->fn);
        self->fn = 0;
    }

    // first col
    const uint32_t byte_code_max = 2 * (3 * max(sizeof(reg_t), sizeof(regf_t))) - 1;
    ASSERT(self->byte_code_top <= byte_code_max);
    uint32_t byte_code_index = 0;
    fprintf(fp, "%016lx:", (uint64_t) self->ip);
    
    // second col
    fprintf(fp, "    ");
    while (byte_code_index < self->byte_code_top) {
        fprintf(fp, "%c", self->byte_code[byte_code_index++]);
    }
    if (byte_code_index < byte_code_max) {
        fprintf(fp, "%*c", byte_code_max - byte_code_index, ' ');
    }

    // third col
    fprintf(fp, "    ");
    fprintf(fp, "%-20s", enum_ins__to_str((ins_t) *self->ip));

    // forth col
    fprintf(fp, "    ");
    const uint32_t instruction_operand_len_max = 3 * (3 * max(sizeof(reg_t), sizeof(regf_t))) - 1;
    if (self->instruction_operand_top > 0) {
        fprintf(fp, "%-*s", instruction_operand_len_max, self->instruction_operand);
    } else {
        fprintf(fp, "%*c", instruction_operand_len_max, ' ');
    }

    // fifth col
    if (self->state->alive) {
        fprintf(fp, "    ");
        fprintf(fp, "%016lx", (uint64_t) self->state->base_pointer);
    }

    // uint8_t* sp = self->state->stack_top;
    // if (sp != self->state->stack) {
    //     fprintf(fp, "    %02x", *--sp);
    //     while (sp > self->state->stack) {
    //         fprintf(fp, " %02x", *--sp);
    //     }
    // }

    fprintf(fp, "\n");

    self->instruction_operand_top = 0;
    self->byte_code_top = 0;
    self->ip = 0;
}
