#ifndef HELPER_MACROS_H
# define HELPER_MACROS_H

# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
# define MEMBER(struct_type, member_name) (((struct_type*)0)->member_name)
# define ARRAY_SIZE_MEMBER(struct_type, member_name) (sizeof(MEMBER(struct_type, member_name)) / sizeof((MEMBER(struct_type, member_name))[0]))

# define KILOBYTES(bytes) ((bytes) * 1024LL)
# define MEGABYTES(bytes) (KILOBYTES(bytes) * 1024LL)
# define GIGABYTES(bytes) (MEGABYTES(bytes) * 1024LL)
# define TERABYTES(bytes) (GIGABYTES(bytes) * 1024LL)

#endif
