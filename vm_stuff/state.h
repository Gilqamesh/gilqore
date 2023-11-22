#ifndef STATE_H
# define STATE_H

# include <stdint.h>

# include "ins.h"
# include "types.h"
# include "hash_map.h"
# include "shared_lib.h"

typedef enum address_register_type {
    REG_IP,
    REG_REG_BP,
    REG_REG_SP,
    REG_RET_IP_SP,
    REG_ARG_TYPES_SP,
    REG_RET_VAL_TYPES_SP,
    REG_LOCAL_TYPES_SP,

    _ADDRESS_REGISTER_TYPE_SIZE
} address_register_type_t;

const char* address_register_type__to_str(address_register_type_t reg);

typedef struct state {
    uint8_t* code_start;
    uint8_t* code_end;

    // for ALU operations, and memory access
    uint8_t* register_stack_start;
    uint8_t* register_stack_end;

    uint8_t* return_ip_stack_start;
    uint8_t* return_ip_stack_end;

    // the offset stack is to determine the alignment during pop_type
    uint8_t*  argument_types_stack_start;
    uint8_t*  argument_types_stack_end;
    uint32_t* argument_types_offset_stack_cur;
    uint32_t* argument_types_offset_stack_start;
    uint32_t* argument_types_offset_stack_end;

    uint8_t*  return_value_types_stack_start;
    uint8_t*  return_value_types_stack_end;
    uint32_t* return_value_offset_stack_cur;
    uint32_t* return_value_offset_stack_start;
    uint32_t* return_value_offset_stack_end;

    uint8_t*  local_types_stack_start;
    uint8_t*  local_types_stack_end;
    uint32_t* local_types_offset_stack_cur;
    uint32_t* local_types_offset_stack_start;
    uint32_t* local_types_offset_stack_end;

    uint8_t* address_registers[_ADDRESS_REGISTER_TYPE_SIZE];

    reg_t exit_status_code;

    types_t types;

    shared_lib_t shared_libs;

    bool     alive;
} state_t;

bool state__create(state_t* self);
void state__destroy(state_t* self);

#endif // STATE_H
