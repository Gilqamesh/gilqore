#include "data_structures/circular_buffer/circular_buffer.h"

#include "libc/libc.h"
#include "common/error_code.h"
#include "math/compare/compare.h"
#include "math/mod/mod.h"

static inline void circular_buffer__advance_and_wrap_head(struct circular_buffer* self, u32 advance_by) {
    self->head_index = mod__u32(self->head_index + advance_by, self->num_of_items_total);
}

static inline void circular_buffer__advance_and_wrap_tail(struct circular_buffer* self, u32 advance_by) {
    self->tail_index = mod__u32(self->tail_index + advance_by, self->num_of_items_total);
}

static inline void circular_buffer__advance_and_wrap_head_by_one(struct circular_buffer* self) {
    self->head_index = self->head_index + 1 < self->num_of_items_total ? self->head_index + 1 : 0;
}

static inline void circular_buffer__advance_and_wrap_tail_by_one(struct circular_buffer* self) {
    self->tail_index = self->tail_index + 1 < self->num_of_items_total ? self->tail_index + 1 : 0;
}

bool circular_buffer__create(
    struct circular_buffer* self,
    struct memory_slice internal_buffer,
    u32 item_size, u32 number_of_items
) {
    if (
        item_size == 0 ||
        number_of_items == 0 ||
        memory_slice__size(&internal_buffer) < item_size * number_of_items
    ) {
        error_code__exit(CIRCULAR_BUFFER_ERROR_CODE_INVALID_PARAMETERS_DURING_CREATION);
    }

    self->internal_buffer = internal_buffer;
    self->head_index = 0;
    self->tail_index = 0;
    self->size_of_item = item_size;
    self->num_of_items_total = number_of_items;
    self->has_items = 0;

    return self;
}

void circular_buffer__destroy(struct circular_buffer* self) {
    (void) self;
}

void circular_buffer__clear(struct circular_buffer* self) {
    self->head_index = 0;
    self->tail_index = 0;
    self->has_items = 0;
}

void circular_buffer__advance_head(struct circular_buffer* self, s32 advance_by) {
    if (advance_by == 0) {
        return ;
    }
    self->head_index = mod__s32((s32) self->head_index + advance_by, self->num_of_items_total);
    self->has_items = 1;
}

void circular_buffer__advance_tail(struct circular_buffer* self, s32 advance_by) {
    if (advance_by == 0) {
        return ;
    }
    self->tail_index = mod__s32((s32) self->tail_index + advance_by, self->num_of_items_total);
    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}


void circular_buffer__push(struct circular_buffer* self, const void* in_item) {
    libc__memcpy(circular_buffer__head(self), in_item, self->size_of_item);
    circular_buffer__advance_and_wrap_head_by_one(self);

    self->has_items = 1;
}

void circular_buffer__push_multiple(struct circular_buffer* self, const void* in, u32 num_of_items) {
    if (num_of_items == 0) {
        return ;
    }

    num_of_items = min__u32(num_of_items, self->num_of_items_total);

    u32 num_of_items_to_insert = min__u32(num_of_items, self->num_of_items_total - self->head_index);
    u32 size_of_items_to_insert = num_of_items_to_insert * self->size_of_item;
    libc__memcpy(circular_buffer__head(self), in, size_of_items_to_insert);
    circular_buffer__advance_and_wrap_head(self, num_of_items_to_insert);
    in = (void *) ((u8*) in + size_of_items_to_insert);

    num_of_items_to_insert = num_of_items - num_of_items_to_insert;
    size_of_items_to_insert = num_of_items_to_insert * self->size_of_item;
    libc__memcpy(circular_buffer__head(self), in, size_of_items_to_insert);
    circular_buffer__advance_and_wrap_head(self, num_of_items_to_insert);

    self->has_items = 1;
}

void circular_buffer__pop(struct circular_buffer* self, void* out_item) {
    libc__memcpy(out_item, circular_buffer__tail(self), self->size_of_item);
    circular_buffer__advance_and_wrap_tail_by_one(self);

    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}

void circular_buffer__pop_multiple(struct circular_buffer* self, void* out, u32 num_of_items) {
    if (num_of_items == 0) {
        return ;
    }

    num_of_items = min__u32(num_of_items, self->num_of_items_total);

    u32 num_of_items_to_extract = min__u32(num_of_items, self->num_of_items_total - self->tail_index);
    u32 size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, circular_buffer__tail(self), size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items_to_extract);
    out = (void*) ((char*) out + size_of_items_to_extract);

    num_of_items_to_extract = num_of_items - num_of_items_to_extract;
    size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, circular_buffer__tail(self), size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items_to_extract);

    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}

void*  circular_buffer__head(struct circular_buffer* self) {
    return (void*) ((char*) memory_slice__memory(&self->internal_buffer) + self->head_index * self->size_of_item);
}

void*  circular_buffer__tail(struct circular_buffer* self) {
    return (void*) ((char*) memory_slice__memory(&self->internal_buffer) + self->tail_index * self->size_of_item);
}

void*  circular_buffer__begin(struct circular_buffer* self) {
    return memory_slice__memory(&self->internal_buffer);
}

void*  circular_buffer__end(struct circular_buffer* self) {
    return (void*) ((char*) memory_slice__memory(&self->internal_buffer) + self->num_of_items_total * self->size_of_item);
}

u32 circular_buffer__size_item(struct circular_buffer* self) {
    return self->size_of_item;
}

u32 circular_buffer__size_current(struct circular_buffer* self) {
    if (self->head_index == self->tail_index) {
        return self->has_items * self->num_of_items_total;
    } else if (self->head_index > self->tail_index) {
        return self->head_index - self->tail_index;
    } else {
        return self->num_of_items_total - (self->tail_index - self->head_index);
    }
}

u32 circular_buffer__size_total(struct circular_buffer* self) {
    return self->num_of_items_total;
}
