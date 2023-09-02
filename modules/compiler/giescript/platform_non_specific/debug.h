#ifndef GIES_DEBUG_H
# define GIES_DEBUG_H

# include "compiler/giescript/giescript_defs.h"

# include "common.h"
# include "value.h"

// @brief disassembles chunk and prints, check disasm_grammar.txt
// @param name chunk name to be displayed
void chunk__disasm(chunk_t* self, value_t value);
u32  chunk__disasm_ins(chunk_t* self, u32 ip);

#endif // GIES_DEBUG_H
