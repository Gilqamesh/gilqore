#ifndef GIES_VALUE_H
# define GIES_VALUE_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

typedef enum {
    VALUE_TYPE_BOOL,
    VALUE_TYPE_NIL,
    VALUE_TYPE_NUMBER,
    VALUE_TYPE_OBJ,

    VALUE_TYPE_UNDEFINED, // used internally for keeping track of defined global identifiers
    VALUE_TYPE_EMPTY, // used internally for hashing
} value_type;

struct value {
    value_type type;
    union {
        bool    boolean;
        r64     number;
        obj_t*  obj;
    } as;
};

struct value_arr {
    u32       values_fill;
    u32       values_size;
    value_t*  values;
};

void value_arr__create(value_arr_t* self, allocator_t* allocator);
void value_arr__destroy(value_arr_t* self, allocator_t* allocator);

// @returns index of pushed value
u32  value_arr__push(value_arr_t* self, allocator_t* allocator, value_t value);
void value__print(value_t value);

value_t value__num(r64 value);
value_t value__bool(bool value);
value_t value__nil();
value_t value__obj(obj_t* obj);
value_t value__empty();
value_t value__undefined();

bool value__is_num(value_t value);
bool value__is_bool(value_t value);
bool value__is_nil(value_t value);
bool value__is_obj(value_t value);
bool value__is_empty(value_t value);
bool value__is_undefined(value_t value);

r64    value__as_num(value_t value);
bool   value__as_bool(value_t value);
obj_t* value__as_obj(value_t value);

bool value__is_falsey(value_t value);
bool value__is_eq(value_t left, value_t right);
u32  value__hash(value_t value);

#endif // GIES_VALUE_H
