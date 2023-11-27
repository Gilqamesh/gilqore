#ifndef DEBUG_H
# define DEBUG_H

# include <stdio.h>
# include <stdint.h>
# include <assert.h>
# include <stdbool.h>

# include "types.h"
# include "buffer.h"

#define ASSERT(cond) do { \
    if (!(cond)) { \
        if (!debug.panic_mode) { \
            debug.panic_mode = true; \
            debug__dump_line(&debug, DEBUG_OUT_MODE_RUNTIME_CODE); \
            debug__clear_line(&debug); \
            debug__destroy(&debug); \
        } \
        assert(cond); \
    } \
} while (false)

typedef enum debug_buffer_type {
    DEBUG_BUFFER_TYPE_IP,
    DEBUG_BUFFER_TYPE_INS_BYTECODE,
    DEBUG_BUFFER_TYPE_INS_MNEMONIC,
    DEBUG_BUFFER_TYPE_INS_OPERAND,
    DEBUG_BUFFER_TYPE_RETURN_IP,
    DEBUG_BUFFER_TYPE_REGISTER,
    DEBUG_BUFFER_TYPE_REGISTERF,
    DEBUG_BUFFER_TYPE_ARG_TYPE,
    DEBUG_BUFFER_TYPE_RET_TYPE,
    DEBUG_BUFFER_TYPE_LOC_TYPE,

    _DEBUG_BUFFER_TYPE_SIZE
} debug_buffer_type_t;

typedef struct debug_buffer {
    buffer_t    buffer;
    const char* name;
    uint32_t    format_len;
} debug_buffer_t;

bool debug_buffer__create(debug_buffer_t* self, const char* name, uint32_t format_len, uint32_t max_size);
void debug_buffer__destroy(debug_buffer_t* self);

typedef enum debug_out_mode {
    DEBUG_OUT_MODE_COMPILE,
    DEBUG_OUT_MODE_RUNTIME_CODE,
    DEBUG_OUT_MODE_RUNTIME_STACK,

    _DEBUG_OUT_MODE_SIZE
} debug_out_mode_t;

typedef struct debug_out {
    FILE*                   fp;
    uint32_t                supported_types_top;
    debug_buffer_type_t     supported_types[_DEBUG_BUFFER_TYPE_SIZE];
} debug_out_t;

typedef struct debug {
    const char*     fn;

    const char*     debug_buffer_separator;
    debug_buffer_t  debug_buffer[_DEBUG_BUFFER_TYPE_SIZE];
    debug_out_t     debug_out[_DEBUG_OUT_MODE_SIZE];

    bool            panic_mode;
} debug_t;

extern debug_t debug;

bool debug__create(debug_t* self);
void debug__destroy(debug_t* self);

void debug__set_fn(debug_t* self, const char* fn);
void debug__push_flt(debug_t* self, debug_buffer_type_t type, double a);
void debug__push_int(debug_t* self, debug_buffer_type_t type, int64_t a);
void debug__push_bin(debug_t* self, debug_buffer_type_t type, uint64_t a);
void debug__push_hex(debug_t* self, debug_buffer_type_t type, uint8_t* bytes, uint32_t bytes_size);
void debug__push_str(debug_t* self, debug_buffer_type_t type, const char* str);
void debug__push_ptr(debug_t* self, debug_buffer_type_t type, uint8_t* ptr);
void debug__dump_line(debug_t* self, debug_out_mode_t out_mode);
void debug__clear_line(debug_t* self);

#endif // DEBUG_H
