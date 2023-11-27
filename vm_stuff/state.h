#ifndef STATE_H
# define STATE_H

# include <stdint.h>
# include <stdbool.h>

# include "shared_lib.h"
# include "buffer.h"
# include "compiler.h"
# include "debug.h"

typedef enum buffer_type {
    BUFFER_TYPE_IP,
    BUFFER_TYPE_RETURN_IP_STACK,
    BUFFER_TYPE_REGISTER_STACK,
    BUFFER_TYPE_REGISTERF_STACK,

    _BUFFER_TYPE_SIZE
} buffer_type_t;
const char* buffer_type__to_str(buffer_type_t type);
debug_buffer_type_t buffer_type__to_debug_buffer_type(buffer_type_t type);

# define BUFFER_TOP_WRAPPER(state_p, buffer_type, type, offset, result) do { \
    ASSERT(buffer_type < _BUFFER_TYPE_SIZE); \
    BUFFER_TOP(state_p->buffer[buffer_type], type, offset, result); \
} while (false)
# define BUFFER_PUSH_WRAPPER(state_p, buffer_type, type, a) do { \
    ASSERT(buffer_type < _BUFFER_TYPE_SIZE); \
    debug__push_hex(&debug, buffer_type__to_debug_buffer_type(buffer_type), (uint8_t*)(&(a)), sizeof(type)); \
    BUFFER_PUSH(state_p->buffer[buffer_type], type, a); \
} while (false)
# define BUFFER_POP_WRAPPER(state_p, buffer_type, type, result) do { \
    ASSERT(buffer_type < _BUFFER_TYPE_SIZE); \
    debug__push_hex(&debug, buffer_type__to_debug_buffer_type(buffer_type), (uint8_t*)(&(result)), sizeof(type)); \
    BUFFER_POP(state_p->buffer[buffer_type], type, result); \
} while (false)
# define BUFFER_GROW_WRAPPER(state_p, buffer_type, n) do { \
    ASSERT(buffer_type < _BUFFER_TYPE_SIZE); \
    BUFFER_GROW(state_p->buffer[buffer_type], n); \
}

typedef enum aligned_buffer_type {
    ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK,
    ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK,
    ALIGNED_BUFFER_TYPE_LOCAL_TYPE_STACK,

    _ALIGNED_BUFFER_TYPE_SIZE
} aligned_buffer_type_t;
const char* aligned_buffer_type__to_str(aligned_buffer_type_t type);
debug_buffer_type_t aligned_buffer_type__to_debug_buffer_type(aligned_buffer_type_t type);

# define ALIGNED_BUFFER_PUSH_WRAPPER(state_p, buffer_type, size, alignment) do { \
    ASSERT(buffer_type < _ALIGNED_BUFFER_TYPE_SIZE); \
    debug__push_ptr(&debug, aligned_buffer_type__to_debug_buffer_type(buffer_type), state_p->aligned_buffer[buffer_type].buffer.cur); \
    debug__push_hex(&debug, aligned_buffer_type__to_debug_buffer_type(buffer_type), (uint8_t*)(&(size)), sizeof(uint32_t)); \
    debug__push_hex(&debug, aligned_buffer_type__to_debug_buffer_type(buffer_type), (uint8_t*)(&(alignment)), sizeof(uint32_t)); \
    ALIGNED_BUFFER_PUSH(state_p->aligned_buffer[buffer_type], size, alignment); \
} while (false)
# define ALIGNED_BUFFER_POP_WRAPPER(state_p, buffer_type, n) do { \
    ASSERT(buffer_type < _ALIGNED_BUFFER_TYPE_SIZE); \
    debug__push_hex( \
        &debug, \
        aligned_buffer_type__to_debug_buffer_type(buffer_type), \
        *(state_p->aligned_buffer[buffer_type].addr_cur - 1), \
        state_p->aligned_buffer[buffer_type].buffer.cur - *(state_p->aligned_buffer[buffer_type].addr_cur - 1) \
    ); \
    ALIGNED_BUFFER_POP(state_p->aligned_buffer[buffer_type], n); \
} while (false)
# define ALIGNED_BUFFER_ADDR_AT_WRAPPER(state_p, buffer_type, index, result_addr) do { \
    ASSERT(buffer_type < _ALIGNED_BUFFER_TYPE_SIZE); \
    ALIGNED_BUFFER_ADDR_AT(state_p->aligned_buffer[buffer_type], index, result_addr); \
} while (false);

typedef struct state {
    buffer_t buffer[_BUFFER_TYPE_SIZE];
    aligned_buffer_t aligned_buffer[_ALIGNED_BUFFER_TYPE_SIZE];

    reg_t exit_status_code;
    
    shared_lib_t shared_libs;

    bool     alive;
} state_t;

bool state__create(state_t* self);
void state__destroy(state_t* self);

void state__init(state_t* self, uint8_t* ip);

void state__run(state_t* self);

#endif // STATE_H
