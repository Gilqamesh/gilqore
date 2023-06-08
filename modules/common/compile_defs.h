#ifndef COMPILE_DEFS_H
# define COMPILE_DEFS_H

# if defined (_WIN32)
#  define WINDOWS
# elif defined(__linux__)
#  define LINUX
# elif defined(__APPLE__)
#  define MAC
# else
#  error "unknown os"
# endif

# if defined(WINDOWS)
#  if defined(GIL_LIB_SHARED_EXPORT)
#   define GIL_API __declspec(dllexport)
#  elif defined(GIL_LIB_SHARED_IMPORT)
#   define GIL_API __declspec(dllimport)
#  endif
# endif

# if defined(_MSC_VER)
#  define COMPILER_MSVC
# endif

# if !defined(GIL_API)
#  define GIL_API
# endif

# if defined(GIL_DEBUG)
#  include <assert.h>
#  define ASSERT(condition) assert(condition)
# else
#  define ASSERT(condition)
# endif

# if defined(WINDOWS)
# elif defined(LINUX)
# elif defined(MAC)
# else
#  error "platform not supported, need to defined either WINDOWS, LINUX or MAC"
# endif

# if defined(__GNUC__)
#  define UNREACHABLE_CODE __builtin_unreachable(); ASSERT(false && "unreachable code")
# endif

# if !defined(UNREACHABLE_CODE)
#  define UNREACHABLE_CODE ASSERT(false && "unreachable code")
# endif

# if defined(GIL_TEST_SHOULD_PRINT)
#  define TEST_FRAMEWORK_SHOULD_PRINT
# endif

#endif
