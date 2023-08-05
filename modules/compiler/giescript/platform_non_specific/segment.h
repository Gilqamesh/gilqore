#ifndef GIES_SEGMENT_H
# define GIES_SEGMENT_H

// todo: move into its own module

# include "compiler/giescript/giescript_defs.h"

# include "memory/memory.h"

# include "types.h"

// @brief initializes memory as a free segment
seg_t seg__init(void* data, size_t size);
// @param seg segment to resize
// @param size new size of the segment, cannot be 0
// @brief modifies the size of 'seg' if necessary
// @returns new seg or NULL on failure
seg_t seg__realloc(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t size);
// @brief free the segment
void seg__free(seg_t* first_free, seg_t seg);
// @brief 'src' into 'dst'
void seg__copy(seg_t dst, seg_t src);

#endif // GIES_SEGMENT_H
