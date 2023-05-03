#ifndef FILE_H
# define FILE_H

// todo: support files greater than 4 giga-bytes

# include "file_defs.h"

struct file;

# if defined(WINDOWS)
#  include "platform_specific/windows/file_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/file_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/file_platform_specific_defs.h"
# endif

enum file_access_mode {
    FILE_ACCESS_MODE_READ  = 1 << 0, // open file in read only mode
    FILE_ACCESS_MODE_WRITE = 1 << 1, // open file in write only mode
    FILE_ACCESS_MODE_RDWR  = 1 << 2  // open file in write and read mode
};

enum file_creation_mode {
    FILE_CREATION_MODE_OPEN   = 1 << 0, // open existing file
    FILE_CREATION_MODE_CREATE = 1 << 1  // create new file or truncate if exists
};

GIL_API bool file__open(
    struct file* self,
    const char* path,
    enum file_access_mode access_mode,
    enum file_creation_mode creation
);
GIL_API void file__close(struct file* self);

GIL_API bool file__exists(const char* path);
GIL_API bool file__is_directory(const char* path);
GIL_API bool file__delete(const char* path);
// @brief renames or moves a directory (including its children) if exists
GIL_API bool file__move(const char* src_path, const char* dest_path);

// @brief reads from opened file, returns bytes read
GIL_API u32 file__read(struct file* self, void* out, u32 size);
// @brief writes to the opened file, returns bytes written
GIL_API u32 file__write(struct file* self, const void* in, u32 size);
GIL_API u32 file__seek(struct file* self, u32 offset);

#endif
