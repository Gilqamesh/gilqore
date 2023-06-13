#ifndef DATA_TYPES
# define DATA_TYPES

# include <stdint.h>
# include <stdbool.h>
# include <float.h>

typedef uint64_t u64;
typedef uint32_t u32;
typedef uint16_t u16;
typedef uint8_t  u8;

typedef int64_t  s64;
typedef int32_t  s32;
typedef int16_t  s16;
typedef int8_t   s8;

typedef double      r64;
typedef float       r32;

typedef size_t memory_index;

# define U64_MAX UINT64_MAX
# define U32_MAX UINT32_MAX
# define U16_MAX UINT16_MAX
# define U8_MAX  UINT8_MAX

# define S64_MAX INT64_MAX
# define S64_MIN INT64_MIN
# define S32_MAX INT32_MAX
# define S32_MIN INT32_MIN
# define S16_MAX INT16_MAX
# define S16_MIN INT16_MIN
# define S8_MAX  INT8_MAX
# define S8_MIN  INT8_MIN

# define R64_MAX DBL_MAX
# define R64_MIN DBL_MIN
# define R32_MAX FLT_MAX
# define R32_MIN FLT_MIN

# if !defined(NULL)
#  define NULL ((char*)0)
# endif

#endif // DATA_TYPES
