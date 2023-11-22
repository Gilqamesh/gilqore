#include "debug.h"

#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>

debug_t debug;

static const char* first_col    = "ip";
static const char* second_col   = "ins bytecode";
static const char* third_col    = "ins mnemonic";
static const char* forth_col    = "ins operand";
static const char* fifth_col    = "stack delta";
static const char* sixth_col    = "bp";
static const char* seventh_col  = "sp";

static const uint32_t col_padding = 4;
static const uint32_t first_col_len  = max(sizeof(first_col),  sizeof(uint64_t) * 2 + 1 /* : */);
static const uint32_t second_col_len = max(sizeof(second_col), 2 * (2 * max(sizeof(reg_t), sizeof(regf_t)) + 2) - 1);
static const uint32_t third_col_len  = max(sizeof(third_col),  20);
static const uint32_t forth_col_len  = max(sizeof(forth_col),  20);
static const uint32_t fifth_col_len  = max(sizeof(forth_col),  3 * (2 * max(sizeof(reg_t), sizeof(regf_t)) + 3) - 1);
static const uint32_t sixth_col_len  = max(sizeof(fifth_col),  sizeof(uint64_t) * 2);
static const uint32_t seventh_col_len  = max(sizeof(fifth_col),  sizeof(uint64_t) * 2);

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
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col
        // col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col,
        // col_padding, ' ', sixth_col_len, sixth_col_len, sixth_col,
        // col_padding, ' ', seventh_col_len, seventh_col_len, seventh_col
    );

    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, runtime_code_file_str);
    self->runtime_code_file = fopen(path_buffer, "w");
    fprintf(
        self->runtime_code_file,
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col,
        col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col,
        col_padding, ' ', sixth_col_len, sixth_col_len, sixth_col,
        col_padding, ' ', seventh_col_len, seventh_col_len, seventh_col
    );

    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, runtime_stack_file_str);
    self->runtime_stack_file = fopen(path_buffer, "w");
    fprintf(
        self->runtime_stack_file,
        "%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s%*c%-*.*s\n",
        first_col_len, first_col_len, first_col, 
        col_padding, ' ', second_col_len, second_col_len, second_col,
        col_padding, ' ', third_col_len, third_col_len, third_col,
        col_padding, ' ', forth_col_len, forth_col_len, forth_col,
        col_padding, ' ', fifth_col_len, fifth_col_len, fifth_col,
        col_padding, ' ', sixth_col_len, sixth_col_len, sixth_col,
        col_padding, ' ', seventh_col_len, seventh_col_len, seventh_col
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
    }

    return buffer_top - buffer_top_start;
}

void debug__push_code(debug_t* self, uint8_t* bytes, uint32_t bytes_size) {
    self->byte_code_top += debug__push_hex(self->byte_code, self->byte_code + self->byte_code_top, self->byte_code + sizeof(self->byte_code), bytes, bytes_size);
}

void debug__push_ins_arg(debug_t* self, const char* str) {
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

void debug__push_stack_delta(debug_t* self, uint8_t* bytes, uint32_t bytes_size) {
    self->stack_delta_top += debug__push_hex(self->stack_delta, self->stack_delta + self->stack_delta_top, self->stack_delta + sizeof(self->stack_delta), bytes, bytes_size);
}

void debug__dump_line(debug_t* self, FILE* fp) {
    if (self->fn) {
        fprintf(fp, "\n%s:\n", self->fn);
        self->fn = 0;
    }

    // first col
    fprintf(fp, "%0*lx:", first_col_len - 1, (uint64_t) self->ip);
    
    // second col
    fprintf(fp, "    ");
    ASSERT(self->byte_code_top <= second_col_len);
    if (self->byte_code_top > 0) {
        fprintf(fp, "%-*s", second_col_len, self->byte_code);
    } else {
        fprintf(fp, "%*c", second_col_len, ' ');
    }

    // third col
    fprintf(fp, "    ");
    fprintf(fp, "%-*s", third_col_len, enum_ins__to_str((ins_t) *self->ip));

    // forth col
    fprintf(fp, "    ");
    if (self->instruction_operand_top > 0) {
        fprintf(fp, "%-*s", forth_col_len, self->instruction_operand);
    } else {
        fprintf(fp, "%*c", forth_col_len, ' ');
    }

    if (self->state->alive) {
        // fifth col
        fprintf(fp, "    ");
        if (self->stack_delta_top > 0) {
            fprintf(fp, "%-*s", fifth_col_len, self->stack_delta);
        } else {
            fprintf(fp, "%*c", fifth_col_len, ' ');
        }
    
        // sixth col
        fprintf(fp, "    ");
        fprintf(fp, "%0*lx", sixth_col_len, (uint64_t) self->state->address_registers[REG_SP]);

        // seventh col
        fprintf(fp, "    ");
        fprintf(fp, "%0*lx", seventh_col_len, (uint64_t) self->state->address_registers[REG_SP]);
    }


    fprintf(fp, "\n");

    self->instruction_operand_top = 0;
    self->byte_code_top = 0;
    self->stack_delta_top = 0;
    self->ip = 0;
}
