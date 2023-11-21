#include "shared_lib.h"

#include <dlfcn.h>
#include <stdlib.h>

#include "debug.h"

void* shared_lib__sym(void* shared_lib_handle, const char* symbol) {
    return dlsym(shared_lib_handle, symbol);
}

bool shared_lib__create(shared_lib_t* self) {
    uint32_t shared_libs_size_of_key = sizeof(const char*);
    uint32_t shared_libs_size_of_value = sizeof(void*);
    uint64_t shared_libs_memory_size = 1024 * hash_map__entry_size(shared_libs_size_of_key, shared_libs_size_of_value);
    void* shared_libs_memory = malloc(shared_libs_memory_size);
    if (!hash_map__create(&self->shared_libs, shared_libs_memory, shared_libs_memory_size, shared_libs_size_of_key, shared_libs_size_of_value, hash_fn__string, eq_fn__string)) {
        return false;
    }

    return true;
}

void shared_lib__destroy(shared_lib_t* self) {
    shared_lib__clear(self);
}

void shared_lib__add(shared_lib_t* self, const char* shared_lib) {
    ASSERT(!shared_lib__find(self, shared_lib));
    uint64_t shared_lib_addr = (uint64_t) shared_lib;
    void* shared_lib_handle = dlopen(shared_lib, RTLD_LAZY);
    ASSERT(shared_lib_handle);
    uint64_t shared_lib_handle_addr = (uint64_t) shared_lib_handle;
    if (!hash_map__insert(&self->shared_libs, &shared_lib_addr, &shared_lib_handle_addr)) {
        ASSERT(false);
    }
}

void* shared_lib__find(shared_lib_t* self, const char* shared_lib) {
    uint64_t shared_lib_addr = (uint64_t) shared_lib;
    void* handle = hash_map__find(&self->shared_libs, &shared_lib_addr);

    return handle;
}

void shared_lib__close(shared_lib_t* self, const char* shared_lib) {
    void* shared_lib_handle = shared_lib__find(self, shared_lib);
    ASSERT(shared_lib_handle);
    int32_t result = dlclose(shared_lib_handle);
    ASSERT(result == 0);
}

void shared_lib__clear(shared_lib_t* self) {
    hash_map_key_t* it = hash_map__begin(&self->shared_libs);
    while (it != hash_map__end(&self->shared_libs)) {
        void** shared_lib_handle_p = hash_map__value(&self->shared_libs, it);
        int32_t result = dlclose(*shared_lib_handle_p);
        ASSERT(result == 0);
        it = hash_map__next(&self->shared_libs, it);
    }
}
