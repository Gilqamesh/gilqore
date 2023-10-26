#include "test_framework/test_framework.h"

#include "data_structures/hash_set/hash_set.h"
#include "libc/libc.h"

typedef struct entry {
    u32 key;
} entry_t;

u32 hash_fn(const hash_set_key_t* key) {
    return *(u32*)key * 1337;
}

bool eq_fn(const hash_set_key_t* key_a, const hash_set_key_t* key_b) {
    return *(u32*)key_a == *(u32*)key_b;
}

void print_hash_set(hash_set_t* hash_set) {
    hash_set_key_t* key = hash_set__begin(hash_set);
    while (key != hash_set__end(hash_set)) {
        libc__printf("Key: %u\n", *(u32*)key);
        key = hash_set__next(hash_set, key);
    }
}

int main() {
    const u32 table_memory_size = KILOBYTES(16);
    void* table_memory = libc__malloc(table_memory_size);

    hash_set_t hash_set;
    TEST_FRAMEWORK_ASSERT(hash_set__create(&hash_set, memory_slice__create(table_memory, table_memory_size), sizeof(u32), &hash_fn, &eq_fn));

    libc__printf("Hash table capacity: %u\n", hash_set__capacity(&hash_set));

    print_hash_set(&hash_set);

    u32 deleted_entries = 0;
    for (u32 data_index = 0; data_index < 128; ++data_index) {
        u32 data = data_index * 125;
        hash_set__insert(&hash_set, &data);
        TEST_FRAMEWORK_ASSERT(hash_set__size(&hash_set) == data_index + 1 - deleted_entries);
        if (data_index % 5 == 0) {
            u32 data_to_delete = deleted_entries * 125;
            TEST_FRAMEWORK_ASSERT(hash_set__remove(&hash_set, &data_to_delete));
            ++deleted_entries;
        }
    }

    print_hash_set(&hash_set);

    libc__free(table_memory);

    return 0;
}
