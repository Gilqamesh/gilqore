#ifndef CIRCULAR_BUFFER_H
# define CIRCULAR_BUFFER_H

# include "circular_buffer_defs.h"

struct circular_buffer { // circular buffer for arbitrary items
    void*   buffer;
    u32     head_index;
    u32     tail_index;
    u32     num_of_items_cur;
    u32     size_of_item;
    u32     num_of_items_total;
    bool    buffer_is_owned;
};

// @brief creates and returns a circular buffer
GIL_API bool circular_buffer__create(struct circular_buffer* self, u32 item_size, u32 number_of_items);
// @brief initializes the circular buffer from an existing resource
GIL_API bool circular_buffer__init(struct circular_buffer* self, void* data, u32 item_size, u32 number_of_items);
// @brief destroys the buffer object, if circular_buffer__init was called to create the buffer, it does not free data
GIL_API void circular_buffer__destroy(struct circular_buffer* self);

// @brief clears the buffer
GIL_API void circular_buffer__clear(struct circular_buffer* self);
// @brief advances head position by advance_by items
GIL_API void circular_buffer__advance(struct circular_buffer* self, u32 advance_by);

// @brief push 1 item into the buffer, undefined if current size is full
GIL_API void circular_buffer__push(struct circular_buffer* self, void* in_item);
// @brief push multiple items into the buffer, undefined if more than available items are pushed
GIL_API void circular_buffer__push_multiple(struct circular_buffer* self, void* in, u32 number_of_items);
// @brief pop 1 item from the buffer, undefined if no more items are left in the buffer
GIL_API void circular_buffer__pop(struct circular_buffer* self, void* out_item);
// @brief pop multiple items from the buffer, undefined if more than available items are extracted
GIL_API void circular_buffer__extract(struct circular_buffer* self, void* out, u32 number_of_items);

// @returns head pointer
GIL_API u8*  circular_buffer__get_head(struct circular_buffer* self);
// @returns tail pointer
GIL_API u8*  circular_buffer__get_tail(struct circular_buffer* self);
// @returns begin pointer
GIL_API u8*  circular_buffer__begin(struct circular_buffer* self);
// @returns end pointer
GIL_API u8*  circular_buffer__end(struct circular_buffer* self);

// @returns number of items stored currently in the buffer
GIL_API u32 circular_buffer__size_current(struct circular_buffer* self);
// @returns total number of items that can be stored in the buffer
GIL_API u32 circular_buffer__size_total(struct circular_buffer* self);

#endif
