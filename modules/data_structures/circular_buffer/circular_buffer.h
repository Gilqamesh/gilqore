#ifndef CIRCULAR_BUFFER_H
# define CIRCULAR_BUFFER_H

# include "circular_buffer_defs.h"

typedef struct circular_buffer *circular_buffer;// circular buffer container to hold arbitrary items

// @brief creates and returns a circular buffer
GIL_API circular_buffer circular_buffer__create(u32 item_size, u32 number_of_items);
// @brief initializes the circular buffer from an existing resource
GIL_API circular_buffer circular_buffer__init(void* data, u32 item_size, u32 number_of_items);
// @brief destroys the buffer object, if circular_buffer__init was called to create the buffer, it does not free data
GIL_API void circular_buffer__destroy(circular_buffer self);

// @brief clears the buffer
GIL_API void circular_buffer__clear(circular_buffer self);
// @brief advances head position by advance_by items
GIL_API void circular_buffer__advance(circular_buffer self, u32 advance_by);

// @brief push 1 item into the buffer, undefined if current size is full
GIL_API void circular_buffer__push(circular_buffer self, void* in_item);
// @brief push multiple items into the buffer, undefined if more than available items are pushed
GIL_API void circular_buffer__push_multiple(circular_buffer self, void* in, u32 number_of_items);
// @brief pop 1 item from the buffer, undefined if no more items are left in the buffer
GIL_API void circular_buffer__pop(circular_buffer self, void* out_item);
// @brief pop multiple items from the buffer, undefined if more than available items are extracted
GIL_API void circular_buffer__extract(circular_buffer self, void* out, u32 number_of_items);

// @returns head pointer
GIL_API u8*  circular_buffer__get_head(circular_buffer self);
// @returns tail pointer
GIL_API u8*  circular_buffer__get_tail(circular_buffer self);
// @returns begin pointer
GIL_API u8*  circular_buffer__begin(circular_buffer self);
// @returns end pointer
GIL_API u8*  circular_buffer__end(circular_buffer self);

// @returns number of items stored currently in the buffer
GIL_API u32 circular_buffer__size_current(circular_buffer self);
// @returns total number of items that can be stored in the buffer
GIL_API u32 circular_buffer__size_total(circular_buffer self);

#endif
