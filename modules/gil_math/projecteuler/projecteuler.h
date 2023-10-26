#ifndef PROJECTEULER_H
# define PROJECTEULER_H

# include "memory/memory.h"

PUBLIC_API bool test_82(const char* matrix_file_path, const char* write_out_path, memory_slice_t memory_slice);
PUBLIC_API bool test_83(const char* matrix_file_path, const char* write_out_path, memory_slice_t memory_slice);
PUBLIC_API bool test_84(memory_slice_t memory_slice);
PUBLIC_API bool test_85(memory_slice_t memory_slice);
PUBLIC_API bool test_86(memory_slice_t memory_slice);
PUBLIC_API bool test_87(memory_slice_t memory_slice);
PUBLIC_API bool test_88(memory_slice_t memory_slice);
PUBLIC_API bool test_89(const char* romans_file_path, memory_slice_t memory_slice);

#endif // PROJECTEULER_H
