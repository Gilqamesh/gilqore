#include "segment.h"

#include "memory/memory.h"
#include "libc/libc.h"

struct seg_tag {
    u32   seg_size     : 31;
    u32   is_available : 1;
    seg_t free_seg;
};

struct seg_state {
    bool    is_available;
    seg_t   next;
    seg_t   prev;
    seg_t*  ff;
};

// size of payload data
size_t    seg__data_size(seg_t seg);
size_t    seg__seg_size_to_data_size(size_t seg_size);
size_t    seg__data_size_to_seg_size(size_t data_size);
// header tag of segment
seg_tag_t seg__head(seg_t seg);
// tailer tag of segment, head's size must be initialized before calling this
seg_tag_t seg__tail(seg_t seg);
// get size of segment
size_t    seg__size(seg_t seg);
// set size of segment
void      seg__set_size(seg_t seg, size_t segment_size);
// true if segment is available
bool      seg__is_available(seg_t seg);
// next seg in memory
seg_t     seg__next(memory_slice_t memory, seg_t seg);
// prev seg in memory
seg_t     seg__prev(memory_slice_t memory, seg_t seg);
seg_t     seg__find_next_free(memory_slice_t memory, seg_t seg);
seg_t     seg__find_prev_free(memory_slice_t memory, seg_t seg);
// next free seg
seg_t     seg__next_free(seg_t seg);
// prev free seg
seg_t     seg__prev_free(seg_t seg);
// try to coal with neighbors, seg can be either available or not, returns resulting grown seg
seg_t     seg__coal(memory_slice_t memory, seg_t* first_free, seg_t seg);
// returns the size of coaling without applying coal
size_t    seg__check_coal_size(memory_slice_t memory, seg_t seg);
// removes part of the seg, seg must be not available, returns the seg with the required size [!A] -> [!A][A]
seg_t     seg__detach(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t new_seg_size);
// @brief copy 'size' bytes from the start of src's data to the start of dst's data
void      seg__copy_data(seg_t dst, seg_t src, size_t size);

// --== states ==--
typedef struct {
    size_t seg_size;
    bool available;
    seg_t prev_free;
    seg_t next_free;
} seg_state;
void seg_state__init(seg_t seg, size_t seg_size, bool available, seg_t prev_free, seg_t next_free);
seg_state seg_state__get(seg_t seg);
// --== state transitions ==--
void seg_state__available(memory_slice_t memory, seg_t* first_free, seg_t seg, bool value);

// Sequential Fit Policies
/*  First Fit
    Searches the list of free blocks from 'seg' and uses the first block large enough to satisfy the request.
    If the block is larger than necessary, it is split and the remainder is put in the free list.
    Problem: The larger blocks near the beginning of the list tend to be split first, and the remaining fragments
    result in a lot of small free blocks near the beginning of the list.
*/
seg_t     seg__first_fit(seg_t* first_free_seg, size_t requested_seg_size);
/*  Next Fit
    Search from segment X with first fit policy.
    Policies for X:
        Roving pointer: Ideally this pointer always points to the largest segment. This is achieved by setting it
        to the segment immediately followed by the last allocation performed (often, this will be sufficiently
        big for the next allocation).
*/
seg_t     seg__next_fit(seg_t seg, size_t requested_seg_size);
/*  Best Fit
    Search the entire list to find the smallest, that is large enough to satisfy the request.
    It may stop if a perfect fit is found earlier.
    Problem: Depending on how the data structure is implemented, this can be slow.
*/
seg_t     seg__best_fit(seg_t* first_free_seg, size_t requested_seg_size);

seg_tag_t seg__head(seg_t seg) {
    ASSERT(seg);

    return (seg_tag_t) seg;
}

seg_tag_t seg__tail(seg_t seg) {
    ASSERT(seg);
    
    return (seg_tag_t) ((u8*) seg + seg__size(seg) - sizeof(struct seg_tag));
}

void* seg__seg_to_data(seg_t seg) {
    if (!seg) {
        return NULL;
    }

    return (u8*) seg + sizeof(struct seg_tag);
}

size_t seg__data_size(seg_t seg) {
    seg_tag_t head = seg__head(seg);
    seg_tag_t tail = seg__tail(seg);
    if (head == tail) {
        return 0;
    }
    else {
        return seg__seg_size_to_data_size(seg__size(seg));
    }
}

size_t seg__seg_size_to_data_size(size_t seg_size) {
    return seg_size - 2 * sizeof(struct seg_tag);
}

size_t seg__data_size_to_seg_size(size_t data_size) {
    return data_size + 2 * sizeof(struct seg_tag);
}

size_t seg__size(seg_t seg) {
    return seg__head(seg)->seg_size;
}

void seg__set_size(seg_t seg, size_t segment_size) {
    seg_tag_t head = seg__head(seg);
    head->seg_size = segment_size;

    // note can't find tail before segment_size is set
    seg_tag_t tail = seg__tail(seg);
    tail->seg_size = segment_size;
}

seg_t seg__first_fit(seg_t* first_free_seg, size_t requested_seg_size) {
    seg_t cur = *first_free_seg;
    while (cur) {
        ASSERT(seg__is_available(cur));

        size_t seg_size = seg__data_size(cur);
        if (seg_size >= requested_seg_size) {
            return cur;
        }

        cur = seg__next_free(cur);
    }

    return NULL;
}

seg_t seg__next_fit(seg_t seg, size_t requested_seg_size) {
    // todo: implement
    return seg__first_fit(&seg, requested_seg_size);
}

seg_t seg__best_fit(seg_t* first_free_seg, size_t requested_seg_size) {
    seg_t best_seg = NULL;
    seg_t cur_seg = *first_free_seg;
    while (cur_seg) {
        ASSERT(seg__is_available(cur_seg));

        size_t seg_size = seg__data_size(cur_seg);
        if (seg_size >= requested_seg_size) {
            if (best_seg == NULL) {
                best_seg = cur_seg;
            } else if (seg_size < seg__data_size(best_seg)) {
                best_seg = cur_seg;
            }
        }

        cur_seg = seg__next_free(cur_seg);
    }

    return best_seg;
}

seg_t seg__next(memory_slice_t memory, seg_t seg) {
    ASSERT(seg);
    ASSERT(memory_slice__memory(&memory));

    seg_t next_seg = (u8*) seg + seg__size(seg);
    if ((u8*) next_seg >= (u8*) memory_slice__memory(&memory) + memory_slice__size(&memory)) {
        return NULL;
    }

    return next_seg;
}

seg_t seg__prev(memory_slice_t memory, seg_t seg) {
    ASSERT(seg);
    ASSERT(memory_slice__memory(&memory));

    if ((u8*) seg - 1 < (u8*) memory_slice__memory(&memory)) {
        return NULL;
    }

    seg_tag_t prev_seg_tail = (seg_tag_t) ((u8*) seg - sizeof(struct seg_tag));
    size_t prev_seg_size = seg__size(prev_seg_tail);

    return (u8*) seg - prev_seg_size;
}

seg_t seg__find_next_free(memory_slice_t memory, seg_t seg) {
    seg = seg__next(memory, seg);
    while (seg) {
        if (seg__is_available(seg)) {
            return seg;
        }
        seg = seg__next(memory, seg);
    }

    return NULL;
}

seg_t seg__find_prev_free(memory_slice_t memory, seg_t seg) {
    seg = seg__prev(memory, seg);
    while (seg) {
        if (seg__is_available(seg)) {
            return seg;
        }
        seg = seg__prev(memory, seg);
    }

    return NULL;
}

seg_t seg__next_free(seg_t seg) {
    return seg__tail(seg)->free_seg;
}

seg_t seg__prev_free(seg_t seg) {
    return seg__head(seg)->free_seg;
}

bool seg__is_available(seg_t seg) {
    return seg__head(seg)->is_available;
}

seg_t seg__coal(memory_slice_t memory, seg_t* first_free, seg_t seg) {
    ASSERT(seg);
    
    seg_t prev = seg__prev(memory, seg);
    seg_t next = seg__next(memory, seg);

    bool is_prev_available = prev && seg__is_available(prev);
    bool is_next_available = next && seg__is_available(next);

    if (!is_prev_available && !is_next_available) {
    } else if (is_prev_available && !is_next_available) {
        bool seg_is_available = seg__is_available(seg);

        // getting rid of one of the two segs
        if (seg_is_available) {
            seg_state__available(memory, first_free, seg, false);
        } else {
            seg_state__available(memory, first_free, prev, false);
        }

        // problem: after updating size, need to update link
        if (seg_is_available) {
            seg_t next_free = seg__next_free(prev);
            size_t new_size = seg__size(seg) + seg__size(prev);
            seg__tail(seg)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(prev)->free_seg = next_free;
        } else {
            size_t new_size = seg__size(seg) + seg__size(prev);
            seg__tail(seg)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(prev)->free_seg = 0;
        }

        // maintain seg's data
        if (seg_is_available) {
            seg__copy_data(prev, seg, seg__data_size(prev));
        }
    } else if (!is_prev_available && is_next_available) {
        bool seg_is_available = seg__is_available(seg);

        // getting rid of one of the coaled next
        seg_state__available(memory, first_free, next, false);

        // problem: after updating size, need to update link
        if (seg_is_available) {
            seg_t next_free = seg__next_free(next);
            size_t new_size = seg__size(seg) + seg__size(next);
            seg__tail(next)->seg_size = new_size;
            seg__head(seg)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(seg)->free_seg = next_free;
        } else {
            size_t new_size = seg__size(seg) + seg__size(next);
            seg__tail(next)->seg_size = new_size;
            seg__head(seg)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(seg)->free_seg = 0;
        }

    } else {
        bool seg_is_available = seg__is_available(seg);

        // getting rid of two of the three segs
        if (seg_is_available) {
            seg_state__available(memory, first_free, seg, false);
            seg_state__available(memory, first_free, next, false);
        } else {
            seg_state__available(memory, first_free, prev, false);
            seg_state__available(memory, first_free, next, false);
        }

        // problem: after updating size, need to update link
        if (seg_is_available) {
            seg_t next_free = seg__next_free(next);
            size_t new_size = seg__size(seg) + seg__size(prev) + seg__size(next);
            seg__tail(next)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(prev)->free_seg = next_free;
        } else {
            size_t new_size = seg__size(seg) + seg__size(prev) + seg__size(next);
            seg__tail(next)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            // fix tail link as sized changed
            seg__tail(prev)->free_seg = 0;
        }

        // maintain seg's data
        if (seg_is_available) {
            seg__copy_data(prev, seg, seg__data_size(prev));
        }
    }

    if (is_prev_available) {
        seg = prev;
    }
    
    return seg;
}

size_t seg__check_coal_size(memory_slice_t memory, seg_t seg) {
    ASSERT(seg);
    
    seg_t prev = seg__prev(memory, seg);
    seg_t next = seg__next(memory, seg);

    bool is_prev_available = prev && seg__is_available(prev);
    bool is_next_available = next && seg__is_available(next);

    if (!is_prev_available && !is_next_available) {
        return seg__size(seg);
    } else if (is_prev_available && !is_next_available) {
        return seg__size(seg) + seg__size(prev);
    } else if (!is_prev_available && is_next_available) {
        return seg__size(seg) + seg__size(next);
    } else {
        return seg__size(seg) + seg__size(prev) + seg__size(next);
    }
}

seg_t seg__detach(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t new_seg_size) {
    // store state of seg
    seg_state state = seg_state__get(seg);
    ASSERT(!state.available);

    if (new_seg_size == state.seg_size) {
        return seg;
    }

    ASSERT(new_seg_size < state.seg_size);

    size_t detachment_size = state.seg_size - new_seg_size;
    seg_t  detachment = (seg_t) ((u8*) seg + new_seg_size);

    // do not support 0 size segments
    if (detachment_size <= seg__data_size_to_seg_size(0)) {
        return seg;
    }

    // initialize the two new segments
    seg_state__init(detachment, detachment_size, false, 0, 0);
    seg_state__init(seg, new_seg_size, state.available, state.prev_free, state.next_free);

    // free the detachment
    DISCARD_RETURN seg__free(memory, first_free, detachment);

    return seg;
}

void seg_state__init(seg_t seg, size_t seg_size, bool available, seg_t prev_free, seg_t next_free) {
    ASSERT(seg);

    seg__head(seg)->seg_size = seg_size;
    seg__tail(seg)->seg_size = seg_size;
    seg__head(seg)->free_seg = prev_free;
    seg__tail(seg)->free_seg = next_free;
    seg__head(seg)->is_available = available;
    seg__tail(seg)->is_available = available;
}

seg_state seg_state__get(seg_t seg) {
    seg_state result = {
        .seg_size = seg__size(seg),
        .available = seg__is_available(seg),
        .prev_free = seg__prev_free(seg),
        .next_free = seg__next_free(seg)
    };

    return result;
}

void seg_state__available(memory_slice_t memory, seg_t* first_free, seg_t seg, bool value) {
    ASSERT(seg);

    if (seg__is_available(seg) == value) {
        return ;
    }

    if (seg__is_available(seg)) {
        seg__head(seg)->is_available = value;
        seg__tail(seg)->is_available = value;

        ASSERT(*first_free);

        seg_t prev = seg__prev_free(seg);
        seg_t next = seg__next_free(seg);

        seg__head(seg)->free_seg = 0;
        seg__tail(seg)->free_seg = 0;

        if (prev) {
            seg__tail(prev)->free_seg = next;
        }
        if (next) {
            seg__head(next)->free_seg = prev;
        }

        if (*first_free == seg) {
            if (prev) {
                *first_free = prev;
            } if (next) {
                *first_free = next;
            } else {
                *first_free = 0;
            }
        } else {
            ASSERT(prev);
            ASSERT(*first_free == prev);
        }
    } else {
        seg__head(seg)->is_available = value;
        seg__tail(seg)->is_available = value;

        seg_t prev = seg__find_prev_free(memory, seg);
        seg_t next = seg__find_next_free(memory, seg);

        if (prev) {
            seg__tail(prev)->free_seg = seg;
        }
        seg__head(seg)->free_seg = prev;
        seg__tail(seg)->free_seg = next;
        if (next) {
            seg__head(next)->free_seg = seg;
        }

        if (!*first_free) {
            *first_free = seg;
        } else if ((u8*) seg < (u8*) *first_free) {
            ASSERT(next);
            ASSERT(*first_free == next);
            *first_free = seg;
        }
    }
}

seg_t seg__convert_memory_to_seg(memory_slice_t memory) {
    seg_t seg = (seg_t) memory_slice__memory(&memory);

    seg_state__init(seg, memory_slice__size(&memory), true, 0, 0);

    return seg;
}

void seg__print(memory_slice_t memory) {
    seg_t seg = (seg_t) memory_slice__memory(&memory);

    libc__printf("--== Segments start ==--\n");
    while (seg) {
        seg_tag_t tag = seg__head(seg);
        seg_t expected = (seg_t) ((u8*) seg + tag->seg_size);
        seg_t next = seg__next(memory, seg);
        libc__printf(
            "[<- %12p, %12p, %s, %8u, %12p%s, %12p ->]\n",
            seg__prev_free(seg),
            seg,
            tag->is_available ? "free" : "used",
            tag->seg_size,
            next ? expected : 0,
            next ? (((u8*) expected == (u8*) next) ? "" : " ??") : "",
            seg__next_free(seg)
        );
        seg = next;
    }
    libc__printf("--== Segments end ==--\n");
}

seg_t seg__malloc(memory_slice_t memory, seg_t* first_free, size_t data_size_requested) {
    // look for available with one of the sequential fit policy
    seg_t seg = seg__first_fit(first_free, data_size_requested);
    if (!seg) {
        return NULL;
    }

    // make seg unavailable
    seg_state__available(memory, first_free, seg, false);
    // detach the unnecessary segment
    seg = seg__detach(memory, first_free, seg, seg__data_size_to_seg_size(data_size_requested));

    return seg;
}

seg_t seg__realloc(memory_slice_t memory, seg_t* first_free, void* data, size_t data_size_requested) {
    ASSERT(data_size_requested != 0);

    seg_t seg = 0;

    if (data == NULL) {
        return seg__malloc(memory, first_free, data_size_requested);
    }

    seg = seg__data_to_seg(data);
    ASSERT(!seg__is_available(seg));

    size_t old_data_size = seg__data_size(seg);
    if (old_data_size < data_size_requested) {
        // coal if it would satisfy the request
        size_t coal_data_size = seg__seg_size_to_data_size(seg__check_coal_size(memory, seg));

        size_t required_seg_size = seg__data_size_to_seg_size(data_size_requested);
        size_t coal_seg_size = seg__data_size_to_seg_size(coal_data_size);

        bool is_coal_big_enough = coal_data_size >= data_size_requested;
        bool is_coal_bigger_than_smallest_seg = is_coal_big_enough && (coal_seg_size - required_seg_size > seg__data_size_to_seg_size(0));

        if (is_coal_bigger_than_smallest_seg) {
            seg = seg__coal(memory, first_free, seg);

            // detach the unnecessary segment
            seg = seg__detach(memory, first_free, seg, seg__data_size_to_seg_size(data_size_requested));
            return seg;
        }

        // todo: copy and free before looking for sequential fit

        // malloc new seg
        seg_t new_seg = seg__malloc(memory, first_free, data_size_requested);
        if (!new_seg) {
            return NULL;
        }

        // copy data to new seg
        seg__copy_data(new_seg, seg, seg__data_size(seg));
        // free seg
        seg__free(memory, first_free, seg);

        return new_seg;
    } else if (data_size_requested < old_data_size) {
        // detach the unnecessary segment
        seg = seg__detach(memory, first_free, seg, seg__data_size_to_seg_size(data_size_requested));
        return seg;
    } else {
        return seg;
    }

    ASSERT(false);
}

seg_t seg__free(memory_slice_t memory, seg_t* first_free, seg_t seg) {
    ASSERT(!seg__is_available(seg));
    seg_state__available(memory, first_free, seg, true);

    return seg__coal(memory, first_free, seg);
}

seg_t seg__data_to_seg(void* data) {
    if (!data) {
        return NULL;
    }
    
    return (seg_t) ((u8*) data - sizeof(struct seg_tag));
}

void seg__copy_data(seg_t dst, seg_t src, size_t size) {
    size_t src_size = seg__head(src)->seg_size;
    size_t dst_size = seg__head(dst)->seg_size;
    ASSERT(src_size <= dst_size);

    libc__memmove(seg__seg_to_data(dst), seg__seg_to_data(src), size);
}
