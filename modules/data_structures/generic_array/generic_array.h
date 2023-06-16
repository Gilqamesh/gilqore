#ifndef GENERIC_ARRAY
# define GENERIC_ARRAY

# include "generic_array_defs.h"

struct generic_array {
    void* items;
    u32 item_size;
    u32 capacity;
    u32 fill;
};

// @brief create an array that can hold arbitrary items
PUBLIC_API bool generic_array__create(
    struct generic_array* self,
    void* memory,
    u64 memory_size,
    u32 size_of_one_item
);

// @brief destroy generic array, leaving it in an undefined state
PUBLIC_API void generic_array__destroy(struct generic_array* self);

// @brief adds an item to the array
PUBLIC_API void* generic_array__push(struct generic_array* self);
// @brief removes the top most item from the array
// @returns top item from the array
PUBLIC_API void* generic_array__pop(struct generic_array* self);
// @returns item at the specified index
PUBLIC_API void* generic_array__at(struct generic_array* self, u32 index);

// @returns available items to add to the array before it's full
PUBLIC_API u32 generic_array__available(struct generic_array* self);
// @returns currently held number of items
PUBLIC_API u32 generic_array__size(struct generic_array* self);
// @returns total number of items that can be stored in the array
PUBLIC_API u32 generic_array__capacity(struct generic_array* self);

#endif
