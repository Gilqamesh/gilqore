#ifndef DIRECTORY_H
# define DIRECTORY_H

# include "directory_defs.h"

struct directory;

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
// @brief returns the name of the current file opened directory, and moves to the next file
// @param bytes_written optional parameter to retrieve the number of bytes written into the buffer
// @returns true on success, false if no more files are in the directory
GIL_API bool directory__read(struct directory* self, char* buffer, u32 buffer_size, u32* bytes_written);

// @brief if it doesn't already exist, create a directory
GIL_API bool directory__create(const char* path);
// @brief deletes a directory if exists and empty
GIL_API bool directory__delete(const char* path);

#endif
