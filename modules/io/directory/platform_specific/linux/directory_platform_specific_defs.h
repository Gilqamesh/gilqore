#ifndef DIRECTORY_PLATFORM_SPECIFIC_DEFS_H
# define DIRECTORY_PLATFORM_SPECIFIC_DEFS_H

# include "../../directory_defs.h"

// todo: error code

# include <dirent.h>

struct directory {
    DIR* handle;
};

struct directory_entry {
    const char* file_name;
}

#endif
