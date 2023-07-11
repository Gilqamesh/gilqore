#ifndef LOX_INTERPRETER_H
# define LOX_INTERPRETER_H

# include "lox_interpreter_defs.h"

# include "compiler/interpreter/interpreter.h"

PUBLIC_API void lox_interpreter__interpret_program(struct interpreter* self, struct parser_program program);

#endif // LOX_INTERPRETER_H
