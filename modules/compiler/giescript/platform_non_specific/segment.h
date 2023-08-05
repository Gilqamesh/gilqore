#ifndef GIES_SEGMENT_H
# define GIES_SEGMENT_H

// todo: move into its own module

# include "compiler/giescript/giescript_defs.h"

# include "memory/memory.h"

# include "types.h"

// @brief initializes memory as a free segment
seg_t seg__init(void* data, size_t data_size);
// @param seg segment to resize
// @param size new size of the segment, cannot be 0
// @brief modifies the size of 'seg' if necessary
// @returns seg large enough to fulfill the request or NULL on failure
seg_t seg__realloc(memory_slice_t memory, seg_t* first_free, void* data, size_t data_size_requested);
// @brief free data
void seg__free(memory_slice_t memory, seg_t* first_free, seg_t seg);
// @brief 'src' into 'dst'
void seg__copy(seg_t dst, seg_t src);

// @returns seg_t associated with 'data'
seg_t seg__data_to_seg(void* data);
void* seg__seg_to_data(seg_t seg);

#endif // GIES_SEGMENT_H
