#ifndef STATE_H
# define STATE_H

# include <stdint.h>
# include <stdbool.h>

# include "shared_lib.h"
# include "buffer.h"
# include "compiler.h"
# include "debug.h"

# define BUFFER_TOP_WRAPPER(buffer, type, offset, result) do { \
    BUFFER_TOP(buffer, type, offset, result); \
} while (false)
# define BUFFER_PUSH_WRAPPER(buffer, type, a) do { \
    BUFFER_PUSH(buffer, type, a); \
} while (false)
# define BUFFER_POP_WRAPPER(buffer, type, result) do { \
    BUFFER_POP(buffer, type, result); \
} while (false)
# define BUFFER_GROW_WRAPPER(buffer, n) do { \
    BUFFER_GROW(buffer, n); \
} while (false)

# define ALIGNED_BUFFER_PUSH_WRAPPER(state_p, size, alignment) do { \
    ALIGNED_BUFFER_PUSH((state_p)->stack, (size), (alignment)); \
} while (false)
# define ALIGNED_BUFFER_POP_WRAPPER(state_p, n) do { \
    ALIGNED_BUFFER_POP((state_p)->stack, (n)); \
} while (false)
# define ALIGNED_BUFFER_ADDR_AT_WRAPPER(state_p, index, type_of_addr, result_addr) do { \
    ALIGNED_BUFFER_ADDR_AT((state_p)->stack, (index), type_of_addr, (result_addr)); \
} while (false);

typedef struct stack_frame {
    type_internal_function_t*   fn;
    uint8_t*                    reg_aligned_bp; // points to first local on the stack
    uint32_t                    offset_for_alignment;
    uint8_t*                    ip;
} stack_frame_t;

typedef struct state {
    buffer_t            stack;

    stack_frame_t*      stack_frame_start;
    stack_frame_t*      stack_frame_cur;
    stack_frame_t*      stack_frame_end;
    
    shared_lib_t shared_libs;

    bool     alive;
} state_t;

bool state__create(state_t* self);
void state__destroy(state_t* self);

void state__run(state_t* self, type_internal_function_t* entry_fn);

#endif // STATE_H
