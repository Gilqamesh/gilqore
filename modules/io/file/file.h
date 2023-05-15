#ifndef FILE_H
# define FILE_H

// todo: support files greater than 4 giga-bytes

# include "file_defs.h"

struct time;

# if defined(WINDOWS)
#  include "platform_specific/windows/file_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/file_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/file_platform_specific_defs.h"
# endif

enum file_access_mode {
    FILE_ACCESS_MODE_READ,  // open file in read only mode
    FILE_ACCESS_MODE_WRITE, // open file in write only mode
    FILE_ACCESS_MODE_RDWR   // open file in write and read mode
};

enum file_creation_mode {
    FILE_CREATION_MODE_OPEN,  // open existing file
    FILE_CREATION_MODE_CREATE // create new file or truncate if exists
};

// todo: differentiate from pipe/socket and other types of files
enum file_type {
    FILE_TYPE_DIRECTORY = 1 << 0,
    FILE_TYPE_FILE      = 1 << 1
};

GIL_API bool file__open( 
    struct file* self,
    const char* path,
    enum file_access_mode access_mode,
    enum file_creation_mode creation
);
GIL_API void file__close(struct file* self);

GIL_API bool file__exists(const char* path);
GIL_API bool file__delete(const char* path);
// @brief renames or moves a directory (including its children) if exists
GIL_API bool file__move(const char* src_path, const char* dest_path);
// @returns last time that the file was modified
GIL_API bool file__last_modified(const char* path, struct time* last_modified);
GIL_API bool file__stat(const char* path, enum file_type* file_type);
// @returns whether the operations was successful or not as well as the file_size if it was
GIL_API bool file__size(const char* path, u64* file_size);
// @brief copies the source file to the destination path
// @note if dest exists, its contents will be overwritten
GIL_API bool file__copy(const char* dest_path, const char* src_path);

enum file_seek_type {
    FILE_SEEK_TYPE_BEGIN,
    FILE_SEEK_TYPE_CUR,
    FILE_SEEK_TYPE_END
};

// @brief reads from opened file, returns bytes read
GIL_API u32 file__read(struct file* self, void* out, u32 size);
// @brief writes to the opened file, returns bytes written
GIL_API u32 file__write(struct file* self, const void* in, u32 size);
// @returns file pointer position
GIL_API u32 file__seek(struct file* self, u32 offset, enum file_seek_type type);

#endif
