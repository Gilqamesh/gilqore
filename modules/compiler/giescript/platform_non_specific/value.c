#include "value.h"
#include "allocator.h"
#include "obj.h"

#include "libc/libc.h"

static void value_arr__init(value_arr_t* self);

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
    if (self->values) {
        allocator__free(allocator, self->values);
    }
    
    value_arr__init(self);
}

u32 value_arr__push(value_arr_t* self, allocator_t* allocator, value_t value) {
    if (self->values_fill == self->values_size) {
        u32 new_size = self->values_size < 8 ? 8 : self->values_size * 2;
        self->values = allocator__realloc(
            allocator, self->values,
            self->values_size * sizeof(*self->values),
            new_size * sizeof(*self->values)
        );
        self->values_size = new_size;
    }
    u32 index = self->values_fill;
    self->values[self->values_fill++] = value;

    return index;
}

void value__print(value_t value) {
    switch (value.type) {
        case VALUE_TYPE_BOOL: {
            libc__printf("%s", value__as_bool(value) ? "true" : "false");
        } break ;
        case VALUE_TYPE_NIL: {
            libc__printf("(nil)");
        } break ;
        case VALUE_TYPE_NUMBER: {
            libc__printf("%g", value__as_num(value));
        } break ;
        case VALUE_TYPE_OBJ: {
            obj__print(value);
        } break ;
        default: ASSERT(false);
    }
}

value_t value__num(r64 value) {
    return (value_t) { .type = VALUE_TYPE_NUMBER, .as.number = value };
}

value_t value__bool(bool value) {
    return (value_t) { .type = VALUE_TYPE_BOOL, .as.boolean = value };
}

value_t value__obj(obj_t* obj) {
    return (value_t) { .type = VALUE_TYPE_OBJ, .as.obj = obj };
}

value_t value__nil() {
    return (value_t) { .type = VALUE_TYPE_NIL, .as.number = 0 };
}

value_t value__empty() {
    return (value_t) { .type = VALUE_TYPE_EMPTY, .as.number = 0 };
}

value_t value__undefined() {
    return (value_t) { .type = VALUE_TYPE_UNDEFINED, .as.number = 0 };
}

bool value__is_num(value_t value) {
    return value.type == VALUE_TYPE_NUMBER;
}

bool value__is_bool(value_t value) {
    return value.type == VALUE_TYPE_BOOL;
}

bool value__is_nil(value_t value) {
    return value.type == VALUE_TYPE_NIL;
}

bool value__is_obj(value_t value) {
    return value.type == VALUE_TYPE_OBJ;
}

bool value__is_empty(value_t value) {
    return value.type == VALUE_TYPE_EMPTY;
}

bool value__is_undefined(value_t value) {
    return value.type == VALUE_TYPE_UNDEFINED;
}

r64 value__as_num(value_t value) {
    return value.as.number;
}

bool value__as_bool(value_t value) {
    return value.as.boolean;
}

obj_t* value__as_obj(value_t value) {
    return value.as.obj;
}

bool value__is_falsey(value_t value) {
    return value__is_nil(value) ||
    (value__is_bool(value) && !value__as_bool(value)) ||
    (value__is_num(value) && value__as_num(value) == 0);
}

bool value__is_eq(value_t left, value_t right) {
    if (left.type != right.type) {
        return false;
    }

    switch (left.type) {
        case VALUE_TYPE_BOOL: {
            return value__as_bool(left) == value__as_bool(right);
        } break ;
        case VALUE_TYPE_NIL: {
            return true;
        } break ;
        case VALUE_TYPE_NUMBER: {
            return value__as_num(left) == value__as_num(right);
        } break ;
        case VALUE_TYPE_OBJ: {
            return obj__is_eq(left, right);
        } break ;
        default: ASSERT(false);
    }

    UNREACHABLE_CODE;
}

static inline u32 value__hash_number(value_t value) {
    ASSERT(value__is_num(value));

    union {
        r64 a;
        s32 b[2];
    } a;

    a.a = value__as_num(value) + 1.0;
    return a.b[0] + a.b[1];
}

u32 value__hash(value_t value) {
    switch (value.type) {
        case VALUE_TYPE_EMPTY: {
            return 0;
        } break ;
        case VALUE_TYPE_BOOL: {
            return value__as_bool(value) ? 5 : 3;
        } break ;
        case VALUE_TYPE_NIL: {
            return 7;
        } break ;
        case VALUE_TYPE_NUMBER: {
            return value__hash_number(value);
        } break ;
        case VALUE_TYPE_OBJ: {
            return obj__hash(value);
        } break ;
        default: ASSERT(false);
    }

    ASSERT(false);
    UNREACHABLE_CODE;
}
