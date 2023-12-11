#ifndef BUFFER_H
# define BUFFER_H

# include <stdbool.h>
# include <stdint.h>

# define BUFFER_CHECK(buffer, addr) do { \
    ASSERT((uint8_t*) (addr) >= (buffer).start && "Buffer underflow."); \
    ASSERT((uint8_t*) (addr) < (buffer).end && "Buffer overflow."); \
} while (false)
# define BUFFER_SET(buffer, n) do { \
    BUFFER_CHECK((buffer), (n)); \
    (buffer).cur = (uint8_t*) (n); \
} while (false)
# define BUFFER_GROW(buffer, n) do { \
    BUFFER_SET((buffer), (buffer).cur + (n)); \
} while (false)
# define BUFFER_PUSH(buffer, type, a) do { \
    *(type*) ((buffer).cur) = (a); \
    BUFFER_GROW((buffer), sizeof(type)); \
} while (false)
# define BUFFER_TOP(buffer, type, offset, result) do { \
    ( result = *(type*) ((buffer).cur - sizeof(type) + (offset))); \
} while (false)
# define BUFFER_POP(buffer, type, result) do { \
    BUFFER_CHECK((buffer), (buffer).cur - sizeof(type)); \
    result = *(type*) ((buffer).cur - sizeof(type)); \
    (buffer).cur -= sizeof(type); \
} while (false)

# define ALIGNED_BUFFER_PUSH(aligned_buffer, size, alignment) do { \
    ASSERT((aligned_buffer).offset_cur < (aligned_buffer).offset_end && "Aligned buffer overflow."); \
    uint64_t remainder = ((uint64_t) (aligned_buffer).buffer.cur) % (alignment); \
    uint32_t offset = 0; \
    if (remainder) { \
        offset = (alignment) - (remainder); \
    } \
    *(aligned_buffer).offset_cur++ = offset; \
    *(aligned_buffer).addr_cur++ = (aligned_buffer).buffer.cur + offset; \
    BUFFER_GROW((aligned_buffer).buffer, offset + (size)); \
} while (false)
# define ALIGNED_BUFFER_POP(aligned_buffer, n) do { \
    ASSERT(((aligned_buffer).offset_cur - (n)) >= (aligned_buffer).offset_start && "Aligned buffer underflow."); \
    (aligned_buffer).buffer.cur = *((aligned_buffer).addr_cur - (n)) - *((aligned_buffer).offset_cur - (n)); \
    (aligned_buffer).offset_cur -= (n); \
    (aligned_buffer).addr_cur -= (n); \
} while (false)
# define ALIGNED_BUFFER_ADDR_AT(aligned_buffer, index, type_of_addr, result_addr) do { \
    ASSERT((aligned_buffer).offset_cur - (index) - 1 >= (aligned_buffer).offset_start && "Aligned buffer underflow."); \
    result_addr = (type_of_addr) *((aligned_buffer).addr_cur  - (index) - 1); \
} while (false)

// [..data..][..data..] ...
typedef struct buffer {
    uint8_t* cur;
    uint8_t* start;
    uint8_t* end;
} buffer_t;

bool buffer__create(buffer_t* self, uint32_t size);
void buffer__destroy(buffer_t* self);

// [..offset.. ..data..][..offset.. ..data..] ...
//               ^ *(addr_cur - 2))   ^ *(addr_cur - 1)
typedef struct aligned_buffer {
    buffer_t  buffer;
    // offset due to alignment
    uint32_t* offset_cur;
    uint32_t* offset_start;
    uint32_t* offset_end;
    // start addr of each data
    uint8_t** addr_cur;
    uint8_t** addr_start;
    uint8_t** addr_end;
} aligned_buffer_t;

bool aligned_buffer__create(aligned_buffer_t* self, uint32_t size, uint32_t max_number_of_elements);
void aligned_buffer__destroy(aligned_buffer_t* self);

#endif // BUFFER_H
