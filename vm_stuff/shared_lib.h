#ifndef SHARED_LIB_H
# define SHARED_LIB_H

# include "hash_map.h"

typedef struct shared_lib {
    hash_map_t shared_libs;
} shared_lib_t;

void* shared_lib__sym(void* shared_lib_handle, const char* symbol);

bool shared_lib__create(shared_lib_t* self);
void shared_lib__destroy(shared_lib_t* self);

void shared_lib__add(shared_lib_t* self, const char* shared_lib);
void* shared_lib__find(shared_lib_t* self, const char* shared_lib);
void shared_lib__close(shared_lib_t* self, const char* shared_lib);
void shared_lib__clear(shared_lib_t* self);

# endif // SHARED_LIB_H
