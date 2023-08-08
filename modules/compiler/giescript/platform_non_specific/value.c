#include "value.h"
#include "allocator.h"

#include "libc/libc.h"

static void value_arr__init(value_arr_t* self) {
    self->values_fill = 0;
    self->values_size = 0;
    self->values = 0;
}

void value_arr__create(value_arr_t* self, allocator_t* allocator) {
    value_arr__init(self);
    (void) allocator;
}

void value_arr__destroy(value_arr_t* self, allocator_t* allocator) {
    FREE_ARRAY(allocator, value_t, self->values, self->values_size);
    
    value_arr__init(self);
}

u32 value_arr__push(value_arr_t* self, allocator_t* allocator, value_t value) {
    if (self->values_fill == self->values_size) {
        u32 new_size = GROW_CAPACITY(self->values_size);
        GROW_ARRAY(self->values, allocator, value_t, self->values, self->values_size, new_size);
        self->values_size = new_size;
    }
    u32 index = self->values_fill;
    self->values[self->values_fill++] = value;

    return index;
}

void value__print(value_t value) {
    libc__printf("%g", value);
}
