#include <stdlib.h>
#include <string.h>

#include "debug.h"
#include "state.h"


static void builtin__execute_malloc(type_builtin_function_t* self, void* processor);
static void builtin__execute_free(type_builtin_function_t* self, void* processor);
static void builtin__execute_print(type_builtin_function_t* self, void* processor);

static void builtin__execute_malloc(type_builtin_function_t* self, void* processor) {
    (void) self;

    state_t* state = (state_t*) processor;

    uint8_t* malloc_arg_addr;
    ALIGNED_BUFFER_ADDR_AT(state->aligned_buffer[ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK], 0, malloc_arg_addr);
    uint64_t malloc_arg = *(uint64_t*) malloc_arg_addr;
    void* malloc_result = malloc(malloc_arg);
    uint8_t* result_addr;
    ALIGNED_BUFFER_ADDR_AT(state->aligned_buffer[ALIGNED_BUFFER_TYPE_RETURN_TYPE_STACK], 0, result_addr);
    memmove(result_addr, &malloc_result, sizeof(void*));
}

static void builtin__execute_free(type_builtin_function_t* self, void* processor) {
    (void) self;

    state_t* state = (state_t*) processor;

    uint8_t* free_arg_addr;
    ALIGNED_BUFFER_ADDR_AT(state->aligned_buffer[ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK], 0, free_arg_addr);
    uint64_t* free_arg = (uint64_t*) *(uint64_t*) free_arg_addr;
    free(free_arg);
}

static void builtin__execute_print(type_builtin_function_t* self, void* processor) {
    (void) self;
    
    state_t* state = (state_t*) processor;

    uint8_t* type_addr;
    ALIGNED_BUFFER_ADDR_AT(state->aligned_buffer[ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK], 1, type_addr);
    type_t* type = (type_t*) *(uint64_t*) type_addr;
    uint8_t* type_value_addr;
    ALIGNED_BUFFER_ADDR_AT(state->aligned_buffer[ALIGNED_BUFFER_TYPE_ARGUMENT_TYPE_STACK], 0, type_value_addr);
    uint8_t* addr = (uint8_t*) *(uint64_t*) type_value_addr;
    type__print(type, stdout, 3, -1, addr);
}
