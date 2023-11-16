#ifndef DEBUG_H
# define DEBUG_H

# include <stdio.h>

extern FILE* compiled_code_file;
extern FILE* runtime_code_file;
extern FILE* runtime_stack_file;

void debug__create();
void debug__destroy();

#endif // DEBUG_H
