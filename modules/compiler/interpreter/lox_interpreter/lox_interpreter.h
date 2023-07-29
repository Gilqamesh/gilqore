#ifndef LOX_INTERPRETER_H
# define LOX_INTERPRETER_H

# include "lox_interpreter_defs.h"

# include "compiler/interpreter/interpreter.h"

PUBLIC_API void lox_interpreter__interpret_ast(struct interpreter* self, struct parser_ast ast);

PUBLIC_API bool lox_interpreter__initialize(struct interpreter* self, struct memory_slice internal_buffer);
PUBLIC_API bool lox_interpreter__init_native_callables(struct interpreter* self);

#endif // LOX_INTERPRETER_H
