#ifndef STACK_H
# define STACK_H

# include "stack_defs.h"

struct stack {
    void* items;
    u32 item_size;
    u32 capacity;
    u32 fill;
};

struct memory_slice;

// @brief create a stack that can hold arbitrary items
PUBLIC_API bool stack__create(
    struct stack* self,
    struct memory_slice memory_slice,
    u32 size_of_one_item
);

// @brief destroy the stack, leaving it in an undefined state
PUBLIC_API void stack__destroy(struct stack* self);

// @brief pushes an item on top of the stack
PUBLIC_API void* stack__push(struct stack* self);
// @brief removes the top item from the stack
// @returns top item from the stack
PUBLIC_API void* stack__pop(struct stack* self);
// @returns item at the specified index
PUBLIC_API void* stack__at(struct stack* self, u32 index);

// @returns available items to add to the stack before it's full
PUBLIC_API u32 stack__available(struct stack* self);
// @returns currently held number of items
PUBLIC_API u32 stack__size(struct stack* self);
// @returns total number of items that can be stored in the stack
PUBLIC_API u32 stack__capacity(struct stack* self);

#endif // STACK_H
