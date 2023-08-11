#ifndef GIES_COMPILER_H
# define GIES_COMPILER_H

# include "types.h"

# include "scanner.h"

struct compiler {
    token_t current;
    token_t previous;

    scanner_t scanner;
    bool had_error;
    bool panic_mode;

    vm_t* vm;
};

void compiler__init(compiler_t* self, vm_t* vm, const char* source);

bool compiler__compile(compiler_t* self, allocator_t* allocator, chunk_t* chunk);

#endif // GIES_COMPILER_H
