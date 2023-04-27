#ifndef COMPILE_DEFS_H
# define COMPILE_DEFS_H

# if defined(_WIN32)
#  if defined(GIL_LIB_SHARED_EXPORT)
#   define GIL_API __declspec(dllexport)
#  elif defined(GIL_LIB_SHARED_IMPORT)
#   define GIL_API __declspec(dllimport)
#  endif
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

#endif
