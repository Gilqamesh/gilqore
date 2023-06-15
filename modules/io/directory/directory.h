#ifndef DIRECTORY_H
# define DIRECTORY_H

# include "directory_defs.h"

struct directory;

// todo: move file dependency out from this file
// note: enum file_flag def
# include "io/file/file.h"

# if defined(WINDOWS)
#  include "platform_specific/windows/directory_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/directory_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/directory_platform_specific_defs.h"
# endif

// @brief opens the first file in the specified directory
PUBLIC_API bool directory__open(struct directory* self, const char* path);
// @brief closes the directory handle
PUBLIC_API void directory__close(struct directory* self);
// @brief returns the name of the current file of the opened directory, and moves to the next file
// @param bytes_written optional parameter to retrieve the number of bytes written into the buffer
// @returns true on success, false if no more files are in the directory
PUBLIC_API bool directory__read(struct directory* self, char* buffer, u32 buffer_size, u32* bytes_written);

// @brief if it doesn't already exist, create a directory
PUBLIC_API bool directory__create(const char* path);
// @brief deletes a directory if exists and empty
PUBLIC_API bool directory__delete(const char* path);

// @brief apply fn on each file_type on path one level deep
PUBLIC_API void directory__foreach_shallow(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags);
// @brief apply fn on each file_type on path recursively
// @param fn function to apply on each of the matching files, should return true if the algorithm should keep recursing on the matched file if it's a directory
PUBLIC_API void directory__foreach_deep(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags);
// @brief apply fn on each file_type on path depth level deep
// @param depth 0 depth is equal to a for each shallow
// @param fn function to apply on each of the matching files, should return true if the algorithm should keep recursing on the matched file if it's a directory
PUBLIC_API void directory__foreach(const char* path, bool (*fn)(const char* path), enum file_type file_type_flags, u32 depth);

#endif
