#ifndef STATE_H
# define STATE_H

# include <stdint.h>

# include "ins.h"
# include "types.h"
# include "hash_map.h"

typedef struct state {
    uint8_t* ip;
    uint8_t* code;
    uint32_t code_size;

    uint8_t* stack_top;
    uint8_t* stack;
    uint8_t* stack_end;
    uint8_t* base_pointer;

    // for push/pop aligned instructions, this metadata is stored, as otherwise
    // the extra space pushed for aligning is undeterminable during pop
    uint8_t** stack_aligned;
    uint32_t  stack_aligned_top;
    uint32_t  stack_aligned_size;

    reg_t exit_status_code;

    hash_map_t* types;

    bool     alive;
} state_t;

// STATE_H
