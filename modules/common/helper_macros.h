#ifndef HELPER_MACROS_H
# define HELPER_MACROS_H

# define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
# define STRUCT_MEMBER(struct_type, member_name) (((struct_type*)0)->member_name)
# define ARRAY_SIZE_MEMBER(struct_type, member_name) (sizeof(STRUCT_MEMBER(struct_type, member_name)) / sizeof((STRUCT_MEMBER(struct_type, member_name))[0]))

# define BYTES(bytes)     (bytes)
# define KILOBYTES(bytes) (BYTES(bytes) * 1024LL)
# define MEGABYTES(bytes) (KILOBYTES(bytes) * 1024LL)
# define GIGABYTES(bytes) (MEGABYTES(bytes) * 1024LL)
# define TERABYTES(bytes) (GIGABYTES(bytes) * 1024LL)

# define ASSERTF(cond, format) do { \
    if (!(cond)) { \
        libc__printf(format); \
        ASSERT(cond); \
    } \
} while (false)

# define ASSERTFV(cond, format, ...) do { \
    if (!(cond)) { \
        libc__printf(format, __VA_ARGS__); \
        ASSERT(cond); \
    } \
} while (false)

#endif
