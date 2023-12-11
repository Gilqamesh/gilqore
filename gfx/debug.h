#ifndef DEBUG_H
# define DEBUG_H

# include <stdbool.h>
# include <stdarg.h>
# include <assert.h>
# include <stdint.h>

# define ASSERT(expr) do { \
    if (!(expr)) { \
        assert(false); \
    } \
} while (false)

bool debug__init_module();
void debug__deinit_module();

typedef enum debug_error_level {
    DEBUG_ERROR,
    DEBUG_WARN,
    DEBUG_INFO,

    _DEBUG_ERROR_LEVEL_SIZE
} debug_error_level_t;
const char* debug_error_level__to_str(debug_error_level_t error_level);

typedef enum debug_module {
    DEBUG_MODULE_APP,
    DEBUG_MODULE_GLFW,

    _DEBUG_MODULE_SIZE
} debug_module_t;
const char* debug_module__to_str(debug_module_t module);

void debug__write(const char* format, ...);
void debug__write_and_flush(debug_module_t module, debug_error_level_t error_level, const char* format, ...);
void debug__flush(debug_module_t module, debug_error_level_t error_level);

#endif // DEBUG_H
