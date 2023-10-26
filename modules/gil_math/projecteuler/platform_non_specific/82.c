#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/compare/compare.h"

static u64 solve_82(int** matrix, const int rows, const int cols, const int aux_col_index) {
    for (int col = cols - 2; col >= 0; --col) {
        // store col in aux
        for (int row = 0; row < rows; ++row) {
            matrix[row][aux_col_index] = matrix[row][col];
        }
        
        // check all paths from cur col (stored in aux) to the next col (that is calculated in previous iteration) and store the min in the matrix
        for (int row = 0; row < rows; ++row) {
            u64 min_sum = matrix[row][aux_col_index] + matrix[row][col + 1];
            for (int target_row = 0; target_row < rows; ++target_row) {
                // add all rows up except for current one
                if (row == target_row) {
                    continue ;
                }

                int row_dir = target_row < row ? -1 : 1;
                int cur_row = row;
                u64 sum = matrix[cur_row][aux_col_index] + matrix[target_row][col + 1];
                while (cur_row != target_row) {
                    cur_row += row_dir;
                    sum += matrix[cur_row][aux_col_index];
                }
                min_sum = min__u64(min_sum, sum);
            }

            // store min in matrix
            matrix[row][col] = min_sum;
        }
    }

    // min is stored in the first col
    u64 result = U64_MAX;
    for (int row = 0; row < rows; ++row) {
        result = min__u64(matrix[row][0], result);
    }

    return result;
}

bool test_82(const char* matrix_file_path, const char* write_out_path, memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    // 1. allocate for the matrix
    const int rows = 80;
    const int cols = 80;
    const int aux_cols = 1;
    seg_t matrix_seg = seg__malloc(memory_slice, rows * sizeof(int*));
    int** matrix = seg__seg_to_data(matrix_seg);
    for (int row = 0; row < rows; ++row) {
        seg_t row_seg = seg__malloc(memory_slice, (cols + aux_cols) * sizeof(int));
        matrix[row] = seg__seg_to_data(row_seg);
    }

    // 2. read into the matrix from the file
    file_t file;
    if (!file__open(&file, matrix_file_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN)) {
        return false;
    }

    // 3. create the file reader to parse the matrix file
    size_t file_reader_memory_size = KILOBYTES(1);
    seg_t file_reader_memory_seg = seg__malloc(memory_slice, file_reader_memory_size);
    void* file_reader_memory = seg__seg_to_data(file_reader_memory_seg);
    file_reader_t file_reader;
    if (!file_reader__create(&file_reader, file, memory_slice__create(file_reader_memory, file_reader_memory_size))) {
        return false;
    }

    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            if (!file_reader__read_s32(&file_reader, &matrix[row][col])) {
                return false;
            }
            if (col < cols - 1) {
                char c;
                if (file_reader__read_one(&file_reader, &c, sizeof(c)) != sizeof(c) || c != ',') {
                    return false;
                }
            }
        }

        if (row < rows - 1) {
            char c;
            if (file_reader__read_one(&file_reader, &c, sizeof(c)) != sizeof(c) || c != '\n') {
                return false;
            }
        }
    }

    // 4. close file
    file__close(&file);
    
    // 5. solve problem 82
    const u64 result_82 = solve_82(matrix, rows, cols, cols);

    // 6. write the matrix and the solution out
    size_t file_writer_size = BYTES(32);
    seg_t file_writer_seg = seg__malloc(memory_slice, file_writer_size);
    void* file_writer_data = seg__seg_to_data(file_writer_seg);
    file_writer_t file_writer;
    if (!file_writer__create(&file_writer, memory_slice__create(file_writer_data, file_writer_size))) {
        return false;
    }
    if (!file__open(&file, write_out_path, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE)) {
        return false;
    }
    for (s32 row = 0; row < rows; ++row) {
        for (s32 col = 0; col < cols; ++col) {
            file_writer__write_format(&file_writer, &file, "%lu ", matrix[row][col]);
        }
        file_writer__write_format(&file_writer, &file, "\n");
    }
    file_writer__write_format(&file_writer, &file, "%lu", result_82);

    file__close(&file);

    return true;
}
