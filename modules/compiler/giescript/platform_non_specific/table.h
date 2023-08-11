#ifndef GIES_TABLE_H
# define GIES_TABLE_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"
# include "value.h"

struct entry {
    value_t  key;
    value_t  value;
};

struct table {
    u32       fill;
    u32       size;
    entry_t*  entries;

    allocator_t* allocator;
};

void table__create(table_t* self, allocator_t* allocator);
void table__destroy(table_t* self);

// @returns true if a new entry is inserted
bool       table__insert(table_t* self, value_t key, value_t value);
// @returns entry in the table associated with the key
entry_t*   table__find(table_t* self, value_t key);
// @param out filled with the vaue of the key if key is found
// @returns true if the key is found
bool       table__get(table_t* self, value_t key, value_t* out);
// @returns true if key is found and deleted
bool       table__erase(table_t* self, value_t key);

obj_str_t* table__find_str(table_t* self, const char* bytes, u32 len, u32 hash);
obj_str_t* table__find_concat_str(table_t* self, value_t left, value_t right);

#endif // GIES_TABLE_H
