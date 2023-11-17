#ifndef TYPES_H
# define TYPES_H

# include <stdio.h>

# include "ins.h"
# include "hash_map.h"

#if defined(min)
# undef min
#endif
#define min(x, y) ((x) < (y) ? (x) : (y))

#if defined(max)
# undef max
#endif
#define max(x, y) ((x) < (y) ? (y) : (x))

typedef enum type_specifier {
    TYPE_ATOM,
    TYPE_STRUCT,
    TYPE_UNION,
    TYPE_ARRAY,
    TYPE_POINTER,
    TYPE_ENUM,
    TYPE_FUNCTION_INTERNAL,
    TYPE_FUNCTION_EXTERNAL,
    TYPE_FUNCTION_BUILTIN
} type_specifier_t;

typedef struct type {
    type_specifier_t    type_specifier;

    const char*         abbreviated_name;

    uint64_t            alignment;
    uint64_t            max_alignment;
    uint64_t            size;
} type_t;

typedef struct type_atom {
    type_t      base;

    void        (*print_value_at_addr)(FILE* fp, uint8_t* addr);
    const char* name;
} type_atom_t;

typedef struct member {
    const char*  name;
    type_t*      type;
    uint64_t     offset;
} member_t;

typedef struct type_struct {
    type_t       base;

    member_t*    members;
    uint32_t     members_size;
    uint32_t     members_top;
} type_struct_t;

typedef struct type_union {
    type_t       base;

    member_t*    biggest_aligned_member;
    member_t*    biggest_sized_member;

    member_t*    members;
    uint32_t     members_size;
    uint32_t     members_top;
} type_union_t;

typedef struct type_pointer {
    type_t  base;

    type_t* pointed_type;
} type_pointer_t;

typedef struct type_array {
    type_t   base;

    type_t*  element_type;
    uint64_t element_size;
} type_array_t;

typedef struct enum_value {
    const char* name;
    int32_t     value;
} enum_value_t;

typedef struct type_enum {
    type_t          base;

    enum_value_t*   values;
    uint32_t        values_size;
    uint32_t        values_top;
} type_enum_t;

typedef struct function_argument {
    const char* name;
    type_t*     type;
} function_argument_t;

typedef struct function_local {
    const char* name;
    type_t*     type;
} function_local_t;

typedef struct type_internal_function {
    type_t                  base;

    const char*             name;
    void                    (*compile_fn)(hash_map_t* types, struct type_internal_function* type_function);

    uint8_t*                start_ip;
    uint8_t*                end_ip;
    type_t*                 return_type;

    function_argument_t*    arguments;
    uint32_t                arguments_top;
    uint32_t                arguments_size;

    function_local_t*       locals;
    uint32_t                locals_top;
    uint32_t                locals_size;
} type_internal_function_t;

typedef struct type_external_function {
    type_t                  base;

    void*                   loaded_addr;
    const char*             name;

    type_t*                 return_type;

    function_argument_t*    arguments;
    uint32_t                arguments_top;
    uint32_t                arguments_size;
} type_external_function_t;

typedef struct type_builtin_function {
    type_t                  base;

    const char*             name;
    void                    (*execute_fn)(struct type_builtin_function* self, void* processor);

    uint32_t                arguments_size;
    uint32_t                arguments_top;
    int64_t*                arguments_offsets;
    int64_t                 return_offset;
} type_builtin_function_t;

void member__print(member_t* self, FILE* fp);
const char* member__name(member_t* self);

type_atom_t* type_atom__create(
    const char* abbreviated_name, const char* name, uint64_t size,
    void (*print_value_at_addr)(FILE* fp, uint8_t* addr)
);
type_struct_t* type_struct__create(const char* abbreviated_name);
void type_struct__add(type_struct_t* self, type_t* member_type, const char* member_name);
member_t* type_struct__member(type_struct_t* self, const char* name);
type_union_t* type_union__create(const char* abbreviated_name);
void type_union__add(type_union_t* self, type_t* member_type, const char* member_name);
member_t* type_union__member(type_union_t* self, const char* name);
type_array_t* type_array__create(const char* abbreviated_name, type_t* member, uint64_t n);
type_pointer_t* type_pointer__create(const char* abbreviated_name, type_t* pointed_type); // if pointed type is null, it'll be a void*
type_enum_t* type_enum__create(const char* abbreviated_name);
void type_enum__add(type_enum_t* self, const char* name);
void type_enum__add_with_value(type_enum_t* self, const char* name, int32_t value);

type_internal_function_t* type_internal_function__create(const char* abbreviated_name, void (*compile_fn)(hash_map_t* types, type_internal_function_t* type_function));
uint8_t* type_internal_function__set_ip(type_internal_function_t* self, uint8_t* ip);
uint8_t* type_internal_function__ip(type_internal_function_t* self);
uint8_t* type_internal_function__end_ip(type_internal_function_t* self);
void type_internal_function__add_argument(type_internal_function_t* self, const char* name, type_t* type);
void type_internal_function__add_local(type_internal_function_t* self, const char* name, type_t* type);
void type_internal_function__set_return(type_internal_function_t* self, type_t* type);
void type_internal_function__add_ins(type_internal_function_t* self, ins_t ins, ...);
void type_internal_function__store_argument(type_internal_function_t* self, const char* argument_name, ...);
void type_internal_function__load_argument(type_internal_function_t* self, const char* argument_name, ...);
void type_internal_function__store_return(type_internal_function_t* self, ...);
void type_internal_function__load_return(type_internal_function_t* self, ...);
void type_internal_function__store_local(type_internal_function_t* self, const char* local_name, ...);
void type_internal_function__load_local(type_internal_function_t* self, const char* local_name, ...);

type_external_function_t* type_external_function__create(const char* name);
void type_external_function__add_argument(type_external_function_t* self, const char* name, type_t* type);
void type_external_function__set_return(type_external_function_t* self, type_t* type);
void type_external_function__call(type_external_function_t* self);

type_builtin_function_t* type_builtin_function__create(const char* name, void (*execute_fn)(type_builtin_function_t* self, void* processor));
void type_builtin_function__add_argument(type_builtin_function_t* self, const char* name, type_t* type);
void type_builtin_function__set_return(type_builtin_function_t* self, type_t* type);
void type_builtin_function__call(type_builtin_function_t* self, void* processor);
int64_t type_builtin__return_offset_from_bp(type_builtin_function_t* self);
int64_t type_builtin__argument_offset_from_bp(type_builtin_function_t* self, uint32_t argument_index);

void type__set_alignment(type_t* self, uint64_t alignment);
uint64_t type__alignment(type_t* self);
void type__set_max_alignment(type_t* self, uint64_t max_alignment);
uint64_t type__max_alignment(type_t* self);
uint64_t type__size(type_t* self);
const char* type__abbreviated_name(type_t* self);
uint8_t* type__address(type_t* self, uint8_t* requested_address);

void type__print(
    type_t* self, FILE* fp,
    uint32_t n_of_name_expansions,
    uint32_t n_of_value_expansions,
    uint8_t* address
);
member_t* type__member(type_t* type, const char* member_name);

#endif // TYPES_H
