#ifndef HASH_SET_H
# define HASH_SET_H

# include "hash_set_defs.h"

# include "memory/memory.h"

typedef void hash_set_key_t;

// static hash_set
typedef struct hash_set {
    u32                 size_of_key;
    u32                 fill;
    memory_slice_t      memory;

    u32                 (*hash_fn)(const hash_set_key_t*);
    bool                (*eq_fn)(const hash_set_key_t*, const hash_set_key_t*);
} hash_set_t;

// use this to measure how much memory is necessary
uint32_t hash_set__entry_size(uint32_t size_of_key);

PUBLIC_API bool hash_set__create(hash_set_t* self, memory_slice_t max_memory, u32 size_of_key, u32 (*hash_fn)(const hash_set_key_t*), bool (*eq_fn)(const hash_set_key_t*, const hash_set_key_t*));

PUBLIC_API hash_set_key_t* hash_set__insert(hash_set_t* self, const hash_set_key_t* key);
PUBLIC_API bool hash_set__remove(hash_set_t* self, const hash_set_key_t* key);
PUBLIC_API void hash_set__clear(hash_set_t* self);

PUBLIC_API hash_set_key_t* hash_set__find(hash_set_t* self, const hash_set_key_t* key);

PUBLIC_API u32 hash_set__size(hash_set_t* self);
PUBLIC_API u32 hash_set__capacity(hash_set_t* self);

PUBLIC_API hash_set_key_t* hash_set__begin(hash_set_t* self);
PUBLIC_API hash_set_key_t* hash_set__next(hash_set_t* self, hash_set_key_t* key);
PUBLIC_API hash_set_key_t* hash_set__end(hash_set_t* self);

#endif // HASH_SET_H
