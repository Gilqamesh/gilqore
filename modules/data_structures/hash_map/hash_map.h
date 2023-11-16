#ifndef HASH_MAP_H
# define HASH_MAP_H

# include "hash_map_defs.h"

# include "memory/memory.h"

typedef void hash_map_key_t;
typedef void hash_map_value_t;

// static hash_map
typedef struct hash_map {
    u32                 size_of_key;
    u32                 size_of_value;
    u32                 fill;
    u32                 (*hash_fn)(const hash_map_key_t*);
    bool                (*eq_fn)(const hash_map_key_t*, const hash_map_key_t*);
    memory_slice_t      memory;
} hash_map_t;

// use this to measure how much memory is necessary
PUBLIC_API u32 hash_map__entry_size(u32 size_of_key, u32 size_of_value);

PUBLIC_API bool hash_map__create(hash_map_t* self, memory_slice_t max_memory, u32 size_of_key, u32 size_of_value, u32 (*hash_fn)(const hash_map_key_t*), bool (*eq_fn)(const hash_map_key_t*, const hash_map_key_t*));

PUBLIC_API hash_map_key_t* hash_map__insert(hash_map_t* self, hash_map_key_t* key, hash_map_value_t* value);
PUBLIC_API bool hash_map__remove(hash_map_t* self, hash_map_key_t* key);
PUBLIC_API void hash_map__clear(hash_map_t* self);
PUBLIC_API hash_map_value_t* hash_map__find(hash_map_t* self, hash_map_key_t* key);

PUBLIC_API u32 hash_map__size(hash_map_t* self);
PUBLIC_API u32 hash_map__capacity(hash_map_t* self);

PUBLIC_API hash_map_key_t* hash_map__begin(hash_map_t* self);
PUBLIC_API hash_map_key_t* hash_map__next(hash_map_t* self, hash_map_key_t* key);
PUBLIC_API hash_map_key_t* hash_map__end(hash_map_t* self);

PUBLIC_API hash_map_value_t* hash_map__value(hash_map_t* self, hash_map_key_t* key);

#endif // HASH_MAP_H
