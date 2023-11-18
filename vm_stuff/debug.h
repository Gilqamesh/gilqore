#ifndef DEBUG_H
# define DEBUG_H

# include <stdio.h>
# include <stdint.h>
# include <assert.h>
# include <stdbool.h>

# include "types.h"
# include "state.h"

#define ASSERT(cond) do { \
    if (!(cond)) { \
        debug__destroy(&debug); \
        assert(cond); \
    } \
} while (false)

typedef struct debug {
    uint8_t*    ip;

    uint32_t    byte_code_top;
    char        byte_code[128];

    uint32_t    instruction_operand_top;
    char        instruction_operand[128];

    const char* fn;

    state_t*    state;

    FILE*       compiled_code_file;
    FILE*       runtime_code_file;
    FILE*       runtime_stack_file;
    FILE*       crash_dump_file;
} debug_t;

extern debug_t debug;

void debug__create(debug_t* self, state_t* state);
void debug__destroy(debug_t* self);

void debug__set_ip(debug_t* self, uint8_t* ip);
void debug__set_fn(debug_t* self, const char* fn);
void debug__push_code(debug_t* self, uint8_t* bytes, uint32_t bytes_size);
void debug__push_ins_arg(debug_t* self, const char* str);
void debug__dump_line(debug_t* self, FILE* fp);

#endif // DEBUG_H
