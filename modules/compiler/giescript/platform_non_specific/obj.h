#ifndef GIES_OBJ_H
# define GIES_OBJ_H

# include "types.h"

# include "value.h"

typedef enum {
    OBJ_STRING,
} obj_type;

struct obj {
    obj_type type;
    obj_t*   next_free;
};

void obj__print(value_t value);
bool obj__is_eq(value_t left, value_t right);
void obj__free(allocator_t* allocator, obj_t* obj);

struct obj_str {
    obj_t  obj;
    u32    len;
    u32    hash;
    char   str[];
};
bool        obj__is_str(value_t value);
obj_str_t*  obj__as_str(value_t value);
char*       obj__as_cstr(value_t value);

obj_str_t*  obj__copy_str(vm_t* vm, allocator_t* allocator, const char* bytes, u32 len);
obj_str_t*  obj__cat_str(vm_t* vm, allocator_t* allocator, value_t left, value_t right);

u32 obj__hash(value_t value, u32 prev_hash);

#endif // GIES_OBJ_H
