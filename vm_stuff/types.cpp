#include <time.h>
#include <stdlib.h>
#include <ASSERT.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <cstdlib>

using namespace std;

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

static type_t* _type__create(const char* abbreviated_name, uint64_t size) {
    type_t* result = calloc(1, size);

    strncpy(result->abbreviated_name, abbreviated_name, sizeof(result->abbreviated_name));

    return result;
}

static void _type_struct__update_member(type_struct_t* self, member_t* new_member) {
    if (self->base.type_specifier != TYPE_UNION && self->base.type_specifier != TYPE_STRUCT) {
        ASSERT(false);
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
        ASSERT(self->biggest_aligned_member == NULL);
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

type_atom_t* type_atom__create(const char* abbreviated_name, const char* name, uint64_t size) {
    type_atom_t* result = (type_atom_t*) _type__create(abbreviated_name, sizeof(*result));

    result->base.type_specifier = TYPE_ATOM;
    result->base.alignment = size;
    result->base.max_alignment = UNSET_MAX_ALIGNMENT;
    result->base.size = size;

    strncpy(result->name, name, sizeof(result->name));

    return result;
}

void type__set_max_alignment(type_t* self, uint64_t max_alignment) {
    if (max_alignment != UNSET_MAX_ALIGNMENT) {
        ASSERT(is_pow_of_two(max_alignment));
        ASSERT(max_alignment <= 16);
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
    if (self->type_specifier == TYPE_ARRAY) {
        if (type__size(self) < alignment) {
            ASSERT(false && "error: alignment of array elements is greater than element size");
        }
    }

    if (alignment != UNSET_MAX_ALIGNMENT) {
        ASSERT(is_pow_of_two(alignment));
    }

    self->alignment = alignment;
    type__set_max_alignment(self, UNSET_MAX_ALIGNMENT);
}

uint64_t type__alignment(type_t* self) {
    return self->alignment;
}

uint64_t type__size(type_t* self) {
    // must be padded at the end so that the total size is divisible by the alignment number
    uint64_t pad_for_self = self->size % self->alignment;
    if (pad_for_self) {
        return self->size + (self->alignment - pad_for_self);
    } else {
        return self->size;
    }
}

const char* type__abbreviated_name(type_t* self) {
    return self->abbreviated_name;
}

member_t* type_struct__access_member(type_struct_t* self, const char* name) {
    for (uint32_t member_index = 0; member_index < self->members_top; ++member_index) {
        if (strcmp(self->members[member_index].name, name) == 0) {
            return &self->members[member_index];
        }
    }

    return NULL;
}

member_t* type_union__access_member(type_union_t* self, const char* name) {
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

    ASSERT(self->members_top != self->members_size);
    new_member = &self->members[self->members_top++];
    new_member->name = member_name;
    new_member->type = member_type;
    new_member->offset = 0;
    ASSERT(new_member);

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

    ASSERT(self->members_top != self->members_size);
    new_member = &self->members[self->members_top++];
    new_member->name = member_name;
    new_member->type = member_type;
    new_member->offset = 0;
    ASSERT(new_member);

    _type_union__update_member(self, new_member);
}

type_array_t* type_array__create(const char* abbreviated_name, type_t* member, uint64_t n) {
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

uint64_t type__max_alignment(type_t* self) {
    return self->max_alignment;
}

static void _type__print_name(type_t* self, FILE* fp, uint32_t number_of_expansions, uint64_t offset) {
    if (number_of_expansions == 0) {
        fprintf(fp, "%s", self->abbreviated_name, offset);
        return ;
    }

    ASSERT(
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
                ASSERT(
                    offset % type__alignment(type_struct->members[member_index].type) == 0 ||
                    offset % type__max_alignment(self) == 0
                );

                _type__print_name(type_struct->members[member_index].type, fp, number_of_expansions - 1, offset);
                fprintf(fp, " %s", type_struct->members[member_index].name);
                fprintf(fp, " %llu", offset);
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
            _type__print_name(type_array->element_type, fp, number_of_expansions - 1, offset + type__size(self));
            fprintf(fp, "]");
        } break ;
        case TYPE_POINTER: {
            type_pointer_t* type_pointer = (type_pointer_t*) self;
            _type__print_name(type_pointer->pointed_type, fp, number_of_expansions - 1, offset);
            fprintf(fp, "*");
        } break ;
        default: ASSERT(false);
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

void type__print(type_t* self, FILE* fp, uint64_t n_of_name_expansions) {

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
static_ASSERT(sizeof(sr32_t) == 4);
typedef double   sr64_t;
static_ASSERT(sizeof(sr64_t) == 8);

#define REGULAR_PRINT(type) do { \
    char buffer[256]; \
    snprintf(buffer, sizeof(buffer), "sizeof(%s): ", #type); \
    printf("%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, buffer, sizeof(s ## type ## _t)); \
    snprintf(buffer, sizeof(buffer), "alignof(%s): ", #type); \
    printf("%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, buffer, __alignof__(s ## type ## _t)); \
    printf("\n"); \
} while (false)

#define TYPES_PRINT(fp, type, n_of_expansions) do { \
    type__print((type_t*) (t ## type), fp, n_of_expansions); \
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
    ASSERT(sizeof(s ## type ## _t) == type__size((type_t*)(t ## type))); \
    ASSERT(ALIGNOF(s ## type ## _t) == (t ## type)->base.alignment); \
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
    ASSERT(type);
    const char* name = va_arg(ap, const char*);
    ASSERT(name);
    do {
        type_struct__add(self, type, name);
        type = va_arg(ap, type_t*);
        if (!type) {
            break ;
        }
        name = va_arg(ap, const char*);
        ASSERT(name);
    } while (true);

    va_end(ap);
}

static void _type_union__add_multiple(type_union_t* self, ...) {
    va_list ap;
    va_start(ap, self);

    type_t* type = va_arg(ap, type_t*);
    ASSERT(type);
    const char* name = va_arg(ap, char*);
    ASSERT(name);
    do {
        type_union__add(self, type, name);
        type = va_arg(ap, type_t*);
        if (!type) {
            break ;
        }
        name = va_arg(ap, char*);
        ASSERT(name);
    } while (true);

    va_end(ap);
}

#define TYPE_STRUCT_ADD_MULTIPLE(self, ...) do { \
    _type_struct__add_multiple(self, __VA_ARGS__, NULL); \
} while (false)
#define TYPE_UNION_ADD_MULTIPLE(self, ...) do { \
    _type_union__add_multiple(self, __VA_ARGS__, NULL); \
} while (false)

instance_t* instance__create(const char* name, type_t* type, uint64_t requested_address) {
    instance_t* result = calloc(1, sizeof(*result));

    strncpy(result->name, name, sizeof(result->name));
    result->type = type;

    // todo: find suitable memory location in available stack/heap that satisfies the alignment requirement
    // address must be divisible by the alignment number
    uint64_t alignment = type__alignment(type);
    ASSERT(alignment);
    uint64_t offset = requested_address % alignment;
    if (offset) {
        requested_address += alignment - offset;
    }
    ASSERT(requested_address % alignment == 0);
    result->addr = requested_address;

    return result;
}

uint64_t instance__addr(instance_t* self) {
    return self->addr;
}

uint64_t instance__size(instance_t* self) {
    return type__size(self->type);
}

uint64_t instance__alignment(instance_t* self) {
    return type__alignment(self->type);
}

type_t* instance__type(instance_t* self) {
    return self->type;
}

void instance__print(instance_t* self, FILE* fp) {
    fprintf(fp, "%-*.*s%s\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "name: ", self->name);

    fprintf(fp, "%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "size: ", instance__size(self));

    fprintf(fp, "%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "alignment: ", instance__alignment(self));

    fprintf(fp, "%-*.*s%llu\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "address: ", instance__addr(self));

    fprintf(fp, "%-*.*s%s\n", FIRST_COL_OFFSET, FIRST_COL_OFFSET, "type: ", type__abbreviated_name(self->type));
}

int main2() {
    type_atom_t* ts8 =  type_atom__create("s8",  "s8",  sizeof(ss8_t));
    type_atom_t* ts16 = type_atom__create("s16", "s16", sizeof(ss16_t));
    type_atom_t* ts32 = type_atom__create("s32", "s32", sizeof(ss32_t));
    type_atom_t* ts64 = type_atom__create("s64", "s64", sizeof(ss64_t));
    type_atom_t* tu8 =  type_atom__create("u8",  "u8",  sizeof(su8_t));
    type_atom_t* tu16 = type_atom__create("u16", "u16", sizeof(su16_t));
    type_atom_t* tu32 = type_atom__create("u32", "u32", sizeof(su32_t));
    type_atom_t* tu64 = type_atom__create("u64", "u64", sizeof(su64_t));
    type_atom_t* tr32 = type_atom__create("r32", "r32", sizeof(sr32_t));
    type_atom_t* tr64 = type_atom__create("r64", "r64", sizeof(sr64_t));

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
    type_array_t* tn = type_array__create("n", (type_t*)ts8, 73);

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
    type_array_t* tq = type_array__create("q", (type_t*)tp, 13);

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
    type_array_t* ts = type_array__create("s", (type_t*)tp, 39);

    typedef ss8_t st_t[7];
    type_array_t* tt = type_array__create("t", (type_t*)ts8, 7);

    typedef st_t su_t[39];
    type_array_t* tu = type_array__create("u", (type_t*)tt, 39);

    typedef struct sv {
        ss_t _;
        su_t __;
    } sv_t;
    type_struct_t* tv = type_struct__create("v");
    TYPE_STRUCT_ADD_MULTIPLE(tv, ts, "__", tu, "___");

    typedef sr_t sw_t[73];
    type_array_t* tw = type_array__create("w", (type_t*)tr, 73);

    typedef struct sx {
        st_t   _;
        ss16_t __;
    } sx_t;
    type_struct_t* tx = type_struct__create("x");
    TYPE_STRUCT_ADD_MULTIPLE(tx, tt, "__", ts16, "___");

    typedef sx_t sy_t[39];
    type_array_t* ty = type_array__create("y", (type_t*)tx, 39);

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

    typedef struct s14 {
        s10_t _;
        s13_t __;
    } ALIGN(1024) s14_t;
    type_struct_t* t14 = type_struct__create("14");
    TYPE_STRUCT_ADD_MULTIPLE(t14, t10, "_", t13, "__");
    type__set_alignment((type_t*)t14, 1024);

    typedef ss8_t s15_t;
    type_atom_t* t15 = type_atom__create("15", "15", sizeof(ss8_t));

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
    typedef struct s28 {
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
    } ALIGN(4096) s28_t;
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

    instance_t* ia = instance__create("a", (type_t*) t27, 1234);
    instance__print(ia, stdout);
    printf("\n");

    instance_t* ib = instance__create("b", (type_t*) t28, 98273);
    instance__print(ib, stdout);
    printf("\n");

    char buffer[64];
    uint32_t buffer_index = 0;
    buffer[buffer_index++] = '_';
    buffer[buffer_index] = '\0';
    member_t* t28_member = type_struct__access_member(t28, buffer);
    while (t28_member && buffer_index < sizeof(buffer) - 1) {
        member__print(t28_member, stdout);
        printf("\n");

        buffer[buffer_index++] = '_';
        buffer[buffer_index] = '\0';
        t28_member = type_struct__access_member(t28, buffer);
    }

    return 0;
}
