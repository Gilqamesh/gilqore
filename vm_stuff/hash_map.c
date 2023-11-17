#include "hash_map.h"

#include <assert.h>
#include <string.h>

enum hash_map_entry_type {
    HASH_MAP_ENTRY_TYPE_EMPTY,
    HASH_MAP_ENTRY_TYPE_TOMBSTONE,
    HASH_MAP_ENTRY_TYPE_NON_EMPTY
};

// note: instead of storing entries in one node, separate entry from data
// [type, key, value][type, key, value][type, key, value] -> [type][type][type][key][key][key][value][value][value]
// this would decrease cache locality to find something in the hash table, but allow data to be contiguous

typedef struct _hash_map_entry {
    enum hash_map_entry_type type;
    // ... key
    // ... value
} _hash_map_entry_t;

static uint32_t _hash_map__entry_size(hash_map_t* self);
static _hash_map_entry_t* hash_map__at(hash_map_t* self, uint32_t index);
static _hash_map_entry_t* hash_map__key_to_internal_entry(hash_map_key_t* key);
static _hash_map_entry_t* hash_map__value_to_internal_entry(hash_map_t* self, hash_map_value_t* value);
static hash_map_key_t* hash_map__internal_entry_to_key(_hash_map_entry_t* _entry);
static hash_map_value_t* hash_map__internal_entry_to_value(hash_map_t* self, _hash_map_entry_t* _entry);
static _hash_map_entry_t* _hash_map__find(hash_map_t* self, const hash_map_key_t* key);

static uint32_t _hash_map__entry_size(hash_map_t* self) {
    uint32_t result = sizeof(((_hash_map_entry_t*)(0))->type) + self->size_of_key + self->size_of_value;
    return result;
}

static _hash_map_entry_t* hash_map__at(hash_map_t* self, uint32_t index) {
    return (_hash_map_entry_t*) ((char*) self->memory + _hash_map__entry_size(self) * index);
}

static _hash_map_entry_t* hash_map__key_to_internal_entry(hash_map_key_t* key) {
    return (_hash_map_entry_t*) ((char*) key - sizeof(((_hash_map_entry_t*)(0))->type));
}

static _hash_map_entry_t* hash_map__value_to_internal_entry(hash_map_t* self, hash_map_value_t* value) {
    return (_hash_map_entry_t*) ((char*) value - self->size_of_key - sizeof(((_hash_map_entry_t*)(0))->type));
}

static hash_map_key_t* hash_map__internal_entry_to_key(_hash_map_entry_t* _entry) {
    return (hash_map_key_t*)((char*) _entry + sizeof(((_hash_map_entry_t*)(0))->type));
}

static hash_map_value_t* hash_map__internal_entry_to_value(hash_map_t* self, _hash_map_entry_t* _entry) {
    return (hash_map_value_t*)((char*) _entry + sizeof(((_hash_map_entry_t*)(0))->type) + self->size_of_key);
}

static _hash_map_entry_t* _hash_map__find(hash_map_t* self, const hash_map_key_t* key) {
    const uint32_t capacity = hash_map__capacity(self);
    uint32_t index = self->hash_fn(key) % capacity;
    const uint32_t start_index = index;
    _hash_map_entry_t* tombstone = NULL;
    while (true) {
        _hash_map_entry_t* _entry = hash_map__at(self, index);
        switch (_entry->type) {
            case HASH_MAP_ENTRY_TYPE_EMPTY: {
                return tombstone ? tombstone : _entry;
            } break ;
            case HASH_MAP_ENTRY_TYPE_TOMBSTONE: {
                if (!tombstone) {
                    tombstone = _entry;
                }
            } break ;
            case HASH_MAP_ENTRY_TYPE_NON_EMPTY: {
                if (self->eq_fn(key, hash_map__internal_entry_to_key(_entry))) {
                    return _entry;
                }
            } break ;
            default: assert(false);
        }
        
        index = (index + 1) % capacity;
        if (index == start_index) {
            // full
            return NULL;
        }
    }

    assert(false);
    return 0;
}

uint32_t hash_map__entry_size(uint32_t size_of_key, uint32_t size_of_value) {
    return sizeof(_hash_map_entry_t) + size_of_key + size_of_value;
}

bool hash_map__create(hash_map_t* self, void* memory, uint64_t memory_size, uint32_t size_of_key, uint32_t size_of_value, uint32_t (*hash_fn)(const hash_map_key_t*), bool (*eq_fn)(const hash_map_key_t*, const hash_map_key_t*)) {
    self->size_of_key = size_of_key;
    self->size_of_value = size_of_value;
    self->memory = memory;
    self->memory_size = memory_size;
    self->fill = 0;
    self->hash_fn = hash_fn;
    self->eq_fn = eq_fn;

    if (hash_map__capacity(self) == 0) {
        return false;
    }

    hash_map__clear(self);

    return true;
}

hash_map_key_t* hash_map__insert(hash_map_t* self, const hash_map_key_t* key, const hash_map_value_t* value) {
    _hash_map_entry_t* _entry = _hash_map__find(self, key);
    if (_entry == NULL) {
        // full
        return NULL;
    }
    if (_entry->type != HASH_MAP_ENTRY_TYPE_NON_EMPTY) {
        ++self->fill;
    }

    hash_map_key_t* found_key = hash_map__internal_entry_to_key(_entry);
    hash_map_value_t* found_value = hash_map__internal_entry_to_value(self, _entry);
    _entry->type = HASH_MAP_ENTRY_TYPE_NON_EMPTY;
    memcpy(found_key, key, self->size_of_key);
    memcpy(found_value, value, self->size_of_value);

    return found_key;
}

bool hash_map__remove(hash_map_t* self, const hash_map_key_t* key) {
    if (self->fill == 0) {
        return false;
    }

    hash_map_value_t* found_value = hash_map__find(self, key);
    if (found_value == NULL) {
        return false;
    }

    _hash_map_entry_t* _entry = hash_map__value_to_internal_entry(self, found_value);
    assert(_entry->type == HASH_MAP_ENTRY_TYPE_NON_EMPTY);

    _entry->type = HASH_MAP_ENTRY_TYPE_TOMBSTONE;
    --self->fill;

    return true;
}

uint32_t hash_map__size(hash_map_t* self) {
    return self->fill;
}

uint32_t hash_map__capacity(hash_map_t* self) {
    return self->memory_size / _hash_map__entry_size(self);
}

void hash_map__clear(hash_map_t* self) {
    self->fill = 0;
    const uint32_t capacity = hash_map__capacity(self);
    for (uint32_t index = 0; index < capacity; ++index) {
        _hash_map_entry_t* _entry = hash_map__at(self, index);
        _entry->type = HASH_MAP_ENTRY_TYPE_EMPTY;
    }
}

hash_map_value_t* hash_map__find(hash_map_t* self, const hash_map_key_t* key) {
    if (self->fill == 0) {
        return NULL;
    }

    _hash_map_entry_t* _entry = _hash_map__find(self, key);
    if (_entry == NULL || _entry->type != HASH_MAP_ENTRY_TYPE_NON_EMPTY) {
        return NULL;
    }

    if (self->eq_fn(key, hash_map__internal_entry_to_key(_entry))) {
        return hash_map__internal_entry_to_value(self, _entry);
    }

    return NULL;
}

hash_map_key_t* hash_map__begin(hash_map_t* self) {
    hash_map_key_t* end = hash_map__end(self);
    _hash_map_entry_t* _end = hash_map__key_to_internal_entry(end);
    _hash_map_entry_t* _entry = self->memory;

    while (_entry != _end) {
        if (_entry->type == HASH_MAP_ENTRY_TYPE_NON_EMPTY) {
            return hash_map__internal_entry_to_key(_entry);
        }
        _entry = (_hash_map_entry_t*) ((char*) _entry + _hash_map__entry_size(self));
    }

    return end;
}

hash_map_key_t* hash_map__next(hash_map_t* self, hash_map_key_t* key) {
    hash_map_key_t* end = hash_map__end(self);
    _hash_map_entry_t* _end = hash_map__key_to_internal_entry(end);
    _hash_map_entry_t* _entry = hash_map__key_to_internal_entry(key);

    while (_entry != _end) {
        _entry = (_hash_map_entry_t*) ((char*) _entry + _hash_map__entry_size(self));
        if (_entry == _end) {
            return end;
        }
        if (_entry->type == HASH_MAP_ENTRY_TYPE_NON_EMPTY) {
            return hash_map__internal_entry_to_key(_entry);
        }
    }

    return end;
}

hash_map_key_t* hash_map__end(hash_map_t* self) {
    _hash_map_entry_t* _end = hash_map__at(self, hash_map__capacity(self));
    return hash_map__internal_entry_to_key(_end);
}

hash_map_value_t* hash_map__value(hash_map_t* self, hash_map_key_t* key) {
    return (hash_map_value_t*)((char*)key + self->size_of_key);
}
