#include "segment.h"

#include "memory/memory.h"
#include "libc/libc.h"

struct seg_tag {
    u32   seg_size     : 31;
    u32   is_available : 1;
    u32   ref_count    : 16; // how many nodes are referencing this as a free node
    seg_t free_seg;
};

void*     seg__data(seg_t seg); // payload data
size_t    seg__data_size(seg_t seg); // size of payload data
seg_tag_t seg__head(seg_t seg); // header tag of segment
seg_tag_t seg__tail(seg_t seg); // tailer tag of segment
size_t    seg__size(seg_t seg); // get size of segment
void      seg__set_size(seg_t seg, size_t size); // set size of segment
seg_t     seg__shrink(memory_slice_t memory, seg_t seg, size_t size); // splits seg, returns the seg with the required size
bool      seg__is_available(seg_t seg); // true if segment is available
void      seg__set_available(seg_t seg, bool free);
seg_t     seg__next(memory_slice_t memory, seg_t seg); // next seg in memory
seg_t     seg__prev(memory_slice_t memory, seg_t seg); // prev seg in memory
seg_t     seg__next_free(seg_t seg); // next free seg
seg_t     seg__prev_free(seg_t seg); // prev free seg
void      seg__set_next_free(seg_t seg, seg_t free);
void      seg__set_prev_free(seg_t seg, seg_t free);
seg_t     seg__coal(seg_t left, seg_t right); // coalesces two segments into one, returns result

// todo: move this concept into central place
// this array holds the information of free segments, so that segs that reference this as their next/prev seg can be
// all updated by changing the value in here, this array has to be referenced counted
static seg_t free_segs[KILOBYTES(4)];

void idk() {
    // just allocated a seg, have to split
    seg_t seg;
    // splitting the seg..
    seg_t split_seg;

    seg__tail(seg)->free_seg;
}

// Sequential Fit Policies
/*  First Fit
    Searches the list of free blocks from 'seg' and uses the first block large enough to satisfy the request.
    If the block is larger than necessary, it is split and the remainder is put in the free list.
    Problem: The larger blocks near the beginning of the list tend to be split first, and the remaining fragments
    result in a lot of small free blocks near the beginning of the list.
*/
seg_t     seg__first_fit(seg_t first_free_seg, size_t size);
/*  Next Fit
    Search from segment X with first fit policy.
    Policies for X:
        Roving pointer: Ideally this pointer always points to the largest segment. This is achieved by setting it
        to the segment immediately followed by the last allocation performed (often, this will be sufficiently
        big for the next allocation).
*/
seg_t     seg__next_fit(seg_t seg, size_t size);
/*  Best Fit
    Search the entire list to find the smallest, that is large enough to satisfy the request.
    It may stop if a perfect fit is found earlier.
    Problem: Depending on how the data structure is implemented, this can be slow.
*/
seg_t     seg__best_fit(seg_t first_free_seg, size_t size);

seg_tag_t seg__head(seg_t seg) {
    ASSERT(seg);

    return (seg_tag_t) seg;
}

seg_tag_t seg__tail(seg_t seg) {
    ASSERT(seg);
    
    return (seg_tag_t) ((u8*) seg + seg__size(seg) - sizeof(struct seg_tag));
}

void* seg__data(seg_t seg) {
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

void seg__set_size(seg_t seg, size_t size) {
    seg_tag_t head = seg__head(seg);
    seg_tag_t tail = seg__tail(seg);
    
    head->seg_size = size;
    tail->seg_size = size;
}

seg_t seg__shrink(memory_slice_t memory, seg_t seg, size_t size) {
    ASSERT(!seg__is_available(seg));

    size_t seg_size = seg__size(seg);
    seg_t next_seg = seg__next(memory, seg);
    seg_t next_free = seg__next_free(seg);
    seg_t prev_free = seg__prev_free(seg);

    // update own size
    seg__set_size(seg, size);

    // deal with the split seg
    seg_t split_seg = (seg_t) ((u8*) seg + size);
    ASSERT(size < seg_size)
    seg__set_size(split_seg, seg_size - size);
    seg__set_prev_free();
    
    // update next seg in memory
    if (next_seg) {
    }

    // update result seg
}

seg_t seg__first_fit(seg_t first_free_seg, size_t size) {
    while (first_free_seg) {
        ASSERT(seg__is_available(first_free_seg));

        size_t seg_size = seg__data_size(first_free_seg);
        if (seg_size >= size) {
            return first_free_seg;
        }

        first_free_seg = seg__next_free(first_free_seg);
    }

    return NULL;
}

seg_t seg__next_fit(seg_t seg, size_t size) {
    // todo: implement
    return seg__first_fit(seg, size);
}

seg_t seg__best_fit(seg_t first_free_seg, size_t size) {
    seg_t best_seg = NULL;
    while (first_free_seg) {
        ASSERT(seg__is_available(first_free_seg));

        size_t seg_size = seg__data_size(first_free_seg);
        if (seg_size >= size) {
            if (best_seg == NULL) {
                best_seg = first_free_seg;
            } else if (seg_size < seg__data_size(best_seg)) {
                best_seg = first_free_seg;
            }
        }

        first_free_seg = seg__next_free(first_free_seg);
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

    seg_tag_t prev_seg_tail = *(seg_tag_t*) ((u8*) seg - sizeof(struct seg_tag));
    size_t prev_seg_size = seg__size(prev_seg_tail);

    return (u8*) seg - prev_seg_size;
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
    seg__tail(seg)->is_available = free ;
}

seg_t seg__coal(seg_t left, seg_t right) {
    ASSERT(seg__is_available(left) && seg__is_available(right));
    ASSERT((u8*) seg__tail(left) + sizeof(struct seg_tag) == (u8*) right);

    seg__set_size(right, seg__size(right) + seg__size(left));
    seg__set_size(left, seg__size(right));

    return left;
}

seg_t seg__init(void* data, size_t size) {
    seg_t seg = (seg_t) data;

    seg__set_size(seg, size);
    seg__set_available(seg, true);
    seg__set_next_free(seg, 0);
    seg__set_prev_free(seg, 0);

    return seg;
}

seg_t seg__realloc(memory_slice_t memory, seg_t* first_free, seg_t seg, size_t size) {
    ASSERT(size != 0);

    if (seg == NULL) {
        // look for available with one of the sequential fit policy
        seg_t seg = seg__first_fit(first_free, size);
        // shrink to required size
        seg__set_size(seg, size);
        // free up the 
    }

    ASSERT(!seg__is_available(seg));

    size_t old_size = seg__data_size(seg);
    if (old_size < size) {
        // try to grow
        seg_t next_free_seg = seg__next_free(seg);
        if (next_free_seg) {
            // check next seg in memory, if it's the free seg, check if we can grow into it
            seg_t next_seg_in_memory = seg__next(memory, seg);
            if (next_seg_in_memory == next_free_seg || old_size + seg__size(next_seg_in_memory) >= size) {
                // grow into next_seg_in_memory
                ASSERT(false);
                return seg;
            }

            // otherwise find seq fit, copy, free, return

            // todo: copy and free before looking for sequential fit

            // all segs are occupied till end of the memory
            // look for available with one of the sequential fit policy
            seg_t result = seg__first_fit(first_free, size);
            // need to copy here before freeing the segment
            seg__copy(result, seg);
            // free seg
            seg__free(first_free, seg);

            return result;
        } else {
            // todo: copy and free before looking for sequential fit

            // all segs are occupied till end of the memory
            // look for available with one of the sequential fit policy
            seg_t result = seg__first_fit(first_free, size);
            // need to copy here before freeing the segment
            seg__copy(result, seg);
            // free seg
            seg__free(first_free, seg);

            return result;
        }
    } else if (size < old_size) {
        // shrink
        seg__set_size(seg, size);
        return seg;
    } else {
        return seg;
    }

    ASSERT(false);
}

void seg__free(seg_t* first_free, seg_t seg) {
    seg__set_available(seg, true);

    seg_t prev_free = seg__prev_free(seg);
    seg_t next_free = seg__next_free(seg);

    // update prev free seg and coalesce
    if (prev_free) {
        seg__set_next_free(prev_free, next_free);
        seg__coal(prev_free, seg);
    } else if (!first_free || (u8*) seg < (u8*) first_free) {
        // update first free segment
        *first_free = seg;
    }

    // update next free seg and coalesce
    if (next_free) {
        seg__set_prev_free(next_free, prev_free);
        seg__coal(seg, next_free);
    }
}

void seg__copy(seg_t dst, seg_t src) {
    size_t src_size = seg__size(src);
    ASSERT(src_size < seg__size(dst));

    libc__memmove(seg__data(dst), seg__data(src), src_size);
}
