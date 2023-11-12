#ifndef TYPES_H
# define TYPES_H

enum type_specifier {
    TYPE_ATOM,
    TYPE_STRUCT,
    TYPE_UNION,
    TYPE_ARRAY,
    TYPE_POINTER
};

typedef struct type {
    enum type_specifier type_specifier;

    const char* abbreviated_name;

    uint64_t    alignment;
    uint64_t    max_alignment;
    uint64_t    size;

    uint64_t    hash;
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
type_pointer_t* type_pointer__create(const char* abbreviated_name, type_t* pointed_type);

void type__set_alignment(type_t* self, uint64_t alignment);
uint64_t type__alignment(type_t* self);
void type__set_max_alignment(type_t* self, uint64_t max_alignment);
uint64_t type__max_alignment(type_t* self);
uint64_t type__size(type_t* self);
const char* type__abbreviated_name(type_t* self);
uint8_t* type__addr(type_t* self, uint8_t* requested_address);

void type__print(
    type_t* self, FILE* fp,
    uint32_t n_of_name_expansions,
    uint32_t n_of_value_expansions,
    uint8_t* address
);
member_t* type__member(type_t* type, const char* member_name);
uint64_t type__hash(type_t* self);

#endif // TYPES_H
