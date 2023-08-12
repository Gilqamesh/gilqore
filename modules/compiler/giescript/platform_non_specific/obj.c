#include "obj.h"
#include "allocator.h"
#include "vm.h"

#include "libc/libc.h"
#include "algorithms/hash/hash.h"

static bool obj__is_type(value_t value, obj_type type);
static obj_type obj__type(value_t value);
static obj_t* obj__allocate(vm_t* vm, allocator_t* allocator, size_t size, obj_type type);

static bool obj__is_type(value_t value, obj_type type) {
    return value__is_obj(value) && obj__type(value) == type;
}

static obj_type obj__type(value_t value) {
    ASSERT(value__is_obj(value));

    return value__as_obj(value)->type;
}

static obj_t* obj__allocate(vm_t* vm, allocator_t* allocator, size_t size, obj_type type) {
    obj_t* obj = (obj_t*) allocator__alloc(allocator, size);
    obj->type = type;
    obj->next_free = vm->objs;
    vm->objs = obj;

    return obj;
}

void obj__print(value_t value) {
    ASSERT(value__is_obj(value));

    obj_t* obj = value__as_obj(value);
    switch (obj->type) {
        case OBJ_STRING: {
            libc__printf("%s", obj__as_cstr(value));
        } break ;
    }
}

bool obj__is_eq(value_t left, value_t right) {
    ASSERT(value__is_obj(left) && value__is_obj(right));

    obj_t* obj_left = value__as_obj(left);
    switch (obj_left->type) {
        case OBJ_STRING: {
            obj_str_t* obj_str_left = obj__as_str(left);
            obj_str_t* obj_str_right = obj__as_str(right);
            // using the fact that we are only storing unique strings, every obj_str will have unique addr
            return obj_str_left == obj_str_right;
        } break ;
        default: ASSERT(false);
    }

    UNREACHABLE_CODE;
}

void obj__free(allocator_t* allocator, obj_t* obj) {
    switch (obj->type) {
        case OBJ_STRING: {
            allocator__free(allocator, obj);
        } break ;
        default: ASSERT(false);
    }
}

bool obj__is_str(value_t value) {
    return obj__is_type(value, OBJ_STRING);
}

obj_str_t* obj__as_str(value_t value) {
    return (obj_str_t*) value__as_obj(value);
}

char* obj__as_cstr(value_t value) {
    ASSERT(obj__is_str(value));

    obj_str_t* obj_str = obj__as_str(value);
    return obj_str->str;
}

obj_str_t* obj__copy_str(vm_t* vm, allocator_t* allocator, const char* bytes, u32 len) {
    u32 hash = hash__fnv_1a(bytes, len, 0);
    // if we already have this str in the interned table, do not create a new one, this way every str address is unique and can be compared
    obj_str_t* obj_str = table__find_str(&vm->obj_str_table, bytes, len, hash);
    if (obj_str) {
        return obj_str;
    }

    obj_str = (obj_str_t*) obj__allocate(vm, allocator, sizeof(*obj_str) + len + 1, OBJ_STRING);
    obj_str->len = len;
    libc__memcpy(obj_str->str, bytes, len);
    obj_str->str[len] = '\0';
    obj_str->hash = hash;

    table__insert(&vm->obj_str_table, value__obj((obj_t*) obj_str), value__nil());

    return obj_str;
}

obj_str_t* obj__cat_str(vm_t* vm, allocator_t* allocator, value_t left, value_t right) {
    ASSERT(obj__is_str(left) && obj__is_str(right));

    obj_str_t* obj_str = table__find_concat_str(&vm->obj_str_table, left, right);
    if (obj_str) {
        return obj_str;
    }

    obj_str_t* obj_str_left = obj__as_str(left);
    obj_str_t* obj_str_right = obj__as_str(right);

    if (!obj_str_left->len) {
        return obj_str_right;
    } else if (!obj_str_right->len) {
        return obj_str_left;
    }

    u32 len = obj_str_left->len + obj_str_right->len;

    obj_str = (obj_str_t*) obj__allocate(vm, allocator, sizeof(*obj_str) + len + 1, OBJ_STRING);
    libc__memcpy(obj_str->str, obj_str_left->str, obj_str_left->len);
    libc__memcpy(obj_str->str + obj_str_left->len, obj_str_right->str, obj_str_right->len);
    obj_str->str[len] = '\0';
    obj_str->len = len;
    obj_str->hash = obj__hash(value__obj((obj_t*) obj_str), 0);

    table__insert(&vm->obj_str_table, value__obj((obj_t*) obj_str), value__nil());

    return obj_str;
}

u32 obj__hash(value_t value, u32 prev_hash) {
    ASSERT(value__is_obj(value));

    obj_t* obj = value__as_obj(value);
    switch (obj->type) {
        case OBJ_STRING: {
            obj_str_t* obj_str = obj__as_str(value);
            return hash__fnv_1a(obj_str->str, obj_str->len, prev_hash);
        } break ;
        default: ASSERT(false);
    }

    ASSERT(false);
    UNREACHABLE_CODE;
}
