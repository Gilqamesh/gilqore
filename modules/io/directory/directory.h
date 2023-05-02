#ifndef DIRECTORY_H
# define DIRECTORY_H

# include "directory_defs.h"

struct directory;
struct directory_entry;

# define WINDOWS

# if defined(WINDOWS)
#  include "platform_specific/windows/directory_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/directory_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/directory_platform_specific_defs.h"
# endif

// @brief opens the first file in the specified directory
GIL_API bool directory__open(struct directory* self, const char* path);
// @brief closes the directory handle
GIL_API void directory__close(struct directory* self);
// @brief returns the directory entry of the current entry's name in the opened directory, and moves to the next entry
GIL_API struct directory_entry directory__read(struct directory* self);

// @brief if it doesn't already exist, create a directory
GIL_API bool directory__create(const char* path);
// @brief deletes a directory if exists and empty
GIL_API bool directory__delete(const char* path);
// @brief renames a directory if exists
GIL_API bool directory__rename(const char* path);

#endif
