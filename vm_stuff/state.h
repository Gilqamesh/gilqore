#ifndef STATE_H
# define STATE_H

# include <stdint.h>

# include "ins.h"
# include "types.h"
# include "hash_map.h"
# include "shared_lib.h"

typedef enum address_register_type {
    REG_SP,
    REG_BP,
    REG_ADDR1,

    _ADDRESS_REGISTER_TYPE_SIZE
} address_register_type_t;

const char* address_register_type__to_str(address_register_type_t reg);

typedef struct state {
    uint8_t* ip;
    uint8_t* code;
    uint32_t code_size;

    uint8_t* stack;
    uint8_t* stack_end;

    uint8_t* address_registers[_ADDRESS_REGISTER_TYPE_SIZE];

    // for push/pop aligned instructions, this metadata is stored, as otherwise
    // the extra space pushed for aligning is undeterminable during pop
    uint8_t** stack_aligned;
    uint32_t  stack_aligned_top;
    uint32_t  stack_aligned_size;

    reg_t exit_status_code;

    hash_map_t types;

    shared_lib_t shared_libs;

    bool     alive;
} state_t;

bool state__create(state_t* self);
void state__destroy(state_t* self);

#endif // STATE_H
