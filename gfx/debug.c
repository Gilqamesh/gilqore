#include "debug.h"

#include "buffer.h"

#include <string.h>
#include <stdio.h>
#include <time.h>

typedef struct debug_buffer {
    buffer_t    buffer;
} debug_buffer_t;

typedef struct debug {
    buffer_t buffer;
    uint32_t number_of_lines;

    FILE* error_file;
} debug_t;

static debug_t debug;

static void debug__vwrite(const char* format, va_list ap);

static void debug__vwrite(const char* format, va_list ap) {
    const char* line_prefix = "  ";
    const uint32_t line_prefix_len = strlen(line_prefix);

    if (debug.number_of_lines == 1) {
        assert(debug.buffer.cur + line_prefix_len <= debug.buffer.end);
        // prepend first line
        memmove(debug.buffer.start + line_prefix_len, debug.buffer.start, debug.buffer.cur - debug.buffer.start);
        memcpy(debug.buffer.start, line_prefix, line_prefix_len);
        debug.buffer.cur += line_prefix_len;
    }

    if (debug.number_of_lines > 0) {
        // prepend current line
        buffer__write(&debug.buffer, "%s", line_prefix);
    }
    ++debug.number_of_lines;

    buffer__vwrite(&debug.buffer, format, ap);
    buffer__write(&debug.buffer, "\n");
}

bool debug__init_module() {
    memset(&debug, 0, sizeof(debug));

    debug.error_file = fopen("debug.txt", "w");
    if (!debug.error_file) {
        return false;
    }

    buffer__create(&debug.buffer, 4096);

    return true;
}

void debug__deinit_module() {
    if (debug.error_file) {
        fclose(debug.error_file);
        debug.error_file = 0;
    }
    buffer__destroy(&debug.buffer);
}

const char* debug_error_level__to_str(debug_error_level_t error_level) {
    switch (error_level) {
    case DEBUG_ERROR: return "error";
    case DEBUG_WARN:  return "warn";
    case DEBUG_INFO:  return "info";
    default: ASSERT(false);
    }

    return 0;
}

const char* debug_module__to_str(debug_module_t module) {
    switch (module) {
    case DEBUG_MODULE_APP: return "app";
    case DEBUG_MODULE_GLFW: return "glfw";
    default: ASSERT(false);
    }

    return 0;
}

void debug__write(const char* format, ...) {
    va_list ap;
    va_start(ap, format);

    debug__vwrite(format, ap);

    va_end(ap);
}

void debug__write_and_flush(debug_module_t module, debug_error_level_t error_level, const char* format, ...) {
    va_list ap;
    va_start(ap, format);

    debug__vwrite(format, ap);

    va_end(ap);

    debug__flush(module, error_level);
}

static void debug__flush_helper(FILE* fp, debug_module_t module, debug_error_level_t error_level) {
    time_t cur_time = time(NULL);
    struct tm* cur_localtime = localtime(&cur_time);
    fprintf(
        fp,
        "[%02d:%02d:%02d] [%s] - %s: ",
        cur_localtime->tm_hour, cur_localtime->tm_min, cur_localtime->tm_sec, debug_module__to_str(module), debug_error_level__to_str(error_level)
    );
    if (debug.number_of_lines > 1) {
        fprintf(fp, "\n");
    }

    fprintf(fp, "%s", debug.buffer.start);
}

void debug__flush(debug_module_t module, debug_error_level_t error_level) {
    debug__flush_helper(debug.error_file, module, error_level);
    if (debug.error_file != stderr) {
        debug__flush_helper(stderr, module, error_level);
    }
    
    buffer__clear(&debug.buffer);
    debug.number_of_lines = 0;
}
