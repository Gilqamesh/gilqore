#include <time.h>
#include <stdlib.h>
#include <assert.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#include "types.h"

// 8  for x86, ARM, and ARM64
// 16 for x64 native and ARM64EC
#define DEFAULT_MAX_ALIGNMENT (sizeof(void*) << 1)

#define UNSET_MAX_ALIGNMENT ((uint64_t)-1)

#define FIRST_COL_OFFSET 22

#if defined(min)
# undef min
#endif
#define min(x, y) ((x) < (y) ? (x) : (y))

#if defined(max)
# undef max
#endif
#define max(x, y) ((x) < (y) ? (y) : (x))

static inline bool is_pow_of_two(uint64_t a) {
    if (a == 0) {
        return false;
    }

    return (a & (a - 1)) == 0;
}

static inline uint64_t next_power_of_two(uint64_t a) {
    --a;

    a |= a >> 1;
    a |= a >> 2;
    a |= a >> 4;
    a |= a >> 8;
    a |= a >> 16;
    a |= a >> 32;

    ++a;

    return a;
}

static type_t* _type__create(const char* abbreviated_name, uint64_t size);
static void _type_struct__update_member(type_struct_t* self, member_t* new_member);
static void _type_union__update_member(type_union_t* self, member_t* new_member);
static void _type__print_name(type_t* self, FILE* fp, uint32_t number_of_expansions, uint64_t offset);
static void _type__print_size(type_t* self, FILE* fp);
static void _type__print_alignment(type_t* self, FILE* fp);
static void _type__print_max_alignment(type_t* self, FILE* fp);
static void _type_struct__add_multiple(type_struct_t* self, ...);
static void _type_union__add_multiple(type_union_t* self, ...);
static void _type__print_value(type_t* self, FILE* fp, uint32_t n_of_value_expansions, uint8_t* address);

static int64_t function__argument_offset_from_bp(function_argument_t* arguments, uint32_t arguments_size, const char* argument_name, va_list ap);
static uint64_t function__size_of_arg(function_argument_t* arguments, uint32_t arguments_size, const char* argument_name, va_list ap);
static int64_t function__return_offset_from_bp(function_argument_t* arguments, uint32_t arguments_size, type_t* return_type, va_list ap);
static uint64_t function__size_of_ret(type_t* return_type, va_list ap);
static int64_t function__local_offset_from_bp(function_local_t* locals, uint32_t locals_size, const char* local_name, va_list ap);
static uint64_t type_internal_function__size_of_local(function_local_t* locals, uint32_t locals_size, const char* local_name, va_list ap);

static void _type__print_value(type_t* self, FILE* fp, uint32_t n_of_value_expansions, uint8_t* address) {
    if (n_of_value_expansions == 0) {
        if (self->type_specifier == TYPE_ATOM) {
            type_atom_t* type_atom = (type_atom_t*) self;
            type_atom->print_value_at_addr(fp, address);
        }
        return ;
    }

    assert(
        ((uint64_t) address) % type__alignment(self) == 0 ||
        ((uint64_t) address) % type__max_alignment(self) == 0
    );

    switch (self->type_specifier) {
        case TYPE_ATOM: {
            type_atom_t* type_atom = (type_atom_t*) self;
            type_atom->print_value_at_addr(fp, address);
        } break ;
        case TYPE_STRUCT: {
            type_struct_t* type_struct = (type_struct_t*) self;
            fprintf(fp, "{");
            for (uint32_t member_index = 0; member_index < type_struct->members_top; ++member_index) {
                assert(
                    ((uint64_t) address) % type__alignment(type_struct->members[member_index].type) == 0 ||
                    ((uint64_t) address) % type__max_alignment(self) == 0
                );

                _type__print_value(type_struct->members[member_index].type, fp, n_of_value_expansions - 1, address);
                if (member_index < type_struct->members_top - 1) {
                    fprintf(fp, ", ");
                    address += type_struct->members[member_index + 1].offset - type_struct->members[member_index].offset;
                }
            }
            fprintf(fp, "}");
        } break ;
        case TYPE_UNION: {
            type_union_t* type_union = (type_union_t*) self;
            fprintf(fp, "|");
            for (uint32_t member_index = 0; member_index < type_union->members_top; ++member_index) {
                _type__print_value(type_union->members[member_index].type, fp, n_of_value_expansions - 1, address);
                if (member_index < type_union->members_top - 1) {
                    fprintf(fp, ", ");
                }
            }
            fprintf(fp, " === ");
            _type__print_value(type_union->biggest_sized_member->type, fp, n_of_value_expansions - 1, address);
            fprintf(fp, "|");
        } break ;
        case TYPE_ARRAY: {
            type_array_t* type_array = (type_array_t*) self;
            fprintf(fp, "[%llu: ", type_array->element_size);
            uint64_t cur_offet = 0;
            for (uint64_t element_index = 0; element_index < type_array->element_size; ++element_index) {
                _type__print_value(type_array->element_type, fp, n_of_value_expansions - 1, address + cur_offet);
                cur_offet += type__size(type_array->element_type);
                if (element_index < type_array->element_size - 1) {
                    fprintf(fp, ", ");
                }
            }
            fprintf(fp, "]");
        } break ;
        case TYPE_POINTER: {
            type_pointer_t* type_pointer = (type_pointer_t*) self;
            if (!type_pointer->pointed_type) {
                fprintf(fp, "(null)");
            } else {
                _type__print_value(type_pointer->pointed_type, fp, n_of_value_expansions - 1, address);
            }
        } break ;
        case TYPE_ENUM: {
            type_enum_t* type_enum = (type_enum_t*) self;
            fprintf(fp, "<%d>", *(int32_t*) address);
        } break ;
        default: assert(false);
    }
}

static type_t* _type__create(const char* abbreviated_name, uint64_t size) {
    type_t* result = calloc(1, size);

    result->abbreviated_name = abbreviated_name;

    return result;
}

static void _type_struct__update_member(type_struct_t* self, member_t* new_member) {
    if (self->base.type_specifier != TYPE_UNION && self->base.type_specifier != TYPE_STRUCT) {
        assert(false);
    }

    // alignment number is the biggest amongst all member's alignment
    self->base.alignment = min(self->base.max_alignment, max(self->base.alignment, new_member->type->alignment));

    // align each member to its alignment
    uint64_t new_member_offset = self->base.size;
    uint64_t pad_for_new_member = 0;
    uint64_t bytes_to_align = new_member_offset % new_member->type->alignment;
    if (bytes_to_align) {
        uint64_t pad_relative_to_new_member = new_member->type->alignment - bytes_to_align;
        pad_for_new_member = pad_relative_to_new_member;
    }
    bytes_to_align = new_member_offset % self->base.alignment;
    if (bytes_to_align) {
        uint64_t pad_relative_to_self_alignment = self->base.alignment - bytes_to_align;
        pad_for_new_member = min(pad_for_new_member, pad_relative_to_self_alignment);
    } else {
        pad_for_new_member = 0;
    }
    new_member_offset += pad_for_new_member;

    new_member->offset = new_member_offset;

    self->base.size = new_member_offset + type__size(new_member->type);
}

static void _type_union__update_member(type_union_t* self, member_t* new_member) {
    if (self->biggest_sized_member == NULL) {
        assert(self->biggest_aligned_member == NULL);
        self->biggest_sized_member = new_member;
        self->biggest_aligned_member = new_member;
    } else {
        if (type__size(new_member->type) > type__size(self->biggest_sized_member->type)) {
            self->biggest_sized_member = new_member;
        }
        if (new_member->type->alignment > self->biggest_aligned_member->type->alignment) {
            self->biggest_aligned_member = new_member;
        }
    }

    self->base.size = type__size(self->biggest_sized_member->type);
    self->base.alignment = min(self->base.max_alignment, self->biggest_aligned_member->type->alignment);
}

type_atom_t* type_atom__create(
    const char* abbreviated_name, const char* name, uint64_t size,\
    void (*print_value_at_addr)(FILE* fp, uint8_t* addr)
) {
    type_atom_t* result = (type_atom_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_ATOM;
    result->base.alignment = size;
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = size;
    result->name = name;
    result->print_value_at_addr = print_value_at_addr;

    return result;
}

void type__set_max_alignment(type_t* self, uint64_t max_alignment) {
    if (self->type_specifier != TYPE_STRUCT && self->type_specifier != TYPE_UNION) {
        return ;
    }

    if (max_alignment != UNSET_MAX_ALIGNMENT) {
        assert(is_pow_of_two(max_alignment));
        assert(max_alignment <= 16);
    }

    self->max_alignment = max_alignment;

    if (self->type_specifier == TYPE_STRUCT) {
        type_struct_t* type_struct = (type_struct_t*) self;
        self->size = 0;
        for (uint32_t member_index = 0; member_index < type_struct->members_top; ++member_index) {
            _type_struct__update_member(type_struct, &type_struct->members[member_index]);
        }
    } else if (self->type_specifier == TYPE_UNION) {
        type_union_t* type_union = (type_union_t*) self;
        self->size = 0;
        for (uint32_t member_index = 0; member_index < type_union->members_top; ++member_index) {
            _type_union__update_member(type_union, &type_union->members[member_index]);
        }
    }
}

void type__set_alignment(type_t* self, uint64_t alignment) {
    // alignment is:
    //   - the highest amongst all the member's alignment, unless set explicitely here
    //   - cannot be more than the max alignment

    if (alignment != UNSET_MAX_ALIGNMENT) {
        assert(is_pow_of_two(alignment));
    }

    self->alignment = alignment;
    type__set_max_alignment(self, UNSET_MAX_ALIGNMENT);
}

uint64_t type__alignment(type_t* self) {
    return self->alignment;
}

uint64_t type__size(type_t* self) {
    if (
        self->type_specifier == TYPE_UNION ||
        self->type_specifier == TYPE_STRUCT
    ) {
        // struct or union has padding at its end, which depends on the alignment of the type
        uint64_t pad_for_self = self->size % self->alignment;
        if (pad_for_self) {
            return self->size + (self->alignment - pad_for_self);
        } else {
            return self->size;
        }
    } else {
        return self->size;
    }
}

const char* type__abbreviated_name(type_t* self) {
    return self->abbreviated_name;
}

uint8_t* type__address(type_t* self, uint8_t* requested_address) {
    // address must be divisible by the alignment number
    uint64_t alignment = type__alignment(self);
    assert(alignment);
    uint64_t offset = ((uint64_t) requested_address) % alignment;
    if (offset) {
        requested_address += alignment - offset;
    }
    assert(((uint64_t) requested_address) % alignment == 0);

    return requested_address;
}

member_t* type_struct__member(type_struct_t* self, const char* name) {
    for (uint32_t member_index = 0; member_index < self->members_top; ++member_index) {
        if (strcmp(self->members[member_index].name, name) == 0) {
            return &self->members[member_index];
        }
    }

    return NULL;
}

member_t* type_union__member(type_union_t* self, const char* name) {
    for (uint32_t member_index = 0; member_index < self->members_top; ++member_index) {
        if (strcmp(self->members[member_index].name, name) == 0) {
            return &self->members[member_index];
        }
    }

    return NULL;
}

void member__print(member_t* self, FILE* fp) {
    fprintf(fp, "%-*.*s%s\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "name: ", self->name);

    fprintf(fp, "%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "offset: ", self->offset);

    fprintf(fp, "%-*.*s%s\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "type: ", type__abbreviated_name(self->type));
}

const char* member__name(member_t* self) {
    return self->name;
}

type_struct_t* type_struct__create(const char* abbreviated_name) {
    type_struct_t* result = (type_struct_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_STRUCT;
    result->base.alignment = 0;
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = 0;
    
    return result;
}

void type_struct__add(type_struct_t* self, type_t* member_type, const char* member_name) {
    member_t* new_member = NULL;
    
    if (self->members_top == self->members_size) {
        if (self->members_top == 0) {
            self->members_size = 8;
            self->members = malloc(self->members_size * sizeof(*self->members));
        } else {
            self->members_size <<= 1;
            self->members = realloc(self->members, self->members_size * sizeof(*self->members));
        }
    }

    assert(self->members_top != self->members_size);
    new_member = &self->members[self->members_top++];
    new_member->name = member_name;
    new_member->type = member_type;
    new_member->offset = 0;
    assert(new_member);

    _type_struct__update_member(self, new_member);
}

type_union_t* type_union__create(const char* abbreviated_name) {
    type_union_t* result = (type_union_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_UNION;
    result->base.alignment = 0;
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = 0;

    return result;
}

void type_union__add(type_union_t* self, type_t* member_type, const char* member_name) {
    member_t* new_member = NULL;

    if (self->members_top == self->members_size) {
        if (self->members_top == 0) {
            self->members_size = 8;
            self->members = malloc(self->members_size * sizeof(*self->members));
        } else {
            self->members_size <<= 1;
            self->members = realloc(self->members, self->members_size * sizeof(*self->members));
        }
    }

    assert(self->members_top != self->members_size);
    new_member = &self->members[self->members_top++];
    new_member->name = member_name;
    new_member->type = member_type;
    new_member->offset = 0;
    assert(new_member);

    _type_union__update_member(self, new_member);
}

type_array_t* type_array__create(const char* abbreviated_name, type_t* member, uint64_t n) {
    if (type__alignment(member) > member->size) {
        assert(false && "error: alignment of array elements is greater than element size");
    }

    type_array_t* result = (type_array_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_ARRAY;
    result->base.alignment = member->alignment;
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = n * type__size(member);

    result->element_type = member;
    result->element_size = n;

    return result;
}

type_pointer_t* type_pointer__create(const char* abbreviated_name, type_t* pointed_type) {
    type_pointer_t* result = (type_pointer_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_POINTER;
    result->base.alignment = sizeof(void*);
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = sizeof(void*);

    result->pointed_type = pointed_type;

    return result;
}

type_enum_t* type_enum__create(const char* abbreviated_name) {
    type_enum_t* result = (type_enum_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_ENUM;
    result->base.alignment = sizeof(int32_t);
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = sizeof(int32_t);

    return result;
}

void _type_enum__add(type_enum_t* self, const char* name, int32_t value) {
    if (self->values_top == self->values_size) {
        if (self->values_size ==  0) {
            self->values_size = 8;
            self->values = malloc(self->values_size * sizeof(*self->values));
        } else {
            self->values_size <<= 1;
            self->values = realloc(self->values, self->values_size * sizeof(*self->values));
        }
    }

    assert(self->values_top < self->values_size);
    self->values[self->values_top].name  = name;
    self->values[self->values_top].value = value;
    ++self->values_top;
}

void type_enum__add(type_enum_t* self, const char* name) {
    if (self->values_size == 0) {
        _type_enum__add(self, name, 0);
    } else {
        assert(self->values_top > 0);
        _type_enum__add(self, name, self->values[self->values_top - 1].value + 1);
    }
}

void type_enum__add_with_value(type_enum_t* self, const char* name, int32_t value) {
    _type_enum__add(self, name, value);
}

type_internal_function_t* type_internal_function__create(const char* name, void (*compile_fn)(hash_map_t* types, type_internal_function_t* type_function)) {
    type_internal_function_t* result = (type_internal_function_t*) _type__create(name, sizeof(*result));

    result->base.type_specifier = TYPE_FUNCTION_INTERNAL;
    result->base.alignment = sizeof(void*);
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = sizeof(void*);

    result->name = name;
    result->compile_fn = compile_fn;

    return result;
}

void type_internal_function__add_argument(type_internal_function_t* self, const char* name, type_t* type) {
    if (self->arguments_size == 0) {
        self->arguments_size = 8;
        self->arguments = malloc(self->arguments_size * sizeof(*self->arguments));
    } else if (self->arguments_top == self->arguments_size) {
        self->arguments_size <<= 1;
        self->arguments = realloc(self->arguments, self->arguments_size * sizeof(*self->arguments));
    }

    assert(self->arguments_top != self->arguments_size);
    self->arguments[self->arguments_top].name = name;
    self->arguments[self->arguments_top].type = type;
    ++self->arguments_top;
}

void type_internal_function__add_local(type_internal_function_t* self, const char* name, type_t* type) {
    if (self->locals_size == 0) {
        self->locals_size = 8;
        self->locals = malloc(self->locals_size * sizeof(*self->locals));
    } else if (self->locals_top == self->locals_size) {
        self->locals_size <<= 1;
        self->locals = realloc(self->locals, self->locals_size * sizeof(*self->locals));
    }

    assert(self->locals_top != self->locals_size);
    self->locals[self->locals_top].name = name;
    self->locals[self->locals_top].type = type;
    ++self->locals_top;
}

void type_internal_function__set_return(type_internal_function_t* self, type_t* type) {
    self->return_type = type;
}

uint8_t* type_internal_function__set_ip(type_internal_function_t* self, uint8_t* ip) {
    self->start_ip = ip;
    self->end_ip = ip;
}

uint8_t* type_internal_function__ip(type_internal_function_t* self) {
    return self->start_ip;
}

uint8_t* type_internal_function__end_ip(type_internal_function_t* self) {
    return self->end_ip;
}

void type_internal_function__add_ins(type_internal_function_t* self, ins_t ins, ...) {
    va_list ap;
    va_start(ap, ins);

    self->end_ip = ins__vadd(ins, self->end_ip, ap);

    va_end(ap);
}

static int64_t function__argument_offset_from_bp(
    function_argument_t* arguments, uint32_t arguments_size, const char* argument_name,
    va_list ap
) {
    int64_t result = 0;
    result -= sizeof(reg_t); // BP register on stack
    result -= sizeof(uint8_t*); // return address
    
    // bug: we need to iterate in reverse order, or subtract the entire argument and then look for the argument_name
    // bug: alignment is not considered here
    bool found_argument = false;
    for (uint32_t arg_index = 0; arg_index < arguments_size; ++arg_index) {
        function_argument_t* argument = &arguments[arg_index];
        result -= type__size(argument->type);
        if (strcmp(argument->name, argument_name) == 0) {
            found_argument = true;
            type_t* parent = argument->type;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(parent, member_name);
                if (member) {
                    result += (int64_t) member->offset;
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        type_array_t* type_array = (type_array_t*) member->type;
                        uint64_t element_index = va_arg(ap, uint64_t);
                        result += (int64_t) element_index * type__size(type_array->element_type);
                    }
                    parent = member->type;
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            break ;
        }
    }
    assert(found_argument);

    return result;
}

static uint64_t function__size_of_arg(
    function_argument_t* arguments, uint32_t arguments_size, const char* argument_name,
    va_list ap
) {
    function_argument_t* function_argument = NULL;
    bool found_argument = false;
    for (uint32_t argument_index = 0; argument_index < arguments_size; ++argument_index) {
        function_argument_t* argument = &arguments[argument_index];
        if (strcmp(argument->name, argument_name) == 0) {
            function_argument = argument;
            found_argument = true;
            break ;
        }
    }
    assert(found_argument);

    type_t* member_type = function_argument->type;
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(member_type, member_name);
        if (member) {
            if (member->type->type_specifier == TYPE_ARRAY) {
                uint64_t element_index = va_arg(ap, uint64_t);
                (void) element_index; // all elements are of the same type
                type_array_t* type_array = (type_array_t*) member->type;
                member_type = type_array->element_type;
            } else {
                member_type = member->type;
            }
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return type__size(member_type);
}

static int64_t function__return_offset_from_bp(
    function_argument_t* arguments, uint32_t arguments_size,
    type_t* return_type,
    va_list ap
) {
    assert(return_type);

    int64_t result = 0;
    result -= sizeof(reg_t); // BP register on stack
    result -= sizeof(uint8_t*); // return address
    for (uint32_t arg_index = 0; arg_index < arguments_size; ++arg_index) {
        result -= type__size(arguments[arg_index].type);
    }
    result -= type__size(return_type);

    // bug: we need to iterate in reverse order, or subtract the entire argument and then look for the argument_name
    // bug: alignment is not considered here
    type_t* type = return_type;
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(type, member_name);
        if (member) {
            result += (int64_t) member->offset;
            if (member->type->type_specifier == TYPE_ARRAY) {
                type_array_t* type_array = (type_array_t*) member->type;
                uint64_t element_index = va_arg(ap, uint64_t);
                result += (int64_t) element_index * type__size(type_array->element_type);
            }
            type = member->type;
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return result;
}

static uint64_t function__size_of_ret(type_t* return_type, va_list ap) {
    assert(return_type);

    type_t* member_type = return_type;
    const char* member_name = va_arg(ap, const char*);
    while (member_name) {
        member_t* member = type__member(member_type, member_name);
        if (member) {
            if (member->type->type_specifier == TYPE_ARRAY) {
                uint64_t element_index = va_arg(ap, uint64_t);
                (void) element_index; // all elements are of the same type
                type_array_t* type_array = (type_array_t*) member->type;
                member_type = type_array->element_type;
            } else {
                member_type = member->type;
            }
        } else {
            assert(false);
        }
        member_name = va_arg(ap, const char*);
    }

    return type__size(member_type);
}

static int64_t function__local_offset_from_bp(
    function_local_t* locals, uint32_t locals_size, const char* local_name,
    va_list ap
) {
    int64_t result = 0;
    bool found = false;
    for (uint32_t local_index = 0; local_index < locals_size; ++local_index) {
        function_local_t* local = &locals[local_index];
        if (strcmp(local_name, local->name) == 0) {
            found = true;
            type_t* parent = local->type;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(parent, member_name);
                if (member) {
                    result += (int64_t) member->offset;
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        type_array_t* type_array = (type_array_t*) member->type;
                        uint64_t element_index = va_arg(ap, uint64_t);
                        result += (int64_t) element_index * type__size(type_array->element_type);
                    }
                    parent = member->type;
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            break ;
        }
        result += type__size(local->type);
    }
    assert(found);

    return result;
}

static uint64_t type_internal_function__size_of_local(
    function_local_t* locals, uint32_t locals_size, const char* local_name,
    va_list ap
) {
    for (uint32_t local_index = 0; local_index < locals_size; ++local_index) {
        function_local_t* local = &locals[local_index];
        if (strcmp(local_name, local->name) == 0) {
            type_t* member_type = local->type;
            const char* member_name = va_arg(ap, const char*);
            while (member_name) {
                member_t* member = type__member(member_type, member_name);
                if (member) {
                    if (member->type->type_specifier == TYPE_ARRAY) {
                        uint64_t element_index = va_arg(ap, uint64_t);
                        (void) element_index; // all elements are of the same type
                        type_array_t* type_array = (type_array_t*) member->type;
                        member_type = type_array->element_type;
                    } else {
                        member_type = member->type;
                    }
                } else {
                    assert(false);
                }
                member_name = va_arg(ap, const char*);
            }
            return type__size(member_type);
        }
    }

    assert(false);
    return 0;
}

// todo: replace this, runtime is the only thing that knows about the alignment, so this fixes the alignment bug of calculating offsets for arg and ret
void type_internal_function__store_argument(type_internal_function_t* self, const char* argument_name, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, argument_name);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__argument_offset_from_bp(self->arguments, self->arguments_top, argument_name, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, argument_name);
    type_internal_function__add_ins(self, INS_STACK_STORE, function__size_of_arg(self->arguments, self->arguments_top, argument_name, ap));
    va_end(ap);
}

void type_internal_function__load_argument(type_internal_function_t* self, const char* argument_name, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, argument_name);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__argument_offset_from_bp(self->arguments, self->arguments_top, argument_name, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, argument_name);
    type_internal_function__add_ins(self, INS_STACK_LOAD, function__size_of_arg(self->arguments, self->arguments_top, argument_name, ap));
    va_end(ap);
}

void type_internal_function__store_return(type_internal_function_t* self, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, self);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__return_offset_from_bp(self->arguments, self->arguments_top, self->return_type, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, self);
    type_internal_function__add_ins(self, INS_STACK_STORE, function__size_of_ret(self->return_type, ap));
    va_end(ap);
}

void type_internal_function__load_return(type_internal_function_t* self, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, self);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__return_offset_from_bp(self->arguments, self->arguments_top, self->return_type, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, self);
    type_internal_function__add_ins(self, INS_STACK_LOAD, function__size_of_ret(self->return_type, ap));
    va_end(ap);
}

void type_internal_function__store_local(type_internal_function_t* self, const char* local_name, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, local_name);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__local_offset_from_bp(self->locals, self->locals_top, local_name, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, local_name);
    type_internal_function__add_ins(self, INS_STACK_STORE, type_internal_function__size_of_local(self->locals, self->locals_top, local_name, ap));
    va_end(ap);
}

void type_internal_function__load_local(type_internal_function_t* self, const char* local_name, ...) {
    va_list ap;

    type_internal_function__add_ins(self, INS_PUSH_BP);

    va_start(ap, local_name);
    type_internal_function__add_ins(self, INS_PUSH, (reg_t){function__local_offset_from_bp(self->locals, self->locals_top, local_name, ap), 0});
    va_end(ap);

    type_internal_function__add_ins(self, INS_ADD);

    va_start(ap, local_name);
    type_internal_function__add_ins(self, INS_STACK_LOAD, type_internal_function__size_of_local(self->locals, self->locals_top, local_name, ap));
    va_end(ap);
}

type_external_function_t* type_external_function__create(const char* name) {
    type_external_function_t* result = (type_external_function_t*) _type__create(name, sizeof(*result));

    result->base.type_specifier = TYPE_FUNCTION_EXTERNAL;
    result->base.alignment = sizeof(void*);
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = sizeof(void*);

    result->name = name;

    return result;
}

void type_external_function__add_argument(type_external_function_t* self, const char* name, type_t* type) {
    if (self->arguments_size == 0) {
        self->arguments_size = 8;
        self->arguments = malloc(self->arguments_size * sizeof(*self->arguments));
    } else if (self->arguments_top == self->arguments_size) {
        self->arguments_size <<= 1;
        self->arguments = realloc(self->arguments, self->arguments_size * sizeof(*self->arguments));
    }

    assert(self->arguments_top != self->arguments_size);
    self->arguments[self->arguments_top].name = name;
    self->arguments[self->arguments_top].type = type;
    ++self->arguments_top;
}

void type_external_function__set_return(type_external_function_t* self, type_t* type) {
    self->return_type = type;
}

void type_external_function__call(type_external_function_t* self) {
    assert(false && "implement");
}

type_builtin_function_t* type_builtin_function__create(const char* name, void (*execute_fn)(type_builtin_function_t* self, void* processor)) {
    type_builtin_function_t* result = (type_builtin_function_t*) _type__create(name, sizeof(*result));

    result->base.type_specifier = TYPE_FUNCTION_BUILTIN;
    result->base.alignment = sizeof(void*);
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = sizeof(void*);

    result->name = name;
    result->execute_fn = execute_fn;

    return result;
}

void type_builtin_function__add_argument(type_builtin_function_t* self, type_t* type) {
    if (self->arguments_top == self->arguments_size) {
        if (self->arguments_size == 0) {
            self->arguments_size = 8;
            self->arguments_offsets = malloc(self->arguments_size * sizeof(*self->arguments_offsets));
        } else {
            self->arguments_size <<= 1;
            self->arguments_offsets = realloc(self->arguments_offsets, self->arguments_size * sizeof(*self->arguments_offsets));
        }
    }

    assert(self->arguments_top < self->arguments_size);
    self->arguments_offsets[self->arguments_top] = -(int64_t) type__size(type);
    self->return_offset += self->arguments_offsets[self->arguments_top];
    ++self->arguments_top;
}

void type_builtin_function__set_return(type_builtin_function_t* self, type_t* type) {
    self->return_offset = 0;
    self->return_offset -= sizeof(reg_t); // BP register on stack
    self->return_offset -= sizeof(uint8_t*); // return address
    for (uint32_t argument_index = 0; argument_index < self->arguments_top; ++argument_index) {
        self->return_offset += self->arguments_offsets[argument_index];
    }
    self->return_offset -= type__size(type);
}

void type_builtin_function__call(type_builtin_function_t* self, void* processor) {
    self->execute_fn(self, processor);
}

int64_t type_builtin__return_offset_from_bp(type_builtin_function_t* self) {
    return self->return_offset;
}

int64_t type_builtin__argument_offset_from_bp(type_builtin_function_t* self, uint32_t argument_index) {
    assert(argument_index < self->arguments_top);
    return self->arguments_offsets[argument_index];
}

member_t* type__member(type_t* type, const char* member_name) {
    if (type->type_specifier == TYPE_UNION) {
        return type_union__member((type_union_t*) type, member_name);
    } else if (type->type_specifier == TYPE_STRUCT) {
        return type_struct__member((type_struct_t*) type, member_name);
    } else {
        return NULL;
    }
}

uint64_t type__max_alignment(type_t* self) {
    return self->max_alignment;
}

static void _type__print_name(type_t* self, FILE* fp, uint32_t number_of_expansions, uint64_t offset) {
    if (number_of_expansions == 0) {
        fprintf(fp, "%s", self->abbreviated_name, offset);
        return ;
    }

    assert(
        offset % type__alignment(self) == 0 ||
        offset % type__max_alignment(self) == 0
    );

    switch (self->type_specifier) {
        case TYPE_ATOM: {
            type_atom_t* type_atom = (type_atom_t*) self;
            fprintf(fp, "%s", type_atom->name);
        } break ;
        case TYPE_STRUCT: {
            type_struct_t* type_struct = (type_struct_t*) self;
            fprintf(fp, "{");
            for (uint32_t member_index = 0; member_index < type_struct->members_top; ++member_index) {
                assert(
                    offset % type__alignment(type_struct->members[member_index].type) == 0 ||
                    offset % type__max_alignment(self) == 0
                );

                fprintf(fp, "@%llu ", offset);
                _type__print_name(type_struct->members[member_index].type, fp, number_of_expansions - 1, offset);
                fprintf(fp, " %s", type_struct->members[member_index].name);
                if (member_index < type_struct->members_top - 1) {
                    fprintf(fp, ", ");
                    offset += type_struct->members[member_index + 1].offset - type_struct->members[member_index].offset;
                }
            }
            fprintf(fp, "}");
        } break ;
        case TYPE_UNION: {
            type_union_t* type_union = (type_union_t*) self;
            fprintf(fp, "|");
            for (uint32_t member_index = 0; member_index < type_union->members_top; ++member_index) {
                _type__print_name(type_union->members[member_index].type, fp, number_of_expansions - 1, offset);
                fprintf(fp, " %s", type_union->members[member_index].name);
                fprintf(fp, " %llu", offset);
                if (member_index < type_union->members_top - 1) {
                    fprintf(fp, ", ");
                }
            }
            fprintf(fp, " === ");
            _type__print_name(type_union->biggest_sized_member->type, fp, number_of_expansions - 1, offset);
            fprintf(fp, " %s", type_union->biggest_sized_member->name);
            fprintf(fp, " %llu", offset);
            fprintf(fp, "|");
        } break ;
        case TYPE_ARRAY: {
            type_array_t* type_array = (type_array_t*) self;
            fprintf(fp, "[%llu, ", type_array->element_size);
            _type__print_name(type_array->element_type, fp, number_of_expansions - 1, offset /* + type__size(self) */);
            fprintf(fp, "]");
        } break ;
        case TYPE_POINTER: {
            type_pointer_t* type_pointer = (type_pointer_t*) self;
            if (!type_pointer->pointed_type) {
                fprintf(fp, "void*");
            } else {
                _type__print_name(type_pointer->pointed_type, fp, number_of_expansions - 1, offset);
            }
            fprintf(fp, "*");
        } break ;
        case TYPE_ENUM: {
            type_enum_t* type_enum = (type_enum_t*) self;
            fprintf(fp, "<");
            for (uint32_t enum_index = 0; enum_index < type_enum->values_top; ++enum_index) {
                fprintf(fp, "%s", type_enum->values[enum_index].name);
                fprintf(fp, " %d", type_enum->values[enum_index].value);
                if (enum_index < type_enum->values_top - 1) {
                    fprintf(fp, ", ");
                }
            }
            fprintf(fp, ">");
        } break ;
        default: assert(false);
    }
}

static void _type__print_size(type_t* self, FILE* fp) {
    fprintf(fp, "%llu", type__size(self));
}

static void _type__print_alignment(type_t* self, FILE* fp) {
    fprintf(fp, "%llu", self->alignment);
}

static void _type__print_max_alignment(type_t* self, FILE* fp) {
    if (self->max_alignment == UNSET_MAX_ALIGNMENT) {
        fprintf(fp, "-");
    } else {
        fprintf(fp, "%llu", self->max_alignment);
    }
}

void type__print(
    type_t* self, FILE* fp,
    uint32_t n_of_name_expansions,
    uint32_t n_of_value_expansions, uint8_t* address
) {
    for (uint32_t name_expansions = 0; name_expansions <= n_of_name_expansions; ++name_expansions) {
        char buffer[256];
        snprintf(buffer, sizeof(buffer), "name (%llu expansions): ", name_expansions);
        fprintf(fp, "%-*.*s", FIRST_COL_OFFSET, FIRST_COL_OFFSET, buffer);
        _type__print_name(self, fp, name_expansions, 0);
        fprintf(fp, "\n");
    }

    fprintf(fp, "%-*.*s", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "size: ");
    _type__print_size(self, fp);
    fprintf(fp, "\n");

    fprintf(fp, "%-*.*s", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "alignment: ");
    _type__print_alignment(self, fp);
    fprintf(fp, "\n");

    fprintf(fp, "%-*.*s", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "max alignment: ");
    _type__print_max_alignment(self, fp);
    fprintf(fp, "\n");

    if (address) {
        fprintf(fp, "%-*.*s", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "value: ");
        _type__print_value(self, fp, 5, address);
        fprintf(fp, "\n");

        fprintf(fp, "%-*.*s%p\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "address: ", address);
    }
}

typedef int8_t   ss8_t;
typedef int16_t  ss16_t;
typedef int32_t  ss32_t;
typedef int64_t  ss64_t;
typedef uint8_t  su8_t;
typedef uint16_t su16_t;
typedef uint32_t su32_t;
typedef uint64_t su64_t;
typedef float    sr32_t;
static_assert(sizeof(sr32_t) == 4);
typedef double   sr64_t;
static_assert(sizeof(sr64_t) == 8);

#define REGULAR_PRINT(type) do { \
    char buffer[256]; \
    snprintf(buffer, sizeof(buffer), "sizeof(%s): ", #type); \
    printf("%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, buffer, sizeof(s ## type ## _t)); \
    snprintf(buffer, sizeof(buffer), "alignof(%s): ", #type); \
    printf("%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, buffer, __alignof__(s ## type ## _t)); \
    printf("\n"); \
} while (false)

#define TYPES_PRINT(fp, type, n_of_expansions) do { \
    type__print((type_t*) (t ## type), fp, n_of_expansions, 0, 0); \
} while (false)

#if defined(_MSC_VER)
# define ALIGNOF(x) alignof(x)
# define ALIGN(x) alignas(x)
#elif defined(__GNUC__)
# define ALIGNOF(x) __alignof__(x)
# define ALIGN(x) __attribute__ ((aligned (x)))
#elif
# error "compiler not supported"
#endif

#define TYPE_SIZE_CHECK(type) do { \
    assert(sizeof(s ## type ## _t) == type__size((type_t*)(t ## type))); \
    assert(ALIGNOF(s ## type ## _t) == (t ## type)->base.alignment); \
} while (false)

#define TEST_TYPE(fp, type) do { \
    TYPES_PRINT(fp, type, 2); \
    REGULAR_PRINT(type); \
    TYPE_SIZE_CHECK(type); \
} while (false)

static void _type_struct__add_multiple(type_struct_t* self, ...) {
    va_list ap;
    va_start(ap, self);

    type_t* type = va_arg(ap, type_t*);
    assert(type);
    const char* name = va_arg(ap, const char*);
    assert(name);
    do {
        type_struct__add(self, type, name);
        type = va_arg(ap, type_t*);
        if (!type) {
            break ;
        }
        name = va_arg(ap, const char*);
        assert(name);
    } while (true);

    va_end(ap);
}

static void _type_union__add_multiple(type_union_t* self, ...) {
    va_list ap;
    va_start(ap, self);

    type_t* type = va_arg(ap, type_t*);
    assert(type);
    const char* name = va_arg(ap, char*);
    assert(name);
    do {
        type_union__add(self, type, name);
        type = va_arg(ap, type_t*);
        if (!type) {
            break ;
        }
        name = va_arg(ap, char*);
        assert(name);
    } while (true);

    va_end(ap);
}

#define TYPE_STRUCT_ADD_MULTIPLE(self, ...) do { \
    _type_struct__add_multiple(self, __VA_ARGS__, NULL); \
} while (false)
#define TYPE_UNION_ADD_MULTIPLE(self, ...) do { \
    _type_union__add_multiple(self, __VA_ARGS__, NULL); \
} while (false)

static void _type__print_value_s8(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(ss8_t*) address);
}

static void _type__print_value_s16(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(ss16_t*) address);
}

static void _type__print_value_s32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%d", *(ss32_t*) address);
}

static void _type__print_value_s64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%lld", *(ss64_t*) address);
}

static void _type__print_value_u8(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(su8_t*) address);
}

static void _type__print_value_u16(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(su16_t*) address);
}

static void _type__print_value_u32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%u", *(su32_t*) address);
}

static void _type__print_value_u64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%llu", *(su64_t*) address);
}

static void _type__print_value_r32(FILE* fp, uint8_t* address) {
    fprintf(fp, "%f", *(sr32_t*) address);
}

static void _type__print_value_r64(FILE* fp, uint8_t* address) {
    fprintf(fp, "%lf", *(sr64_t*) address);
}

int main2() {
    type_atom_t* ts8 =  type_atom__create("s8",  "s8",  sizeof(ss8_t), &_type__print_value_s8);
    type_atom_t* ts16 = type_atom__create("s16", "s16", sizeof(ss16_t), &_type__print_value_s16);
    type_atom_t* ts32 = type_atom__create("s32", "s32", sizeof(ss32_t), &_type__print_value_s32);
    type_atom_t* ts64 = type_atom__create("s64", "s64", sizeof(ss64_t), &_type__print_value_s64);
    type_atom_t* tu8 =  type_atom__create("u8",  "u8",  sizeof(su8_t), &_type__print_value_u8);
    type_atom_t* tu16 = type_atom__create("u16", "u16", sizeof(su16_t), &_type__print_value_u16);
    type_atom_t* tu32 = type_atom__create("u32", "u32", sizeof(su32_t), &_type__print_value_u32);
    type_atom_t* tu64 = type_atom__create("u64", "u64", sizeof(su64_t), &_type__print_value_u64);
    type_atom_t* tr32 = type_atom__create("r32", "r32", sizeof(sr32_t), &_type__print_value_r32);
    type_atom_t* tr64 = type_atom__create("r64", "r64", sizeof(sr64_t), &_type__print_value_r64);

    typedef struct sa {
        ss8_t _;
    } sa_t;
    type_struct_t* ta = type_struct__create("a");
    type_struct__add(ta, (type_t*) ts8, "_");

    typedef struct sb {
        ss8_t  _;
        ss32_t __;
    } sb_t;
    type_struct_t* tb = type_struct__create("b");
    type_struct__add(tb, (type_t*) ts8, "_");
    type_struct__add(tb, (type_t*) ts32, "__");

    typedef struct sc {
        ss32_t _;
        ss8_t  __;
    } sc_t;
    type_struct_t* tc = type_struct__create("c");
    TYPE_STRUCT_ADD_MULTIPLE(tc, ts32, "_", ts8, "__");

    typedef ss8_t sd_t[3];
    type_array_t* td = type_array__create("d", (type_t*) ts8, 3);

    typedef union se {
        ss32_t _;
        ss8_t  __;
        ss64_t ___;
    } se_t;
    type_union_t* te = type_union__create("e");
    TYPE_UNION_ADD_MULTIPLE(te, ts32, "_", ts8, "__", ts64, "___");

    typedef se_t* sf_t;
    type_pointer_t* tf = type_pointer__create("f", (type_t*) te);

    typedef struct sg {
        sf_t   _;
        sr32_t __;
        se_t   ___;
        sc_t   ____;
    } sg_t;
    type_struct_t* tg = type_struct__create("g");
    TYPE_STRUCT_ADD_MULTIPLE(tg, tf, "_", tr32, "__", te, "___", tc, "____");

    typedef se_t sh_t[37];
    type_array_t* th = type_array__create("h", (type_t*) te, 37);

    typedef union si {
        sh_t _;
        sf_t __;
    } si_t;
    type_union_t* ti = type_union__create("i");
    TYPE_UNION_ADD_MULTIPLE(ti, th, "_", tf, "__");

#pragma pack(push, 1)
    typedef struct sj {
        ss32_t _;
        ss8_t  __;
    } sj_t;
#pragma pack()
    type_struct_t* tj = type_struct__create("j");
    TYPE_STRUCT_ADD_MULTIPLE(tj, ts32, "_", ts8, "__");
    type__set_max_alignment((type_t*) tj, 1);

    typedef struct sk  {
        sj_t _;
        si_t __;
    } ALIGN(1024) sk_t;
    typedef struct sk sk_t;
    type_struct_t* tk = type_struct__create("k");
    TYPE_STRUCT_ADD_MULTIPLE(tk, tj, "_", ti, "__");
    type__set_alignment((type_t*) tk, 1024);

#pragma pack(push, 1)
    typedef struct sl {
        sk_t _;
        si_t __;
    } sl_t;
#pragma pack()

    type_struct_t* tl = type_struct__create("l");
    TYPE_STRUCT_ADD_MULTIPLE(tl, tk, "_", ti, "__");
    type__set_max_alignment((type_t*) tl, 1);

    typedef struct sm {
        ss8_t _;
        sj_t  __;
    } sm_t;
    type_struct_t* tm = type_struct__create("m");
    TYPE_STRUCT_ADD_MULTIPLE(tm, ts8, "_", tj, "__");

    typedef ss8_t sn_t[73];
    type_array_t* tn = type_array__create("n", (type_t*) ts8, 73);

    typedef struct so {
        sn_t _;
    } so_t;
    type_struct_t* to = type_struct__create("o");
    TYPE_STRUCT_ADD_MULTIPLE(to, tn, "_");

    typedef struct sp {
        so_t _;
        sj_t __;
        sm_t ___;
    } sp_t;
    type_struct_t* tp = type_struct__create("p");
    TYPE_STRUCT_ADD_MULTIPLE(tp, to, "_", tj, "__", tm, "___");

    typedef sp_t sq_t[13];
    type_array_t* tq = type_array__create("q", (type_t*) tp, 13);

    sizeof(sp_t);

    typedef struct sr {
        ss8_t  _;
        sq_t   __;
        ss32_t ___;
        sp_t   ____;
        so_t   _____;
    } sr_t;
    type_struct_t* tr = type_struct__create("r");
    TYPE_STRUCT_ADD_MULTIPLE(tr, ts8, "_", tq, "__", ts32, "___", tp, "____", to, "_____");

    typedef sp_t ss_t[39];
    type_array_t* ts = type_array__create("s", (type_t*) tp, 39);

    typedef ss8_t st_t[7];
    type_array_t* tt = type_array__create("t", (type_t*) ts8, 7);

    typedef st_t su_t[39];
    type_array_t* tu = type_array__create("u", (type_t*) tt, 39);

    typedef struct sv {
        ss_t _;
        su_t __;
    } sv_t;
    type_struct_t* tv = type_struct__create("v");
    TYPE_STRUCT_ADD_MULTIPLE(tv, ts, "__", tu, "___");

    typedef sr_t sw_t[73];
    type_array_t* tw = type_array__create("w", (type_t*) tr, 73);

    typedef struct sx {
        st_t   _;
        ss16_t __;
    } sx_t;
    type_struct_t* tx = type_struct__create("x");
    TYPE_STRUCT_ADD_MULTIPLE(tx, tt, "__", ts16, "___");

    typedef sx_t sy_t[39];
    type_array_t* ty = type_array__create("y", (type_t*) tx, 39);

    typedef struct sz {
        sv_t _;
        sr_t __;
        sy_t ___;
    } sz_t;
    type_struct_t* tz = type_struct__create("z");
    TYPE_STRUCT_ADD_MULTIPLE(tz, tv, "__", tr, "___", ty, "____");

    typedef union s1 {
        ss32_t _;
        sr64_t __;
        sz_t   ___;
    } s1_t;
    type_union_t* t1 = type_union__create("1");
    TYPE_UNION_ADD_MULTIPLE(t1, ts32, "__", tr64, "___", tz, "____");

    typedef struct s2 {
        s1_t _;
    } s2_t;
    type_struct_t* t2 = type_struct__create("2");
    TYPE_STRUCT_ADD_MULTIPLE(t2, t1, "_");

    typedef struct s3 {
        so_t _;
        sj_t __;
        sr_t ___;
    } s3_t;
    type_struct_t* t3 = type_struct__create("3");
    TYPE_STRUCT_ADD_MULTIPLE(t3, to, "_", tj, "__", tr, "___");

    typedef union s4 {
        sm_t _;
        s3_t __;
        sp_t ___;
        sr_t ____;
        sz_t _____;
    } s4_t;
    type_union_t* t4 = type_union__create("4");
    TYPE_UNION_ADD_MULTIPLE(t4, tm, "_", t3, "__", tp, "___", tr, "____", tz, "_____");

    typedef struct s5 {
        s4_t _;
        so_t __;
        sp_t ___;
        sr_t ____;
        s2_t _____;
    } s5_t;
    type_struct_t* t5 = type_struct__create("5");
    TYPE_STRUCT_ADD_MULTIPLE(t5, t4, "_", to, "__", tp, "___", tr, "____", t2, "____");

    typedef so_t s6_t[902];
    type_array_t* t6 = type_array__create("6", (type_t*)to, 902);

    typedef union s7 {
        sj_t _;
        s6_t __;
        sr_t ___;
    } s7_t;
    type_union_t* t7 = type_union__create("7");
    TYPE_UNION_ADD_MULTIPLE(t7, tj, "_", t6, "__", tr, "___");

    typedef sp_t s8_t[39];
    type_array_t* t8 = type_array__create("8", (type_t*)tp, 39);

    typedef struct s9 {
        s5_t _;
        s8_t __;
        s7_t ___;
    } s9_t;
    type_struct_t* t9 = type_struct__create("9");
    TYPE_STRUCT_ADD_MULTIPLE(t9, t5, "_", t8, "__", t7, "___");

    typedef s7_t s10_t[32];
    type_array_t* t10 = type_array__create("10", (type_t*)t7, 32);

    typedef s9_t s11_t[50];
    type_array_t* t11 = type_array__create("11", (type_t*)t9, 50);

    typedef s7_t s12_t[39];
    type_array_t* t12 = type_array__create("12", (type_t*)t7, 39);

#pragma pack(push, 1)
    typedef union s13 {
        s11_t _;
        s12_t __;
    } s13_t;
#pragma pack()
    type_union_t* t13 = type_union__create("13");
    TYPE_UNION_ADD_MULTIPLE(t13, t11, "_", t12, "__");
    type__set_max_alignment((type_t*) t13, 1);

    struct s14 {
        s10_t _;
        s13_t __;
    } ALIGN(1024);
    typedef struct s14 s14_t;
    type_struct_t* t14 = type_struct__create("14");
    TYPE_STRUCT_ADD_MULTIPLE(t14, t10, "_", t13, "__");
    type__set_alignment((type_t*)t14, 1024);

    typedef ss8_t s15_t;
    type_atom_t* t15 = type_atom__create("15", "15", sizeof(ss8_t), &_type__print_value_s8);

/*
    sj  -> a
    sm  -> b
    so  -> c
    sp  -> d
    sr  -> e
    sz  -> f
    s2  -> g
    s4  -> h
    s5  -> i
    s7  -> j
    s9  -> k
    s14 -> l
*/
    typedef sj_t  s16_t[1];
    type_array_t* t16 = type_array__create("16", (type_t*)tj, 1);
    typedef sm_t  s17_t[2];
    type_array_t* t17 = type_array__create("17", (type_t*)tm, 2);
    typedef sn_t  s18_t[3];
    type_array_t* t18 = type_array__create("18", (type_t*)to, 3);
    typedef sp_t  s19_t[4];
    type_array_t* t19 = type_array__create("19", (type_t*)tp, 4);
    typedef sr_t  s20_t[5];
    type_array_t* t20 = type_array__create("20", (type_t*)tr, 5);
    typedef sz_t  s21_t[6];
    type_array_t* t21 = type_array__create("21", (type_t*)tz, 6);
    typedef s2_t  s22_t[7];
    type_array_t* t22 = type_array__create("22", (type_t*)t2, 7);
    typedef s4_t  s23_t[8];
    type_array_t* t23 = type_array__create("23", (type_t*)t4, 8);
    typedef s5_t  s24_t[9];
    type_array_t* t24 = type_array__create("24", (type_t*)t5, 9);
    typedef s7_t  s25_t[10];
    type_array_t* t25 = type_array__create("25", (type_t*)t7, 10);
    typedef s9_t  s26_t[11];
    type_array_t* t26 = type_array__create("26", (type_t*)t9, 11);
    typedef s14_t s27_t[12];
    type_array_t* t27 = type_array__create("27", (type_t*)t14, 12);

#pragma pack(push, 1)
    struct s28 {
        s16_t  _;
        s17_t  __;
        s18_t  ___;
        s19_t  ____;
        s20_t  _____;
        s21_t  ______;
        s22_t  _______;
        s23_t  ________;
        s24_t  _________;
        s25_t  __________;
        s26_t  ___________;
        s27_t ____________;
    } ALIGN(4096);
    typedef struct s28 s28_t;
#pragma pack()

    type_struct_t* t28 = type_struct__create("28");
    TYPE_STRUCT_ADD_MULTIPLE(
        t28,
        t16, "_",
        t17, "__",
        t18, "___",
        t19, "____",
        t20, "_____",
        t21, "______",
        t22, "_______",
        t23, "________",
        t24, "_________",
        t25, "__________",
        t26, "___________",
        t27, "____________"
    );
    type__set_max_alignment((type_t*) t28, 1);
    type__set_alignment((type_t*) t28, 4096);

    typedef ss32_t s29_t ALIGN(4);
    type_atom_t* t29 = type_atom__create("29", "29", sizeof(s29_t), &_type__print_value_s32);
    type__set_alignment((type_t*) t29, 4);

    typedef s29_t s30_t[7];
    type_array_t* t30 = type_array__create("30", (type_t*) t29, 7);

#pragma pack(push, 1)
    typedef struct s31 {
        s30_t _;
    } s31_t;
#pragma pack()

    type_struct_t* t31 = type_struct__create("31");
    type_struct__add(t31, (type_t*) t30, "_");
    type__set_max_alignment((type_t*) t31, 1);

    struct s32 {
        ss8_t _;
    } ALIGN(2048);
    typedef struct s32 s32_t;
    type_struct_t* t32 = type_struct__create("32");
    type_struct__add(t32, (type_t*) ts8, "_");
    type__set_alignment((type_t*) t32, 2048);

    typedef ss8_t s33_t ALIGN(4);
    type_atom_t* t33 = type_atom__create("33", "33", sizeof(ss8_t), &_type__print_value_s8);
    type__set_alignment((type_t*) t33, 4);

    enum s34 {
        S34_YO,
        S34_SUP = -1,
        S34_WAT,
        S34_NOPE
    };
    typedef enum s34 s34_t;
    type_enum_t* t34 = type_enum__create("34");
    type_enum__add(t34, "S34_YO");
    type_enum__add_with_value(t34, "S34_SUP", -1);
    type_enum__add(t34, "S34_WAT");
    type_enum__add(t34, "S34_NOPE");

    enum s35 {
        S35_1 = -10,
        S35_2,
        S35_3,
        S35_4
    };
    typedef enum s35 s35_t ALIGN(4096);
    type_enum_t* t35 = type_enum__create("35");
    type_enum__add_with_value(t35, "S35_1", -10);
    type_enum__add(t35, "S35_2");
    type_enum__add(t35, "S35_3");
    type_enum__add(t35, "S35_4");
    type__set_alignment((type_t*) t35, 4096);

    TEST_TYPE(stdout, s8);
    TEST_TYPE(stdout, s16);
    TEST_TYPE(stdout, s32);
    TEST_TYPE(stdout, s64);
    TEST_TYPE(stdout, u8);
    TEST_TYPE(stdout, u16);
    TEST_TYPE(stdout, u32);
    TEST_TYPE(stdout, u64);
    TEST_TYPE(stdout, r32);
    TEST_TYPE(stdout, r64);
    TEST_TYPE(stdout, a);
    TEST_TYPE(stdout, b);
    TEST_TYPE(stdout, c);
    TEST_TYPE(stdout, d);
    TEST_TYPE(stdout, e);
    TEST_TYPE(stdout, f);
    TEST_TYPE(stdout, g);
    TEST_TYPE(stdout, h);
    TEST_TYPE(stdout, i);
    TEST_TYPE(stdout, j);
    TEST_TYPE(stdout, k);
    TEST_TYPE(stdout, l);
    TEST_TYPE(stdout, m);
    TEST_TYPE(stdout, n);
    TEST_TYPE(stdout, o);
    TEST_TYPE(stdout, p);
    TEST_TYPE(stdout, q);
    TEST_TYPE(stdout, r);
    TEST_TYPE(stdout, s);
    TEST_TYPE(stdout, t);
    TEST_TYPE(stdout, u);
    TEST_TYPE(stdout, v);
    TEST_TYPE(stdout, w);
    TEST_TYPE(stdout, x);
    TEST_TYPE(stdout, y);
    TEST_TYPE(stdout, z);
    TEST_TYPE(stdout, 1);
    TEST_TYPE(stdout, 2);
    TEST_TYPE(stdout, 3);
    TEST_TYPE(stdout, 4);
    TEST_TYPE(stdout, 5);
    TEST_TYPE(stdout, 6);
    TEST_TYPE(stdout, 7);
    TEST_TYPE(stdout, 8);
    TEST_TYPE(stdout, 9);
    TEST_TYPE(stdout, 10);
    TEST_TYPE(stdout, 11);
    TEST_TYPE(stdout, 12);
    TEST_TYPE(stdout, 13);
    TEST_TYPE(stdout, 14);
    TEST_TYPE(stdout, 15);
    TEST_TYPE(stdout, 16);
    TEST_TYPE(stdout, 17);
    TEST_TYPE(stdout, 18);
    TEST_TYPE(stdout, 19);
    TEST_TYPE(stdout, 20);
    TEST_TYPE(stdout, 21);
    TEST_TYPE(stdout, 22);
    TEST_TYPE(stdout, 23);
    TEST_TYPE(stdout, 24);
    TEST_TYPE(stdout, 25);
    TEST_TYPE(stdout, 26);
    TEST_TYPE(stdout, 27);
    TEST_TYPE(stdout, 28);
    TEST_TYPE(stdout, 29);
    TEST_TYPE(stdout, 30);
    TEST_TYPE(stdout, 31);
    TEST_TYPE(stdout, 32);
    TEST_TYPE(stdout, 33);
    TEST_TYPE(stdout, 34);
    TEST_TYPE(stdout, 35);

    sb_t isb_a = {
        ._ = 3,
        .__ = -38563
    };
    type__print((type_t*) tb, stdout, 2, 5, (uint8_t*) &isb_a);
    printf("\n");

    sg_t isg_a = {
        ._ = (void*) 0xabab,
        .__ = 23.14f,
        .___ = {
            ._ = -231,
            .__ = 76,
            .___ = 4329743792
        },
        .____ = {
            ._ = -23854,
            .__ = -34
        }
    };
    type__print((type_t*) tg, stdout, 2, -1, (uint8_t*) &isg_a);
    printf("\n");

    sd_t isd_a = { -3, 72, -120 };
    type__print((type_t*) td, stdout, 2, -1, (uint8_t*) &isd_a);
    printf("\n");

    return 0;
}
