#include "segment.h"

#include "memory/memory.h"
#include "libc/libc.h"

struct seg_tag {
    u32   seg_size     : 31;
    u32   is_available : 1;
    seg_t free_seg;
};

seg_t     seg__data_to_seg(void* data); // converts data to seg
void*     seg__seg_to_data(seg_t seg); // payload data
size_t    seg__data_size(seg_t seg); // size of payload data
seg_tag_t seg__head(seg_t seg); // header tag of segment
seg_tag_t seg__tail(seg_t seg); // tailer tag of segment
size_t    seg__size(seg_t seg); // get size of segment
void      seg__set_size(seg_t seg, size_t segment_size); // set size of segment
seg_t     seg__shrink(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t requested_seg_size); // splits seg, returns the seg with the required size
bool      seg__is_available(seg_t seg); // true if segment is available
void      seg__set_available(seg_t seg, bool free);
seg_t     seg__next(memory_slice_t memory, seg_t seg); // next seg in memory
seg_t     seg__prev(memory_slice_t memory, seg_t seg); // prev seg in memory
seg_t     seg__find_next_free(memory_slice_t memory, seg_t seg);
seg_t     seg__find_prev_free(memory_slice_t memory, seg_t seg);
seg_t     seg__next_free(seg_t seg); // next free seg
seg_t     seg__prev_free(seg_t seg); // prev free seg
void      seg__set_next_free(seg_t seg, seg_t free);
void      seg__set_prev_free(seg_t seg, seg_t free);
seg_t     seg__coal(seg_t left, seg_t right); // coalesces two segments into one, returns result

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
    return (u8*) seg + sizeof(struct seg_tag);
}

size_t seg__data_size(seg_t seg) {
    seg_tag_t head = seg__head(seg);
    seg_tag_t tail = seg__tail(seg);
    if (head == tail) {
        return seg__size(seg) - sizeof(struct seg_tag);
    }
    else {
        return seg__size(seg) - 2 * sizeof(struct seg_tag);
    }
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

seg_t seg__shrink(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t requested_seg_size) {
    ASSERT(requested_seg_size > sizeof(seg_tag_t));

    ASSERT(!seg__is_available(seg));

    size_t seg_size = seg__size(seg);
    ASSERT(requested_seg_size < seg_size);
    size_t split_seg_size = seg_size - requested_seg_size;
    seg_t split_seg = (seg_t) ((u8*) seg + requested_seg_size);
    seg_t prev_free = seg__find_prev_free(memory, seg);
    seg_t next_free = seg__find_next_free(memory, seg);

    // deal with the split seg
    seg__set_size(split_seg, split_seg_size);
    seg__set_prev_free(split_seg, prev_free);
    seg__set_next_free(split_seg, next_free);
    seg__set_available(split_seg, true);
    
    // update next free (is same as next -> coal) and prev free
    if (next_free) {
        if (next_free == seg__next(memory, seg)) {
            // coal with split_seg
            split_seg = seg__coal(split_seg, next_free);
        } else {
            seg__set_prev_free(next_free, split_seg);
        }
    }
    if (prev_free) {
        seg__set_next_free(prev_free, split_seg);
    }

    // update result seg
    seg__set_size(seg, requested_seg_size);
    seg__set_next_free(seg, 0);
    seg__set_prev_free(seg, 0);

    // update first_free
    if (seg == *first_free) {
        *first_free = split_seg;
    }

    return seg;
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

void seg__set_next_free(seg_t seg, seg_t free) {
    seg__tail(seg)->free_seg = free;
}

void seg__set_prev_free(seg_t seg, seg_t free) {
    seg__head(seg)->free_seg = free;
}

bool seg__is_available(seg_t seg) {
    return seg__head(seg)->is_available;
}

void seg__set_available(seg_t seg, bool free) {
    seg__head(seg)->is_available = free;
    seg__tail(seg)->is_available = free;
}

seg_t seg__coal(seg_t left, seg_t right) {
    ASSERT(seg__is_available(left) && seg__is_available(right));
    ASSERT((u8*) seg__tail(left) + sizeof(struct seg_tag) == (u8*) right);

    seg__set_size(right, seg__size(right) + seg__size(left));
    seg__set_size(left, seg__size(right));

    return left;
}

seg_t seg__init(void* data, size_t data_size) {
    seg_t seg = (seg_t) data;

    // note: set_size takes in segment_size, which is normally data_size + 2 * sizeof(struct seg_tag), but in this case
    // we are provided raw data, so we initialize the segment to contain the entire data
    seg__set_size(seg, data_size);
    seg__set_available(seg, true);
    seg__set_next_free(seg, 0);
    seg__set_prev_free(seg, 0);

    return seg;
}

void* seg__realloc(memory_slice_t memory, seg_t* first_free, void* data, size_t data_size_requested) {
    ASSERT(data_size_requested != 0);

    seg_t seg = 0;
    size_t seg_size_requested = data_size_requested + 2 * sizeof(struct seg_tag);

    if (data == NULL) {
        // act as malloc

        // look for available with one of the sequential fit policy
        seg = seg__first_fit(first_free, data_size_requested);
        // shrink to required segment_size
        // todo: weird, seg__shrink operates with non-available data
        seg__set_available(seg, false);
        seg = seg__shrink(memory, first_free, seg, seg_size_requested);
        return seg__seg_to_data(seg);
    }

    seg = seg__data_to_seg(data);
    ASSERT(!seg__is_available(seg));

    size_t old_data_size = seg__data_size(seg);
    if (old_data_size < data_size_requested) {
        seg_t seg_to_grow_into = seg__next(memory, seg);
        if (seg_to_grow_into && seg__is_available(seg_to_grow_into)) {
            // next segment is available, potentially we can grow into it which'd satisfy the request
            size_t new_data_size = old_data_size + seg__data_size(seg_to_grow_into) + 2 * sizeof(struct seg_tag);
            if (new_data_size >= data_size_requested) {
                seg_t prev_seg = seg__prev_free(seg_to_grow_into);
                seg_t next_seg = seg__next_free(seg_to_grow_into);
                if (prev_seg) {
                    seg__set_next_free(prev_seg, next_seg);
                }
                if (next_seg) {
                    seg__set_prev_free(next_seg, prev_seg);
                }
                seg__set_size(seg, new_data_size + 2 * sizeof(struct seg_tag));
                seg = seg__shrink(memory, first_free, seg, seg_size_requested);
                return seg__seg_to_data(seg);
            }
        }

        // todo: copy and free before looking for sequential fit

        // all segs are occupied till end of the memory
        // look for available with one of the sequential fit policy
        seg_t result = seg__first_fit(first_free, seg_size_requested);
        // need to copy here before freeing the segment
        seg__copy(result, seg);
        // free seg
        seg__free(memory, first_free, seg__seg_to_data(seg));

        return seg__seg_to_data(result);
    } else if (data_size_requested < old_data_size) {
        // shrink
        seg = seg__shrink(memory, first_free, seg, seg_size_requested);
        return seg__seg_to_data(seg);
    } else {
        return seg__seg_to_data(seg);
    }

    ASSERT(false);
}

void seg__free(memory_slice_t memory, seg_t* first_free, void* data) {
    ASSERT(*first_free);

    seg_t seg = seg__data_to_seg(data);

    seg__set_available(seg, true);

    seg_t next_seg = seg__next(memory, seg);
    seg_t prev_seg = seg__prev(memory, seg);

    // if prev seg free -> update prev free seg and coalesce
    if (prev_seg && seg__is_available(prev_seg)) {
        seg__set_next_free(prev_seg, next_seg);
        seg = seg__coal(prev_seg, seg);
    }
    
    if (!*first_free || (u8*) seg < (u8*) *first_free) {
        // update first free segment
        *first_free = seg;
    }

    // if next seg free -> update next free seg and coalesce
    if (next_seg && seg__is_available(next_seg)) {
        seg__set_prev_free(next_seg, prev_seg);
        seg__coal(seg, next_seg);
    }
}

seg_t seg__data_to_seg(void* data) {
    return (seg_t) ((u8*) data - sizeof(struct seg_tag));
}

void seg__copy(seg_t dst, seg_t src) {
    size_t src_size = seg__size(src);
    ASSERT(src_size < seg__size(dst));

    libc__memmove(seg__seg_to_data(dst), seg__seg_to_data(src), src_size);
}
