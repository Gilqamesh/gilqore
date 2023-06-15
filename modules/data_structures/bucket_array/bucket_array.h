#ifndef BUCKET_ARRAY_H
# define BUCKET_ARRAY_H

# include "bucket_array_defs.h"

struct bucket_array {
    s32 i;
};

// @brief returns 42, always succeeds
PUBLIC_API bool bucket_array__create(struct bucket_array* self);

#endif //BUCKET_ARRAY_H
