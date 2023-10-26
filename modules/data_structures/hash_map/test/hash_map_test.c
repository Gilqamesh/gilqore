#include "test_framework/test_framework.h"

#include "data_structures/hash_map/hash_map.h"
#include "libc/libc.h"

typedef struct entry {
    u32 key;
    u32 value;
} entry_t;

u32 hash_fn(const void* key) {
    return *(const u32*)key * 1337;
}

bool eq_fn(const void* key_a, const void* key_b) {
    return *(const u32*)key_a == *(const u32*)key_b;
}

void print_hash_map(hash_map_t* self) {
    hash_map_key_t* key = hash_map__begin(self);
    while (key != hash_map__end(self)) {
        libc__printf("Key: %u, Value: %u\n", *(u32*)key, *(u32*)hash_map__value(self, key));
        key = hash_map__next(self, key);
    }
}

int main() {
    const u32 map_memory_size = KILOBYTES(16);
    void* map_memory = libc__malloc(map_memory_size);

    hash_map_t hash_map;
    TEST_FRAMEWORK_ASSERT(hash_map__create(&hash_map, memory_slice__create(map_memory, map_memory_size), sizeof(u32), sizeof(u32), &hash_fn, &eq_fn));

    libc__printf("Hash map capacity: %u\n", hash_map__capacity(&hash_map));

    print_hash_map(&hash_map);

    u32 deleted_entries = 0;
    for (u32 data_index = 0; data_index < 128; ++data_index) {
        u32 key = data_index;
        u32 value = data_index * 125;
        hash_map__insert(&hash_map, &key, &value);
        TEST_FRAMEWORK_ASSERT(hash_map__size(&hash_map) == data_index + 1 - deleted_entries);
        if (data_index % 5 == 0) {
            u32 key_to_delete = deleted_entries;
            TEST_FRAMEWORK_ASSERT(hash_map__remove(&hash_map, &key_to_delete));
            ++deleted_entries;
        }
    }

    print_hash_map(&hash_map);

    libc__free(map_memory);

    return 0;
}
