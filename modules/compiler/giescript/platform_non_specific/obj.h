#ifndef GIES_OBJ_H
# define GIES_OBJ_H

# include "common.h"

# include "value.h"

typedef enum {
    OBJ_STRING,
    OBJ_VAR_INFO,
} obj_type;

struct obj {
    obj_type type;
    obj_t*   next_free;
};

void obj__print(value_t value);
bool obj__is_eq(value_t left, value_t right);
void obj__free(vm_t* vm, obj_t* obj);
u32  obj__hash(value_t value);

struct obj_str {
    obj_t  base;

    u32    len;
    u32    hash;
    char   str[];
};
bool       obj__is_str(value_t value);
obj_str_t* obj__as_str(value_t value);
char*      obj__as_cstr(value_t value);

value_t obj__copy_str(vm_t* vm, const char* bytes, u32 len);
value_t obj__cat_str(vm_t* vm, value_t left, value_t right);

struct obj_var_info {
    obj_t base;
    
    // local:  indexes into locals
    // global: indexes into chunk's values
    s32   var_index;
    bool  is_const;
};
bool    obj__is_var_info(value_t value);
value_t obj__get_var_info(vm_t* vm, s32 var_index, bool is_const);

obj_var_info_t* obj__as_var_info(value_t value);
obj_var_info_t  obj__var_info(s32 var_index, bool is_const);

#endif // GIES_OBJ_H
