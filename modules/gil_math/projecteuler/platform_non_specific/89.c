#include "gil_math/projecteuler/projecteuler.h"

#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "libc/libc.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/sqrt/sqrt.h"
#include "system/thread/thread.h"
#include "data_structures/hash_set/hash_set.h"

bool test_89(const char* romans_file_path, memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    const u32 romans_size = 1000;
    seg_t romans_seg = seg__malloc(memory_slice, romans_size);
    if (!romans_seg) {
        return false;
    }
    char** romans = (char**) seg__seg_to_data(romans_seg);
    const u32 max_roman_len = 50;
    for (u32 roman_index = 0; roman_index < romans_size; ++roman_index) {
        seg_t roman_seg = seg__malloc(memory_slice, max_roman_len);
        if (!roman_seg) {
            return false;
        }
        char* roman = (char*) seg__seg_to_data(roman_seg);
        romans[roman_index] = roman;
    }

    file_t file;
    ASSERT(file__open(&file, romans_file_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN));

    const u32 file_reader_memory_size = KILOBYTE(1);
    seg_t file_reader_internal_memory_seg = seg__malloc(memory_slice, file_reader_memory_size);
    if (!file_reader_internal_memory_seg) {
        return false;
    }
    void* file_reader_internal_memory = seg__seg_to_data(file_reader_internal_memory_seg);
    file_reader_t file_reader;
    file_reader__create(&file_reader, file, memory_slice__create(file_reader_internal_memory, file_reader_memory_size));

    for (u32 roman_index = 0; roman_index < romans_size; ++roman_index) {
        file_reader__read_format(&file_reader, "%s\n", &romans[roman_index]);
    }

    file_reader__destroy(&file_reader);

    file__close(&file);

    return true;
}
