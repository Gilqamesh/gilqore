#include "debug.h"

#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>

debug_t debug;

static uint32_t _debug__push_bin(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint64_t a);
static uint32_t _debug__push_hex(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* bytes, uint32_t bytes_size);
static uint32_t _debug__push_int(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, int64_t a);
static uint32_t _debug__push_flt(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, double a);

uint32_t print_bin(uint64_t a, uint8_t* buffer_cur, uint8_t* buffer_end) {
    ASSERT(buffer_cur < buffer_end);
    if (a < 2) {
        *buffer_cur = (a & 1) ? '1': '0';
        return 1;
    }

    *buffer_cur++ = (a & 1) ? '1': '0';
    
    return 1 + print_bin(a >> 1, buffer_cur, buffer_end);
}

static uint32_t _debug__push_bin(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint64_t a) {
    uint8_t* buffer_top_start = buffer_top;

    ASSERT(buffer_top < buffer_end);
    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }

    uint32_t written_bytes = print_bin(a, buffer_top, buffer_end);
    uint8_t* bytes_to_flip = buffer_top;
    buffer_top += written_bytes;

    // flip
    for (uint32_t byte_offset = 0; byte_offset < written_bytes / 2; ++byte_offset) {
        uint8_t tmp = *(bytes_to_flip + byte_offset);
        *(bytes_to_flip + byte_offset) = *(bytes_to_flip + written_bytes - 1 - byte_offset);
        *(bytes_to_flip + written_bytes - 1 - byte_offset) = tmp;
    }

    ASSERT(buffer_top < buffer_end);
    *buffer_top = '\0';

    return buffer_top - buffer_top_start;
}

static uint32_t _debug__push_hex(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, uint8_t* bytes, uint32_t bytes_size) {
    bytes = bytes + bytes_size;
    uint8_t* buffer_top_start = buffer_top;

    ASSERT(buffer_top < buffer_end);
    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }

    for (uint32_t bytes_index = 0; bytes_index < bytes_size; ++bytes_index) {
        ASSERT(buffer_top + 2 < buffer_end);
        int32_t bytes_written = snprintf(
            (char*) buffer_top, buffer_end - buffer_top,
            "%02x", (int32_t) *--bytes
        );
        ASSERT(bytes_written == 2);
        buffer_top += bytes_written;
    }

    return buffer_top - buffer_top_start;
}

static uint32_t _debug__push_int(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, int64_t a) {
    uint8_t* buffer_top_start = buffer_top;
    ASSERT(buffer_top < buffer_end);
    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }
    int32_t bytes_written = snprintf((char*) buffer_top, buffer_end - buffer_top, "%ld", a);
    buffer_top += bytes_written;

    return buffer_top - buffer_top_start;
}

static uint32_t _debug__push_flt(uint8_t* buffer_start, uint8_t* buffer_top, uint8_t* buffer_end, double a) {
    uint8_t* buffer_top_start = buffer_top;
    ASSERT(buffer_top < buffer_end);
    if (buffer_top > buffer_start) {
        *buffer_top++ = ' ';
    }
    int32_t bytes_written = snprintf((char*) buffer_top, buffer_end - buffer_top, "%.3lf", a);
    buffer_top += bytes_written;

    return buffer_top - buffer_top_start;
}

bool debug_buffer__create(debug_buffer_t* self, const char* name, uint32_t format_len, uint32_t max_size) {
    self->name = name;
    self->format_len = max(strlen(name), format_len);
    if (!buffer__create(&self->buffer, max_size)) {
        return false;
    }

    return true;
}

void debug_buffer__destroy(debug_buffer_t* self) {
    (void) self;
}

bool debug__create(debug_t* self) {
    memset(self, 0, sizeof(*self));

    self->debug_buffer_separator = "    ";

    const char* debug_buffer_name[_DEBUG_BUFFER_TYPE_SIZE] = {
        [DEBUG_BUFFER_TYPE_IP]              = "ip",
        [DEBUG_BUFFER_TYPE_INS_BYTECODE]    = "ins bytecode",
        [DEBUG_BUFFER_TYPE_INS_MNEMONIC]    = "ins mnemonic",
        [DEBUG_BUFFER_TYPE_INS_OPERAND]     = "ins operand",
        [DEBUG_BUFFER_TYPE_RETURN_IP]       = "return ip",
        [DEBUG_BUFFER_TYPE_REGISTER]        = "register",
        [DEBUG_BUFFER_TYPE_REGISTERF]       = "registerf",
        [DEBUG_BUFFER_TYPE_ARG_TYPE]        = "argument type",
        [DEBUG_BUFFER_TYPE_RET_TYPE]        = "return type",
        [DEBUG_BUFFER_TYPE_LOC_TYPE]        = "local type"
    };
    const uint32_t debug_buffer_format_len[_DEBUG_BUFFER_TYPE_SIZE] = {
        [DEBUG_BUFFER_TYPE_IP]              = sizeof(uint64_t) * 2 + 1 /* : */,
        [DEBUG_BUFFER_TYPE_INS_BYTECODE]    = 2 * (2 * max(sizeof(reg_t), sizeof(regf_t)) + 2) - 1,
        [DEBUG_BUFFER_TYPE_INS_MNEMONIC]    = 20,
        [DEBUG_BUFFER_TYPE_INS_OPERAND]     = 50,
        [DEBUG_BUFFER_TYPE_RETURN_IP]       = sizeof(uint8_t*) * 2,
        [DEBUG_BUFFER_TYPE_REGISTER]        = sizeof(reg_t) * 2,
        [DEBUG_BUFFER_TYPE_REGISTERF]       = sizeof(regf_t) * 2,
        [DEBUG_BUFFER_TYPE_ARG_TYPE]        = sizeof(uint8_t*) * 2,
        [DEBUG_BUFFER_TYPE_RET_TYPE]        = sizeof(uint8_t*) * 2,
        [DEBUG_BUFFER_TYPE_LOC_TYPE]        = sizeof(uint8_t*) * 2
    };
    ASSERT(sizeof(debug_buffer_name)/sizeof(debug_buffer_name[0]) == _DEBUG_BUFFER_TYPE_SIZE);
    for (uint32_t debug_buffer_index = 0; debug_buffer_index < _DEBUG_BUFFER_TYPE_SIZE; ++debug_buffer_index) {
        if (!debug_buffer__create(&self->debug_buffer[debug_buffer_index], debug_buffer_name[debug_buffer_index], debug_buffer_format_len[debug_buffer_index], 256)) {
            return false;
        }
    }

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
    const char* source_dump_name = "in_source.txt";
    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, source_dump_name);
    self->source_dump = fopen(path_buffer, "w");
    ASSERT(self->source_dump);
    
    const char* scanner_dump_name = "out_scanner.txt";
    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, scanner_dump_name);
    self->scanner_dump = fopen(path_buffer, "w");
    ASSERT(self->scanner_dump);
    
    const char* compiler_out_dump_name = "out_compiler.txt";
    snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, compiler_out_dump_name);
    self->compiler_out_dump = fopen(path_buffer, "w");
    ASSERT(self->compiler_out_dump);


    const char* out_paths[_DEBUG_OUT_MODE_SIZE] = {
        [DEBUG_OUT_MODE_COMPILE]        = "compiled_code.txt",
        [DEBUG_OUT_MODE_RUNTIME_CODE]   = "runtime_code.txt",
        [DEBUG_OUT_MODE_RUNTIME_STACK]  = "runtime_stack.txt"
    };

    const debug_buffer_type_t debug_out_supported_types[_DEBUG_OUT_MODE_SIZE][_DEBUG_BUFFER_TYPE_SIZE] = {
        [DEBUG_OUT_MODE_COMPILE] = { // DEBUG_OUT_MODE_COMPILE
            DEBUG_BUFFER_TYPE_IP,
            DEBUG_BUFFER_TYPE_INS_BYTECODE,
            DEBUG_BUFFER_TYPE_INS_MNEMONIC,
            DEBUG_BUFFER_TYPE_INS_OPERAND,

            _DEBUG_BUFFER_TYPE_SIZE
        },
        [DEBUG_OUT_MODE_RUNTIME_CODE] = { // DEBUG_OUT_MODE_RUNTIME_CODE
            DEBUG_BUFFER_TYPE_IP,
            DEBUG_BUFFER_TYPE_INS_BYTECODE,
            DEBUG_BUFFER_TYPE_INS_MNEMONIC,
            DEBUG_BUFFER_TYPE_INS_OPERAND,

            _DEBUG_BUFFER_TYPE_SIZE
        },
        [DEBUG_OUT_MODE_RUNTIME_STACK] = { // DEBUG_OUT_MODE_RUNTIME_STACK
            DEBUG_BUFFER_TYPE_IP,
            DEBUG_BUFFER_TYPE_INS_MNEMONIC,
            DEBUG_BUFFER_TYPE_RETURN_IP,
            DEBUG_BUFFER_TYPE_REGISTER,
            DEBUG_BUFFER_TYPE_REGISTERF,
            DEBUG_BUFFER_TYPE_ARG_TYPE,
            DEBUG_BUFFER_TYPE_RET_TYPE,
            DEBUG_BUFFER_TYPE_LOC_TYPE,

            _DEBUG_BUFFER_TYPE_SIZE
        }
    };

    ASSERT(sizeof(debug_out_supported_types)/sizeof(debug_out_supported_types[0]) == _DEBUG_OUT_MODE_SIZE);
    for (uint32_t debug_out_index = 0; debug_out_index < _DEBUG_OUT_MODE_SIZE; ++debug_out_index) {
        snprintf(path_buffer, sizeof(path_buffer), "%s/%s", dir_buffer, out_paths[debug_out_index]);
        debug_out_t* debug_out = &self->debug_out[debug_out_index];
        debug_out->fp = fopen(path_buffer, "w");
        ASSERT(debug_out->fp);
        debug_out->supported_types_top = 0;
        for (uint32_t debug_out_supported_types_index = 0; debug_out_supported_types_index < _DEBUG_BUFFER_TYPE_SIZE; ++debug_out_supported_types_index) {
            debug_buffer_type_t supported_type = debug_out_supported_types[debug_out_index][debug_out_supported_types_index];
            if (supported_type == _DEBUG_BUFFER_TYPE_SIZE) {
                break ;
            }
            if (debug_out_supported_types_index > 0) {
                fprintf(debug_out->fp, "%s", self->debug_buffer_separator);
            }
            fprintf(debug_out->fp, "%-*.*s", self->debug_buffer[supported_type].format_len, self->debug_buffer[supported_type].format_len, self->debug_buffer[supported_type].name);
            debug_out->supported_types[debug_out->supported_types_top++] = supported_type;
        }
        fprintf(debug_out->fp, "\n");
    }

    return true;
}

void debug__destroy(debug_t* self) {
    for (uint32_t debug_out_index = 0; debug_out_index < _DEBUG_OUT_MODE_SIZE; ++debug_out_index) {
        fclose(self->debug_out[debug_out_index].fp);
    }
    fclose(self->scanner_dump);
    fclose(self->source_dump);
    fclose(self->compiler_out_dump);
}

void debug__set_fn(debug_t* self, const char* fn) {
    self->fn = fn;
}

void debug__push_flt(debug_t* self, debug_buffer_type_t type, double a) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    self->debug_buffer[type].buffer.cur += _debug__push_flt(self->debug_buffer[type].buffer.start, self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end, a);
}

void debug__push_int(debug_t* self, debug_buffer_type_t type, int64_t a) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    self->debug_buffer[type].buffer.cur += _debug__push_int(self->debug_buffer[type].buffer.start, self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end, a);
}

void debug__push_bin(debug_t* self, debug_buffer_type_t type, uint64_t a) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    self->debug_buffer[type].buffer.cur += _debug__push_bin(self->debug_buffer[type].buffer.start, self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end, a);
}

void debug__push_hex(debug_t* self, debug_buffer_type_t type, uint8_t* bytes, uint32_t bytes_size) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    self->debug_buffer[type].buffer.cur += _debug__push_hex(self->debug_buffer[type].buffer.start, self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end, bytes, bytes_size);
}

void debug__push_str(debug_t* self, debug_buffer_type_t type, const char* str) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    size_t str_len = strlen(str);
    ASSERT(self->debug_buffer[type].buffer.cur + str_len < self->debug_buffer[type].buffer.end);
    if (self->debug_buffer[type].buffer.cur > self->debug_buffer[type].buffer.start) {
        *self->debug_buffer[type].buffer.cur++ = ' ';
    }
    ASSERT(
        snprintf(
            (char*) self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end - self->debug_buffer[type].buffer.cur,
            "%s", str
        ) == (int) str_len
    );
    self->debug_buffer[type].buffer.cur += str_len;
}

void debug__push_ptr(debug_t* self, debug_buffer_type_t type, uint8_t* ptr) {
    ASSERT(type < _DEBUG_BUFFER_TYPE_SIZE);
    uint64_t ptr_val = (uint64_t) ptr;
    uint8_t* ptr_val_p = (uint8_t*) &ptr_val;
    self->debug_buffer[type].buffer.cur += _debug__push_hex(self->debug_buffer[type].buffer.start, self->debug_buffer[type].buffer.cur, self->debug_buffer[type].buffer.end, ptr_val_p, sizeof(uint8_t*));
}

void debug__dump_line(debug_t* self, debug_out_mode_t out_mode) {
    ASSERT(out_mode < _DEBUG_OUT_MODE_SIZE);
    FILE* fp = self->debug_out[out_mode].fp;

    if (self->fn) {
        fprintf(fp, "\n%s:\n", self->fn);
        self->fn = 0;
    }

    bool written_line = false;
    for (debug_buffer_type_t debug_buffer_type = 0; debug_buffer_type < _DEBUG_BUFFER_TYPE_SIZE; ++debug_buffer_type) {
        bool is_supported = false;
        for (uint32_t supported_types_index = 0; supported_types_index < self->debug_out[out_mode].supported_types_top; ++supported_types_index) {
            if (self->debug_out[out_mode].supported_types[supported_types_index] == debug_buffer_type) {
                is_supported = true;
                break ;
            }
        }

        if (is_supported) {
            if (!written_line) {
                written_line = true;
            } else {
                fprintf(fp, "%s", self->debug_buffer_separator);
            }

            if (self->debug_buffer[debug_buffer_type].buffer.cur > self->debug_buffer[debug_buffer_type].buffer.start) {
                fprintf(fp, "%-*.*s", self->debug_buffer[debug_buffer_type].format_len, self->debug_buffer[debug_buffer_type].format_len, self->debug_buffer[debug_buffer_type].buffer.start);
            } else {
                fprintf(fp, "%*c", self->debug_buffer[debug_buffer_type].format_len, ' ');
            }
        }
    }
    fprintf(fp, "\n");
    fflush(fp);
}

void debug__clear_line(debug_t* self) {
    self->fn = 0;
    for (debug_buffer_type_t debug_buffer_type = 0; debug_buffer_type < _DEBUG_BUFFER_TYPE_SIZE; ++debug_buffer_type) {
        self->debug_buffer[debug_buffer_type].buffer.cur = self->debug_buffer[debug_buffer_type].buffer.start;
    }
}
