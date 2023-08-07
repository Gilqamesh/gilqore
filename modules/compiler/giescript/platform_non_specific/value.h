#ifndef GIES_VALUE_H
# define GIES_VALUE_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

struct value_arr {
    u32       values_fill;
    u32       values_size;
    value_t*  values;
};

void value_arr__create(value_arr_t* self, memory_t* memory);
void value_arr__destroy(value_arr_t* self, memory_t* memory);

// @returns index of pushed value
u32  value_arr__push(value_arr_t* self, memory_t* memory, value_t value);
void value__print(value_t value);

#endif // GIES_VALUE_H
