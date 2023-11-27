#include "hash_set.h"

#include "debug.h"

#include <assert.h>
#include <string.h>

enum hash_set_entry_type {
    HASH_SET_ENTRY_TYPE_EMPTY,
    HASH_SET_ENTRY_TYPE_TOMBSTONE,
    HASH_SET_ENTRY_TYPE_NON_EMPTY
};

// note: instead of storing entries in one node, separate entry from data
// [type, key][type, key][type, key] -> [type][type][type][key][key][key]
// this would decrease cache locality to find something in the hash table, but allow data to be contiguous

typedef struct hash_set_key {
    enum hash_set_entry_type type;
    // ... key
} _hash_set_key_t;

static uint32_t _hash_set__entry_size(hash_set_t* self);
static _hash_set_key_t* hash_set__at(hash_set_t* self, uint32_t index);
static _hash_set_key_t* hash_set__key_to_internal_key(hash_set_key_t* key);
static hash_set_key_t* hash_set__internal_key_to_key(_hash_set_key_t* _key);
static _hash_set_key_t* _hash_set__find(hash_set_t* self, const hash_set_key_t* key);

static uint32_t _hash_set__entry_size(hash_set_t* self) {
    uint32_t result = sizeof(((_hash_set_key_t*)(0))->type) + self->size_of_key;
    return result;
}

static _hash_set_key_t* hash_set__at(hash_set_t* self, uint32_t index) {
    return (_hash_set_key_t*) ((char*) self->memory + _hash_set__entry_size(self) * index);
}

static _hash_set_key_t* hash_set__key_to_internal_key(hash_set_key_t* key) {
    return (_hash_set_key_t*) ((char*) key - sizeof(((_hash_set_key_t*)(0))->type));
}

static hash_set_key_t* hash_set__internal_key_to_key(_hash_set_key_t* _key) {
    return (hash_set_key_t*) ((char*) _key + sizeof(((_hash_set_key_t*)(0))->type));
}

static _hash_set_key_t* _hash_set__find(hash_set_t* self, const hash_set_key_t* key) {
    const uint32_t capacity = hash_set__capacity(self);
    uint32_t index = self->hash_fn(key) % capacity;
    const uint32_t start_index = index;
    _hash_set_key_t* tombstone = NULL;
    while (true) {
        _hash_set_key_t* _found_key = hash_set__at(self, index);
        switch (_found_key->type) {
            case HASH_SET_ENTRY_TYPE_EMPTY: {
                return tombstone ? tombstone : _found_key;
            } break ;
            case HASH_SET_ENTRY_TYPE_TOMBSTONE: {
                if (!tombstone) {
                    tombstone = _found_key;
                }
            } break ;
            case HASH_SET_ENTRY_TYPE_NON_EMPTY: {
                if (self->eq_fn(key, hash_set__internal_key_to_key(_found_key))) {
                    return _found_key;
                }
            } break ;
            default: ASSERT(false);
        }
        
        index = (index + 1) % capacity;
        if (index == start_index) {
            // full
            return NULL;
        }
    }

    ASSERT(false);
}

uint32_t hash_set__entry_size(uint32_t size_of_key) {
    return sizeof(_hash_set_key_t) + size_of_key;
}

uint32_t hash_set__hash_fn_string(const hash_set_key_t* string_key) {
    const char* _string_ky = *(const char**) string_key;
    uint32_t result = 0;
    
    while (*_string_ky != '\0') {
        result += *_string_ky++;
    }

    return result;
}

bool hash_set__eq_fn_string(const hash_set_key_t* string_key_a, const hash_set_key_t* string_key_b) {
    const char* _string_key_a = *(const char**) string_key_a;
    const char* _string_key_b = *(const char**) string_key_b;

    return strcmp(_string_key_a, _string_key_b) == 0;
}

bool hash_set__create(hash_set_t* self, void* memory, uint64_t memory_size, uint32_t size_of_key, uint32_t (*hash_fn)(const hash_set_key_t*), bool (*eq_fn)(const hash_set_key_t*, const hash_set_key_t*)) {
    self->size_of_key = size_of_key;
    self->memory = memory;
    self->memory_size = memory_size;
    self->fill = 0;
    self->hash_fn = hash_fn;
    self->eq_fn = eq_fn;

    if (hash_set__capacity(self) == 0) {
        return false;
    }

    hash_set__clear(self);

    return true;
}

hash_set_key_t* hash_set__insert(hash_set_t* self, const hash_set_key_t* key) {
    _hash_set_key_t* _found_key = _hash_set__find(self, key);
    if (_found_key == NULL) {
        // full
        return NULL;
    }

    if (_found_key->type != HASH_SET_ENTRY_TYPE_NON_EMPTY) {
        ++self->fill;
    }

    _found_key->type = HASH_SET_ENTRY_TYPE_NON_EMPTY;
    hash_set_key_t* found_key = hash_set__internal_key_to_key(_found_key);
    memcpy(found_key, key, self->size_of_key);

    return found_key;
}

bool hash_set__remove(hash_set_t* self, const hash_set_key_t* key) {
    if (self->fill == 0) {
        return false;
    }

    hash_set_key_t* found_key = hash_set__find(self, key);
    if (found_key == NULL) {
        return false;
    }

    _hash_set_key_t* _key = hash_set__key_to_internal_key(found_key);
    ASSERT(_key->type == HASH_SET_ENTRY_TYPE_NON_EMPTY);

    _key->type = HASH_SET_ENTRY_TYPE_TOMBSTONE;
    --self->fill;

    return true;
}

uint32_t hash_set__size(hash_set_t* self) {
    return self->fill;
}

uint32_t hash_set__capacity(hash_set_t* self) {
    return self->memory_size / _hash_set__entry_size(self);
}

void hash_set__clear(hash_set_t* self) {
    self->fill = 0;
    const uint32_t capacity = hash_set__capacity(self);
    for (uint32_t index = 0; index < capacity; ++index) {
        _hash_set_key_t* _key = hash_set__at(self, index);
        _key->type = HASH_SET_ENTRY_TYPE_EMPTY;
    }
}

hash_set_key_t* hash_set__find(hash_set_t* self, const hash_set_key_t* key) {
    if (self->fill == 0) {
        return NULL;
    }

    _hash_set_key_t* _found_key = _hash_set__find(self, key);
    if (_found_key == NULL || _found_key->type != HASH_SET_ENTRY_TYPE_NON_EMPTY) {
        return NULL;
    }

    hash_set_key_t* found_key = hash_set__internal_key_to_key(_found_key);
    if (self->eq_fn(key, found_key)) {
        return found_key;
    }

    return NULL;
}

hash_set_key_t* hash_set__begin(hash_set_t* self) {
    hash_set_key_t* end = hash_set__end(self);
    _hash_set_key_t* _end = hash_set__key_to_internal_key(end);
    _hash_set_key_t* _key = self->memory;

    while (_key != _end) {
        if (_key->type == HASH_SET_ENTRY_TYPE_NON_EMPTY) {
            return hash_set__internal_key_to_key(_key);
        }
        _key = (_hash_set_key_t*) ((char*) _key + _hash_set__entry_size(self));
    }

    return end;
}

hash_set_key_t* hash_set__next(hash_set_t* self, hash_set_key_t* key) {
    hash_set_key_t* end = hash_set__end(self);
    _hash_set_key_t* _end = hash_set__key_to_internal_key(end);
    _hash_set_key_t* _key = hash_set__key_to_internal_key(key);

    while (_key != _end) {
        _key = (_hash_set_key_t*) ((char*) _key + _hash_set__entry_size(self));
        if (_key == _end) {
            return end;
        }
        if (_key->type == HASH_SET_ENTRY_TYPE_NON_EMPTY) {
            return hash_set__internal_key_to_key(_key);
        }
    }

    return end;
}

hash_set_key_t* hash_set__end(hash_set_t* self) {
    _hash_set_key_t* _end = hash_set__at(self, hash_set__capacity(self));
    return hash_set__internal_key_to_key(_end);
}
