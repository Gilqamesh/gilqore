#ifndef COMPILE_DEFS_H
# define COMPILE_DEFS_H

// compiler used
# ifdef __TINYC__
#  define COMPILER_TCC
# elif defined(_MSC_VER)
#  define COMPILER_MSVC
# elif defined(__GNUC__)
#  define COMPILER_GCC
# endif

# if defined (_WIN32) || defined (__CYGWIN__)
#  define WINDOWS
# elif defined(__linux__)
#  define LINUX
# elif defined(__APPLE__)
#  define MAC
# else
#  error "platform unsupported"
# endif

# if defined(__cplusplus)
#  define C_LINKAGE extern "C"
# endif

# if !defined(C_LINKAGE)
#  define C_LINKAGE
# endif


# if defined(WINDOWS)
#  if defined(GIL_LIB_SHARED_EXPORT)
#   define PUBLIC_API __declspec(dllexport) C_LINKAGE
#  elif defined(GIL_LIB_SHARED_IMPORT)
#   define PUBLIC_API __declspec(dllimport) C_LINKAGE
#  endif
# endif

# if !defined(PUBLIC_API)
#  define PUBLIC_API C_LINKAGE
# endif

# if defined(GIL_DEBUG)
#  include <assert.h>
#  define ASSERT(condition) assert(condition)
# else
#  define ASSERT(condition)
# endif

# if defined(COMPILER_GCC)
#  define UNREACHABLE_CODE __builtin_unreachable(); ASSERT(false && "unreachable code")
# endif

# if !defined(UNREACHABLE_CODE)
#  define UNREACHABLE_CODE ASSERT(false && "unreachable code")
# endif

# if defined(GIL_TEST_SHOULD_PRINT)
#  define TEST_FRAMEWORK_SHOULD_PRINT
# endif

# ifndef INLINE
#  define INLINE inline
# endif

# if defined(COMPILER_GCC)
#  define packed_struct(x) struct __attribute__((packed, aligned(x)))
# elif defined(COMPILER_MSVC)
#  error "test to see if this works"
#  define packed_struct(x) struct __pragma(pack(push, x))
# else
#  define packed_struct(x) struct
# endif

// todo: __attribute__((warn_unused_result))
# define DISCARD_RETURN

#endif
