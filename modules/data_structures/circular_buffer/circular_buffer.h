#ifndef CIRCULAR_BUFFER_H
# define CIRCULAR_BUFFER_H

# include "circular_buffer_defs.h"

typedef struct circular_buffer *circular_buffer_t; // circular buffer container to hold arbitrary items

// @brief creates and returns a circular buffer
// @param number_of_items max number of items to be held in the buffer, must be greater than 0
GIL_API circular_buffer_t circular_buffer__create(u32 item_size, u32 number_of_items);
// @brief initializes the circular buffer from an existing resource
// @param number_of_items max number of items to be held in the buffer, must be greater than 0
GIL_API circular_buffer_t circular_buffer__create_from_data(void* data, u32 item_size, u32 number_of_items);
// @brief destroys the buffer object, if circular_buffer__create_from_data was called to create the buffer, it does not free data
GIL_API void circular_buffer__destroy(circular_buffer_t self);

// @brief clears the buffer and sets the head equal to the tail
GIL_API void circular_buffer__clear(circular_buffer_t self);
// @brief advances head position and wrap around by the total size of the buffer
GIL_API void circular_buffer__advance_tail(circular_buffer_t self, s32 advance_by);
// @brief advances tail position and wrap around by the total size of the buffer
GIL_API void circular_buffer__advance_head(circular_buffer_t self, s32 advance_by);

// @brief push 1 item into the buffer and advances the head pointer by 1
GIL_API void circular_buffer__push(circular_buffer_t self, const void* in_item);
// @brief push multiple items (max buffer size) into the buffer and advances the head pointer by that much
GIL_API void circular_buffer__push_multiple(circular_buffer_t self, const void* in, u32 number_of_items);
// @brief pop 1 item from the buffer and advances the tail pointer by 1
GIL_API void circular_buffer__pop(circular_buffer_t self, void* out_item);
// @brief pop multiple items (max buffer size) from the buffer and advances the tail pointer by that much
GIL_API void circular_buffer__pop_multiple(circular_buffer_t self, void* out, u32 number_of_items);

// @returns head pointer
GIL_API void*  circular_buffer__head(circular_buffer_t self);
// @returns tail pointer
GIL_API void*  circular_buffer__tail(circular_buffer_t self);
// @returns begin pointer
GIL_API void*  circular_buffer__begin(circular_buffer_t self);
// @returns end pointer
GIL_API void*  circular_buffer__end(circular_buffer_t self);

// @returns size of an item in bytes
GIL_API u32 circular_buffer__size_item(circular_buffer_t self);
// @returns number of items stored currently in the buffer
GIL_API u32 circular_buffer__size_current(circular_buffer_t self);
// @returns total number of items that can be stored in the buffer
GIL_API u32 circular_buffer__size_total(circular_buffer_t self);

#endif
