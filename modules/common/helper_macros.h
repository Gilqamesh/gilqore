#ifndef HELPER_MACROS_H
# define HELPER_MACROS_H

# define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
# define MEMBER_SIZE(struct_type, member_name) (((struct_type*)0)->member_name)
# define ARRAY_SIZE_MEMBER(struct_type, member_name) (sizeof(MEMBER_SIZE(struct_type, member_name)) / sizeof((MEMBER_SIZE(struct_type, member_name))[0]))

# define BYTES(bytes)     (bytes)
# define KILOBYTES(bytes) (BYTES(bytes) * 1024LL)
# define MEGABYTES(bytes) (KILOBYTES(bytes) * 1024LL)
# define GIGABYTES(bytes) (MEGABYTES(bytes) * 1024LL)
# define TERABYTES(bytes) (GIGABYTES(bytes) * 1024LL)

#endif
