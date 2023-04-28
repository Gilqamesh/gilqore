#include "file/file.h"

#include <Windows.h>

#include "common/error_code.h"
#include "data_structures/circular_buffer/circular_buffer.h"

struct file {
    HANDLE           handle;
    circular_buffer  buffer;
};

file file__open(const char* path) {
    (void) path;
    return NULL;
}

void file__close(file self) {
    (void) self;
}

u32 file__read(file self, void* out, u32 size) {
    return 0;
}
