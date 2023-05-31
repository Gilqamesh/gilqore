#ifndef GMC_H
# define GMC_H

# include "gmc_defs.h"

struct gmc {
    char*  buffer;
    u32    buffer_size;
    u32
};

// @brief parse the gmc format from the provided path to the provided buffer
// @param buffer must be big enough to hold the meta data of the parsed info
GIL_API bool gmc__parse(struct gmc* self, const char* path, char* buffer, u32 buffer_size);

#endif
