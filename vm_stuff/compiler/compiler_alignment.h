#ifndef COMPILER_ALIGNMENT_H
# define COMPILER_ALIGNMENT_H

# include "../types.h"

typedef struct compiled_type {
    uint32_t  offset_from_bp;
    type_t*   type;
} compiled_type_t;
typedef struct compiled_statement {
    compiled_type_t* compiled_types;
    uint32_t         compiled_types_top;
    uint32_t         compiled_types_size;
} compiled_statement_t;

bool compiled_statement__create(compiled_statement_t* self);
void compiled_statement__destroy(compiled_statement_t* self);
void compiled_statement__push(type_t* type);
compiled_type_t compiled_statement__pop(compiled_statement_t* self);
compiled_type_t compiled_statement__top(compiled_statement_t* self);

#endif // COMPILER_ALIGNMENT_H
