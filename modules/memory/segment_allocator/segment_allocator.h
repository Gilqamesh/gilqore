#ifndef SEGMENT_ALLOCATOR_H
# define SEGMENT_ALLOCATOR_H

# include "segment_allocator_defs.h"

# include "memory/memory.h"

typedef void* seg_t;

// @brief marks memory as a seg
seg_t seg__init(memory_slice_t memory);
// @brief print segment view of memory
void  seg__print(memory_slice_t memory);

seg_t seg__malloc(memory_slice_t memory, seg_t* first_free, size_t data_size_requested);
// @param seg segment to resize
// @param size new size of the segment, cannot be 0
// @brief modifies the size of 'seg' if necessary
// @returns seg large enough to fulfill the request or NULL on failure
seg_t seg__realloc(memory_slice_t memory, seg_t* first_free, void* data, size_t data_size_requested);
// @brief free seg, returns freed seg
seg_t seg__free(memory_slice_t memory, seg_t* first_free, seg_t seg);

// @returns seg_t associated with 'data'
seg_t seg__data_to_seg(void* data);
void* seg__seg_to_data(seg_t seg);


#endif // SEGMENT_ALLOCATOR_H
