#ifndef TYPES_H
# define TYPES_H

# include <stdio.h>
# include <ffi.h>

# include "ins.h"
# include "hash_map.h"
# include "shared_lib.h"

#if defined(min)
# undef min
#endif
#define min(x, y) ((x) < (y) ? (x) : (y))

#if defined(max)
# undef max
#endif
#define max(x, y) ((x) < (y) ? (y) : (x))

typedef int8_t   ss8_t;
typedef int16_t  ss16_t;
typedef int32_t  ss32_t;
typedef int64_t  ss64_t;
typedef uint8_t  su8_t;
typedef uint16_t su16_t;
typedef uint32_t su32_t;
typedef uint64_t su64_t;
typedef float    sr32_t;
typedef double   sr64_t;

# define SYMBOL_ATOM_S8   "s8"
# define SYMBOL_ATOM_S16  "s16"
# define SYMBOL_ATOM_S32  "s32"
# define SYMBOL_ATOM_S64  "s64"
# define SYMBOL_ATOM_U8   "u8"
# define SYMBOL_ATOM_U16  "u16"
# define SYMBOL_ATOM_U32  "u32"
# define SYMBOL_ATOM_U64  "u64"
# define SYMBOL_ATOM_R32  "r32"
# define SYMBOL_ATOM_R64  "r64"
# define SYMBOL_ATOM_VOID "void"

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

    ffi_type*           ffi;

    const char*         abbreviated_name;

    uint64_t            alignment;
    uint64_t            max_alignment;
    uint64_t            size;
} type_t;

extern type_t* t_s8;
extern type_t* t_s16;
extern type_t* t_s32;
extern type_t* t_s64;
extern type_t* t_u8;
extern type_t* t_u16;
extern type_t* t_u32;
extern type_t* t_u64;
extern type_t* t_r32;
extern type_t* t_r64;
extern type_t* t_void;
extern type_t* t_reg;
extern type_t* t_regf;

typedef struct types {
    hash_map_t types;
} types_t;

bool type__is_unsigned(type_t* type);
bool type__is_signed(type_t* type);
bool type__is_integral(type_t* type);
bool type__is_floating(type_t* type);

bool types__create(types_t* self);
void types__destroy(types_t* self);

void types__type_add(types_t* self, type_t* type);
type_t* types__type_find(types_t* self, const char* abbreviated_name);

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

typedef struct type_function {
    type_t                      base;

    const char*                 name;

    function_argument_t*        arguments;
    uint32_t                    arguments_top;
    uint32_t                    arguments_size;
    type_t*                     return_type;

    void                        (*compile_fn)(struct type_function* self, types_t* types);
} type_function_t;

bool type__is_function(type_t* type);
bool type__is_aggregate_type(type_t* type);
void type_function__create(type_function_t* self, type_specifier_t type_specifier, const char* name);
type_specifier_t type_function__type(type_function_t* self);
void type_function__add_argument(type_function_t* self, const char* name, type_t* type);
type_t* type_function__get_argument(type_function_t* self, const char* name, uint32_t* result_arg_index);
void type_function__set_return(type_function_t* self, type_t* type);

typedef struct type_internal_function {
    type_function_t         function_base;
 
    // uint8_t*                data_segment;
    uint8_t*                ip_start;
    uint8_t*                ip_cur; // for compilation
    uint8_t*                ip_end;
} type_internal_function_t;

typedef struct type_external_function {
    type_function_t         function_base;

    bool                    is_compiled;
    bool                    is_variadic;

    void                    *fn;

    ffi_cif                 cif; // call interface
    ffi_type**              ffi_arguments;
    uint32_t                ffi_arguments_top;
    uint32_t                ffi_arguments_size;
} type_external_function_t;

typedef struct type_builtin_function {
    type_function_t         function_base;

    void                    (*execute_fn)(struct type_builtin_function* self, void* processor);
} type_builtin_function_t;

// todo(david): figure out and specify if this includes variadic arguments
#define MAX_ARGS 256

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

type_internal_function_t* type_internal_function__create(const char* abbreviated_name);
uint8_t* type_internal_function__start_ip(type_internal_function_t* self);
uint8_t* type_internal_function__cur_ip(type_internal_function_t* self);
void type_internal_function__add_ins(type_internal_function_t* self, ins_t ins, ...);
void type_internal_function__vadd_ins(type_internal_function_t* self, ins_t ins, va_list ap);

type_external_function_t* type_external_function__create(const char* symbol, const char* shared_lib, shared_lib_t* shared_libs, bool is_variadic);
void type_external_function__add_argument(type_external_function_t* self, const char* name, type_t* type, types_t* types);
void type_external_function__compile(type_external_function_t* self);
void type_external_function__call(type_external_function_t* self, void* processor);

type_builtin_function_t* type_builtin_function__create(const char* name, void (*execute_fn)(type_builtin_function_t* self, void* processor));
void type_builtin_function__call(type_builtin_function_t* self, void* processor);

void type__set_alignment(type_t* self, uint64_t alignment);
uint64_t type__alignment(type_t* self);
void type__set_max_alignment(type_t* self, uint64_t max_alignment);
uint64_t type__max_alignment(type_t* self);
uint64_t type__size(type_t* self);
const char* type__abbreviated_name(type_t* self);
uint8_t* type__address(type_t* self, uint8_t* requested_address);
// @param ap:
//   - sequential member names
//   - array type must be followed by an uint64_t element index
// @param self contains the result member
// @return searched member offset from 'self'
uint64_t type__member_offsetv(type_t** self, va_list ap);

void type__print(
    type_t* self, FILE* fp,
    uint32_t n_of_name_expansions,
    uint32_t n_of_value_expansions,
    uint8_t* address
);
member_t* type__member(type_t* type, const char* member_name);

#endif // TYPES_H
