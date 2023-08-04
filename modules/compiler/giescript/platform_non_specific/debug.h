#ifndef DEBUG_H
# define DEBUG_H

# include "compiler/giescript/giescript_defs.h"

# include "types.h"

void chunk__disassemble(chunk_t* self, const char* name);
u32 chunk__disassemble_ins(chunk_t* self, u32 ip);

#endif // DEBUG_H
