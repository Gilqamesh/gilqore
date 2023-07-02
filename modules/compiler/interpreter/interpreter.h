#ifndef INTERPRETER_H
# define INTERPRETER_H

# include "interpreter_defs.h"

PUBLIC_API bool interpreter__run_file(const char* path);
PUBLIC_API void interpreter__run_prompt();

#endif // INTERPRETER_H
