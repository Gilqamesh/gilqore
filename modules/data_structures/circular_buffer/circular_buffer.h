#ifndef CIRCULAR_BUFFER_H
# define CIRCULAR_BUFFER_H

# include "circular_buffer_defs.h"

# include "memory/memory.h"

struct circular_buffer {
    struct memory_slice internal_buffer;
    u32    head_index;
    u32    tail_index;
    u32    size_of_item;
    u32    num_of_items_total;
    u32    has_items;
};

// @brief views and treats the provided internal_buffer as a circular buffer
// @param internal_buffer buffer to view as a circular buffer
// @param item_size size of each item in the buffer, must be greater than 0
// @param number_of_items max number of items held in the buffer, must be greater than 0 and not greater than what the provided buffer can store
PUBLIC_API bool circular_buffer__create(
    struct circular_buffer* self,
    struct memory_slice internal_buffer,
    u32 item_size, u32 number_of_items
);
// @brief destroys the buffer object, if circular_buffer__create_from_data was called to create the buffer, it does not free data
PUBLIC_API void circular_buffer__destroy(struct circular_buffer* self);

// @brief clears the buffer and sets the head equal to the tail
PUBLIC_API void circular_buffer__clear(struct circular_buffer* self);
// @brief advances head position and wrap around by the total size of the buffer
PUBLIC_API void circular_buffer__advance_tail(struct circular_buffer* self, s32 advance_by);
// @brief advances tail position and wrap around by the total size of the buffer
PUBLIC_API void circular_buffer__advance_head(struct circular_buffer* self, s32 advance_by);

// @brief push 1 item into the buffer and advances the head pointer by 1
PUBLIC_API void circular_buffer__push(struct circular_buffer* self, const void* in_item);
// @brief push multiple items (max buffer size) into the buffer and advances the head pointer by that much
PUBLIC_API void circular_buffer__push_multiple(struct circular_buffer* self, const void* in, u32 number_of_items);
// @brief pop 1 item from the buffer and advances the tail pointer by 1
PUBLIC_API void circular_buffer__pop(struct circular_buffer* self, void* out_item);
// @brief pop multiple items (max buffer size) from the buffer and advances the tail pointer by that much
PUBLIC_API void circular_buffer__pop_multiple(struct circular_buffer* self, void* out, u32 number_of_items);

// @returns head pointer
PUBLIC_API void*  circular_buffer__head(struct circular_buffer* self);
// @returns tail pointer
PUBLIC_API void*  circular_buffer__tail(struct circular_buffer* self);
// @returns begin pointer
PUBLIC_API void*  circular_buffer__begin(struct circular_buffer* self);
// @returns end pointer
PUBLIC_API void*  circular_buffer__end(struct circular_buffer* self);

// @returns size of an item in bytes
PUBLIC_API u32 circular_buffer__size_item(struct circular_buffer* self);
// @returns number of items stored currently in the buffer
PUBLIC_API u32 circular_buffer__size_current(struct circular_buffer* self);
// @returns total number of items that can be stored in the buffer
PUBLIC_API u32 circular_buffer__size_total(struct circular_buffer* self);

#endif
