#include "table.h"
#include "allocator.h"
#include "obj.h"
#include "value.h"

#include "libc/libc.h"
#include "algorithms/hash/hash.h"

#define TABLE_LOAD_FACTOR 0.75

static void table__ensure_size(table_t* self, u32 size);
static void table__copy(table_t* dst, table_t* src);

static void table__ensure_size(table_t* self, u32 size) {
    ASSERT(size > 0);

    table_t new_table;
    table__create(&new_table, self->allocator);
    new_table.size = size;
    new_table.entries = allocator__alloc(self->allocator, size * sizeof(*new_table.entries));
    entry_t* entry = new_table.entries;
    entry_t* last_entry = &new_table.entries[new_table.size];
    while (entry < last_entry) {
        entry->key = value__empty();
        entry->value = value__nil();
        ++entry;
    }

    table__copy(&new_table, self);

    table__destroy(self);

    self->allocator = new_table.allocator;
    self->entries = new_table.entries;
    self->fill = new_table.fill;
    self->size = new_table.size;
}

static void table__copy(table_t* dst, table_t* src) {
    if (src->size == 0) {
        return ;
    }

    entry_t* entry = &src->entries[0];
    entry_t* last_entry = &src->entries[src->size];
    while (entry < last_entry) {
        if (!value__is_empty(entry->key)) {
            table__insert(dst, entry->key, entry->value);
        }
        ++entry;
    }
}

void table__create(table_t* self, allocator_t* allocator) {
    self->entries = 0;
    self->fill = 0;
    self->size = 0;

    self->allocator = allocator;
}

void table__destroy(table_t* self) {
    if (self->entries) {
        allocator__free(self->allocator, self->entries);
    }

    libc__memset(self, 0, sizeof(*self));
}

bool table__insert(table_t* self, value_t key, value_t value) {
    ASSERT(!value__is_empty(key));

    if (self->fill + 1 > self->size * TABLE_LOAD_FACTOR) {
        u32 new_size = self->size < 8 ? 8 : self->size * 2;
        table__ensure_size(self, new_size);
    }

    bool is_new_entry = false;
    entry_t* entry = table__find(self, key);
    ASSERT(entry);
    if (value__is_empty(entry->key)) {
        // don't count tombstones as additional fills
        if (value__is_nil(entry->value)) {
            ++self->fill;
        }
        is_new_entry = true;
    }

    entry->key = key;
    entry->value = value;

    return is_new_entry;
}

entry_t* table__find(table_t* self, value_t key) {
    ASSERT(self->size > 0);

    u32 index = value__hash(key) % self->size;
    entry_t* tombstone  = NULL;
    while (true) {
        entry_t* entry = &self->entries[index];
        if (value__is_empty(entry->key)) {
            if (value__is_nil(entry->value)) {
                return tombstone ? tombstone : entry;
            } else {
                // found tombstone
                if (!tombstone) {
                    tombstone = entry;
                }
            }
        } else if (value__is_eq(entry->key, key)) {
            return entry;
        }

        index = (index + 1) % self->size;
    }

    ASSERT(false);
    UNREACHABLE_CODE;
}

bool table__get(table_t* self, value_t key, value_t* out) {
    if (self->fill == 0) {
        return false;
    }

    entry_t* entry = table__find(self, key);
    if (value__is_empty(entry->key)) {
        return false;
    }

    *out = entry->value;

    return true;
}

bool table__erase(table_t* self, value_t key) {
    if (self->fill == 0) {
        return false;
    }

    entry_t* entry = table__find(self, key);
    if (value__is_empty(entry->key)) {
        return false;
    }

    entry->key = value__empty();
    // mark it as a tombstone
    entry->value = value__bool(true);

    return true;
}


obj_str_t* table__find_str(table_t* self, const char* bytes, u32 len, u32 hash) {
    if (self->fill == 0) {
        return 0;
    }

    u32 index = hash % self->size;
    while (true) {
        entry_t* cur = &self->entries[index];
        if (value__is_empty(cur->key)) {
            // stop if an empty, non-tombstone entry is found
            if (value__is_nil(cur->value)) {
                return 0;
            }
        } else {
            if (obj__is_str(cur->key)) {
                obj_str_t* obj_str = obj__as_str(cur->key);
                if (
                    obj_str->len == len &&
                    obj_str->hash == hash &&
                    libc__memcmp(obj_str->str, bytes, len) == 0
                ) {
                    return obj_str;
                }
            }
        }

        index = (index + 1) % self->size;
    }

    ASSERT(false);
    UNREACHABLE_CODE;
}

obj_str_t* table__find_concat_str(table_t* self, value_t left, value_t right) {
    ASSERT(obj__is_str(left) && obj__is_str(right));
    if (self->fill == 0) {
        return 0;
    }

    obj_str_t* obj_str_left = obj__as_str(left);
    obj_str_t* obj_str_right = obj__as_str(right);
    u32 left_hash  = obj__hash(left);
    u32 right_hash = obj__hash(right);
    u32 hash       = hash__fnv_1a(obj_str_right->str, obj_str_right->len, left_hash);
    ASSERT((left_hash ^ right_hash) == hash);
    u32 index = hash % self->size;
    u32 len = obj_str_left->len + obj_str_right->len;
    while (true) {
        entry_t* cur = &self->entries[index];
        if (value__is_empty(cur->key)) {
            // stop if an empty, non-tombstone entry is found
            if (value__is_nil(cur->value)) {
                return 0;
            }
        } else {
            if (obj__is_str(cur->key)) {
                obj_str_t* obj_str = obj__as_str(cur->key);
                if (
                    obj_str->len == len &&
                    obj_str->hash == hash &&
                    libc__memcmp(obj_str->str, obj_str_left->str, obj_str_left->len) == 0 &&
                    libc__memcmp(obj_str->str + obj_str_left->len, obj_str_right->str, obj_str_right->len) == 0
                ) {
                    return obj_str;
                }
            }
        }

        index = (index + 1) % self->size;
    }

    ASSERT(false);
    UNREACHABLE_CODE;
}
