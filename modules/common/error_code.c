#include "error_code.h"

#include <stdlib.h>

void error_code__exit(u32 error_code) {
    exit(error_code);
}
