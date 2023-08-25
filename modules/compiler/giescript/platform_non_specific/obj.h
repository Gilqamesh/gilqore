#ifndef GIES_OBJ_H
# define GIES_OBJ_H

# include "common.h"

# include "value.h"
# include "chunk.h"

typedef enum {
    OBJ_STRING,
    OBJ_DECL,
    OBJ_FUNCTION,
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

struct obj_decl {
    obj_t base;
    
    s32   index;
    u32   scope_depth;
    bool  is_const;
    // declaring and defining is a two step process for variables, to avoid cases such as: var a = 2; { var a = a; }
    bool  is_defined;
};
bool    obj__is_decl(value_t value);
value_t obj__alloc_decl(vm_t* vm, s32 index, s32 scope_depth, bool is_const, bool is_defined);
obj_decl_t* obj__as_decl(value_t value);
obj_decl_t  obj__decl(s32 index, s32 scope_depth, bool is_const, bool is_defined);

struct obj_fun {
    obj_t       base;

    u32         arity;
    obj_str_t*  name;
    chunk_t     chunk;
};
bool       obj__is_fun(value_t value);
obj_fun_t* obj__as_fun(value_t value);
obj_fun_t* obj__alloc_fun(vm_t* vm, u32 arity, obj_str_t* name);

#endif // GIES_OBJ_H
