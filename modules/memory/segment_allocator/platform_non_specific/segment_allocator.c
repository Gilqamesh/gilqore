#include "memory/segment_allocator/segment_allocator.h"

#include "memory/memory.h"
#include "libc/libc.h"

typedef struct seg_tag {
    u32   seg_size     : 31;
    u32   is_available : 1;
    seg_t free_seg;
} *seg_tag_t;

struct seg_state {
    bool    is_available;
    seg_t   next;
    seg_t   prev;
};

typedef struct { // stored at the end of the provided memory
    size_t  ff;
} aux_state;

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
seg_t     seg__coal(memory_slice_t memory, seg_t seg);
// returns the size of coaling without applying coal
size_t    seg__check_coal_size(memory_slice_t memory, seg_t seg);
// removes part of the seg, seg must be not available, returns the seg with the required size [!A] -> [!A][A]
seg_t     seg__detach(memory_slice_t memory, seg_t seg, size_t new_seg_size);
// copy 'size' bytes from the start of src's data to the start of dst's data
void      seg__copy_data(seg_t dst, seg_t src, size_t size);

// get the first free pointer
seg_t     seg__get_ff(memory_slice_t memory);
// seg the first free pointer
void      seg__set_ff(memory_slice_t memory, seg_t seg);

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
void seg_state__available(memory_slice_t memory, seg_t seg, bool value);

// Sequential Fit Policies
/*  First Fit
    Searches the list of free blocks from 'seg' and uses the first block large enough to satisfy the request.
    If the block is larger than necessary, it is split and the remainder is put in the free list.
    Problem: The larger blocks near the beginning of the list tend to be split first, and the remaining fragments
    result in a lot of small free blocks near the beginning of the list.
*/
seg_t     seg__first_fit(memory_slice_t memory, size_t requested_seg_size);
/*  Next Fit
    Search from segment X with first fit policy.
    Policies for X:
        Roving pointer: Ideally this pointer always points to the largest segment. This is achieved by setting it
        to the segment immediately followed by the last allocation performed (often, this will be sufficiently
        big for the next allocation).
*/
seg_t     seg__next_fit(memory_slice_t memory, size_t requested_seg_size);
/*  Best Fit
    Search the entire list to find the smallest, that is large enough to satisfy the request.
    It may stop if a perfect fit is found earlier.
    Problem: Depending on how the data structure is implemented, this can be slow.
*/
seg_t     seg__best_fit(memory_slice_t memory, size_t requested_seg_size);

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

seg_t seg__first_fit(memory_slice_t memory, size_t requested_seg_size) {
    seg_t cur = seg__get_ff(memory);
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

seg_t seg__next_fit(memory_slice_t memory, size_t requested_seg_size) {
    // todo: implement
    return seg__first_fit(memory, requested_seg_size);
}

seg_t seg__best_fit(memory_slice_t memory, size_t requested_seg_size) {
    seg_t best_seg = NULL;
    seg_t cur_seg = seg__get_ff(memory);
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
    if ((u8*) next_seg >= (u8*) memory_slice__memory(&memory) + memory_slice__size(&memory) - sizeof(aux_state)) {
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
    // size_t prev_seg_size = seg__size(prev_seg_tail);

    return (u8*) seg - prev_seg_tail->seg_size;
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

seg_t seg__coal(memory_slice_t memory, seg_t seg) {
    ASSERT(seg);
    
    seg_t prev = seg__prev(memory, seg);
    seg_t next = seg__next(memory, seg);

    bool is_prev_available = prev && seg__is_available(prev);
    bool is_next_available = next && seg__is_available(next);

    if (!is_prev_available && !is_next_available) {
    } else if (is_prev_available && !is_next_available) {
        /*
            [ A ][ A/!A ]
                    ^
        */

        size_t new_size = seg__size(seg) + seg__size(prev);

        if (seg__is_available(seg)) {
            seg_t next_free = seg__next_free(seg);

            seg_state__available(memory, seg, false);

            seg__tail(seg)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;
            
            seg__tail(prev)->free_seg = next_free;
            seg__tail(prev)->is_available = true;
        } else {
            size_t seg_data_size = seg__data_size(seg);
            void*  seg_dst       = seg__seg_to_data(prev);
            void*  seg_src       = seg__seg_to_data(seg);

            seg_state__available(memory, prev, false);

            seg__tail(seg)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            ASSERT(seg_data_size < seg__data_size(prev));
            libc__memmove(seg_dst, seg_src, seg_data_size);
        }
    } else if (!is_prev_available && is_next_available) {
        /*
            [ A/!A ][ A ]
               ^
        */

        size_t new_size = seg__size(seg) + seg__size(next);

        if (seg__is_available(seg)) {  
            seg_t next_free = seg__next_free(next);

            seg_state__available(memory, next, false);

            seg__tail(next)->seg_size = new_size;
            seg__head(seg)->seg_size = new_size;
            
            seg__tail(seg)->free_seg = next_free;
            seg__tail(seg)->is_available = true;
        } else {
            seg_state__available(memory, next, false);

            seg__tail(next)->seg_size = new_size;
            seg__head(seg)->seg_size = new_size;
        }
    } else {
        /*
            [ A ][ A/!A ][ A ]
                    ^
        */

        size_t new_size = seg__size(seg) + seg__size(prev) + seg__size(next);

        if (seg__is_available(seg)) {
            seg_t next_free = seg__next_free(next);

            seg_state__available(memory, seg, false);
            seg_state__available(memory, next, false);

            seg__tail(next)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            seg__tail(prev)->free_seg = next_free;
            seg__tail(prev)->is_available = true;
        } else {
            size_t seg_data_size = seg__data_size(seg);
            void*  seg_dst       = seg__seg_to_data(prev);
            void*  seg_src       = seg__seg_to_data(seg);

            seg_state__available(memory, prev, false);
            seg_state__available(memory, next, false);

            seg__tail(next)->seg_size = new_size;
            seg__head(prev)->seg_size = new_size;

            ASSERT(seg_data_size < seg__data_size(prev));
            libc__memmove(seg_dst, seg_src, seg_data_size);
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

seg_t seg__detach(memory_slice_t memory, seg_t seg, size_t new_seg_size) {
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

    ASSERT(seg__tail(seg)->free_seg == 0);
    ASSERT(seg__head(seg)->free_seg == 0);

    // free the detachment
    DISCARD_RETURN seg__free(memory, detachment);

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

void seg_state__available(memory_slice_t memory, seg_t seg, bool value) {
    ASSERT(seg);
    ASSERT(seg__is_available(seg) != value);

    if (seg__is_available(seg)) {
        seg__head(seg)->is_available = value;
        seg__tail(seg)->is_available = value;

        seg_t ff = seg__get_ff(memory);
        ASSERT(ff);

        seg_t prev_free = seg__prev_free(seg);
        seg_t next_free = seg__next_free(seg);

        seg__head(seg)->free_seg = 0;
        seg__tail(seg)->free_seg = 0;

        if (prev_free) {
            seg__tail(prev_free)->free_seg = next_free;
        }
        if (next_free) {
            seg__head(next_free)->free_seg = prev_free;
        }

        if (ff == seg) {
            if (prev_free) {
                seg__set_ff(memory, prev_free);
            } else if (next_free) {
                seg__set_ff(memory, next_free);
            } else {
                seg__set_ff(memory, 0);
            }
        } else {
            ASSERT(prev_free);
        }
    } else {
        seg__head(seg)->is_available = value;
        seg__tail(seg)->is_available = value;

        seg_t prev_free = seg__find_prev_free(memory, seg);
        seg_t next_free = seg__find_next_free(memory, seg);

        seg__head(seg)->free_seg = prev_free;
        seg__tail(seg)->free_seg = next_free;

        if (prev_free) {
            seg__tail(prev_free)->free_seg = seg;
        }
        if (next_free) {
            seg__head(next_free)->free_seg = seg;
        }

        seg_t ff = seg__get_ff(memory);
        if (!ff) {
            seg__set_ff(memory, seg);
        } else if ((u8*) seg < (u8*) ff) {
            ASSERT(next_free);
            ASSERT(ff == next_free);
            seg__set_ff(memory, seg);
        }
    }
}

bool seg__init(memory_slice_t memory) {
    size_t mem_size = memory_slice__size(&memory);
    if (mem_size < sizeof(aux_state)) {
        return false;
    }

    seg_t seg = (seg_t) memory_slice__memory(&memory);
    seg__set_ff(memory, seg);

    seg_state__init(seg, mem_size - sizeof(aux_state), true, 0, 0);

    return true;
}

bool seg__print(memory_slice_t memory, seg_t seg) {
    seg_tag_t tag = seg__head(seg);
    seg_t next = seg__next(memory, seg);
    seg_t expected = (seg_t) ((u8*) seg + tag->seg_size);
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

    return true;
}

void seg__print_aux(memory_slice_t memory) {
    libc__printf("--== Aux start      ==--\n");
    libc__printf("[ ff: %12p ]\n", (seg_t) seg__get_ff(memory));
    libc__printf("--== Aux end        ==--\n");
}

void seg__for_each(memory_slice_t memory, bool (*fn)(memory_slice_t memory, seg_t seg)) {
    seg_t seg = (seg_t) memory_slice__memory(&memory);

    while (seg) {
        seg_t next = seg__next(memory, seg);
        if (!fn(memory, seg)) {
            break ;
        }
        seg = next;
    }

}

seg_t seg__malloc(memory_slice_t memory, size_t data_size_requested) {
    // look for available with one of the sequential fit policy
    seg_t seg = seg__first_fit(memory, data_size_requested);
    if (!seg) {
        return NULL;
    }

    // make seg unavailable
    seg_state__available(memory, seg, false);
    // detach the unnecessary segment
    seg = seg__detach(memory, seg, seg__data_size_to_seg_size(data_size_requested));

    return seg;
}

seg_t seg__realloc(memory_slice_t memory, void* data, size_t data_size_requested) {
    ASSERT(data_size_requested != 0);

    seg_t seg = 0;

    if (data == NULL) {
        return seg__malloc(memory, data_size_requested);
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
            seg = seg__coal(memory, seg);

            // detach the unnecessary segment
            seg = seg__detach(memory, seg, seg__data_size_to_seg_size(data_size_requested));
            return seg;
        }

        // todo: copy and free before looking for sequential fit

        // malloc new seg
        seg_t new_seg = seg__malloc(memory, data_size_requested);
        if (!new_seg) {
            return NULL;
        }

        // copy data to new seg
        seg__copy_data(new_seg, seg, seg__data_size(seg));
        // free seg
        seg__free(memory, seg);

        return new_seg;
    } else if (data_size_requested < old_data_size) {
        // detach the unnecessary segment
        seg = seg__detach(memory, seg, seg__data_size_to_seg_size(data_size_requested));
        return seg;
    } else {
        return seg;
    }

    ASSERT(false);
}

seg_t seg__free(memory_slice_t memory, seg_t seg) {
    ASSERT(!seg__is_available(seg));
    seg_state__available(memory, seg, true);

    // libc__printf("------- BEFORE COAL START -------\n");
    // seg__for_each(memory, &seg__print);
    // libc__printf("------- BEFORE COAL END   -------\n");

    seg_t coaled_seg = seg__coal(memory, seg);

    // libc__printf("------- AFTER COAL START -------\n");
    // seg__for_each(memory, &seg__print);
    // libc__printf("------- AFTER COAL END   -------\n");

    return coaled_seg;
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

seg_t seg__get_ff(memory_slice_t memory) {
    void* data = memory_slice__memory(&memory);
    size_t data_size = memory_slice__size(&memory);
    aux_state* aux = (aux_state*) ((u8*) data + data_size - sizeof(aux_state));
    return (seg_t) aux->ff;
}

void seg__set_ff(memory_slice_t memory, seg_t seg) {
    void* data = memory_slice__memory(&memory);
    size_t data_size = memory_slice__size(&memory);
    aux_state* aux = (aux_state*) ((u8*) data + data_size - sizeof(aux_state));
    aux->ff = (size_t) seg;
}
