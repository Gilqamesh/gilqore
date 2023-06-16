#include "data_structures/circular_buffer/circular_buffer.h"

#include "libc/libc.h"
#include "common/error_code.h"
#include "math/compare/compare.h"
#include "math/mod/mod.h"

struct circular_buffer {
    void*  buffer;
    u32    head_index;
    u32    tail_index;
    u32    size_of_item;
    u32    num_of_items_total;
    u32    has_items;
    bool   buffer_is_owned;
};

static inline circular_buffer_t circular_buffer_init(void* data, u32 size_of_item, u32 num_of_items_total, bool buffer_is_owned) {
    if (size_of_item == 0 || num_of_items_total == 0) {
        error_code__exit(CIRCULAR_BUFFER_ERROR_CODE_INVALID_PARAMETERS_DURING_CREATION);
    }

    circular_buffer_t self = libc__malloc(sizeof(*self));

    self->buffer = data;
    self->head_index = 0;
    self->tail_index = 0;
    self->size_of_item = size_of_item;
    self->num_of_items_total = num_of_items_total;
    self->has_items = 0;
    self->buffer_is_owned = buffer_is_owned;

    return self;
}

static inline void circular_buffer__advance_and_wrap_head(circular_buffer_t self, u32 advance_by) {
    self->head_index = mod__u32(self->head_index + advance_by, self->num_of_items_total);
}

static inline void circular_buffer__advance_and_wrap_tail(circular_buffer_t self, u32 advance_by) {
    self->tail_index = mod__u32(self->tail_index + advance_by, self->num_of_items_total);
}

static inline void circular_buffer__advance_and_wrap_head_by_one(circular_buffer_t self) {
    self->head_index = self->head_index + 1 < self->num_of_items_total ? self->head_index + 1 : 0;
}

static inline void circular_buffer__advance_and_wrap_tail_by_one(circular_buffer_t self) {
    self->tail_index = self->tail_index + 1 < self->num_of_items_total ? self->tail_index + 1 : 0;
}

circular_buffer_t circular_buffer__create(u32 size_of_item, u32 num_of_items) {
    return
    circular_buffer_init(
        libc__malloc(size_of_item * num_of_items),
        size_of_item,
        num_of_items,
        true
    );
}

circular_buffer_t circular_buffer__create_from_data(void* data, u32 size_of_item, u32 num_of_items) {
    return
    circular_buffer_init(
        data,
        size_of_item,
        num_of_items,
        false
    );
}

void circular_buffer__destroy(circular_buffer_t self) {
    if (self->buffer_is_owned) {
        libc__free(self->buffer);
    }
    libc__free(self);
}

void circular_buffer__clear(circular_buffer_t self) {
    self->head_index = 0;
    self->tail_index = 0;
    self->has_items = 0;
}

void circular_buffer__advance_head(circular_buffer_t self, s32 advance_by) {
    if (advance_by == 0) {
        return ;
    }
    self->head_index = mod__s32((s32) self->head_index + advance_by, self->num_of_items_total);
    self->has_items = 1;
}

void circular_buffer__advance_tail(circular_buffer_t self, s32 advance_by) {
    if (advance_by == 0) {
        return ;
    }
    self->tail_index = mod__s32((s32) self->tail_index + advance_by, self->num_of_items_total);
    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}


void circular_buffer__push(circular_buffer_t self, const void* in_item) {
    libc__memcpy(circular_buffer__head(self), in_item, self->size_of_item);
    circular_buffer__advance_and_wrap_head_by_one(self);

    self->has_items = 1;
}

void circular_buffer__push_multiple(circular_buffer_t self, const void* in, u32 num_of_items) {
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

void circular_buffer__pop(circular_buffer_t self, void* out_item) {
    libc__memcpy(out_item, circular_buffer__tail(self), self->size_of_item);
    circular_buffer__advance_and_wrap_tail_by_one(self);

    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}

void circular_buffer__pop_multiple(circular_buffer_t self, void* out, u32 num_of_items) {
    if (num_of_items == 0) {
        return ;
    }

    num_of_items = min__u32(num_of_items, self->num_of_items_total);

    u32 num_of_items_to_extract = min__u32(num_of_items, self->num_of_items_total - self->tail_index);
    u32 size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, circular_buffer__tail(self), size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items_to_extract);
    out = (void*) ((u8*) out + size_of_items_to_extract);

    num_of_items_to_extract = num_of_items - num_of_items_to_extract;
    size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, circular_buffer__tail(self), size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items_to_extract);

    self->has_items = self->head_index == self->tail_index ? 0 : 1;
}

void*  circular_buffer__head(circular_buffer_t self) {
    return (void*) ((u8*) self->buffer + self->head_index * self->size_of_item);
}

void*  circular_buffer__tail(circular_buffer_t self) {
    return (void*) ((u8*) self->buffer + self->tail_index * self->size_of_item);
}

void*  circular_buffer__begin(circular_buffer_t self) {
    return self->buffer;
}

void*  circular_buffer__end(circular_buffer_t self) {
    return (void*) ((u8*) self->buffer + self->num_of_items_total * self->size_of_item);
}

u32 circular_buffer__size_item(circular_buffer_t self) {
    return self->size_of_item;
}

u32 circular_buffer__size_current(circular_buffer_t self) {
    if (self->head_index == self->tail_index) {
        return self->has_items * self->num_of_items_total;
    } else if (self->head_index > self->tail_index) {
        return self->head_index - self->tail_index;
    } else {
        return self->num_of_items_total - (self->tail_index - self->head_index);
    }
}

u32 circular_buffer__size_total(circular_buffer_t self) {
    return self->num_of_items_total;
}
