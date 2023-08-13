#ifndef SEGMENT_ALLOCATOR_H
# define SEGMENT_ALLOCATOR_H

# include "segment_allocator_defs.h"

# include "memory/memory.h"

typedef void* seg_t;

// @brief marks memory as a seg
PUBLIC_API bool  seg__init(memory_slice_t memory);

PUBLIC_API seg_t seg__malloc(memory_slice_t memory, size_t data_size_requested);
// @param seg segment to resize
// @param size new size of the segment, cannot be 0
// @brief modifies the size of 'seg' if necessary
// @returns seg large enough to fulfill the request or NULL on failure
PUBLIC_API seg_t seg__realloc(memory_slice_t memory, void* data, size_t old_size, size_t data_size_requested);
// @brief free seg, returns freed seg
PUBLIC_API seg_t seg__free(memory_slice_t memory, seg_t seg);

// @returns seg_t associated with 'data'
PUBLIC_API seg_t seg__data_to_seg(void* data);
PUBLIC_API void* seg__seg_to_data(seg_t seg);

// @brief prints segment
PUBLIC_API bool  seg__print(memory_slice_t memory, seg_t seg);
PUBLIC_API void  seg__print_aux(memory_slice_t memory);

// @brief applies fn to each segment in memory while it returns true
PUBLIC_API void  seg__for_each(memory_slice_t memory, bool (*fn)(memory_slice_t memory, seg_t seg));

#endif // SEGMENT_ALLOCATOR_H
