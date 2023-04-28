#include "circular_buffer.h"

#include "libc/libc.h"
#include "common/error_code.h"
#include "compare/compare.h"

struct circular_buffer {
    void*  buffer;
    u32    head_index;
    u32    tail_index;
    u32    num_of_items_cur;
    u32    size_of_item;
    u32    num_of_items_total;
    bool   buffer_is_owned;
};

static inline circular_buffer circular_buffer_init(void* data, u32 size_of_item, u32 num_of_items_total, bool buffer_is_owned) {
    if (size_of_item == 0 || num_of_items_total == 0) {
        error_code__exit(CIRCULAR_BUFFER_ERROR_CODE_INVALID_PARAMETERS_DURING_CREATION);
    }

    circular_buffer self = libc__malloc(sizeof(*self));

    self->buffer = data;
    self->head_index = 0;
    self->tail_index = 0;
    self->num_of_items_cur = 0;
    self->size_of_item = size_of_item;
    self->num_of_items_total = num_of_items_total;
    self->buffer_is_owned = buffer_is_owned;

    return self;
}

static inline void circular_buffer__advance_and_wrap_head(circular_buffer self, u32 advance_by) {
    self->head_index = (self->head_index + advance_by) % self->num_of_items_total;
}

static inline void circular_buffer__advance_and_wrap_tail(circular_buffer self, u32 advance_by) {
    self->tail_index = (self->tail_index + advance_by) % self->num_of_items_total;
}

static inline void circular_buffer__advance_and_wrap_head_by_one(circular_buffer self) {
    self->head_index = self->head_index + 1 < self->num_of_items_total ? self->head_index + 1 : 0;
}

static inline void circular_buffer__advance_and_wrap_tail_by_one(circular_buffer self) {
    self->tail_index = self->tail_index + 1 < self->num_of_items_total ? self->tail_index + 1 : 0;
}

circular_buffer circular_buffer__create(u32 size_of_item, u32 num_of_items) {
    return
    circular_buffer_init(
        libc__malloc(size_of_item * num_of_items),
        size_of_item,
        num_of_items,
        true
    );
}

circular_buffer circular_buffer__init(void* data, u32 size_of_item, u32 num_of_items) {
    return
    circular_buffer_init(
        data,
        size_of_item,
        num_of_items,
        false
    );
}

void circular_buffer__destroy(circular_buffer self) {
    if (self->buffer_is_owned) {
        libc__free(self->buffer);
    }
}

void circular_buffer__clear(circular_buffer self) {
    self->head_index = 0;
    self->tail_index = 0;
    self->num_of_items_cur = 0;
}

void circular_buffer__advance(circular_buffer self, u32 advance_by) {
    self->head_index = (self->head_index + advance_by) % self->num_of_items_total;
}


void circular_buffer__push(circular_buffer self, void* in_item) {
    libc__memcpy(self->buffer + self->head_index * self->size_of_item, in_item, self->size_of_item);
    circular_buffer__advance_and_wrap_head_by_one(self);
}

void circular_buffer__push_multiple(circular_buffer self, void* in, u32 num_of_items) {
    num_of_items = max__u32(num_of_items, self->num_of_items_total);

    u32 num_of_items_to_insert = min__u32(num_of_items, self->num_of_items_total - self->head_index);
    u32 size_of_items_to_insert = num_of_items_to_insert * self->size_of_item;
    libc__memcpy(self->buffer + self->head_index * self->size_of_item, in, size_of_items_to_insert);
    circular_buffer__advance_and_wrap_head(self, num_of_items_to_insert);
    in += size_of_items_to_insert;

    num_of_items_to_insert = num_of_items - num_of_items_to_insert;
    size_of_items_to_insert = num_of_items_to_insert * self->size_of_item;
    libc__memcpy(self->buffer, in, size_of_items_to_insert);
    circular_buffer__advance_and_wrap_head(self, num_of_items);
}

void circular_buffer__pop(circular_buffer self, void* out_item) {
    libc__memcpy(out_item, self->buffer + self->tail_index * self->size_of_item, self->size_of_item);
    circular_buffer__advance_and_wrap_tail_by_one(self);
}

void circular_buffer__extract(circular_buffer self, void* out, u32 num_of_items) {
    num_of_items = max__u32(num_of_items, self->num_of_items_total);

    u32 num_of_items_to_extract = min__u32(num_of_items, self->num_of_items_total - self->tail_index);
    u32 size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, self->buffer + self->tail_index * self->size_of_item, size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items_to_extract);
    out += size_of_items_to_extract;

    num_of_items_to_extract = num_of_items - num_of_items_to_extract;
    size_of_items_to_extract = num_of_items_to_extract * self->size_of_item;
    libc__memcpy(out, self->buffer, size_of_items_to_extract);
    circular_buffer__advance_and_wrap_tail(self, num_of_items);
}

u8*  circular_buffer__get_head(circular_buffer self) {
    return self->buffer + self->head_index * self->size_of_item;
}

u8*  circular_buffer__get_tail(circular_buffer self) {
    return self->buffer + self->tail_index * self->size_of_item;
}

u8*  circular_buffer__begin(circular_buffer self) {
    return self->buffer;
}

u8*  circular_buffer__end(circular_buffer self) {
    return self->buffer + self->num_of_items_total * self->size_of_item;
}

u32 circular_buffer__size_current(circular_buffer self) {
    return self->num_of_items_cur;
}

u32 circular_buffer__size_total(circular_buffer self) {
    return self->num_of_items_total;
}
