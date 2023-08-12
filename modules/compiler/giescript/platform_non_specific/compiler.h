#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "types.h"

# include "scanner.h"
# include "table.h"

struct compiler {
    token_t current;
    token_t previous;

    scanner_t scanner;
    bool had_error;
    bool panic_mode;

    // identifier name -> index of the value stored in the chunk
    // table_t identifier_to_index;

    vm_t* vm;
    allocator_t* allocator;
    chunk_t* chunk;
};

void compiler__init(compiler_t* self, vm_t* vm, allocator_t* allocator, chunk_t* chunk, const char* source);

bool compiler__compile(compiler_t* self);

#endif // GIES_COMPILER_H
